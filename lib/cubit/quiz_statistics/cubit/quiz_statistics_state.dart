part of 'quiz_statistics_cubit.dart';

@immutable
abstract class QuizStatisticsState {}

class QuizStatisticsInitial extends QuizStatisticsState {}

class QuizStatisticsLoading extends QuizStatisticsState {}

class QuizStatisticsSuccess extends QuizStatisticsState {}

class QuizStatisticsFailure extends QuizStatisticsState {}
