import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({Key? key, required this.exam, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: exam.isPassed ? Colors.grey : Colors.blue,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        exam.subject,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: exam.isPassed ? Colors.grey.shade600 : Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: exam.isPassed
                            ? Colors.grey.shade200
                            : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exam.isPassed ? 'Поминат' : 'Предстоен',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: exam.isPassed ? Colors.grey.shade700 : Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: exam.isPassed ? Colors.grey : Colors.blue,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      dateFormat.format(exam.dateTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: exam.isPassed ? Colors.grey.shade600 : Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: exam.isPassed ? Colors.grey : Colors.blue,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeFormat.format(exam.dateTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: exam.isPassed ? Colors.grey.shade600 : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.meeting_room,
                      size: 16,
                      color: exam.isPassed ? Colors.grey : Colors.orange,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        exam.rooms.join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: exam.isPassed ? Colors.grey.shade600 : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}