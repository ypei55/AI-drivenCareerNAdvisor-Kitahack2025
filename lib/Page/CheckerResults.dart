import 'package:flutter/material.dart';
import '../Component/TopNavBar.dart';
import 'package:go_router/go_router.dart';

class CheckerResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
                onPressed: () {
                  context.go('/checker');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
              child: Column(
                children: [
                  Text(
                    "Checking Results",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF2994A)),
                  ),
                  SizedBox(height: 15),
                  // Matching Score Section (Using Container)
                  Container(
                    padding: EdgeInsets.all(15),
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
                            children: [
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
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.orange,
                          child: Text(
                            "75%",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  // Revised Version Section
                  Text(
                    "Revised Version",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF2994A)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                  SizedBox(height: 30),
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
                      child: Text(
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
