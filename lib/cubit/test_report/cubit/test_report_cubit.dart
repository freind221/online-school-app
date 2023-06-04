import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../models/test_report_model.dart';
import '../../../models/user_model.dart';

part 'test_report_state.dart';

class TestReportCubit extends Cubit<TestReportState> {
  TestReportCubit() : super(TestReportInitial());
  late TestReportModel testReportData;
  int quizScore = 0;

  Future<void> getAnsweredQuestionsData(String pin, [String? groupPin]) async {
    log("THis is the pin you are looking for: $pin");
    log("THis is the pin you are looking for: $groupPin");
    emit(TestReportLoading());
    // try {\
    CollectionReference<Map<String, dynamic>> questions;
    if (groupPin != null) {
      questions = FirebaseFirestore.instance
          .collection('group')
          .doc(groupPin)
          .collection('quiz')
          .doc(pin)
          .collection('questions');
    } else {
      questions = FirebaseFirestore.instance
          .collection('quiz')
          .doc(pin)
          .collection('questions');
    }
    var data = (await questions.get());

    for (var question in data.docs) {
      final data = await FirebaseFirestore.instance
          .collection('quiz')
          .doc(pin)
          .collection('questions')
          .doc(question.id)
          .get();
      log("scorescorecsoeo");
      log(data.data().toString());
      quizScore = (data.data()?['score'] ?? 0) + quizScore;
    }

    Map<UserModel, int> testUsersScores = {};
    int totalScore = 0;
    int numOfUsers = 0;
    int userTestTime = 0;
    int userPoints = 0;
    bool isUnderMinute = false;

    for (var element in data.docs) {
      var users = await questions.doc(element.id).collection('players').get();

      numOfUsers = users.docs.length;
      for (var user in users.docs) {
        var userData = await questions
            .doc(element.id)
            .collection('players')
            .doc(user.id)
            .get();

        totalScore += (userData.data()![user.id]['score'] as int);

        log("This is the name of the user form test reposr cubit :${user.data()}");

        final userModel = UserModel.fromMap((await FirebaseFirestore.instance
                .collection('User')
                .where('email', isEqualTo: user.id.toLowerCase())
                .get())
            .docs[0]
            .data());
        log("222222222222222222222222");
        log(userModel.firstName);
        log(user.id);

        // log("This is the userModel: ${userModel.firstName}");

        testUsersScores[userModel] = userData.data()![user.id]['score'];

        if (user.id == (FirebaseAuth.instance.currentUser?.email)) {
          var endTime = getTime(userData, user, 'end time', 1);
          var startTime = getTime(userData, user, 'start time', 1);
          var differenceTime = endTime - startTime;

          if (differenceTime == 0) {
            isUnderMinute = true;
            endTime = getTime(userData, user, 'end time', 2);
            startTime = getTime(userData, user, 'start time', 2);
          }
          differenceTime = endTime - startTime;

          userTestTime += differenceTime;
          userPoints += (userData.data()![user.id]['score'] as int);
        }
      }
    }
    log(testUsersScores.toString());

    List<UserModel> testSortedUsers = [];

    testUsersScores = Map.fromEntries(testUsersScores.entries.toList()
      ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    testSortedUsers = testUsersScores.keys.toList().reversed.toList();

    for (var element in testSortedUsers) {
      log(element.firstName);
    }
    log(testSortedUsers.length.toString());
    log(numOfUsers.toString());

    testReportData = TestReportModel(
      totalScore: totalScore.toString(),
      isUnderMinute: isUnderMinute,
      userTestTime: userTestTime.toString(),
      userPoints: userPoints.toString(),
      firstUser:
          testSortedUsers.isEmpty ? UserModel.defaultt() : testSortedUsers[0],
      secondUser: testSortedUsers.length < 2
          ? UserModel.defaultt()
          : testSortedUsers[1],
      thirdUser: testSortedUsers.length < 3
          ? UserModel.defaultt()
          : testSortedUsers[2],
      pointsAverage: (totalScore ~/ numOfUsers).toString(),
    );
    emit(TestReportSuccess());
    // }
    // catch (e) {
    //   emit(TestReportFailure());
    // }
  }

  int getTime(
      DocumentSnapshot<Map<String, dynamic>> userData,
      QueryDocumentSnapshot<Map<String, dynamic>> user,
      String time,
      int timePosition) {
    return double.parse((userData.data()![user.id][time] as Timestamp)
            .toDate()
            .toString()
            .split(' ')[1]
            .split(':')[timePosition])
        .toInt();
  }
}
