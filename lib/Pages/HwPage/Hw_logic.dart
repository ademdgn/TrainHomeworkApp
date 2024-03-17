import 'package:trackinghwapp/Model/Homework.dart';
import 'package:trackinghwapp/Storage_Service/Firebase_Storage.dart';
import 'package:flutter/material.dart';
import '../../Storage_Service/Firebase_Auth.dart';

class HwController {
  HwController();
  Storage storage = Storage();
  Auth auth = Auth();

  Stream<List<Map<String, dynamic>>> getHwStream() {
    return Stream.fromFuture(getHw());
  }

  Stream<List<Map<String, dynamic>>> historyHomeworkStream() {
    return Stream.fromFuture(historyHomework());
  }

  Stream<List<Map<String, dynamic>>> SendsAllHomeworkStream() {
    return Stream.fromFuture(_sendsHomework());
  }

  Future<List<Map<String, dynamic>>> getHw() async {
    return await storage.getHomework();
  }

  Future<List<Map<String, dynamic>>> historyHomework() async {
    return await storage.getHomeworkHistory();
  }

  Future<List<Map<String, dynamic>>> _sendsHomework() async {
    return await storage.sendsHomework();
  }

  addHw(Homework homework, BuildContext context) async {
    Map<String, dynamic> hw = {
      "name": homework.name,
      "homeworkName": homework.homeworkName,
      "startDate": homework.startDate,
      "endDate": homework.endDate,
      "details": homework.details,
      "isSend": homework.isSend,
      "isGrade": homework.isGrade,
      "hwFileStudentPath": homework.hwFileStudentPath,
      "hwFileTeacherPath": homework.hwFileTeacherPath,
      "percent": homework.percent,
      "sendsName": homework.sendsName,
      "grade": homework.grade,
    };

    await storage.addHomework(hw);
  }

  uploadHw(selectedFilePath, selectedFileName, homeworkName) async {
    return await storage.uploadFileToFirebase(
        selectedFilePath, selectedFileName, homeworkName);
  }

  uploadStudent(hwId, selectedFilePath, selectedFileName) async {
    return await storage.uploadFileToFirebaseStudent(
        hwId, selectedFilePath, selectedFileName);
  }

  updatedGrade(hwId, Map<String, dynamic> updatedData, id) async {
    return await storage.updateHw(hwId, updatedData, id);
  }
}
