part of 'start_quiz_cubit.dart';

@immutable
abstract class StartQuizState {}

class StartQuizInitial extends StartQuizState {}

class StartQuizLoading extends StartQuizState {}

class StartQuizSuccess extends StartQuizState {}

class StartQuizFailure extends StartQuizState {}
