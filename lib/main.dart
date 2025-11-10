import 'package:flutter/material.dart';
import 'screens/exam_list_screen.dart';

void main() {
  runApp(const ExamScheduleApp());
}

class ExamScheduleApp extends StatelessWidget {
  const ExamScheduleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред на Испити',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const ExamListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}