import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

import '../Component/AccordianData.dart';
import '../Component/AccordianWidget.dart';

class InterviewResult extends StatelessWidget {
  final String videoUrl;
  final String jobTitle;
  final String result;
  final Map<String, int> score = {
    'mcq': 85,
    'technical': 70
  };

  InterviewResult({super.key, required this.videoUrl, required this.jobTitle, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Wrap(
          children: [
            const Text('Summary of Practice Mock Interview for ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
            Text(jobTitle, style: const TextStyle(color: Color(0xFFFF6B00),fontWeight: FontWeight.w800),),
          ],)
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
              ScoreOverview(result:result,score:score),
              const SizedBox(height: 20),
              const Divider(height: 10,thickness: 1),
              const SizedBox(height: 20),
              RecordedSession(videoUrl),
              const SizedBox(height: 25),
              ScoreDetails(result: result,score:score),
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
  final String result;
  final Map<String,int>score;

  const ScoreOverview({super.key, required this.result, required this.score});
  @override
  Widget build(BuildContext context) {
    final technicalSkills = int.tryParse(RegExp(r'Technical Skills Rating: (\d+)/10').firstMatch(result)?.group(1) ?? '0') ?? 0;
    final communicationSkills = int.tryParse(RegExp(r'Communication Skills Rating: (\d+)/10').firstMatch(result)?.group(1) ?? '0') ?? 0;
    final hrIVScore = int.tryParse(RegExp(r'Overall Score: (\d+)/10').firstMatch(result)?.group(1) ?? '0') ?? 0;
    final hrIVOverallScore = (hrIVScore / 10 * 100).toInt();

    final mcq = score['mcq'] ?? 0;
    final tech = score['technical'] ?? 0;

    double overallScore = (mcq + hrIVOverallScore + tech) / 300;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MCQ Test - $mcq%'),
            Text('HR Interview - $hrIVOverallScore%'),
            Text('Technical Interview - $tech%'),
          ],
        ),
        Container(width: 1.0,height: MediaQuery.of(context).size.height * 0.1, color: Colors.orange,margin: const EdgeInsets.symmetric(horizontal: 10.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Technical Skills - ${(technicalSkills / 10 * 100).toInt()}%'),
            Text('Communication - ${(communicationSkills / 10 * 100).toInt()}%'),
          ],
        ),
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: overallScore,
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
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: ElevatedButton(
        //       // Navigate back or to another page
        //     onPressed: () {Navigator.pop(context);},
        //     child: const Text('BACK TO INTERVIEW'),
        //   ),
        // ),
      ],
    );
  }
}
class ScoreDetails extends StatelessWidget {
  final Map<String, int> score;
  String result;

  ScoreDetails({super.key, required this.result, required this.score});

  @override
  Widget build(BuildContext context) {
    RegExp questionRegex = RegExp(r'Question: (.+?)\s*Interviewee Response: (.+?)\s*Feedback: (.+?)\s*Score: (\d+)/10');
    Iterable<Match> questionMatches = questionRegex.allMatches(result);
    final overallScore = int.tryParse(RegExp(r'Overall Score: (\d+)/10').firstMatch(result)?.group(1) ?? '0') ?? 0;

    List<AccordionItemData> accordionItems = [
      AccordionItemData(
        title: 'MCQ test report',
        score: '${score['mcq']}%',
      ),
      AccordionItemData(
        title: 'HR interview report',
        score: '${overallScore * 10}%',
        typeOfInterview: 'AI based interview',
        levelOfInterview: 'Medium',
        numberOfQuestions: 5,
        questionAnswerScores: 
        questionMatches.map((match) {
            return QuestionAnswerScore(
              question: match.group(1) ?? '',
              answer: match.group(2) ?? '',
              feedback: match.group(3) ?? '',
              score: int.parse(match.group(4) ?? '0'),
            );
          }).toList()),
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