import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/cubit/state.dart';
import 'package:faheem/models/group_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CreateQuiz.dart';
import '../models/group_data_model.dart';
import '../models/test_data_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<GroupModel>? group = [];
  List<QuestionModel> questions = [];

  Future getGroupData() async {
    try {
      var dataList = await FirebaseFirestore.instance.collection('group').get();
      for (var element in dataList.docs) {
        log(element.data().toString());
        group!.add(GroupModel.fromJson(element.data()));
      }
      emit(HomeSuccess());
    } on Exception catch (e) {
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  late List<GroupDataModel> groupsDataModel = [];
  late List<TestDataModel> testDataModel = [];

  Future<void> _getGroups(String userEmail) async {
    log("This is the userEmail $userEmail");
    groupsDataModel = [];

    try {
      final data = FirebaseFirestore.instance.collection('group');
      final groups = await data.get();
      for (var group in groups.docs) {
        final userData = await data.doc(group.id).get();

        final members = await data.doc(group.id).collection('members').get();

        if (userData.data()!['accessLevel'] == 2) {
          _addDataToGroupsDataModel(userData, members);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  void _addDataToGroupsDataModel(
      DocumentSnapshot<Map<String, dynamic>> userData,
      QuerySnapshot<Map<String, dynamic>> members) {
    groupsDataModel.add(GroupDataModel.fromMap({
      ...userData.data()!,
      'numberOfMembers': members.docs.length.toString()
    }));
  }

  Future<void> _getQuizes(String userEmail) async {
    log("This is the userEmail $userEmail");
    testDataModel = [];
    questions = [];

    try {
      final data = FirebaseFirestore.instance.collection('quiz');
      final groups = await data.get();
      for (var group in groups.docs) {
        questions = [];

        final quizData = await data.doc(group.id).get();

        final questionsData =
            await data.doc(group.id).collection('questions').get();

        log(quizData.data()!["ownerId"]);

        for (var question in questionsData.docs) {
          questions.add(QuestionModel.fromMap(question.data()));
        }

        if (quizData.data()!['accessLevel'] == 2) {
          _addDataToTestDataModel(quizData, questions);
        }
        log("This is the length of questions: ${questions.length}");
      }
    } catch (e) {
      rethrow;
    }
  }

  void _addDataToTestDataModel(
    DocumentSnapshot<Map<String, dynamic>> quizData,
    List<QuestionModel> questions,
  ) {
    log("Thi is the questions: $questions");
    testDataModel.add(TestDataModel.fromMap({
      ...quizData.data()!,
      'questions': questions,
    }));
  }

  void getHomeData(String userEmail) {
    emit(Loading());
    _getGroups(userEmail).then(
      (_) {
        _getQuizes(userEmail).then(
          (_) => emit(
            HomeSuccess(),
          ),
        );
      },
    ).catchError(
      (error) {
        emit(ErrorOccurred(error: error));
      },
    );
  }

  Future<void> addQuizToGroup(Request req, String pin, String groupPin,
      List<QuestionModel> questions) async {
    try {
      final request = FirebaseFirestore.instance
          .collection('group')
          .doc(groupPin)
          .collection('quiz')
          .doc(pin);

      final json = req.toJson();
      await request.set(json);
      for (int i = 0; i < questions.length; i++) {
        request
            .collection("questions")
            .doc('${i + 1}')
            .set(questions[i].toMap());
      }
      emit(AddQuizToGroupSuccess());
    } catch (e) {
      emit(AddQuizToGroupFailure(error: e.toString()));
    }
  }
}
