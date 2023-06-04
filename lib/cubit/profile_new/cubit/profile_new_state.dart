part of 'profile_new_cubit.dart';

abstract class ProfileNewState {}

class ProfileNewStateInitial extends ProfileNewState {}

class ProfileNewStateLoading extends ProfileNewState {}

class ProfileNewStateSuccess extends ProfileNewState {}

class ProfileNewStateFailure extends ProfileNewState {}

class ProfileNewStateGetUserDataLoading extends ProfileNewState {}

class ProfileNewStateGetUserDataSuccess extends ProfileNewState {}

class ProfileNewStateGetUserDataFailure extends ProfileNewState {}
