import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  File? coverImage;
  late String imageUrl;
  final picker = ImagePicker();

  Future<void> getCoverImage() async {
    emit(EditProfileImageLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(EditProfileGetImageSuccess());
    } else {
      emit(EditProfileGetImageFailure());
    }
  }

  void updateCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        emit(EditProfileImageSuccess());
      }).catchError((error) {
        emit(EditProfileImageFailure());
      });
    }).catchError((error) {
      emit(EditProfileImageFailure());
    });
  }
}
