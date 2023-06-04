// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:developer';
import 'dart:math' hide log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:faheem/GroupStatistics.dart';
import 'package:faheem/QuizList.dart';

import 'bottom_tab.dart';
import 'cubit/groups_list/cubit/groups_list_cubit.dart';
import 'models/group_data_model.dart';

class groupList extends StatefulWidget {
  const groupList({super.key});

  @override
  State<groupList> createState() => _groupListState();
}

class _groupListState extends State<groupList> {
  var userName, userEmail;

  final user = FirebaseAuth.instance.currentUser!;
  late final Stream<QuerySnapshot> stream;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserDetail();
  }

  _getUserDetail() {
    var id = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance
        .collection('User')
        .doc(id) //------
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      userName = snapshot.get('firstName');
      userEmail = snapshot.get('email');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4F8),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 19, 1, 96),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomTabBarr(),
              ),
            );
          },
        ),
        title: Text(
          ' المجموعات',
          style: GoogleFonts.tajawal(
              fontSize: 25,
              color: Color.fromARGB(255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: userEmail == null
          ? Center(child: CircularProgressIndicator())
          : BlocProvider(
              create: (context) => GroupsListCubit()..getGroups(userEmail),
              child: GroupsListView(
                userEmail: userEmail,
              ),
            ),
    );
  }
}

class GroupsListView extends StatelessWidget {
  final String userEmail;
  const GroupsListView({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsListCubit, GroupsListState>(
      builder: (context, state) {
        final List<GroupDataModel> groups =
            BlocProvider.of<GroupsListCubit>(context).groupsDataModel;
        log(groups.length.toString());
        if (state is GroupsListStateLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupsListStateFailure) {
          return Center(
            child: Text("ليس لديك اي مجموعة",
                style: GoogleFonts.tajawal(
                    fontSize: 28,
                    color: Color.fromARGB(255, 19, 1, 96),
                    fontWeight: FontWeight.bold)),
          );
        }
        if (state is GroupsListStateSuccess) {
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<GroupsListCubit>(context).getGroups(userEmail);
              final stateChangeFuture =
                  BlocProvider.of<GroupsListCubit>(context).stream.first;
              return stateChangeFuture;
            },
            child: SafeArea(
              child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var ind = 1 + Random().nextInt(4);
                      return Container(
                          height: 200,
                          padding: EdgeInsets.all(20),
                          child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 5,
                              child: new Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    image: groups[i].image.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              groups[i].image,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: NetworkImage(
                                              'assets/group${ind}_image.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  child: new ListTile(
                                      title: Column(children: [
                                        Row(
                                          children: [
                                            Text(
                                              groups[i].name,
                                              //'المجموعة',
                                              style: GoogleFonts.tajawal(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.person,
                                                color: Colors.grey[600]),
                                            Text(
                                              //' عدد الاعضاء',
                                              "${groups[i].numberOfMembers} أعضاء",
                                              //document[''],----------------
                                              //
                                              style: GoogleFonts.tajawal(
                                                fontSize: 18,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return QuizListScreen(
                                                group: groups[i],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      trailing:
                                          Wrap(spacing: 1, children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            //color: Color(0xFF57636C),
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GroupStatistics(
                                                  group: groups[i],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ])),
                                ),
                              )));
                    },
                    itemCount: groups.length,
                  )),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
