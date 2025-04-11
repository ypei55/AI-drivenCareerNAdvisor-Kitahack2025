import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  String page;
  TopNavBar({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final isHome = page.toLowerCase() == "home";
    final isChecker = page.toLowerCase() == "checker";
    final isInterview = page.toLowerCase() == "interview";
    final isCourses = page.toLowerCase() == "courses";

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      primary: false, // Ensures it doesn’t adapt to the body color
      title: Row(
        children: [
          // Logo with title
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Column(
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
                    size: const Size(120, 6), // Width & height of the oval
                    painter: OvalPainter(),
                  ),
                ),
              ],
            )
          ),
          const Spacer(),
          // Navigation items
          _buildNavItem('Home', context, '/home', isHome),
          _buildNavItem('Checker', context, '/checker', isChecker),
          _buildNavItem('Mock Interview', context, '/interview', isInterview),
          _buildNavItem('Courses', context, '/courses', isCourses),



          // Profile button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF2994A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  value = '/$value';
                  context.go(value); // Use GoRouter navigation
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "profile",
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black54), // Profile icon
                        SizedBox(width: 10),
                        Text("Profile"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "wallet",
                    child: Row(
                      children: [
                        Icon(Icons.wallet, color: Colors.black54), // Logout icon
                        SizedBox(width: 10),
                        Text("Wallet"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "language",
                    child: Row(
                      children: [
                        Icon(Icons.language, color: Colors.black54), // Logout icon
                        SizedBox(width: 10),
                        Text("Language"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "settings",
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.black54), // Settings icon
                        SizedBox(width: 10),
                        Text("Settings"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "logout",
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black54), // Logout icon
                        SizedBox(width: 10),
                        Text("Logout"),
                      ],
                    ),
                  ),
                ],
                offset: const Offset(0, 40), // Adjust position of dropdown
                color: Colors.white, // Dropdown background color
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('profile.png'), // Ensure correct path
                      radius: 12,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Micheal',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build nav items
  Widget _buildNavItem(String title, BuildContext context, String path, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {
          context.go(path);
        },
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.black,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Custom Painter for the Oval Shape
class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFF2994A) // Oval color
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
