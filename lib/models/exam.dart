class Exam {
  final String subject;
  final DateTime dateTime;
  final List<String> rooms;

  Exam({required this.subject, required this.dateTime, required this.rooms,});

  bool get isPassed {
    return dateTime.isBefore(DateTime.now());
  }
}