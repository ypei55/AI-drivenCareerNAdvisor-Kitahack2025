import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InterviewResult(),
    );
  }
}

class InterviewResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Mock Interview for Software Engineer'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(),
            SizedBox(height: 20),
            ScoreOverview(),
            SizedBox(height: 20),
            RecordedSession(),
            SizedBox(height: 20),
            ScoreDetails(),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Text('Micheal Wong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Mar 10, 2025'),
            Text('📍 Malaysia  |  ✉️ micheal_wong@gmail.com'),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recorded Session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/video_placeholder.png', width: double.infinity),
              Icon(Icons.play_circle_fill, size: 50, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}

class ScoreDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ScoreTile(title: 'MCQ test report', score: '87%'),
        ScoreTile(title: 'Technical interview report', score: '74%'),
      ],
    );
  }
}

class ScoreTile extends StatelessWidget {
  final String title;
  final String score;

  ScoreTile({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(score, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
