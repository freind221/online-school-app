part of 'groups_list_cubit.dart';

abstract class GroupsListState {}

class GroupsListStateInitial extends GroupsListState {}

class GroupsListStateLoading extends GroupsListState {}

class GroupsListStateSuccess extends GroupsListState {}

class GroupsListStateFailure extends GroupsListState {}
