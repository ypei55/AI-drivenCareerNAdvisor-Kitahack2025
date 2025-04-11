import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String category;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const Category({super.key,
    required this.category,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 325,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 10), // X: 0 (no horizontal shift), Y: 10 (deeper bottom shadow)
          ),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Icon(
                  widget.icon,
                  size: 54,
                  color: widget.iconColor,
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.category,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            child: Text(
              widget.description,
              style: const TextStyle(
                color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
}
