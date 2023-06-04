import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'QuizList.dart';

import 'componanet/grid_view_card.dart';
import 'models/group_data_model.dart';

class publicGroup extends StatelessWidget {
  final List<GroupDataModel> groups;
  const publicGroup({super.key, required this.groups});

  makeCard(GroupDataModel group, BuildContext context) => GridCard(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => QuizListScreen(group: group),
          ));
        },
        img: group.image,
        name: group.name,
        onCard: "${group.numberOfMembers}  أعضاء",
      );

  makeBody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 140,
                crossAxisSpacing: 60,
              ),
              itemCount: groups.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(groups[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCD4D),
        title: Text(
          'المجموعات ',
          style: GoogleFonts.tajawal(
              fontSize: 25,
              color: const Color.fromARGB(255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: makeBody(),
    );
  }
}
