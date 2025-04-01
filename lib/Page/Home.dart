import 'dart:convert';

import 'package:careeradvisor_kitahack2025/Page/SignUp.dart';
import 'package:careeradvisor_kitahack2025/Services/Provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Component/TopNavBar.dart';
import '../Services/AIServices.dart';

class Home extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<Home> createState() => _HomeState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final AIService apiService = AIService();
  List<int> jobOpenings = [0,0,0,0,0];
  List<String> skills = [];
  List<String> companies = [];
  String salary='';

  void _onSearch() async {
    String query = _searchController.text.trim();
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
          throw FormatException("Unexpected response format: Not valid JSON");
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
            SnackBar(content: Text("Failed to fetch job data.")));
        return;
      }

      if (!skillData.containsKey('skills') || skillData['skills'] is! List) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to fetch skills.")));
        return;
      }

      if (!companyData.containsKey('companies') || companyData['companies'] is! List) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to fetch hiring companies.")));
        return;
      }

      if (!salaryData.containsKey('salary')) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to fetch salary.")));
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
    } catch (e) {
      print("JSON Decode Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid response format.")));
    }
  }

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(jobOpenings.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: jobOpenings[index].toDouble(),
            color: Colors.orange,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  List<String> filterOptions = [
    "High salary",
    "High growth potential",
    "Good company culture",
    "Learning opportunity",
    "Job stability",
    "Work life balance"
  ];

  Set<String> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> recommended = Provider.of<RecommendationProvider>(context).recommended;
    List<Map<String, dynamic>> relevant = Provider.of<RecommendationProvider>(context).relevant;
    return Scaffold(
      appBar: TopNavBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsetsDirectional.only(start:50,end:25,top:30),
          color: Color( 0xFFFFF5EC),
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Market Statistics',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25
                    ) ,
                  ),SizedBox(
                    width: 15,
                  ),
                  Image(image:AssetImage('assets/market.png'),
                    height:60,),
                  SizedBox(
                    width: 700,
                  ),
                  GestureDetector(
                    onTap: (){
                      context.go('/profile');
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: 100,end:100),
                      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 30),
                      width: 280,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2994A),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('Adjust your Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23
                        ),),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 300,
                width: 1400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width:400,
                          height:30 ,
                          child: SearchBar(
                            controller:_searchController,
                            backgroundColor:WidgetStateProperty.all(Colors.white) ,
                            hintText: 'Search for specific job',
                            hintStyle:WidgetStatePropertyAll(TextStyle(
                              color:Colors.grey
                            )),
                            leading: Icon(Icons.search,color: Colors.grey,),
                            onSubmitted: (_)=>_onSearch(),
                          )
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:100),
                          child: Text('Job Openings',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            )
                            ,),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 150,
                          width: 400,
                          child: BarChart(
                            BarChartData(
                              barGroups: _getBarGroups(),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget: (value, meta) {
                                        if (value % 10000 == 0) {
                                          return Text('${(value ~/ 1000)}K',
                                            style: TextStyle(fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          );
                                        }
                                        return SizedBox.shrink();
                                      }
                                  ),

                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false
                                  )
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false), // Hide numbers on top
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value,meta){
                                      const years = ['2020','2021','2022','2023','2024'];
                                      return Text(years[value.toInt()]);
                                    }
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  drawHorizontalLine: true,
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 80,top:25,bottom:25,end:80),
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 25),
                          child: Column(
                            children: [
                              Text('Common Required Skills',
                                  style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25
                                  )
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
          SizedBox(
            width: 300,
            height: 200,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: skills.map((skill) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
          ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 80,top:25,bottom:25,end:40),
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Top Hiring Companies',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            height: 130,
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: companies.map((company){
                                    return Padding(
                                        padding:EdgeInsets.only(top:15),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.verified,
                                              color:Colors.orange
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              company,
                                              style:TextStyle(
                                                fontSize: 15
                                              ) ,)
                                          ],
                                        ),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Average Salary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(end:125),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Image(
                                    image:AssetImage('assets/salary.png',),
                                    height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(salary,
                                  style:TextStyle(
                                      fontSize: 15
                                  ) ,)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height:20
              ),
              Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Recommended Job',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(image:AssetImage('assets/recommended.png'),
                          height:40,),
                        SizedBox(
                          width: 1050,
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.filter_alt_sharp,
                            size: 40,),
                          onSelected: (String value) {
                            setState(() {
                              if (selectedFilters.contains(value)) {
                                selectedFilters.remove(value);
                              } else {
                                selectedFilters.add(value);
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return filterOptions.map((String option) {
                              bool isSelected = selectedFilters.contains(option);
                              return PopupMenuItem<String>(
                                value: option,
                                child: Row(
                                  children: [
                                    if (isSelected) Icon(Icons.check, color: Colors.black),
                                    if (isSelected) SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontWeight:
                                          isSelected ? FontWeight.bold : FontWeight.normal,
                                          backgroundColor: isSelected
                                              ? Colors.orange[100]
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                     height: 15,
                    ),
                   Container(
                     height: 180,
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       physics: BouncingScrollPhysics(),
                       itemCount: recommended.length,
                       itemBuilder: (context,index){
                         return Container(
                             width: 440,
                             height: 180,
                             margin: EdgeInsetsDirectional.only(end: 40),
                             padding: EdgeInsetsDirectional.only(top: 15),
                             decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child: Column(
                               children: [
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Image(image: AssetImage('assets/software.png'),height: 30,),
                                     SizedBox(
                                       width: 35,
                                     ),
                                     Text(recommended[index]['title']?? 'No Title',
                                       style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 25
                                       ),
                                     )
                                   ],
                                 ),
                                 SizedBox(
                                   height: 15,
                                 ),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Image(image: AssetImage('assets/salary.png'),height: 15,),
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Text(recommended[index]['salary']?? 'No Salary Info',
                                       style: TextStyle(
                                           fontSize: 15
                                       ),
                                     )
                                   ],
                                 ),
                                 SizedBox(
                                   height: 15,
                                 ),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Image(image: AssetImage('assets/skills.png'),height: 15,),
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Text(recommended[index]['skills']?? 'No Skills Info',
                                       style: TextStyle(
                                           fontSize: 15
                                       ),
                                     )
                                   ],
                                 ),
                                 SizedBox(
                                   height: 15,
                                 ),
                                 Row(
                                   children: [
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Image(image: AssetImage('assets/match.png'),height: 15,),
                                     SizedBox(
                                       width: 15,
                                     ),
                                     Text(recommended[index]['match']?? 'No Match Info',
                                       style: TextStyle(
                                           fontSize: 15
                                       ),
                                     )
                                   ],
                                 )
                               ],
                             ),
                           );
                       },
                     ),
                   )
                  ],
                ) ,
              ),
              SizedBox(
                  height:20
              ),
              Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Relevant Job',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(image:AssetImage('assets/relevant.png'),
                          height:40,),
                        SizedBox(
                          width: 1120,
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.filter_alt_sharp,
                            size: 40,),
                          onSelected: (String value) {
                            setState(() {
                              if (selectedFilters.contains(value)) {
                                selectedFilters.remove(value);
                              } else {
                                selectedFilters.add(value);
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return filterOptions.map((String option) {
                              bool isSelected = selectedFilters.contains(option);
                              return PopupMenuItem<String>(
                                value: option,
                                child: Row(
                                  children: [
                                    if (isSelected) Icon(Icons.check, color: Colors.black),
                                    if (isSelected) SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontWeight:
                                          isSelected ? FontWeight.bold : FontWeight.normal,
                                          backgroundColor: isSelected
                                              ? Colors.orange[100]
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relevant.length,
                        itemBuilder: (context,index){
                          return Container(
                            width: 440,
                            height: 180,
                            margin: EdgeInsetsDirectional.only(end: 40),
                            padding: EdgeInsetsDirectional.only(top: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image(image: AssetImage('assets/software.png'),height: 30,),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(relevant[index]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image(image: AssetImage('assets/salary.png'),height: 15,),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(relevant[index]['salary'],
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image(image: AssetImage('assets/skills.png'),height: 15,),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(relevant[index]['skills'],
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image(image: AssetImage('assets/match.png'),height: 15,),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(relevant[index]['match'],
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); }


