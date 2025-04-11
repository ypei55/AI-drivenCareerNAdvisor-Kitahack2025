import 'dart:typed_data';
import 'package:careeradvisor_kitahack2025/Services/AIServices.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:careeradvisor_kitahack2025/Page/CheckerResults.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../Component/TopNavBar.dart';

class Checker extends StatefulWidget {
  const Checker({super.key});

  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  String? _fileName;
  bool _isHovering = false;
  bool _isLoading = false;
  final TextEditingController _jobDescriptionController = TextEditingController();
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
          const SnackBar(content: Text("Please upload a resume first.")),
        );
        return;
      }

      String jobDescription = _jobDescriptionController.text;

      if (jobDescription.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a job description.")),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      AIService aiService = AIService();

      String aiResponse = await aiService.compareResumeAndJobDescription(
          _resumeText!, jobDescription);

      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      context.go('/checkerresults', extra: aiResponse);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error during navigation: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(page: 'checker',),
      backgroundColor: const Color(0xFFFFF5EC),
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
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isHovering
                                  ? Colors.orangeAccent
                                  : Colors.orange,
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
                                color: _isHovering
                                    ? Colors.orange
                                    : Colors.grey[400],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _fileName ?? "Drop, Upload or Paste Resume",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Supported formats: .pdf, .docx, .doc",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Description",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 130,
                      padding: const EdgeInsets.all(13),
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
                          hintText:
                              "Write or paste job description about your desired role on job vacancy",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _checkResume,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                "Checking",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
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
