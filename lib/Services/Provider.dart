import 'package:flutter/material.dart';

class RecommendationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> recommended = [];
  List<Map<String, dynamic>> relevant= [];
  List<int> jobOpenings = [];
  List<String> skills = [];
  List<String> companies = [];
  String salary='';

  void updateRecommendations(List<Map<String, dynamic>> newRecommendations) {
    recommended = newRecommendations;
    notifyListeners();
  }

  void updateRelevant(List<Map<String, dynamic>> newRelevant) {
    relevant = newRelevant;
    notifyListeners();
  }

  void updateJobOpenings(List<int> newJobOpenings) {
    jobOpenings = newJobOpenings;
    notifyListeners();
  }

  void updateSkills(List<String> newSkills) {
    skills = newSkills;
    notifyListeners();
  }

  void updateCompanies(List<String> newCompanies) {
    companies = newCompanies;
    notifyListeners();
  }

  void updateSalary(String newSalary) {
    salary = newSalary;
    notifyListeners();
  }
}