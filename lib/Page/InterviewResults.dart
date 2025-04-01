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

  InterviewResult({required this.videoUrl, required this.jobTitle, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Mock Interview for $jobTitle'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSection(),
              SizedBox(height: 20),
              ScoreOverview(),
              SizedBox(height: 20),
              Divider(height: 10,thickness: 1),
              SizedBox(height: 20),
              RecordedSession(videoUrl),
              SizedBox(height: 25),
              // Divider(height: 10,thickness: 1),
              ScoreDetails(),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateFormat('MMM d, yyyy').format(DateTime.now());
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Micheal Wong', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text(today, style: TextStyle(fontSize: 17,color: Color(0xFFA4A4A4),fontWeight: FontWeight.w600),),
            Text('📍 Malaysia  |  ✉️ micheal_wong@gmail.com', style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500),),
          ],
        ),
      ],
    );
  }
}

class ScoreOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MCQ test 72%'),
            Text('HR Interview 63%'),
            Text('Technical Interview 75%'),
          ],
        ),
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: 0.83,
          center: Text('83%'),
          progressColor: Colors.green,
        ),
      ],
    );
  }
}

class RecordedSession extends StatelessWidget {
  final String videoUrl;
  RecordedSession(this.videoUrl);


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Create a video element for playback
    final videoElement = html.VideoElement()
      ..src = videoUrl
      ..autoplay = false
      ..controls = true
      ..width = (screenWidth * 0.7).toInt() // Adjust as needed
      ..height = (screenHeight * 0.5).toInt(); // Adjust as needed
    // ..width = html.window.innerWidth!
    // ..height = html.window.innerHeight!;

    // Register the view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('result-video', (int _) => videoElement);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recorded session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFFFF6B00))),
        const SizedBox(height: 15),
        Container(
          width: screenWidth * 0.9, // Match video width
          height: screenHeight * 0.9,
          child: Center(
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
  @override
  Widget build(BuildContext context) {
    List<AccordionItemData> accordionItems = [
      AccordionItemData(
        title: 'MCQ test report',
        score: '87%',
        // No extra details for MCQ
      ),
      AccordionItemData(
        title: 'HR interview report',
        score: '74%',
        typeOfInterview: 'AI based interview',
        levelOfInterview: 'Medium',
        numberOfQuestions: 8,
        questionAnswerScores: [
          QuestionAnswerScore(
            question: '1. Hello, I am Lucy, and I will be interviewing you for the Python job. Can you please introduce yourself?',
            answer: '', // No answer for the first question
            score: 90,
          ),
          QuestionAnswerScore(
            question: '1. Hello, I am Lucy, and I will be interviewing you for the Python job. Can you please introduce yourself?',
            answer: 'Sure Maam First of all I would like to thank you for giving this wonderful opportunity to introduce myself. I am Raghupathi Sahiti, I\'m born and brought up in Visakhapatnam. I have completed my Bachelors of Technology from Andhra University in Electronics and Communication Engineering and completed my intermediate in Narayana Junior College. And I did my schooling from central board and I\'m a quick learner, assertive and sociable. My short term goal is to get a good job in reputed company like yours and my long term goal is to get immense known. Which in it domain and to get into a respectable position and coming to my programming skills I have learned basics and theoretical concepts of C, Python And core Java And also I have done my internship in data science with IBM from Burgio. Also have done mini projects on Java that is create 4 game and coming to my hobbies. I love playing badminton and that\'s all about me. Thank you maam.',
            score: 90,
          ),
          QuestionAnswerScore(
            question: '1. Hello, I am Lucy, and I will be interviewing you for the Python job. Can you please introduce yourself?',
            answer: '', // No answer for the third question
            score: 90,
          ),
        ],
      ),
      AccordionItemData(
        title: 'Technical interview report',
        score: '74%',
        // No extra details for technical interview
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        AccordionWidget(items: accordionItems)
      ],
    );
  }
}
