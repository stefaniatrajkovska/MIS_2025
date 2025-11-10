import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({Key? key, required this.exam}) : super(key: key);

  String _getTimeRemaining() {
    final now = DateTime.now();
    final difference = exam.dateTime.difference(now);

    if (difference.isNegative) {
      final positiveDiff = now.difference(exam.dateTime);
      final days = positiveDiff.inDays;
      final hours = positiveDiff.inHours % 24;
      return 'Поминат пред $days дена, $hours часа';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за испит'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: exam.isPassed
                      ? [Colors.grey.shade400, Colors.grey.shade600]
                      : [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.subject,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      exam.isPassed ? 'Поминат' : 'Предстоен',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailCard(
                    icon: Icons.calendar_today,
                    title: 'Датум',
                    value: dateFormat.format(exam.dateTime),
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    icon: Icons.access_time,
                    title: 'Време',
                    value: timeFormat.format(exam.dateTime),
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard(
                    icon: Icons.meeting_room,
                    title: 'Простории',
                    value: exam.rooms.join(', '),
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: exam.isPassed
                          ? Colors.grey.shade100
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: exam.isPassed
                            ? Colors.grey.shade300
                            : Colors.blue.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: exam.isPassed ? Colors.grey : Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              exam.isPassed ? 'Време од испит' : 'Преостанува',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: exam.isPassed ? Colors.grey.shade700 : Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getTimeRemaining(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: exam.isPassed ? Colors.grey.shade600 : Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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