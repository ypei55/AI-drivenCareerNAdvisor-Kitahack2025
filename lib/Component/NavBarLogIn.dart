import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarLogIn extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          // Logo with title
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "TalentTrail",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2994A), // Orange color
                        ),
                      ),
                      SizedBox(height: 10), // Space between text and oval
                    ],
                  ),
                  Positioned(
                    bottom: 6, // Adjust this value for fine-tuning
                    child: CustomPaint(
                      size: Size(120, 6), // Width & height of the oval
                      painter: OvalPainter(),
                    ),
                  ),
                ],
              )
          ),
          Spacer(),
          // Navigation items
          GestureDetector(
            onTap: (){
              context.go('/signup');
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFF2994A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                    'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
              ),
            ),
        ],
      ),
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Custom Painter for the Oval Shape
class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFF2994A) // Oval color
      ..style = PaintingStyle.stroke // Stroke to create a ring effect
      ..strokeWidth = 4.0; // Thickness of the oval

    Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
