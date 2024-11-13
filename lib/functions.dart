import 'package:flutter/material.dart';

class Functions {
  Widget themedContainer(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueAccent, Colors.purpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(4, 4),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
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
      textAlign: TextAlign.center,
    ),
  );
}

Widget themedContainerBlueAccent(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(4, 4),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
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
      textAlign: TextAlign.center,
    ),
  );
}

Widget themedContainerPurpleAccent(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.purpleAccent,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(4, 4),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
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
      textAlign: TextAlign.center,
    ),
  );
}
String formatTime(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  if (hours > 0) {
    return "${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m:${seconds.toString().padLeft(2, '0')}s";
  } else if (minutes > 0) {
    return "${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s";
  } else {
    return "${seconds.toString().padLeft(2, '0')}s";
  }
}

}