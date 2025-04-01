import 'package:flutter/material.dart';
import 'AccordianData.dart';

class AccordionWidget extends StatefulWidget {
  final List<AccordionItemData> items;

  AccordionWidget({required this.items});

  @override
  _AccordionWidgetState createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = List.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.asMap().entries.map((entry) {
        int index = entry.key;
        AccordionItemData item = entry.value;

        return Card(          
          margin: EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.white, // Set the background color to white
          elevation: 0.0, 
          shape: RoundedRectangleBorder( 
            side: BorderSide(color: Colors.orange, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(item.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          SizedBox(width: 10),
                          Text(item.score, style: TextStyle(color: Color(0xFF20BF55)),),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded[index] = !_isExpanded[index];
                        });
                      },
                      child: Text(
                        _isExpanded[index] ? 'view less' : 'view more',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isExpanded[index])
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (item.typeOfInterview.isNotEmpty)
                      //   Text('Type of interview: ${item.typeOfInterview}'),
                      // if (item.levelOfInterview.isNotEmpty)
                      //   Text('Level of interview: ${item.levelOfInterview}'),
                      // if (item.numberOfQuestions > 0)
                      //   Text('Number of questions: ${item.numberOfQuestions}'),
                      // SizedBox(height: 8.0),
                      ...item.questionAnswerScores.map((qa) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(qa.question)),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (qa.answer.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(qa.answer, style: TextStyle(color: Color(0xFF7F7F7F)),),
                                ),
                              SizedBox(height: 20),
                            ],
                          ), 
                          ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}