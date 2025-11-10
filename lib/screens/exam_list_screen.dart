// screens/exam_list_screen.dart
import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../data/exam_data.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exams = getExams();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Распоред за испити - 221195'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(
                  exam: exams[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamDetailScreen(exam: exams[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(
                top: BorderSide(color: Colors.blue.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Вкупно испити: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${exams.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}