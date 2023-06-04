import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/quiz_report_model.dart';
import '../../../models/user_model.dart';

part 'quiz_statistics_state.dart';

class QuizStatisticsCubit extends Cubit<QuizStatisticsState> {
  QuizStatisticsCubit() : super(QuizStatisticsInitial());

  int _totalTime = 0;
  late QuizReportModel quizReportModel;
  int quizScore = 0;

  Future<void> getQuizStatistics(String groupPin, String pin) async {
    log("helllllllllllllllllllllllllllllllllllllllllllllllllllllllo");
    emit(QuizStatisticsLoading());
    // try {
    Map<UserModel, int> playersScores = {};
    List<QuestionRightOrFalseAnswerNumbers> correctOrFalseNumbers = [];
    int totalScore = 0;
    int numOfPlayers = 1;
    int correctQuestionPoints = 0;
    int falseQuestionsPoints = 0;

    final questions = await _getQuestions(groupPin, pin);

    for (var question in questions.docs) {
      correctQuestionPoints = 0;
      falseQuestionsPoints = 0;

      final players = await _getPlayers(groupPin, pin, question.id);

      for (var player in players.docs) {
        log("This is the number of players: ${players.docs.length}");
        numOfPlayers = players.docs.length;
        final result =
            await _getPlayerData(groupPin, pin, question.id, player.id);

        final name = UserModel.fromMap((await FirebaseFirestore.instance
                .collection('User')
                .where('email', isEqualTo: player.id)
                .get())
            .docs[0]
            .data());

        final score = result.data()![player.id]['score'] as int;

        totalScore += score;

        if (score != 0) {
          correctQuestionPoints++;
        } else {
          falseQuestionsPoints++;
        }

        _getTotalTime(result, player);

        if (playersScores[name] == null) {
          playersScores[name] = score;
        } else {
          playersScores[name] = score + playersScores[name]!;
        }
      }

      correctOrFalseNumbers.add(QuestionRightOrFalseAnswerNumbers(
        correctNumber: correctQuestionPoints,
        falseNumber: falseQuestionsPoints,
      ));
    }

    playersScores = Map.fromEntries(playersScores.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));

    quizReportModel = QuizReportModel(
      totalPoints: totalScore.toString(),
      averageTime: ((_totalTime ~/ numOfPlayers)).toString(),
      firstUser: playersScores.keys.isEmpty
          ? "NONE"
          : playersScores.keys.elementAt(0).firstName,
      secondUser: playersScores.keys.length < 2
          ? "NONE"
          : playersScores.keys.elementAt(1).firstName,
      thirdUser: playersScores.keys.length < 3
          ? "NONE"
          : playersScores.keys.elementAt(2).firstName,
      pointsAverage: (totalScore ~/ numOfPlayers).toString(),
      users: playersScores,
      correctAndWrongNumbers: correctOrFalseNumbers,
    );

    log("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    log(quizReportModel.averageTime);
    log(quizReportModel.firstUser);
    log(quizReportModel.secondUser);
    log(quizReportModel.thirdUser);
    log(quizReportModel.pointsAverage);
    log(quizReportModel.users.toString());
    quizReportModel.correctAndWrongNumbers
        .map((e) => log("${e.correctNumber} || ${e.falseNumber}"));

    emit(QuizStatisticsSuccess());
    // } catch (e) {
    //   log(e.toString());
    //   emit(QuizStatisticsFailure());
    // }
  }

  void _getTotalTime(DocumentSnapshot<Map<String, dynamic>> result,
      QueryDocumentSnapshot<Map<String, dynamic>> player) {
    var endTime = _getTime(result.data()![player.id]['end time'], 1);
    var startTime = _getTime(result.data()![player.id]['start time'], 1);

    var differenceTime = (endTime - startTime) * 60;

    if (differenceTime == 0) {
      endTime = _getTime(result.data()![player.id]['end time'], 2);
      startTime = _getTime(result.data()![player.id]['start time'], 2);
    }

    differenceTime = endTime - startTime;

    _totalTime += differenceTime;
  }

  int _getTime(Timestamp time, int timePosition) {
    return double.parse(
            (time).toDate().toString().split(' ')[1].split(':')[timePosition])
        .toInt();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getQuestions(
      String groupPin, String pin) async {
    final questions = await FirebaseFirestore.instance
        .collection('group')
        .doc(groupPin)
        .collection('quiz')
        .doc(pin)
        .collection('questions')
        .get();

    for (var question in questions.docs) {
      final data = await FirebaseFirestore.instance
          .collection('quiz')
          .doc(pin)
          .collection('questions')
          .doc(question.id)
          .get();
      quizScore = (data.data()?['score'] ?? 0) + quizScore;
    }
    return questions;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getPlayers(
      String groupPin, String pin, String questionId) async {
    return await FirebaseFirestore.instance
        .collection('group')
        .doc(groupPin)
        .collection('quiz')
        .doc(pin)
        .collection('questions')
        .doc(questionId)
        .collection('players')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getPlayerData(
      String groupPin, String pin, String questionId, String playerId) async {
    return await FirebaseFirestore.instance
        .collection('group')
        .doc(groupPin)
        .collection('quiz')
        .doc(pin)
        .collection('questions')
        .doc(questionId)
        .collection('players')
        .doc(playerId)
        .get();
  }
}
