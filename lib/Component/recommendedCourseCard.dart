import 'package:flutter/material.dart';

class RecommendedCourseCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int chapters;
  final int hours;
  final String description;

  const RecommendedCourseCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.chapters,
    required this.hours,
    required this.description
  });

  @override
  State<RecommendedCourseCard> createState() => _RecommendedCourseCardState();
}

class _RecommendedCourseCardState extends State<RecommendedCourseCard> {
  bool _isHovered = false; // State variable for hover effect

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      height: 350, // Adjust height for better layout
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image (Upper part)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              widget.imageUrl,
              width: double.infinity,
              height: 175, // Only takes upper part
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay for better text readability
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 175, // Same as image height
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),

          // Course Title
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // White Bottom Section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 175, // White section height
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(width: 10,),
                            Text(
                              "${widget.chapters}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const Text(
                              "Chapters",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40,),
                        Column(
                          children: [
                            Text(
                              "${widget.hours}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const Text(
                              "Hours",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(width: 60,),
                        const Column(
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              '0%',
                              style: TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Circular Progress with Solid Background
          Positioned(
            bottom: 140, // Adjust position to overlap both sections
            right: 25,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: () {
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 70, // Slightly enlarge on hover
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white, // Ensures solid background
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (_isHovered)
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: _isHovered ? 70 : 65, // Adjust size slightly smaller than the container
                        height: _isHovered ? 70 : 65,
                        child: CircularProgressIndicator(
                          value: 0.0,
                          strokeWidth: 7,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      const Icon(
                        Icons.play_arrow,
                        size: 36,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
