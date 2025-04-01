import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Component/NavBarSignup.dart';
import '../Services/AIServices.dart';
import '../Services/Provider.dart';

class SignUp extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<SignUp> createState() => _SignUpState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fieldStudyController = TextEditingController();
  List<Map<String, dynamic>> recommended = [];
  List<Map<String, dynamic>> relevant = [];
  final AIService apiService = AIService();

  String cleanJson(String response) {
    return response.replaceAll(RegExp(r'```json|```'), '').trim();
  }

  // Method to validate the cleaned JSON and parse it
  dynamic parseJson(String response) {
    response = cleanJson(response);

    if (!response.startsWith('{') && !response.startsWith('[')) {
      throw FormatException("Unexpected response format: Not valid JSON");
    }
    return jsonDecode(response);
  }

  void _onSearch() async {
    String query = _fieldStudyController.text.trim();
    if (query.isEmpty) return;

    try {
      // Get the recommendation data
      String recommendJsonData = await apiService.getRecommend(query);
      String relevantJsonData = await apiService.getRelevant(query);

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
              SnackBar(content: Text("Failed to fetch recommendations.")));
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
            SnackBar(content: Text("Invalid response format.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarSignup(),
      body: Container(
        color: Color( 0xFFFFF5EC),
        height:double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.only(top:30,start: 50,end:50),
            height: 1300,
            width: 1350,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(30)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Sign up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF2994A),
                  ),),
                SizedBox(
                  height: 5,
                ),
                Text('Sign up to enjoy the feature of TalentTrail',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 50,end: 50),
                  child: Column(
                    children: [
                      Row(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Name",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Email",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Location",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Phone Number",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 40,
                      ),
                      Row(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Highest Education Level",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              controller: _fieldStudyController,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Field of Study Major",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              ),
                              onSubmitted: (_)=>_onSearch(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "University/ Institution Name",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:200,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Graduation Year",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 40,
                      ),
                      Row(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Year of Work Experience",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:900,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Industry of Work Experience",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Past Work Experience ",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 40,
                      ),
                      Row(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Hard Skills",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Soft Skills",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:1300,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Certifications & Licenses ",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 40,
                      ),
                      Row(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Preferred Work Mode",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Industries of Interest",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width:400,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Salary Expectation",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Job Prioritization Factors",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width:600,
                            child: TextField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFF2994A)
                                  ),
                                  labelText: "Preferred Locations for Work",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFF2994A)
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                SizedBox(
                  height:40,
                ),
                GestureDetector(
                  onTap: (){
                    context.go('/home');
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: 100,end:100),
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 110),
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2994A),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style:TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: (){
                        context.go('/');
                      },
                      child: Container(
                        child: Text('Log in',
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
  Size get preferredSize => Size.fromHeight(60); }
