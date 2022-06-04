import 'package:flutter/material.dart';

Widget getTodoDueDatePriorityContainer(DateTime todoDate) {
  DateTime dateAfterTwoDays = DateTime.now().add(const Duration(days: 2));

  // this check if current todos duedate is less then 2 Days

  // this is Low Priority Box
  if (todoDate.year <= dateAfterTwoDays.year &&
      todoDate.month <= dateAfterTwoDays.month &&
      todoDate.day <= dateAfterTwoDays.day) {
    return Positioned(
      bottom: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: const Color.fromARGB(255, 192, 255, 210),
        ),
        child: const Text(
          'Low',
          style: TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 60, 221, 66),
          ),
        ),
      ),
    );
  } else {
    // this is High Priority Box
    return Positioned(
      bottom: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: const Color.fromARGB(255, 255, 230, 228),
        ),
        child: const Text(
          'High',
          style: TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 255, 140, 132),
          ),
        ),
      ),
    );
  }
}
