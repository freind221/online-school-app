import 'package:faheem/models/user_model.dart';

class TestReportModel {
  final String userTestTime;
  final String userPoints;
  final UserModel firstUser;
  final UserModel secondUser;
  final UserModel thirdUser;
  final String pointsAverage;
  final bool isUnderMinute;
  final String totalScore;
  TestReportModel({
    required this.userTestTime,
    required this.userPoints,
    required this.firstUser,
    required this.secondUser,
    required this.thirdUser,
    required this.pointsAverage,
    required this.isUnderMinute,
    required this.totalScore,
  });
}
