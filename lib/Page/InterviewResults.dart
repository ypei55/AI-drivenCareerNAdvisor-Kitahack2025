import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Import for JSON decoding

import '../Component/AccordianData.dart';
import '../Component/AccordianWidget.dart';

class InterviewResult extends StatefulWidget {
  final String videoUrl;
  final String jobTitle;
  final String result;
  final Map<String, int> score = {
    'mcq': 85,
    'technical': 70
  };

  InterviewResult({super.key, required this.videoUrl, required this.jobTitle, required this.result});

  @override
  _InterviewResultState createState() => _InterviewResultState();
}

class _InterviewResultState extends State<InterviewResult> {
  Map<String, dynamic> extractedData = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }


  Map<String, dynamic> _extractData(String result) {
    try {
      String cleanedResult = result;
      if (result.startsWith('```json') && result.endsWith('```')) {
        cleanedResult = result.substring(7, result.length - 3).trim();
      }

      final decodedJson = jsonDecode(cleanedResult);
      List<Map<String, dynamic>> questions = [];
      if (decodedJson.containsKey('interviewEvaluations') && decodedJson['interviewEvaluations'] is List) {
        questions = (decodedJson['interviewEvaluations'] as List<dynamic>).map((eval) {
          if (eval is Map<String, dynamic>) {
            final scoreParts = (eval['score'] as String?)?.split('/');
            return {
              'question': eval['question'] ?? '',
              'answer': eval['intervieweeResponse'] ?? '',
              'feedback': eval['feedback'] ?? '',
              'score': scoreParts != null && scoreParts.length == 2 ? int.tryParse(scoreParts[0]) ?? 0 : 0,
            };
          } else {
            // Handle the case where an element is not a Map<String, dynamic>
            print('Warning: Unexpected type in interviewEvaluations: $eval');
            return <String, dynamic>{}; // Return an empty map or some other default
          }
        }).toList();
      }

      Map<String, dynamic> finalReport = decodedJson['finalInterviewReport'] ?? {};
      final technicalSkillsParts = (finalReport['technicalSkillsRating'] as String?)?.split('/');
      final communicationSkillsParts = (finalReport['communicationSkillsRating'] as String?)?.split('/');
      final overallhrIVScoreParts = (finalReport['overallhrIVScore'] as String?)?.split('/');
      return {
        'interviewEvaluations': questions,
        'technicalSkillsRating': technicalSkillsParts != null && technicalSkillsParts.length == 2 ? int.tryParse(technicalSkillsParts[0]) ?? 0 : 0,
        'communicationSkillsRating': communicationSkillsParts != null && communicationSkillsParts.length == 2 ? int.tryParse(communicationSkillsParts[0]) ?? 0 : 0,
        'overallhrIVScore': overallhrIVScoreParts != null && overallhrIVScoreParts.length == 2 ? int.tryParse(overallhrIVScoreParts[0]) ?? 0 : 0,
      };
    } catch (e) {
      print('Error decoding JSON: $e');
      print('Raw response: $result');
      return {
        'interviewEvaluations': [],
        'technicalSkillsRating': 0,
        'communicationSkillsRating': 0,
        'overallhrIVScore': 0,
      };
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          children: [
            const Text('Summary of Practice Mock Interview for ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
            Text(widget.jobTitle, style: const TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.w800)),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileSection(),
              const SizedBox(height: 20),
              ScoreOverview(
                technicalSkills: extractedData['technicalSkillsRating'] as int,
                communicationSkills: extractedData['communicationSkillsRating'] as int,
                overallhrIVScore: extractedData['overallhrIVScore'] as int,
                score: widget.score,
                ),
                const SizedBox(height: 20),
                const Divider(height: 10, thickness: 1),
                const SizedBox(height: 20),
                RecordedSession(widget.videoUrl),
                const SizedBox(height: 25),
                ScoreDetails(extractedEvaluations: extractedData['interviewEvaluations'] ?? [], overallhrIVScore: extractedData['overallhrIVScore'] as int, score: widget.score),
                ],
              ),
            ),
          ),
        );
      }
    }



class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('MMM d, yyyy').format(DateTime.now());
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('profile.png'),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Micheal Wong', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text(today, style: const TextStyle(fontSize: 17,color: Color(0xFFA4A4A4),fontWeight: FontWeight.w500),),
            const Text('📍 Malaysia  |  ✉️ micheal_wong@gmail.com', style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500),),
          ],
        ),
      ],
    );
  }
}

class ScoreOverview extends StatelessWidget {
  // final String result;
  final int technicalSkills;
  final int communicationSkills;
  final int overallhrIVScore;
  final Map<String,int>score;

  const ScoreOverview({super.key, required this.technicalSkills, required this.communicationSkills, required this.overallhrIVScore, required this.score});
  @override
  Widget build(BuildContext context) {
    final mcq = score['mcq'] ?? 0;
    final tech = score['technical'] ?? 0;

    double overallScore = (mcq + overallhrIVScore * 10 + tech) / 300;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MCQ Test - $mcq%'),
            Text('HR Interview - ${overallhrIVScore * 10}%'),
            Text('Technical Interview - $tech%'),
          ],
        ),
        Container(width: 1.0,height: MediaQuery.of(context).size.height * 0.1, color: Colors.orange,margin: const EdgeInsets.symmetric(horizontal: 10.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Technical Skills - ${technicalSkills * 10}%'),
            Text('Communication - ${communicationSkills * 10}%'),
          ],
        ),
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: overallScore.isNaN ? 0.0 : overallScore,
          center: Text('${(overallScore * 100).toStringAsFixed(2)}%',style: const TextStyle(fontSize: 20, color: Colors.green),),
          progressColor: Colors.green,
        ),
      ],
    );
  }
}

class RecordedSession extends StatelessWidget {
  final String videoUrl;
  const RecordedSession(this.videoUrl, {super.key});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Create a video element for playback
    final videoElement = html.VideoElement()
      ..src = videoUrl
      ..autoplay = false
      ..controls = true
      ..width = (screenWidth * 0.7).toInt()
      ..height = (screenHeight * 0.5).toInt();

    // Register the view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('result-video', (int _) => videoElement);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recorded session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFFFF6B00))),
        const SizedBox(height: 15),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.9,
          child: const Center(
            child: HtmlElementView(
              viewType: 'result-video',
            ),
          ),
        ),
      ],
    );
  }
}
class ScoreDetails extends StatelessWidget {
  final List<Map<String,dynamic>> extractedEvaluations;
  final int overallhrIVScore;
  final Map<String, int> score;
  // String result;

  ScoreDetails({super.key, required this.extractedEvaluations, required this.overallhrIVScore, required this.score});

  @override
  Widget build(BuildContext context) {

    List<AccordionItemData> accordionItems = [
      AccordionItemData(
        title: 'MCQ test report',
        score: '${score['mcq']}%',
      ),
      AccordionItemData(
        title: 'HR interview report',
        score: '${overallhrIVScore * 10}%',
        questionAnswerScores: extractedEvaluations.map((q) =>
            QuestionAnswerScore(
              question: q['question'] ?? 'N/A',
              answer: q['answer'] ?? 'N/A',
              feedback: q['feedback'] ?? 'N/A',
              score: q['score'] ?? 0,
            ),
        ).toList(),
      ),
      AccordionItemData(
        title: 'Technical interview report',
        score: '${score['technical']}%',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Scores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        AccordionWidget(items: accordionItems)
      ],
    );
  }
}