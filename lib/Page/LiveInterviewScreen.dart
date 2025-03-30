import 'package:camera/camera.dart';
import 'package:careeradvisor_kitahack2025/Component/mockInterviewHeader.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // List<CameraDescription> cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final List<CameraDescription> cameras;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Interview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MockInterviewScreen(jobTitle:'jobTile', companyName: 'companyName',responsibilities: '...',jobDesc: '...',),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MockInterviewScreen extends StatefulWidget {
  final bool showNotification;
  final String jobTitle;
  final String companyName;
  final String responsibilities;
  final String jobDesc;
  // final List<CameraDescription> cameras;
  const MockInterviewScreen({super.key, required this.jobTitle, required this.companyName,this.showNotification=true, required this.responsibilities, required this.jobDesc});
  @override
  _MockInterviewScreenState createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  CameraController? _cameraController;
  Future<void>? _initializeCameraControllerFuture;
  bool _micActive = false;
  bool _cameraActive = false;
  bool _permissionsRequested = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedWords = '';
  List<CameraDescription>? _availableCameras;
  List<String> interviewQuestions = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _getAvailableCameras();
    _initSpeech();
  }

  Future<void> _getAvailableCameras()async{
    try{
      List<CameraDescription> cameras = await availableCameras();
      setState((){
        _availableCameras= cameras;
      });
    }catch(e){
      setState(() {
        _availableCameras = [];
      });
      print("No cameras available: $e");
    }
  }

    void _initializeCamera() {
    if(_availableCameras !=null && _availableCameras!.isNotEmpty){
      _cameraController = CameraController(
        _availableCameras!.first,
        ResolutionPreset.medium,
      );
      _initializeCameraControllerFuture = _cameraController!.initialize();
    }else{
      print("No camera found");
    }
    // _cameraController = CameraController(
    //   widget.cameras.first,
    //   ResolutionPreset.medium,
    // );
    // _initializeCameraControllerFuture = _cameraController!.initialize();
  }
  void _disposeCameraController() {
    _cameraController?.dispose();
    _cameraController = null;
    _initializeCameraControllerFuture = null;
    // if (_cameraController != null) {
    //   _cameraController!.dispose();
    //   _cameraController = null;
    //   _initializeCameraControllerFuture = null;
    // }
  }

  @override
  void dispose() {
    _disposeCameraController();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    if (!_permissionsRequested) {
      _permissionsRequested = true;
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.camera,
        Permission.storage,
      ].request();

      if (statuses[Permission.microphone]!.isGranted && statuses[Permission.camera]!.isGranted) {
        // Permissions granted.
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone, and camera permission are required')),);
      }
    }
  }

  void _initSpeech() async {
    bool available = await _speech.initialize(
      onError: (val) => print('onError: $val'),
      onStatus: (val) => print('onStatus: $val'),
    );
    if (available) {
      // Speech recognition available.
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _startListening() async {
    await _speech.listen(onResult: (result) {
      setState(() {
        _recognizedWords = result.recognizedWords;
      });
    });
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _recognizedWords = '';
    });
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Provide real case about how you calm down your emosi',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 40,
              child: SizedBox(
                width: 150,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    'assets/signlanguage.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              right: 40,
              child: SizedBox(
                width: 150,
                height: 100,
                child: _cameraActive && _availableCameras!=null && _availableCameras!.isNotEmpty
                    ? (_initializeCameraControllerFuture != null
                        ? FutureBuilder<void>(
                            future: _initializeCameraControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                return CameraPreview(_cameraController!);
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Center(child: CircularProgressIndicator())))
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
                      ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: Row(
                children: [
                  _buildIconButton(
                    _micActive ? Icons.mic_rounded : Icons.mic_off_rounded,
                    () {
                      setState(() {
                        _micActive = !_micActive;
                        if (_micActive) {
                          _startListening();
                        } else {
                          _stopListening();
                          _recognizedWords = '';
                        }
                      });
                    },
                  ),
                  _buildIconButton(
                    _cameraActive
                        ? Icons.videocam_rounded
                        : Icons.videocam_off_rounded,
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
                  _buildIconButton(Icons.fiber_manual_record_rounded, () {
                    //record this meeting
                  }),
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
