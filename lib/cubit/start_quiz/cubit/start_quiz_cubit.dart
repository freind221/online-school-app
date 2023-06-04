import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/test_data_model.dart';

part 'start_quiz_state.dart';

class StartQuizCubit extends Cubit<StartQuizState> {
  StartQuizCubit() : super(StartQuizInitial());

  late TestDataModel testDataModel;
  List<QuestionModel> questions = [];
  int quizScore = 0;
  int quizTime = 0;

  Future<void> getQuize(String pin) async {
    emit(StartQuizLoading());
    try {
      final quiz =
          await FirebaseFirestore.instance.collection('quiz').doc(pin).get();
      final questionsData = await FirebaseFirestore.instance
          .collection('quiz')
          .doc(pin)
          .collection('questions')
          .get();

      for (var question in questionsData.docs) {
        final data = await FirebaseFirestore.instance
            .collection('quiz')
            .doc(pin)
            .collection('questions')
            .doc(question.id)
            .get();
        quizScore = (data.data()?['score'] ?? 0) + quizScore;
        log("This is the time: ${data.data()?['time'].toString().split("د")[0]}");
        final time = (int.tryParse(
                data.data()?['time'].toString().split("د")[0] ?? "0")) ??
            0;
        quizTime = time + quizTime;
        log("This is the quizTime: $quizTime");

        questions.add(QuestionModel.fromMap(data.data()!));
      }

      testDataModel =
          TestDataModel.fromMap({...quiz.data()!, "questions": questions});
      emit(StartQuizSuccess());
    } catch (e) {
      emit(StartQuizFailure());
    }
  }
}
