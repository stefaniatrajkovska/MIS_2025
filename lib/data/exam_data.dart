import '../models/exam.dart';

List<Exam> getExams() {
  final now = DateTime.now();

  return [
    Exam(
      subject: 'Математика 1',
      dateTime: DateTime(now.year, now.month - 1, 15, 10, 0),
      rooms: ['Амфитеатар ТМФ', 'Амфитеатар ФИНКИ'],
    ),
    Exam(
      subject: 'Структурно Програмирање',
      dateTime: DateTime(now.year, now.month - 1, 20, 12, 0),
      rooms: ['Лабораторија 138'],
    ),
    Exam(
      subject: 'Вовед во наука за податоци',
      dateTime: DateTime(now.year, now.month, now.day - 5, 9, 0),
      rooms: ['Амфитеатар ТМФ'],
    ),
    Exam(
      subject: 'Веројатност и Статистика',
      dateTime: DateTime(now.year, now.month, now.day - 2, 11, 0),
      rooms: ['Просторија 315', 'Лабораторија 117'],
    ),
    Exam(
      subject: 'Дискретна Математика',
      dateTime: DateTime(now.year, now.month, now.day + 3, 10, 0),
      rooms: ['Амфитеатар ФИНКИ'],
    ),
    Exam(
      subject: 'Бази на Податоци',
      dateTime: DateTime(now.year, now.month, now.day + 5, 13, 0),
      rooms: ['Лабораторија 215', 'Лабораторија 138'],
    ),
    Exam(
      subject: 'Оперативни Системи',
      dateTime: DateTime(now.year, now.month, now.day + 8, 9, 30),
      rooms: ['Амфитеатар ТМФ'],
    ),
    Exam(
      subject: 'Веб Програмирање',
      dateTime: DateTime(now.year, now.month, now.day + 12, 14, 0),
      rooms: ['Лабораторија 215', 'Лабораторија 13'],
    ),
    Exam(
      subject: 'Алгоритми и Податочни Структури',
      dateTime: DateTime(now.year, now.month, now.day + 15, 10, 0),
      rooms: ['Лабораторија 12', 'Лабораторија 13'],
    ),
    Exam(
      subject: 'Компјутерски Мрежи',
      dateTime: DateTime(now.year, now.month, now.day + 18, 11, 30),
      rooms: ['Лабораторија 2'],
    ),
    Exam(
      subject: 'Софтверско Инженерство',
      dateTime: DateTime(now.year, now.month, now.day + 22, 12, 0),
      rooms: ['Амфитеатар ФИНКИ'],
    ),
    Exam(
      subject: 'Вештачка Интелигенција',
      dateTime: DateTime(now.year, now.month + 1, 5, 9, 0),
      rooms: ['Лабораторија 3'],
    ),
  ]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
}
