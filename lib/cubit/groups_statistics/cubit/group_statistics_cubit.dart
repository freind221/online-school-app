import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'group_statistics_state.dart';

class GroupStatisticsCubit extends Cubit<GroupStatisticsState> {
  GroupStatisticsCubit() : super(GroupStatisticsInitial());

  Map<UserModel, int> playersMap = {};
  Map<String, int> testsMap = {};
  List<UserModel> sortedUsers = [];

  Future<void> getGroupStatistics(String pin) async {
    emit(GroupStatisticsLoading());

    log("PINPINPIN: $pin");

    try {
      final quizes = await FirebaseFirestore.instance
          .collection('group')
          .doc(pin)
          .collection('quiz')
          .get();

      // every group has some quizes we need to go through every one of them
      for (var quiz in quizes.docs) {
        final quizQuestions = await FirebaseFirestore.instance
            .collection('group')
            .doc(pin)
            .collection('quiz')
            .doc(quiz.id)
            .collection('questions')
            .get();

        // every quiz has some questions each question player solves so he has some score we need to get this score form each question
        // and increase score accourding to the next question
        for (var question in quizQuestions.docs) {
          final players = await FirebaseFirestore.instance
              .collection('group')
              .doc(pin)
              .collection('quiz')
              .doc(quiz.id)
              .collection('questions')
              .doc(question.id)
              .collection('players')
              .get();

          // Here every question has some players
          for (var player in players.docs) {
            log(player.id);
            final playerData = await FirebaseFirestore.instance
                .collection('group')
                .doc(pin)
                .collection('quiz')
                .doc(quiz.id)
                .collection('questions')
                .doc(question.id)
                .collection('players')
                .doc(player.id)
                .get();

            final score = playerData.data()![player.id]['score'];
            if (score != null) {
              log("This is the score: $score");

              if (testsMap[quiz.data()['name']] == null) {
                testsMap[quiz.data()['name']] = score;
              } else {
                testsMap[quiz.data()['name']] =
                    score + testsMap[quiz.data()['name']];
              }

              final playerData = UserModel.fromMap((await FirebaseFirestore
                      .instance
                      .collection('User')
                      .where('email', isEqualTo: player.id)
                      .get())
                  .docs[0]
                  .data());

              if (playersMap[playerData] == null) {
                log("Yeah it's null");
                playersMap[playerData] = score;
              } else {
                log("This is the score");
                playersMap[playerData] = score + playersMap[playerData];
              }
            }
          }
        }
        // }
      }

      // List<int> sortedScores = playersMap.values.toList()..sort();
      // sortedScores = sortedScores.reversed.toList();

      // List<String> sortedUsers = [];

      playersMap = Map.fromEntries(playersMap.entries.toList()
        ..sort((e1, e2) => e1.value.compareTo(e2.value)));

      // sortedUsers = playersMap.keys.toList().reversed.toList();

      // List<int> sortedTestsScores = testsMap.values.toList()..sort();
      // sortedTestsScores = sortedTestsScores.reversed.toList();

      // List<String> sortedTests = [];

      testsMap = Map.fromEntries(testsMap.entries.toList()
        ..sort((e1, e2) => e1.value.compareTo(e2.value)));

      log(playersMap.values.toString());

      // sortedTests = testsMap.keys.toList().reversed.toList();

      emit(GroupStatisticsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GroupStatisticsFailure());
    }
  }
}
