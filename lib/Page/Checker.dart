import 'package:flutter/material.dart';

import '../Component/TopNavBar.dart';

class Checker extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      body: Text('checker'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust height if needed
}
