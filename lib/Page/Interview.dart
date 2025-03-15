import 'package:flutter/material.dart';
import '../Component/TopNavBar.dart';

class Interview extends StatelessWidget {
  final List<Map<String, String>> interviewData = [
    {
      'company': 'ANT Company - Software Engineer',
      'image': 'job1.jpg',
      'sessions': '2'
    },
    {
      'company': 'NETFLIX - Platform Engineer',
      'image': 'job2.jpg',
      'sessions': '2'
    },
    {
      'company': 'AWS - Junior Consultant',
      'image': 'job3.jpg',
      'sessions': '3'
    },
    {
      'company': 'EXACT Company - Software Engineer',
      'image': 'job1.jpg',
      'sessions': '3'
    },
    {
      'company': 'OpenAI - Research Engineer',
      'image': 'job2.jpg',
      'sessions': '2'
    },
    {
      'company': 'Microsoft - AI Engineer',
      'image': 'job3.jpg',
      'sessions': '2'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: Color(0xFFFFF5EC),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Practice Mock Interview for Any Role",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                TextButton(
                  onPressed: () {
                    // Implement navigation to a detailed interview list
                  },
                  child: Text(
                    "view more",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1.5,
                ),
                itemCount: interviewData.length,
                itemBuilder: (context, index) {
                  return _buildInterviewCard(interviewData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterviewCard(Map<String, String> data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.asset(
                    data['image']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Blur effect
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.black
                          .withOpacity(0.3), // Semi-transparent overlay
                    ),
                  ),
                ),
                // Company name
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Text(
                    data['company']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['sessions']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Interview Sessions Required"),
                  ],
                ),
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF49BBBD),
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
   
  }
}
