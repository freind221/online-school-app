// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:faheem/profile_new/widgets/test_card_widget.dart';

import '../../models/group_data_model.dart';
import '../../models/test_data_model.dart';

class TestsListWidget extends StatelessWidget {
  final List<TestDataModel> testsList;
  final List<GroupDataModel> groupList;

  const TestsListWidget({
    Key? key,
    required this.testsList,
    required this.groupList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 12),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int i) => TestCardWidget(
          test: testsList[i],
          groups: groupList,
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 10,
        ),
        itemCount: testsList.length,
      ),
    );
  }
}
