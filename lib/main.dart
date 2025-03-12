import 'package:careeradvisor_kitahack2025/Page/CheckerResults.dart';
import 'package:careeradvisor_kitahack2025/Page/LogIn.dart';
import 'package:careeradvisor_kitahack2025/Page/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'Page/Checker.dart';
import 'Page/Courses.dart';
import 'Page/Home.dart';
import 'Page/Interview.dart';
import 'Page/Profile.dart'; // Import the component

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      builder: (context, state) => CheckerResults(),
    ),
    GoRoute(
      path: '/interview',
      builder: (context, state) => Interview(),
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => Courses(),
    ),
  ],
);
