// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.purpleAccent, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    elevation: 5,
  ),
  onPressed: ()=>onPressed(),
  child: Text(
    text,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
);
  }
}
