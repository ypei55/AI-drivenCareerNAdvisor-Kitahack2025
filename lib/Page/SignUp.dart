import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Component/NavBarSignup.dart';
import '../Services/AIServices.dart';
import '../Services/Provider.dart';

class SignUp extends StatefulWidget implements PreferredSizeWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fieldStudyController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();
  final TextEditingController _hardSkillController = TextEditingController();
  List<Map<String, dynamic>> recommended = [];
  List<Map<String, dynamic>> relevant = [];
  List<int> jobOpenings = [];
  List<String> skills = [];
  List<String> companies = [];
  String salary='';
  final AIService apiService = AIService();

  String cleanJson(String response) {
    return response.replaceAll(RegExp(r'```json|```'), '').trim();
  }

  // Method to validate the cleaned JSON and parse it
  dynamic parseJson(String response) {
    response = cleanJson(response);

    if (!response.startsWith('{') && !response.startsWith('[')) {
      throw const FormatException("Unexpected response format: Not valid JSON");
    }
    return jsonDecode(response);
  }

  Future<void> _onSearch() async {
    String query = _fieldStudyController.text.trim();
    String query1 = _jobRoleController.text.trim();
    String query2 = _hardSkillController.text.trim();

    if (query.isEmpty || query1.isEmpty || query2.isEmpty) {
      return;
    }

    try {
      // Get the recommendation data
      String recommendJsonData = await apiService.getRecommend(query,query1,query2);
      String relevantJsonData = await apiService.getRelevant(query,query1,query2);

      // Debugging: Print the cleaned response
      print("Recommendations API Response: $recommendJsonData");
      print("Relevant API Response: $relevantJsonData");

      // Use the parseJson function to clean and decode the JSON data
      Map<String, dynamic> recommendData = parseJson(recommendJsonData);
      Map<String, dynamic> relevantData = parseJson(relevantJsonData);

      // Handle cases where 'recommendations' is missing or not a List
      if (!recommendData.containsKey('recommendations') || recommendData['recommendations'] is! List) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to fetch recommendations.")));
        }
        return;
      }

      // Update the recommendations list with the fetched data
      recommended = List<Map<String, dynamic>>.from(recommendData['recommendations']);
      relevant = List<Map<String, dynamic>>.from(relevantData['relevant']);

      // Update the provider with the new recommendations
      if (mounted) {
        Provider.of<RecommendationProvider>(context, listen: false)
            .updateRecommendations(recommended);

        Provider.of<RecommendationProvider>(context, listen: false)
            .updateRelevant(relevant);
      }

    } catch (e) {
      print("JSON Decode Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid response format.")));
      }
    }
  }

  Future<void> _onSearch1() async {
    String query = recommended[0]['title'];
    if (query.isEmpty) return;

    try {
      String jsonData = await apiService.getJobOpenings(query);
      String skillJsonData = await apiService.getCommonSkills(query);
      String companyJsonData = await apiService.getTopHiringCompanies(query);
      String salaryJsonData = await apiService.getSalary(query);

      // Debugging: Print raw API responses
      print("Raw Job Openings API Response: ${jsonData.runtimeType} -> $jsonData");
      print("Raw Skills API Response: ${skillJsonData.runtimeType} -> $skillJsonData");
      print("Raw Companies API Response: ${companyJsonData.runtimeType} -> $companyJsonData");
      print("Raw Salary API Response: ${salaryJsonData.runtimeType} -> $salaryJsonData");

      // Ensure API response is a valid JSON string
      String cleanJson(String response) {
        return response.replaceAll(RegExp(r'```json|```'), '').trim();
      }

      // Validate if the response is JSON or contains unexpected formatting
      dynamic parseJson(String response) {
        response = cleanJson(response);
        if (!response.startsWith('{') && !response.startsWith('[')) {
          throw const FormatException("Unexpected response format: Not valid JSON");
        }
        return jsonDecode(response);
      }

      Map<String, dynamic> jobData = parseJson(jsonData);
      Map<String, dynamic> skillData = parseJson(skillJsonData);
      Map<String, dynamic> companyData = parseJson(companyJsonData);
      Map<String, dynamic> salaryData = parseJson(salaryJsonData);

      // Handle API error responses
      if (jobData.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to fetch job data.")));
        return;
      }

      if (!skillData.containsKey('skills') || skillData['skills'] is! List) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to fetch skills.")));
        return;
      }

      if (!companyData.containsKey('companies') || companyData['companies'] is! List) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to fetch hiring companies.")));
        return;
      }

      if (!salaryData.containsKey('salary')) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to fetch salary.")));
        return;
      }

      // Update state with validated data
      setState(() {
        jobOpenings = [
          jobData['2020'] ?? 0,
          jobData['2021'] ?? 0,
          jobData['2022'] ?? 0,
          jobData['2023'] ?? 0,
          jobData['2024'] ?? 0,
        ];

        skills = List<String>.from(skillData['skills']);

        companies = List<String>.from(companyData['companies']);
        salary = salaryData['salary'];
      });

      Provider.of<RecommendationProvider>(context, listen: false)
          .updateJobOpenings(jobOpenings);

      Provider.of<RecommendationProvider>(context, listen: false)
          .updateSkills(skills);

      Provider.of<RecommendationProvider>(context, listen: false)
          .updateCompanies(companies);

      Provider.of<RecommendationProvider>(context, listen: false)
          .updateSalary(salary);

    } catch (e) {
      print("JSON Decode Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid response format.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarSignup(),
      body: Container(
        color: const Color( 0xFFFFF5EC),
        height:double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsetsDirectional.only(top:30,start: 50,end:50),
            height: 1300,
            width: 1350,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(30)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Sign up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF2994A),
                  ),),
                const SizedBox(
                  height: 5,
                ),
                const Text('Sign up to enjoy the feature of TalentTrail',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 50,end: 50),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Basic Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Name",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Email",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Location",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Phone Number",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Password",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Education Background',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.school_outlined,
                            color: Colors.grey,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Highest Education Level",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              controller: _fieldStudyController,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Field of Study Major",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "University/ Institution Name",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:200,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Graduation Year",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Professional Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.description_outlined,
                            color: Colors.grey,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Year of Work Experience",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:900,
                            child: TextField(
                              controller: _jobRoleController,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Job Role",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Past Work Experience ",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Skills & Certifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.workspace_premium,
                            color: Colors.grey,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              controller: _hardSkillController,
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Hard Skills",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Soft Skills",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Certifications & Licenses ",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Career Preferences & Interests',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.business_center,
                            color: Colors.grey,
                            size: 25,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Preferred Work Mode",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Industries of Interest",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Salary Expectation",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Job Prioritization Factors",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Preferred Locations for Work",
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height:40,
                ),
                GestureDetector(
                  onTap: ()
                    async{
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                      );

                      try{
                         await _onSearch();
                         await _onSearch1();
                         context.go('/home');
                      }
                      finally{
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 100,end:100),
                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 110),
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF2994A),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23
                      ),),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                        style:TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: (){
                        context.go('/');
                      },
                      child: Container(
                        child: const Text('Log in',
                          style: TextStyle(
                              color: Color(0xFFF2994A),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFF2994A)
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); }
