class Homework {
  String homeworkName;
  String hwId;
  String name;
  DateTime? endDate;
  DateTime? startDate;
  bool isSend;
  bool isGrade;
  String details;
  String percent;
  String hwFileTeacherPath;
  String hwFileStudentPath;
  String sendsName;
  String grade;
  String personId;

  Homework(
      {required this.homeworkName,
      required this.startDate,
      required this.hwId,
      required this.sendsName,
      required this.percent,
      required this.name,
      required this.endDate,
      required this.isSend,
      required this.isGrade,
      required this.grade,
      required this.personId,
      required this.details,
      required this.hwFileTeacherPath,
      required this.hwFileStudentPath});
}
