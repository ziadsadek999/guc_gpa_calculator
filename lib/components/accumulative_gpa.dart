import 'package:flutter/material.dart';

class AccumulativeGpa extends StatelessWidget {
  const AccumulativeGpa({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Total GPA: 0.7"),
        Text("Languages GPA: 0.8"),
      ],
    );
  }
}
