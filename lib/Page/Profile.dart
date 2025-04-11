import 'package:careeradvisor_kitahack2025/Component/lessonCard.dart';
import 'package:flutter/material.dart';

import '../Component/TopNavBar.dart';
import '../Services/AIServices.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEditingExperience = false;
  bool isEditingInterest = false;
  bool isEditingEducation = false;

  TextEditingController experienceController = TextEditingController(text: "Internship as Frontend Developer");
  TextEditingController interestController = TextEditingController(text: "Editing video and vlog");
  TextEditingController educationController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.");

  final List<Map<String, dynamic>> lessons = [
    {
      "title": "Data Structures and Algorithms",
      "imageUrl": "assets/course1.png",
      "chapters": 10,
      "hours": 6,
    },
    {
      "title": "Introduction to Machine Learning",
      "imageUrl": "assets/course3.jpg",
      "chapters": 12,
      "hours": 8,
    },
    {
      "title": "Mobile App Development",
      "imageUrl": "assets/course7.jpg",
      "chapters": 15,
      "hours": 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(page: 'profile'),
      backgroundColor: const Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                  width: 1000,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
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
                                const CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage('profile.png'), // Replace with your image
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Free Tier",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Micheal Wong",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Row(
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
                        const SizedBox(width: 20),
                        // Vertical Divider
                        Container(width: 1, height: 170, color: Colors.black26),
                        const SizedBox(width: 20),
                        // Right Education Section
                        const Expanded(
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
                                logo: 'school1.png', // Replace with University of Edinburgh logo
                                university: "University of Edinburgh",
                                duration: "2022–2024",
                                degree: "Master of Science in Artificial Intelligence",
                              ),
                              SizedBox(height: 10),
                              EducationItem(
                                logo: 'school2.png', // Replace with UPM logo
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
                  const SizedBox(height: 50,),
                  Container(
                    width: 1000,
                    height: 332,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
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
                              const Expanded( // Prevents text overflow
                                child: Text(
                                  "Lesson Achieved",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFFF2994A)),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Implement navigation to a detailed interview list
                                },
                                icon: const Icon(Icons.refresh, size: 25,),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 875,
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal, // Horizontal list
                                  itemCount: lessons.length,
                                  itemBuilder: (context, index) {
                                    final lesson = lessons[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: LessonCard(
                                        title: lesson['title'],
                                        imageUrl: lesson['imageUrl'],
                                        chapters: lesson['chapters'],
                                        hours: lesson['hours'],
                                      ),
                                    );
                                  },
                                ),
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
                                    icon: const Icon(
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
                  const SizedBox(height: 50,),
                  Row(
                    children: [
                      // Experience Section (Editable)
                      _editableSection(
                        "Experience",
                        experienceController,
                        isEditingExperience,
                            () => setState(() => isEditingExperience = !isEditingExperience),
                      ),

                      const SizedBox(width: 50,),

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
              const SizedBox(width: 70,),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
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
                      const Text(
                          'Unlock your full potential with Premium Tier',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        width: 170,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFAD6B7),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 15,),
                            const CircleAvatar(
                              backgroundImage: AssetImage('profile.png'), // Ensure correct path
                              radius: 20,
                            ),
                            const SizedBox(width: 15,),
                            GestureDetector(
                              onTap: () async {
                                AIService aiService = AIService();

                                String userAnswer = "I have 3 years of experience in Flutter development.";
                                String evaluation = await aiService.evaluateAnswer(userAnswer);

                                print("AI Feedback: $evaluation");
                              },
                              child: Container(
                                width: 80,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffff51007),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Premium Tier",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text(
                        'With benefits of:',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          '- Download Resume                            - Personalized Upskills',
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
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
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
              const Spacer(),
              GestureDetector(
                onTap: onEditPress,
                child: const Icon(Icons.edit, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            enabled: isEditing,
            maxLines: 3,
            decoration: const InputDecoration(
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
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(university, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(duration, style: const TextStyle(fontSize: 14)),
            Text(degree, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }
}