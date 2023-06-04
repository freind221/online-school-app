part of 'test_report_cubit.dart';

@immutable
abstract class TestReportState {}

class TestReportInitial extends TestReportState {}

class TestReportLoading extends TestReportState {}

class TestReportSuccess extends TestReportState {}

class TestReportFailure extends TestReportState {}
