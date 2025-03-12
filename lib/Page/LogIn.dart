import 'package:careeradvisor_kitahack2025/Component/NavBarLogIn.dart';
import 'package:flutter/material.dart';


class Login extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarLogIn(),
      body: Text('Login'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust height if needed
}
