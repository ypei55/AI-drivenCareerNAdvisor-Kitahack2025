import 'package:flutter/material.dart';

import '../Component/TopNavBar.dart';
import '../Component/category.dart';
import '../Component/courseCard.dart';
import '../Component/recommendedCourseCard.dart';

class Courses extends StatelessWidget implements PreferredSizeWidget {

  final List<Map<String, dynamic>> courses = [
    {
      "title": "Data Structures and Algorithms",
      "imageUrl": "assets/course1.png",
      "chapters": 10,
      "hours": 6,
      "progress": 20,
    },
    {
      "title": "Web Development Bootcamp",
      "imageUrl": "assets/course2.jpg",
      "chapters": 12,
      "hours": 8,
      "progress": 60,
    },
    {
      "title": "Machine Learning Basics",
      "imageUrl": "assets/course3.jpg",
      "chapters": 8,
      "hours": 5,
      "progress": 40,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "category": "Design",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
      "icon": Icons.design_services,
      "iconColor": Colors.blue,
      "backgroundColor": Colors.lightBlueAccent,
    },
    {
      "category": "Development",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
      "icon": Icons.code,
      "iconColor": Colors.green,
      "backgroundColor": Colors.greenAccent,
    },
    {
      "category": "Marketing",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
      "icon": Icons.sell,
      "iconColor": Colors.red,
      "backgroundColor": Colors.redAccent,
    },
    {
      "category": "Management",
      "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
      "icon": Icons.business,
      "iconColor": Colors.orange,
      "backgroundColor": Colors.orangeAccent,
    },
  ];

  final List<Map<String, dynamic>> categories2 = [
    {
      "category": "Art",
      "description": "Explore the world of creativity and expression through art.",
      "icon": Icons.palette,
      "iconColor": Colors.purple,
      "backgroundColor": Colors.purpleAccent,
    },
    {
      "category": "Science",
      "description": "Dive deep into the world of discovery and innovation.",
      "icon": Icons.science,
      "iconColor": Colors.green,
      "backgroundColor": Colors.greenAccent,
    },
    {
      "category": "Business",
      "description": "Learn the strategies for success and entrepreneurship.",
      "icon": Icons.business_center,
      "iconColor": Colors.blue,
      "backgroundColor": Colors.blueAccent,
    },
    {
      "category": "Music",
      "description": "Master the art of music and enhance your skills.",
      "icon": Icons.music_note,
      "iconColor": Colors.red,
      "backgroundColor": Colors.redAccent,
    },
  ];

  final List<Map<String, dynamic>> recommendedCourses = [
    {
      "title": "Introduction to Python Programming",
      "imageUrl": "assets/course4.jpg",
      "chapters": 9,
      "hours": 7,
      "description": "Learn Python from scratch — syntax, loops, functions, and more for beginners.",
    },
    {
      "title": "Fundamentals of Cybersecurity",
      "imageUrl": "assets/course5.jpg",
      "chapters": 11,
      "hours": 9,
      "description": "Understand key cybersecurity principles to protect data and networks.",
    },
    {
      "title": "UI/UX Design Essentials",
      "imageUrl": "assets/course6.png",
      "chapters": 7,
      "hours": 4,
      "description": "Master the basics of user interface and experience design with practical tips.",
    },
    {
      "title": "Mobile App Development",
      "imageUrl": "assets/course7.jpg",
      "chapters": 15,
      "hours": 10,
      "description": "Lorem ipsum dolor sit amet, consectetur adipising elit, sed do eiusmod tempor",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(page: 'courses',),
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
                  Container(
                    width: 1450,
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal, // Makes it horizontal
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseCard(
                          title: course['title'],
                          imageUrl: course['imageUrl'],
                          chapters: course['chapters'],
                          hours: course['hours'],
                          progress: course['progress'],
                        );
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 50,); },
                    ),
                  )
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
                        Container(
                          width: 1450,
                          height: 325,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal, // Horizontal list
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Category(
                                  category: category['category'],
                                  description: category['description'],
                                  icon: category['icon'],
                                  iconColor: category['iconColor'],
                                  backgroundColor: category['backgroundColor'],
                                ),
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 50,);},
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Container(
                          width: 1450,
                          height: 325,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal, // Horizontal list
                            itemCount: categories2.length,
                            itemBuilder: (context, index) {
                              final category = categories2[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Category(
                                  category: category['category'],
                                  description: category['description'],
                                  icon: category['icon'],
                                  iconColor: category['iconColor'],
                                  backgroundColor: category['backgroundColor'],
                                ),
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 50,);},
                          ),
                        )
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
                      icon: Icon(
                          Icons.search,
                        size: 30,
                      ),
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
                  Container(
                    width: 1450,
                    height: 350,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal, // Horizontal list
                      itemCount: recommendedCourses.length,
                      itemBuilder: (context, index) {
                        final course = recommendedCourses[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: RecommendedCourseCard(
                            title: course['title'],
                            imageUrl: course['imageUrl'],
                            chapters: course['chapters'],
                            hours: course['hours'],
                            description: course['description'],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 65,); },
                    ),
                  )

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
