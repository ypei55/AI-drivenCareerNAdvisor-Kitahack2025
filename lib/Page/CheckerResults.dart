import 'package:flutter/material.dart';
import '../Component/TopNavBar.dart';
import 'package:go_router/go_router.dart';

class CheckerResults extends StatelessWidget {
  final double percentage; // Pass percentage dynamically

  CheckerResults({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: const Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 25),
                onPressed: () {
                  context.go('/checker');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
              child: Column(
                children: [
                  const Text(
                    "Checking Results",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF6B00)),
                  ),
                  const SizedBox(height: 15),
                  // Matching Score Section (Using Container)
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Matched Parts:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                              SizedBox(height: 10),
                              Text(
                                "Missing Keywords:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("IoT sensor integration"),
                              SizedBox(height: 10),
                              Text(
                                "Suggestions:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Add a project where work on IoT & sensor integration"),
                            ],
                          ),
                        ),
                        // Circular Progress with Percentage
                        Padding(
  padding: const EdgeInsets.only(right: 100),
  child: Column(
    children: [
      // Circular Progress with Percentage
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: percentage / 100, // Convert 0-100 to 0.0-1.0
              strokeWidth: 10,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFF6B00),
              ),
            ),
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Text(
              "${percentage.toInt()}%",
              style: const TextStyle(
                color: Color(0xFFFF6B00),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12), // Space between percentage and text
      const Text(
        "Matching Score",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  ),
),

                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Revised Version Section
                  const Text(
                    "Revised Version",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF6B00)),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("**Name**"),
                        Text("Hardware Developer - Smart Rubbish Bin Project"),
                        Text(
                            "Email: yourname@email.com | Phone: (123) 456-7890 | LinkedIn: linkedin.com/in/yourname"),
                        SizedBox(height: 10),
                        Text("**Professional Summary**"),
                        Text(
                            "Hardware Developer with expertise in designing and implementing smart sensor technology."),
                        SizedBox(height: 10),
                        Text("**Technical Skills**"),
                        Text("- Hardware Design (PCB, Microcontrollers)"),
                        Text("- IoT Development (ESP32, Raspberry Pi)"),
                        Text("- Sensor Integration (Ultrasonic IR Sensors)"),
                        Text("- Programming (C++, Python)"),
                        Text("- Prototyping and Testing"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Download Button
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Download",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
