// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:faheem/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../StartQuiz.dart';
import '../../models/group_data_model.dart';
import '../../models/test_data_model.dart';

class TestCardWidget extends StatelessWidget {
  final TestDataModel test;
  final List<GroupDataModel> groups;

  const TestCardWidget({
    Key? key,
    required this.test,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Card(
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: SizedBox(
                    height: 100,
                    width: 40,
                    child: test.img.isNotEmpty
                        ? Image.network(test.img,
                            // 'assets/images/biology.png',
                            fit: BoxFit.fill)
                        : null,
                  )),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          test.name,
                          //'عنوان',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          //'عدد الاسئلة',
                          "${test.questionsNumber.toString()} س",
                          //'${document['asignedKid']}\n${document['points']}🌟/*  | ${_colors(document['state'], document['asignedKid'])} */',
                          style: GoogleFonts.tajawal(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                test.category,
                                style: GoogleFonts.tajawal(
                                  fontSize: 12,
                                  color: const Color.fromARGB(255, 19, 1, 96),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                PopupMenuButton(
                  // Initial Value

                  // Down Arrow Icon
                  icon: const Icon(Icons.add),
                  onSelected: (value) {
                    log(test.questions.length.toString());
                    BlocProvider.of<HomeCubit>(context).addQuizToGroup(
                        test.toRequest(),
                        test.pin,
                        value!.toString(),
                        test.questions);
                  },

                  // Array list of items
                  itemBuilder: (context) => groups.map((GroupDataModel item) {
                    return PopupMenuItem(
                      value: item,
                      child: Text(
                        item.name,
                        style: GoogleFonts.tajawal(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 19, 1, 96),
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => StartQuiz(
                  pin: test.pin,
                  groupPin: null,
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
