import 'package:flutter/material.dart';

class AestheticAppbar extends StatelessWidget {
  final String text;
  const AestheticAppbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueAccent, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(0, 4),
          blurRadius: 8,
        ),
      ],
    ),
  ),
  title: Text(
    text,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: Offset(2, 2),
          blurRadius: 3,
        ),
      ],
    ),
  ),
  centerTitle: true,
);
  }
}