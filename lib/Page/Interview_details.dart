import 'package:careeradvisor_kitahack2025/Page/LiveInterviewScreen.dart';
import 'package:flutter/material.dart';
import '../Component/TopNavBar.dart';

class Interview_details extends StatelessWidget {
    final Map<String, dynamic> interview;
  const Interview_details({super.key, required this.interview});

  @override
  Widget build(BuildContext context) {
  final Map<String, String> mcqTest = {
    'assessmentName': 'react js',
    'Aptitude' : '10',
    'Technical' : '10',
    'Total' : '40',
    'Reasoning' : '10',
    'CutOff' : '70%',
    'Verbal' : '10'
  };
  final Map <String, String> techIV = {
    'InterviewType' : 'AI-based Interview',
    'InterviewLevel' : 'Medium',
    'TotalQuestion' : '5' 
  };
    final Map <String, String> hrIV = {
    'InterviewType' : 'Virtual Interview',
    'InterviewLevel' : 'Not added',
    'TotalQuestion' : 'Not added' 
  };
  final Map<String, String> jobInfo = {
    'Salary': '35k-40k',
    'Part / Full Time': 'Full Time',
    'Experience': '2+ years',
    'Work Mode': 'Hybrid',
    'Location': 'Chennai',
    'Openings': '5',
  };
        List<Map<String, dynamic>> jobHistory = [
      {
        'role': 'Software Engineer',
        'date': 'Dec 20, 2024',
        'location' : 'Malaysia',
        'communication': '89%',
        'technical': '84%',
        'overall': '86%',
        'image': 'assets/profile.png',
      },
      {
        'role': 'Software Engineer',
        'date': 'Jan 20, 2025',
        'location' : 'Malaysia',
        'communication': '92%',
        'technical': '88%',
        'overall': '90%',
        'image': 'assets/profile.png',
      },
      {
        'role': 'Software Engineer',
        'date': 'Feb 20, 2025',
        'location' : 'Malaysia',
        'communication': '85%',
        'technical': '90%',
        'overall': '87%',
        'image': 'assets/profile.png',
      },
    ];

    return Scaffold(
      appBar: TopNavBar(),
      backgroundColor: const Color(0xFFFFF5EC),
      body: 
      // SingleChildScrollView(
      //   child: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child:
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: jobHistory.length,
                      itemBuilder: (context, index) {
                    return JobCard(role: interview['role'],jobData: jobHistory[index]);
              },
            ),
                  ),
                  Expanded(
                    flex: 2,
                    child: JobDetails(jobTitle: interview['role'], companyName: interview['company'], logo:interview['logo'],jobDesc: interview['jobDesc'],responsibilities: interview['responsibilities'],requiredSkills: interview['requiredSkills'],jobInfo: jobInfo, mcqTest: mcqTest, techIV: techIV, hrIV: hrIV),
                  ),
                ],
              ),
        ),
      // ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Map<String, dynamic> jobData;
  final String role;
  const JobCard({super.key, required this.role, required this.jobData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(jobData['image']),
                  radius: 30,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Role: ${role}',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(jobData['date'], style: const TextStyle(fontSize: 12,color: Color(0xFF717171)),),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.place,color: Color(0xFFA4A4A4),size: 13.0),
                        const SizedBox(width: 3.0), // Add some spacing between icon and text
                        Text(
                          jobData['location'],
                          style: const TextStyle(fontSize: 13.0,color: Color(0xFFA4A4A4),fontWeight: FontWeight.w500), // You can customize the text style
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(jobData['communication'], style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            const Text('Communication',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w100),)
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          children: [
                            Text(jobData['technical'], style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            const Text('Technical skills',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w100),)
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          children: [
                            Text(jobData['overall'], style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            const Text('Overall all score',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w100),)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(onPressed: () {}, child: 
                    const Row(
                      children: [
                        Text('View More', style: TextStyle(fontSize: 13, color: Color(0xFFFF6B00)),),
                        SizedBox(width: 5,),
                        Icon(Icons.arrow_circle_right_outlined, size: 13,color: Color(0xFFFF6B00),),
                      ],
                    )),
                    
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


class JobDetails extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String logo;
  final String jobDesc;
  final String responsibilities;
  final List <String> requiredSkills;
  final Map<String, String> jobInfo; // Receive jobInfo as a parameter
  final Map<String, String> mcqTest;
  final Map<String, String> techIV;
  final Map<String, String> hrIV;

  const JobDetails({super.key, required this.jobTitle, required this.companyName, required this.logo, required this.jobDesc, required this.responsibilities, required this.requiredSkills, required this.jobInfo, required this.mcqTest, required this.techIV, required this.hrIV});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.width * 0.96,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.orange,width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Basic Job Details', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: Color(0xFFFF6B00))),
              const SizedBox(height: 10),
              Text(jobTitle,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('-- $companyName',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w300, color: Color(0xFF747474))),
              // const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
  flex: 2,
  child: GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 10,
    ),
    itemCount: jobInfo.length,
    itemBuilder: (context, index) {
      final entry = jobInfo.entries.toList()[index];
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(0xFFFF6B00),
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText( // Use RichText
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${entry.key}: ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF747474),
                  ),
                ),
                TextSpan(
                  text: entry.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF747474),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

                    Expanded(
                      flex: 1, // Image takes 1/3 of space
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: 100,
                            maxWidth: 100,
                          ),
                          child: Image.asset(logo, fit: BoxFit.contain)), // Replace with your image path
                      ),
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),              
              const Text('Job Description : ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
              const SizedBox(height: 4),
              Text(jobDesc),
              const SizedBox(height: 10),
              const Text('Responsibilities : ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
              const SizedBox(height: 4),
              Text(responsibilities),
              const SizedBox(height: 10),
              const Text('Required Skills : ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),),
              const SizedBox(height: 4),
              // const Text('- Google Flutter'),
              // const Text('- Google Cloud'),
              // const Text('- Data Structures and Algorithms'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: requiredSkills.map((skill)=>Text('- $skill')).toList(),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: Color(0xFFFF6B00),
                  thickness: 2.0,
                ),
              ),    
              const Text('MCQ Test', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Color(0xFFFF6B00))),
              const SizedBox(height: 15),
              _buildGrid(mcqTest),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: Color(0xFFFF6B00),
                  thickness: 2.0,
                ),
              ),
              const Text('Technical Interview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Color(0xFFFF6B00))),
              const SizedBox(height: 15),
              _buildGrid(techIV),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: Color(0xFFFF6B00),
                  thickness: 2.0,
                ),
              ),     
              const Text('HR Interview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Color(0xFFFF6B00))),
              const SizedBox(height: 15),
              _buildGrid(hrIV),
              const SizedBox(height: 40),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ready to begin your mock interview? ',style: TextStyle(color: Color(0xFF747474),fontSize: 15),),
                    Icon(Icons.info, color: Color(0xFFC3C3C3),size: 15,)
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=> MockInterviewScreen(showNotification:true,jobTitle: jobTitle, companyName: companyName, responsibilities: responsibilities, jobDesc:jobDesc)),
                );
                //Navigate to MockInterviewScreen()
                },style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B00),foregroundColor: Colors.white), child: const Text('Normal Mode'),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=> MockInterviewScreen(showNotification: false, jobTitle: jobTitle, companyName: companyName, responsibilities:responsibilities, jobDesc:jobDesc)),
                );
              },style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD9D9D9),foregroundColor: Colors.white), child: const Text('Intensive Mode'),),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildGrid(Map<String, String> data){
    return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 10,
    ),
    itemCount: data.length,
    itemBuilder: (context, index) {
      final entry = data.entries.toList()[index];
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(0xFFFF6B00),
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: RichText( // Use RichText
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${entry.key}: ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF747474),
                  ),
                ),
                TextSpan(
                  text: entry.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF747474),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
   );
  }
}
