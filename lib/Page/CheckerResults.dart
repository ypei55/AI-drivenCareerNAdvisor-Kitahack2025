import 'package:flutter/material.dart';
import '../Component/TopNavBar.dart';
import 'package:go_router/go_router.dart';

class CheckerResults extends StatelessWidget {
  final String aiResponse;

  CheckerResults({super.key, required this.aiResponse});

  Map<String, String> _parseAIResponse(String response) {
    Map<String, String> sections = {
      'Matching Score': 'N/A',
      'Missing Keywords': 'N/A',
      'Suggestions': 'N/A',
      'Revised Resume': 'N/A',
    };

    try {
      String cleanText(String text) {
        return text.replaceAll('**', '').trim();
      }

      if (response.contains('Matching Score:')) {
        sections['Matching Score'] = cleanText(
          response.split('Matching Score:')[1].split('Missing Keywords:')[0],
        );
      }

      if (response.contains('Missing Keywords:')) {
        sections['Missing Keywords'] = cleanText(
          response.split('Missing Keywords:')[1].split('Suggestions:')[0],
        );
      }

      if (response.contains('Suggestions:')) {
        sections['Suggestions'] = cleanText(
          response.split('Suggestions:')[1].split('Revised Resume:')[0],
        );
      }

      if (response.contains('Revised Resume:')) {
        sections['Revised Resume'] = cleanText(
          response.split('Revised Resume:')[1],
        );
      }
    } catch (e) {
      print('Error parsing AI response: $e');
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> parsedResponse = _parseAIResponse(aiResponse);

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
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      "Checking Results",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF6B00)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Matching Score: ${parsedResponse['Matching Score']}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black), // Default style
                            children: [
                              TextSpan(
                                text: "Missing Keywords:\n", // Bold label
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: parsedResponse['Missing Keywords'] ??
                                    "", // Regular value
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black), // Default style
                            children: [
                              TextSpan(
                                text: "Suggestions:\n", // Bold label
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: parsedResponse['Suggestions'] ??
                                    "", // Regular value
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: const Text(
                      "Revised Version",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF6B00)),
                    ),
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
                      children: [
                        Text(
                          parsedResponse['Revised Resume'] ??
                              "No revised resume available.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
