import 'package:careeradvisor_kitahack2025/Page/CheckerResults.dart';
import 'package:careeradvisor_kitahack2025/Page/InterviewResults.dart';
import 'package:careeradvisor_kitahack2025/Page/Interview_details.dart';
import 'package:careeradvisor_kitahack2025/Page/LiveInterviewScreen.dart';
import 'package:careeradvisor_kitahack2025/Page/LogIn.dart';
import 'package:careeradvisor_kitahack2025/Page/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'Page/Checker.dart';
import 'Page/Courses.dart';
import 'Page/Home.dart';
import 'Page/Interview.dart';
import 'Page/Profile.dart'; // Import the component
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Services/Provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCvA8Pr4zEmYj-_C1yAvBn5ErdikdGETuo",
        projectId: "ai-drivencareernadvisor",
        messagingSenderId: "590026782937",
        appId: "1:590026782937:web:bd46249dffdc1952cce6c8",
    ));
  runApp(
      ChangeNotifierProvider(
          create: (context)=>RecommendationProvider(),
          child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,// Use GoRouter
    );
  }
}

// Define GoRouter
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUp(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => Profile(),
    ),
    GoRoute(
      path: '/checker',
      builder: (context, state) => Checker(),
    ),
    GoRoute(
      path: '/checkerresults',
      builder: (context, state) {
        final aiResponse = state.extra as String? ?? "No response available.";
        return CheckerResults(aiResponse: aiResponse);
      },
    ),
    GoRoute(
      path: '/interview',
      builder: (context, state) => Interview(),
    ),
    GoRoute(
        path: '/interview_detail',
      builder: (context, state){
          final data = state.extra as Map<String, dynamic>;
          return Interview_details(
            interview: {
              ...data, // Keep other keys unchanged
              'requiredSkills': (data['requiredSkills'] as List<dynamic>?)?.cast<String>() ?? [], // Fix type casting
            },
          );
      }
    ),
    GoRoute(
      path: '/live_interview',
      builder: (context, state) {
        final Map<String, dynamic> data = state.extra as Map<String, dynamic>? ?? {};

        return MockInterviewScreen(
          showNotification: data['showNotification'] ?? false, // Default to false if null
          jobTitle: data['jobTitle'] ?? 'Unknown Job',
          companyName: data['companyName'] ?? 'Unknown Company',
          responsibilities: data['responsibilities'] ?? 'No Responsibilities',
          jobDesc: data['jobDesc'] ?? 'No Job Description',
          isNormal: data['isNormal'] ?? true,
        );
      },
    ),
    GoRoute(
      path: '/interview_result',
      builder: (context, state){
        final extra = state.extra as Map<String, dynamic>?; // Extract 'extra'

        return InterviewResult(
          result: extra?['result'],
          videoUrl: extra?['videoUrl'],
          jobTitle: extra?['jobTitle'],
        );
      },
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => Courses(),
    ),
  ],
);
