import 'package:flutter/material.dart';

import '../Component/NavBarSignup.dart';

class SignUp extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarSignup(),
      body: Text('Signup'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust height if needed
}
