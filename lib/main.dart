import 'package:flutter/material.dart';
import 'screens/select_screen.dart';

void main() {
  runApp(WeddingPlannerApp());
}

class WeddingPlannerApp extends StatelessWidget {
  const WeddingPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding Planner',
      home: SelectRoleScreen());
  }
}

