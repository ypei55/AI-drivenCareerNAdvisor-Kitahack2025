import 'dart:io';
import 'dart:typed_data';
import 'package:careeradvisor_kitahack2025/Services/AIServices.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:careeradvisor_kitahack2025/Page/CheckerResults.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../Component/TopNavBar.dart';

class Checker extends StatefulWidget {
  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  String? _fileName;
  bool _isHovering = false;
  TextEditingController _jobDescriptionController = TextEditingController();
  String? _resumeText;

  Future<String> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });

      Uint8List bytes = result.files.single.bytes!;
      _resumeText = await extractTextFromPDF(bytes); // Store the extracted text
    }
    return "No file selected.";
  }

  Future<String> extractTextFromPDF(Uint8List bytes) async {
    final PdfDocument document = PdfDocument(inputBytes: bytes);
    String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return text;
  }

  Future<void> _checkResume() async {
  try {
    if (_resumeText == null || _resumeText!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload a resume first.")),
        );
        return;
      }

    String jobDescription = _jobDescriptionController.text;

    if (jobDescription.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a job description.")),
        );
        return;
      }

    print("Resume Text: $_resumeText");
    print("Job Description: $jobDescription");

    AIService aiService = AIService();
    print("AIService initialized with API Key: ${aiService}");

    String aiResponse = await aiService.compareResumeAndJobDescription(_resumeText!, jobDescription);

    print("AI Response: $aiResponse");

    print("Navigating to /checkerresults");
    context.go('/checkerresults', extra: aiResponse);
  } catch (e) {
    print("Error during navigation: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    MouseRegion(
                      onEnter: (_) => setState(() => _isHovering = true),
                      onExit: (_) => setState(() => _isHovering = false),
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: _pickFile,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isHovering ? Colors.orangeAccent : Colors.orange,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload,
                                size: 200,
                                color: _isHovering ? Colors.orange : Colors.grey[400],
                              ),
                              SizedBox(height: 10),
                              Text(
                                _fileName ?? "Drop, Upload or Paste Resume",
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Supported formats: .pdf, .docx, .doc",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Description",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 130,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _jobDescriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write or paste job description about your desired role on job vacancy",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _checkResume,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Checking",
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
      ),
    );
  }
}