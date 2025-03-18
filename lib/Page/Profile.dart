import 'package:careeradvisor_kitahack2025/Component/lessonCard.dart';
import 'package:flutter/material.dart';

import '../Component/TopNavBar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEditingExperience = false;
  bool isEditingInterest = false;
  bool isEditingEducation = false;

  TextEditingController experienceController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.");
  TextEditingController interestController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.");
  TextEditingController educationController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                  width: 1000,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Profile Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage('profile.png'), // Replace with your image
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Free Tier",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Micheal Wong",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.email, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  "micheal_wong@gmail.com",
                                  style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // Vertical Divider
                        Container(width: 1, height: 170, color: Colors.black26),
                        SizedBox(width: 20),
                        // Right Education Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Education",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                                  ),
                                  Spacer(),
                                  Icon(Icons.edit, color: Colors.black54),
                                ],
                              ),
                              SizedBox(height: 10),
                              EducationItem(
                                logo: 'profile.png', // Replace with University of Edinburgh logo
                                university: "University of Edinburgh",
                                duration: "2022–2024",
                                degree: "Master of Science in Artificial Intelligence",
                              ),
                              SizedBox(height: 10),
                              EducationItem(
                                logo: 'profile.png', // Replace with UPM logo
                                university: "Universiti Putra Malaysia",
                                duration: "2018–2022",
                                degree: "Bachelor of Science in Software Engineering",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    width: 1000,
                    height: 332,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded( // Prevents text overflow
                                child: Text(
                                  "Lesson Achieved",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFFF2994A)),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Implement navigation to a detailed interview list
                                },
                                icon: Icon(Icons.refresh, size: 25,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LessonCard(
                                title: "Data Structures and Algorithms",
                                imageUrl: "assets/job1.jpg",
                                chapters: 10,
                                hours: 6,
                              ),
                              LessonCard(
                                title: "Data Structures and Algorithms",
                                imageUrl: "assets/job1.jpg",
                                chapters: 10,
                                hours: 6,
                              ),
                              LessonCard(
                                title: "Data Structures and Algorithms",
                                imageUrl: "assets/job1.jpg",
                                chapters: 10,
                                hours: 6,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                        Icons.navigate_next,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      // Experience Section (Editable)
                      _editableSection(
                        "Experience",
                        experienceController,
                        isEditingExperience,
                            () => setState(() => isEditingExperience = !isEditingExperience),
                      ),

                      SizedBox(width: 50,),

                      // Interest Section (Editable)
                      _editableSection(
                        "Interest",
                        interestController,
                        isEditingInterest,
                            () => setState(() => isEditingInterest = !isEditingInterest),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 70,),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                          'Unlock your full potential with Premium Tier',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: 170,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFFAD6B7),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('profile.png'), // Ensure correct path
                              radius: 20,
                            ),
                            SizedBox(width: 15,),
                            Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFFF51007),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Premium Tier",
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'With benefits of:',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          '- AI generate perfect resume                            - Improve resume',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  // Editable Section Widget
  Widget _editableSection(String title, TextEditingController controller, bool isEditing, VoidCallback onEditPress) {
    return Container(
      width: 475, // Set a width constraint
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
              Spacer(),
              GestureDetector(
                onTap: onEditPress,
                child: Icon(Icons.edit, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller,
            enabled: isEditing,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

}


// Education Item Widget
class EducationItem extends StatelessWidget {
  final String logo;
  final String university;
  final String duration;
  final String degree;

  const EducationItem({
    super.key,
    required this.logo,
    required this.university,
    required this.duration,
    required this.degree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(logo, width: 30, height: 30), // University Logo
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(university, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(duration, style: TextStyle(fontSize: 14)),
            Text(degree, style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}