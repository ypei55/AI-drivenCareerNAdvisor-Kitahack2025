import 'package:flutter/material.dart';

class Mockinterviewheader extends StatelessWidget implements PreferredSizeWidget {
  final String jobTitle;
  final String companyName;
  const Mockinterviewheader({super.key, required this.jobTitle, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFF5EC),
      leading: FloatingActionButton(
        backgroundColor: const Color(0xFF49BBBD),
        child: const Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: LayoutBuilder( // Use LayoutBuilder to get context for text sizing
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
            color: Colors.white,
                borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30), // Padding around the text
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Important for content-based sizing
              children: [
                Wrap( // Use Wrap to keep texts in the same line when possible.
                    children: [
                      Text(
                        '$companyName - $jobTitle ',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      const Text(
                        'HR Interview',
                        style: TextStyle(
                            color: Color(0xFFFF6B00),
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                ),
                const SizedBox(height: 5,),
                const Text(
                  '30 minutes',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}