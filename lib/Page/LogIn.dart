import 'package:careeradvisor_kitahack2025/Component/NavBarLogIn.dart';
import 'package:careeradvisor_kitahack2025/Services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Services/AIServices.dart';


class Login extends StatefulWidget implements PreferredSizeWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarLogIn(),
      body: Container(
        color: const Color( 0xFFFFF5EC),
        height:double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 500,
              width: 1350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(start:70,top:40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Log in',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF2994A),
                          ),),
                        const Text('Log in to improve your career path',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                        ),),
                        const SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          width:600,
                          child: TextField(
                            controller: _emailController,
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
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width:600,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
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
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _obscureText =!_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText ? Icons.visibility_off : Icons.visibility,
                                    ))
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: _signIn,
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(start: 100,end:100),
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 130),
                            width: 350,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2994A),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text('Log in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23
                            ),),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 190,
                            ),
                            const Text('Need an account?',
                            style:TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: (){
                                context.go('/signup');
                              },
                              child: Container(
                                child: const Text('Sign up',
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
                  const SizedBox(
                    width:50
                  ),
                  Image.asset("assets/Login.png",
                    width: 600,
                    alignment: const Alignment(3, 0),
                  )

                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void _signIn() async{
    String email = _emailController.text;
    String password=_passwordController.text;

    User ? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User is successfully signed in")
          ));
      print("User is successfully signed in");
      context.go('/home');
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Some error happend")
          ));
      print('Some error happend');
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); }
