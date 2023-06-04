import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/group_data_model.dart';

part 'groups_list_state.dart';

class GroupsListCubit extends Cubit<GroupsListState> {
  GroupsListCubit() : super(GroupsListStateInitial());
  late List<GroupDataModel> groupsDataModel = [];

  Future<void> getGroups(String userEmail) async {
    log("This is the userEmail $userEmail");
    emit(GroupsListStateLoading());
    groupsDataModel = [];

    try {
      final data = FirebaseFirestore.instance.collection('group');
      final groups = await data.get();
      for (var group in groups.docs) {
        final userData = await data.doc(group.id).get();

        final members = await data.doc(group.id).collection('members').get();

        for (var member in members.docs) {
          if (member.id == userEmail) {
            addDataToGroupsDataModel(userData, members);
          }
        }

        if (userData.data()!['ownerId'] == userEmail) {
          addDataToGroupsDataModel(userData, members);
        }
      }

      for (var element in groupsDataModel) {
        print(element.name);
      }

      emit(GroupsListStateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GroupsListStateFailure());
    }
  }

  void addDataToGroupsDataModel(DocumentSnapshot<Map<String, dynamic>> userData,
      QuerySnapshot<Map<String, dynamic>> members) {
    groupsDataModel.add(GroupDataModel.fromMap({
      ...userData.data()!,
      'numberOfMembers': members.docs.length.toString()
    }));
  }
}
