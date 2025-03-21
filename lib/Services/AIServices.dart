import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? ''; // Get API Key from .env
  late final GenerativeModel model;

  AIService() {
    if (apiKey.isEmpty) {
      throw Exception("API Key not found. Make sure you have a .env file.");
    }
    model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  Future<String> evaluateAnswer(String answer) async {
    final prompt = "Evaluate the following interview answer: '$answer'. "
        "Rate it from 1-10 based on clarity, relevance, and correctness. "
        "Provide a short explanation for the score.";

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error evaluating answer.";
  }
}
