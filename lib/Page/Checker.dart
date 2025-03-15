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
  bool _isHovering = false; // Track hover state

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
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
                      cursor:
                          SystemMouseCursors.click, // Change cursor to pointer
                      child: GestureDetector(
                        onTap: _pickFile,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
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
                            boxShadow: _isHovering ? [] : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload,
                                size: 200,
                                color: _isHovering
                                    ? Colors.orange // Change to orange on hover
                                    : Colors.grey[400], // Default color
                              ),
                              SizedBox(height: 10),
                              Text(
                                _fileName ?? "Drop, Upload or Paste Resume",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Supported formats: .pdf, .docx, .doc",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
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
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w900),
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
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Write or paste job description about your desired role on job vacancy",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                         context.go('/checkerResults', extra: 100);
                        },
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
