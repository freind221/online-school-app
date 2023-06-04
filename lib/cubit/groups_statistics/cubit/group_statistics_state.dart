part of 'group_statistics_cubit.dart';

@immutable
abstract class GroupStatisticsState {}

class GroupStatisticsInitial extends GroupStatisticsState {}

class GroupStatisticsLoading extends GroupStatisticsState {}

class GroupStatisticsSuccess extends GroupStatisticsState {}

class GroupStatisticsFailure extends GroupStatisticsState {}
