part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileGetImageSuccess extends EditProfileState {}

class EditProfileGetImageFailure extends EditProfileState {}

class EditProfileImageLoading extends EditProfileState {}

class EditProfileImageSuccess extends EditProfileState {}

class EditProfileImageFailure extends EditProfileState {}
