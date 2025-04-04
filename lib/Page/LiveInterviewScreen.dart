import 'dart:ui_web' as ui;

import 'package:camera/camera.dart';
import 'package:careeradvisor_kitahack2025/Component/mockInterviewHeader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../Services/AIServices.dart';
import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

class MockInterviewScreen extends StatefulWidget {
  final bool showNotification;
  final String jobTitle;
  final String companyName;
  final String responsibilities;
  final String jobDesc;
  final bool isNormal;
  // final List<CameraDescription> cameras;
  const MockInterviewScreen({super.key, required this.jobTitle, required this.companyName,this.showNotification=true, required this.responsibilities, required this.jobDesc, required this.isNormal});
  @override
  _MockInterviewScreenState createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeCameraControllerFuture;
  bool _cameraActive = true;
  bool _permissionsRequested = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedWords = '';
  List<CameraDescription>? _availableCameras;
  FlutterTts flutterTts = FlutterTts();
  List<String> interviewQuestions = [];
  List<String> hints = [];
  List<String> interviewAnswers = [];
  Timer? _questionTimer;
  String hint = '';
  String userAnswer = '';
  List<Map<String, String>> interviewData = [];

  late html.VideoElement _recordedVideo;
  html.MediaRecorder? _mediaRecorder;
  html.MediaStream? _mediaStream;
  bool _isRecording = false;
  String? _recordedVideoUrl;
  html.Blob? _recordingBlob;

  AIService aiService = AIService();

  @override
  void initState(){
    super.initState();
    _initializeApp();
  }

  Map<String, List<String>> parseQuestionsAndHints(String response) {
    List<String> questions = [];
    List<String> hints = [];

    // Split response by new lines
    List<String> lines = response.split("\n");

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();

      if (line.startsWith("Question ")) {
        questions.add(line.substring(line.indexOf(":") + 1).trim());
      } else if (line.startsWith("Hint ")) {
        hints.add(line.substring(line.indexOf(":") + 1).trim());
      }
    }

    return {"questions": questions, "hints": hints};
  }

  //Reading question with time interval
  void _startReadingQuestions() async {
    String aiResponse = await aiService.generateInterviewQuestionsWithHints(
        widget.jobTitle, widget.companyName, widget.jobDesc, widget.responsibilities);
    Map<String, List<String>> parsedData = parseQuestionsAndHints(aiResponse);

    setState(() {
      interviewQuestions = parsedData["questions"] ?? [];
      hints = parsedData["hints"] ?? [];
    });

    for (int i = 0; i < interviewQuestions.length; i++) {
      print("Q: ${interviewQuestions[i]}");
      print("Hint: ${hints[i]}\n");
    }

    for (int i = 0; i < interviewQuestions.length; i++) {
      String question = interviewQuestions[i];


      await _speak(question); // Wait until question is spoken completely
      print(question);
      setState(() {
        hint = hints[i];
      });
      await _releaseMicrophone();
      String answer = await _recordAnswer(); // Wait until answer is recorded

      interviewData.add({"question": question, "answer": answer});
    }

    print(interviewData); // Debug output

    await _speak('The interview session has ended. You can click end button to end the interview session.');


  }


  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true); // Ensures it waits until speaking is done
  }

  Future<String> _recordAnswer() async {
    if (!await _speech.initialize()) {
      return "Speech recognition not available.";
    }

    setState(() {
      _recognizedWords = '';
      userAnswer = "";
    });

    Completer<String> answerCompleter = Completer<String>();

    _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedWords = result.recognizedWords; // Append new words
          userAnswer = result.recognizedWords;
        });
      },
      listenFor: Duration(seconds: 30),
    );

    await Future.delayed(Duration(seconds: 30)); // Ensure full 30s wait
    await _speech.stop(); // Stop recording after 30 seconds

    return userAnswer; // Return the recorded answer
  }

  Future<void> _initializeApp() async {
    _requestPermissions();
    // await Permission.camera.request();
    // await Permission.microphone.request();
    await _getAvailableCameras();
    _initRecording();
    _speak('The interview session will start now, there are five questions and you have 1 minutes to answer each questions');
    _startReadingQuestions();
    _initSpeech();
    if (_cameraActive) {
      _initializeCamera();
    }
    _startCameraAndRecording();
  }

  void _initRecording() {
    _recordedVideo = html.VideoElement()
      ..autoplay = false
      ..muted = false
      ..width = html.window.innerWidth!
      ..height = html.window.innerHeight!
      ..controls = true;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('recorded-video', (int_) => _recordedVideo);
  }

  Future<void> _startCameraAndRecording() async {
    try {
      _mediaStream = await html.window.navigator.mediaDevices?.getUserMedia({'video': {'cursor': 'always', 'displaySurface': 'monitor'}, 'audio': {'echoCancellation': true, 'noiseSuppression': true}});
      if (_mediaStream != null) {

        _recordedVideo.srcObject = _mediaStream;
        _startRecording(_mediaStream!);
      }
    } catch (e) {
      print('Error starting camera: $e');
    }
  }

  void _startRecording(html.MediaStream stream) {
    try{    
      // Ensure audio is enabled in MediaRecorder options
      final options = {
        'audioBitsPerSecond': 128000,
        'videoBitsPerSecond': 2500000,
        'mimeType': 'video/webm;codecs=vp9,opus' // Explicit codec specification
      };
    
    _mediaRecorder = html.MediaRecorder(stream);
    _mediaRecorder!.start();
    setState(() => _isRecording = true);

    _recordingBlob = html.Blob([]);

    _mediaRecorder!.addEventListener('dataavailable', (event) {
      _recordingBlob = js.JsObject.fromBrowserObject(event)['data'];
    }, true);

    _mediaRecorder!.addEventListener('stop', (event) {
      final url = html.Url.createObjectUrl(_recordingBlob!);
      setState(() => _recordedVideoUrl = url);
    });
  }catch(e){
    print('Recording error: $e');
  }
  }

  Future<void> _stopRecording() async {
    _mediaRecorder?.stop();
    _mediaStream?.getTracks().forEach((track) => track.stop());
    setState(() {
      _isRecording = false;
      _cameraActive = false;
    });

    _disposeCameraController();
    Map<String?, String?> responses = {
      for (var item in interviewData) item["question"]: item["answer"]
    };
    String result = await aiService.evaluateInterviewResponses(responses);
    print(result);

    await Future.delayed(const Duration(milliseconds: 500));
    if (_recordedVideoUrl != null) {
      context.go('/interview_result', extra: {
        'result': result,
        'videoUrl': _recordedVideoUrl!,
        'jobTitle': widget.jobTitle
      });
    }
  }

    Future<void> _requestPermissions() async {
    if (!_permissionsRequested) {
      _permissionsRequested = true;
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.camera,
        Permission.storage,
      ].request();


      if (statuses[Permission.microphone]!.isGranted && statuses[Permission.camera]!.isGranted&& statuses[Permission.storage]!.isGranted) {
        // Permissions granted.
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone, camera, and storage permission are required')),);
      }
    }
  }


  Future<void> _getAvailableCameras() async {
    try {
      List<CameraDescription> cameras = await availableCameras();
      setState(() {
        _availableCameras = cameras;
      });
    } catch (e) {
      setState(() {
        _availableCameras = [];
      });
      print("No cameras available: $e");
    }
  }

  void _initializeCamera() {
    if (_availableCameras != null && _availableCameras!.isNotEmpty) {
      _cameraController = CameraController(
        _availableCameras!.first,
        ResolutionPreset.medium,
      );
      _initializeCameraControllerFuture = _cameraController!.initialize();
    } else {
      print("No camera found");
    }
  }

  void _disposeCameraController() {
    _cameraController?.dispose();
    _cameraController = null;
    _initializeCameraControllerFuture = null;
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onError: (val) => print('onError: $val'),
      onStatus: (val) => print('onStatus: $val'),
    );
    if (available) {
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  @override
  void dispose() {
    _disposeCameraController();
    if (_isRecording) _stopRecording();
    _mediaStream?.getTracks().forEach((track) => track.stop());
    super.dispose();
  }

  Future<void> _releaseMicrophone() async {
    _mediaStream?.getAudioTracks().forEach((track) => track.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Mockinterviewheader(jobTitle:widget.jobTitle, companyName:widget.companyName),
      backgroundColor: const Color(0xFFFFF5EC),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Stack(
          children: [
            Center(
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.96,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/interviewer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (widget.showNotification)
            Positioned(
              top: 10,
              left: 40,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: widget.isNormal ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outlined,color: Colors.black),
                    SizedBox(width: 5),
                    Container(
                      width: hint == '' ? 15 : 600,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          hint,
                          maxLines: 5,
                          softWrap: true,  // Allows text to wrap to the next line
                          overflow: TextOverflow.visible,  // Ensures it remains visible
                        ),
                      ),
                    ),
                  ],
                ) : Container()
              ),
            ),
            if (_isRecording)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 12),
                      SizedBox(width: 5),
                      Text('REC', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 50,
              right: 20,
              child: SizedBox(
                width: 150,
                height: 100,
                child: (_cameraActive && _availableCameras != null && _availableCameras!.isNotEmpty
                    ? (_initializeCameraControllerFuture != null
                    ? FutureBuilder<void>(
                  future: _initializeCameraControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_cameraController!);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )
                    : Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ))
                    : Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.videocam_off,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                )),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: Row(
                children: [
                  _buildIconButton(
                    _cameraActive ? Icons.videocam_rounded : Icons.videocam_off_rounded,
                        () {
                      setState(() {
                        _cameraActive = !_cameraActive;
                        if (_cameraActive) {
                          _initializeCamera();
                        } else {
                          _disposeCameraController();
                        }
                      });
                    },
                  ),
                  _buildIconButton(
                    Icons.stop_rounded,
                        () {
                      _stopRecording();
                    },
                  ),
                  _buildIconButton(Icons.more_horiz_rounded, () {}),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  _recognizedWords,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}