// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faheem/models/user_model.dart';

class QuizReportModel {
  final String averageTime;
  final String totalPoints;
  final String firstUser;
  final String secondUser;
  final String thirdUser;
  final String pointsAverage;
  final Map<UserModel, int> users;
  List<QuestionRightOrFalseAnswerNumbers> correctAndWrongNumbers;
  QuizReportModel({
    required this.averageTime,
    required this.firstUser,
    required this.secondUser,
    required this.thirdUser,
    required this.pointsAverage,
    required this.users,
    required this.totalPoints,
    required this.correctAndWrongNumbers,
  });
}

class QuestionRightOrFalseAnswerNumbers {
  final int correctNumber;
  final int falseNumber;

  QuestionRightOrFalseAnswerNumbers({
    required this.correctNumber,
    required this.falseNumber,
  });
}
