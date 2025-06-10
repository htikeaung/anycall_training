// Flutter: Existing Libraries
import 'package:flutter/material.dart';

// ExamsScreen: StatelessWidget Class
class ExamsScreen extends StatelessWidget {
  // Constructor
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Returning Widgets
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("This is the exam screen & coming soon!"),
        ),
      ),
    );
  }
}
