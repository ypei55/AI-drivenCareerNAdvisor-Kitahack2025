import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Component/TopNavBar.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Interview(),
//     );
//   }
// }

class Interview extends StatelessWidget {
  final List<Map<String, dynamic>> interviewData = [
    {
      'company': 'ANT Company',
      'role': 'Software Engineer',
      'image': 'job1.jpg',
      'logo': 'assets/Ant_Group_logo.png',
      'sessions': '2',
      'jobDesc':'Develop high-quality software solutions, troubleshoot issues, and optimize application performance. Participate in the entire software development lifecycle, from planning and design to deployment and maintenance. Work with cross-functional teams to enhance product features and ensure software meets business requirements.',
      'responsibilities': 'Collaborate with teams to design and implement scalable software solutions. Write clean, maintainable, and efficient code following best practices. Conduct code reviews and optimize performance. Integrate APIs and third-party services. Ensure security, reliability, and performance of applications. Participate in Agile development processes, including sprint planning and retrospectives.',
      'requiredSkills': ["Flutter", "Google Cloud", "DSA", "RESTful APIs", "CI/CD", "Unit Testing", "Firebase", "Git"]
    },
    {
      'company': 'NETFLIX ',
      'role':'Platform Engineer',
      'image': 'job2.jpg',
      'logo': 'assets/Netflixlogo.png',
      'sessions': '2',
      'jobDesc':'Design, develop, and maintain scalable platform solutions to support high-traffic applications. Optimize system performance, reliability, and security. Work closely with product teams to enhance platform capabilities and ensure seamless integration of services. Automate infrastructure deployment and monitoring processes to improve efficiency.',
      'responsibilities': 'Collaborate with cross-functional teams to build and maintain highly available, scalable, and secure platform services. Write clean, efficient, and well-documented code to improve system reliability. Implement monitoring and alerting solutions to ensure platform stability. Optimize databases, caching mechanisms, and server performance. Automate deployment pipelines and CI/CD workflows. Troubleshoot and resolve production issues to maintain platform uptime.',
      'requiredSkills': ["PHP", "Firebase", "DSA", "Microservices", "Kubernetes", "Cloud Computing", "DevOps", "CI/CD", "NoSQL Databases", "Docker"]
    },
    {
      'company': 'AWS',
      'role': 'Junior Consultant',
      'image': 'job3.jpg',
      'logo': 'assets/AWSlogo.png',
      'sessions': '3',
      'jobDesc':'Assist clients in designing, deploying, and optimizing cloud-based solutions using AWS services. Work closely with senior consultants and technical teams to understand business requirements and provide tailored recommendations. Support cloud migration, security assessments, and performance optimization initiatives. Develop technical documentation and provide training to clients on AWS best practices.',
      'responsibilities': 'Collaborate with teams to assess client needs and propose AWS solutions. Assist in deploying and configuring cloud infrastructure. Support security and compliance efforts by implementing AWS best practices. Troubleshoot and optimize cloud workloads to improve performance and cost efficiency. Develop technical documentation and presentations for clients. Participate in training sessions and workshops to enhance cloud expertise.',
      'requiredSkills': ["AWS Services", "Cloud Computing", "Infrastructure as Code (IaC)", "Python", "Linux", "Networking Basics", "Security Best Practices", "Terraform", "DevOps", "CI/CD"]
    },
    {
      'company': 'EXACT Company',
      'role': 'Software Engineer',
      'image': 'job1.jpg',
      'logo': 'assets/ExactCompanyLogo.png',
      'sessions': '3',
      'jobDesc':'Design, develop, and maintain robust software applications that meet business and user requirements. Write clean, efficient, and scalable code while following best development practices. Work collaboratively with cross-functional teams to build high-quality software solutions.',
      'responsibilities': 'Develop and maintain software applications using modern programming languages and frameworks. Participate in code reviews, debugging, and troubleshooting. Collaborate with product managers, designers, and other engineers to enhance user experience. Optimize application performance and scalability. Ensure security and data integrity in software solutions.',
      'requiredSkills': ["Java", "Spring Boot", "React", "SQL", "RESTful APIs", "Git"]
    },
    {
      'company': 'OpenAI',
      'role': 'Research Engineer',
      'image': 'job4.jpg',
      'logo': 'assets/OpenAILogo.png',
      'sessions': '2',
      'jobDesc':'Conduct cutting-edge research in artificial intelligence, develop machine learning models, and contribute to innovative AI solutions. Work on improving and optimizing deep learning architectures and algorithms to enhance AI capabilities.',
      'responsibilities': 'Develop and experiment with AI models and architectures. Optimize neural networks for performance and scalability. Work with large-scale datasets to train and evaluate AI models. Collaborate with researchers and engineers to implement new AI methodologies. Publish research findings and contribute to the AI community.',
      'requiredSkills': ["Python", "PyTorch", "TensorFlow", "NLP", "Deep Learning", "Reinforcement Learning", "Scientific Research"]
    },
    {
      'company': 'Microsoft',
      'role': 'AI Engineer',
      'image': 'job5.png',
      'logo': 'assets/MicrosoftLogo.png',
      'sessions': '2',
      'jobDesc':'Design and develop AI-powered solutions that enhance Microsoft products and services. Implement machine learning models, integrate AI-driven features, and improve automation across different applications.',
      'responsibilities': 'Build and deploy machine learning models for real-world applications. Work on AI-driven automation and intelligent assistants. Optimize AI models for scalability and efficiency. Collaborate with software engineers and data scientists to integrate AI solutions. Conduct research and stay updated on the latest advancements in AI and machine learning.',
      'requiredSkills': ["Machine Learning", "Azure AI", "Python", "Deep Learning", "NLP", "Computer Vision", "MLOps"]
    },
  ];

  Interview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: const Color(0xFFFFF5EC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Practice Mock Interview for Any Role",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement navigation to a detailed interview list
                    },
                    child: const Text(
                      "view more",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 35,
                  mainAxisSpacing: 35,
                  childAspectRatio: 1.5,
                ),
                itemCount: interviewData.length,
                itemBuilder: (context, index) {
                  return _buildInterviewCard(context, interviewData[index]);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterviewCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Image.asset(
                    data['image']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 20,
                  child: Text(
                    '${data['company']!} - ${data['role']!}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data['sessions']!,
                      style:
                          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Text("Interview Sessions Required"),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/interview_detail', extra: data);
                    //Navigate to Interview_details
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(25),
                    backgroundColor: const Color(0xFF49BBBD),
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
