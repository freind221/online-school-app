import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/models/test_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/group_data_model.dart';

part 'profile_new_state.dart';

class ProfileNewCubit extends Cubit<ProfileNewState> {
  ProfileNewCubit() : super(ProfileNewStateInitial());

  List<TestDataModel> testDataModel = [];
  List<QuestionModel> questions = [];
  List<GroupDataModel> groupsDataModel = [];

  String name = '';
  String image = '';
  String email = '';

  Future<void> _getUserData() async {
    try {
      var id = FirebaseAuth.instance.currentUser?.uid;

      var data =
          await FirebaseFirestore.instance.collection('User').doc(id).get();
      name = data.data()!['firstName'];
      name += ' ${data.data()!['lastName']}';
      email = data.data()!['email'];
      image = data.data()!['image'] ?? '';
      log(image);
      log(name);
      log(email);
    } catch (e) {
      rethrow;
    }
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

        if (quizData.data()!['ownerId'] == userEmail) {
          _addDataToTestDataModel(quizData, questions);
        }
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

  Future<void> _getGroups(String userEmail) async {
    log("This is the userEmail $userEmail");
    groupsDataModel = [];

    try {
      final data = FirebaseFirestore.instance.collection('group');
      final groups = await data.get();
      for (var group in groups.docs) {
        final userData = await data.doc(group.id).get();

        final members = await data.doc(group.id).collection('members').get();

        for (var member in members.docs) {
          if (member.id == userEmail) {
            _addDataToGroupsDataModel(userData, members);
          }
        }

        if (userData.data()!['ownerId'] == userEmail) {
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

  void getProfileNewData(String userEmail) {
    emit(ProfileNewStateLoading());
    Future.wait([_getGroups(userEmail), _getQuizes(userEmail), _getUserData()])
        .then((_) {
      emit(ProfileNewStateSuccess());
    }).catchError((error) {
      log(error.toString());
      emit(ProfileNewStateFailure());
    });
  }
}
