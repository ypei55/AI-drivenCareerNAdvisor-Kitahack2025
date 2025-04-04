import 'package:flutter/material.dart';
import 'AccordianData.dart';

class AccordionWidget extends StatefulWidget {
  final List<AccordionItemData> items;

  const AccordionWidget({super.key, required this.items});

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
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.white,
          elevation: 0.0, 
          shape: RoundedRectangleBorder( 
            side: const BorderSide(color: Colors.orange, width: 1.0),
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
                          Text(item.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 10),
                          Text(item.score, style: const TextStyle(color: Color(0xFF20BF55)),),
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
                        style: const TextStyle(color: Colors.orange),
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
                      ...item.questionAnswerScores.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final qa = entry.value;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text('Question $index: ${qa.question}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                                      Text(qa.score.toString(),style: const TextStyle(color: Colors.green,fontSize: 16)),
                                      const Text('/10',style: TextStyle(color: Colors.black,)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (qa.answer.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text('Answer: ${qa.answer}', style: const TextStyle(color: Color(0xFF7F7F7F),fontSize: 15),),
                                ),
                              const SizedBox(height: 10),
                              if(qa.feedback.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text('[ Feedback: ${qa.feedback} ]', style: const TextStyle(color: Color(0xFF7F7F7F),fontSize: 14),),
                                ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }
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