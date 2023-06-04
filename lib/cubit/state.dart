// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class Loading extends HomeState {}

class ErrorOccurred extends HomeState {
  final String error;
  ErrorOccurred({required this.error});
}

class HomeSuccess extends HomeState {}

class GetGroupData extends HomeState {}

class AddQuizToGroupSuccess extends HomeState {}

class AddQuizToGroupFailure extends HomeState {
  final String error;
  AddQuizToGroupFailure({
    required this.error,
  });
}
