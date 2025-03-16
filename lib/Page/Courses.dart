import 'package:flutter/material.dart';

import '../Component/TopNavBar.dart';
import '../Component/category.dart';
import '../Component/courseCard.dart';
import '../Component/recommendedCourseCard.dart';

class Courses extends StatelessWidget implements PreferredSizeWidget {
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded( // Prevents text overflow
                    child: Text(
                      "Welcome back, ready for your next lesson?",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement navigation to a detailed interview list
                    },
                    child: Text(
                      "view more",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    progress: 20,
                  ),
                  CourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    progress: 20,
                  ),
                  CourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    progress: 20,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity, // Ensures full width
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose favourite course from top category",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 75,),
                        Category(
                          category: 'Design',
                          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod',
                          icon: Icons.design_services,
                          iconColor: Colors.blue,
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 25,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                children: [
                  Text(
                    "Recommended for you",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.search),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Implement navigation to a detailed interview list
                    },
                    child: Text(
                      "view more",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RecommendedCourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    description: 'Lorem ipsum dolor sit amet, consectetur adipising elit, sed do eiusmod tempor',
                  ),
                  SizedBox(width: 50,),
                  RecommendedCourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    description: 'Lorem ipsum dolor sit amet, consectetur adipising elit, sed do eiusmod tempor',
                  ),
                  SizedBox(width: 50,),
                  RecommendedCourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    description: 'Lorem ipsum dolor sit amet, consectetur adipising elit, sed do eiusmod tempor',
                  ),
                  SizedBox(width: 50,),
                  RecommendedCourseCard(
                    title: "Data Structures and Algorithms",
                    imageUrl: "assets/job1.jpg",
                    chapters: 10,
                    hours: 6,
                    description: 'Lorem ipsum dolor sit amet, consectetur adipising elit, sed do eiusmod tempor',
                  ),
                ],
              ),
            ),
          ],
        ),
      )

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust height if needed
}
