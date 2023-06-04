import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:faheem/CreateQuiz.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TestDataModel {
  final int accessLevel;
  final String category;
  final String deadline;
  final String img;
  final String name;
  final String numberOfAttempt;
  final String ownerId;
  final String pin;
  final int type;
  final int questionsNumber;
  final List<QuestionModel> questions;

  TestDataModel({
    required this.accessLevel,
    required this.category,
    required this.deadline,
    required this.img,
    required this.name,
    required this.numberOfAttempt,
    required this.ownerId,
    required this.pin,
    required this.type,
    required this.questionsNumber,
    required this.questions,
  });

  Request toRequest() {
    return Request(
      uid: FirebaseAuth.instance.currentUser?.uid ?? "not Authenticated",
      name: name,
      category: category,
      accessLevel: accessLevel,
      attempts: numberOfAttempt,
      type: type,
      pin: pin,
      questionsNum: questionsNumber,
      img: img,
      deadline: deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessLevel': accessLevel,
      'category': category,
      'deadline': deadline,
      'img': img,
      'name': name,
      'numberOfAttempt': numberOfAttempt,
      'ownerId': ownerId,
      'pin': pin,
      'questions number': questionsNumber,
      'type': type,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory TestDataModel.fromMap(Map<String, dynamic> map) {
    return TestDataModel(
      accessLevel: map['accessLevel'] as int,
      category: map['category'] as String,
      deadline: (map['deadline'] ?? "2023-02-09") as String,
      img: map['img'] as String,
      name: map['name'] as String,
      numberOfAttempt: map['numberOfAttempt'] as String,
      ownerId: map['ownerId'] as String,
      pin: map['pin'] as String,
      questionsNumber: map['questions number'] as int,
      type: map['type'] as int,
      questions: map['questions'] as List<QuestionModel>,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestDataModel.fromJson(String source) =>
      TestDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class QuestionModel {
  final AnswersModel answers;
  final int score;
  final String time;
  final String title;
  final String type;
  QuestionModel({
    required this.answers,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answers': answers.toMap(),
      'score': score,
      'time': time,
      'title': title,
      'type': type,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      answers: AnswersModel.fromMap(map['answers'] as Map<String, dynamic>),
      score: map['score'] as int,
      time: map['time'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AnswersModel {
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;
  AnswersModel({
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'correctAnswer': correctAnswer,
    };
  }

  factory AnswersModel.fromMap(Map<String, dynamic> map) {
    return AnswersModel(
      answer1: (map['answer1'] ?? "") as String,
      answer2: (map['answer2'] ?? "") as String,
      answer3: (map['answer3'] ?? "") as String,
      answer4: (map['answer4'] ?? "") as String,
      correctAnswer: (map['correctAnswer'] ?? "") as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswersModel.fromJson(String source) =>
      AnswersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
