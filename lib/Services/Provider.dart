import 'package:flutter/material.dart';

class RecommendationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> recommended = [];
  List<Map<String, dynamic>> relevant= [];

  void updateRecommendations(List<Map<String, dynamic>> newRecommendations) {
    recommended = newRecommendations;
    notifyListeners();
  }

  void updateRelevant(List<Map<String, dynamic>> newRelevant) {
    relevant = newRelevant;
    notifyListeners();
  }
}