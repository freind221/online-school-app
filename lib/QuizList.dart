// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, unnecessary_new, sort_child_properties_last

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/GroupStatistics.dart';
import 'package:faheem/StartQuiz.dart';
import 'package:faheem/models/group_data_model.dart';
import 'package:faheem/quizes_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'componanet/quiz_card.dart';

int pn = 0;

enum PopUpItems {
  groupStatistics,
  editGroup,
  quizesInformation,
}

extension on PopUpItems {
  String getName() {
    switch (this) {
      case PopUpItems.groupStatistics:
        return "احصائيات المجموعة";

      case PopUpItems.editGroup:
        return "تعديل المجموعة";

      case PopUpItems.quizesInformation:
        return " معلومات الاختبارات";
    }
  }
}

class QuizListScreen extends StatefulWidget {
  final GroupDataModel group;
  const QuizListScreen({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    super.initState();
  }

//final user = FirebaseAuth.instance.currentUser!;
/* void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetail();
  } */
  /* _getUserDetail() {
    FirebaseFirestore.instance
        .collection('User')
        .doc(user.userID)//------
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      userName = snapshot.get('firstName');
      userEmail = snapshot.get('email');
      setState(() {});
    });
  } */

  int dd = 0;

  String _colors(String i, String kid) {
    if (i == "Not complete") {
      return 'غير مكتمل🔴';
    } else if (i == "pending") {
      /* if (dd == 0)
        Notifications.showNotification(
          title: "EARNILY",
          body: ' طفلك  ' + kid + ' اكمل المهمة ',
          payload: 'earnily',
        ); */
      dd++;
      return 'انتظار موافقتك🟠';
    } else {
      return 'مكتمل🟢';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> stream1 = FirebaseFirestore.instance
        .collection('group')
        .doc(widget.group.pin)
        .collection("quiz")
        .where('type', isEqualTo: 1)
        .snapshots();

    final Stream<QuerySnapshot> stream2 = FirebaseFirestore.instance
        .collection('group')
        .doc(widget.group.pin)
        .collection("quiz")
        .where('type', isEqualTo: 2)
        .snapshots();
    // final Stream<QuerySnapshot> stream2 = FirebaseFirestore.instance
    //     .collection('quiz')
    //     /*   .doc(user.uid)
    //     .collection('Task') */
    //     // .where('quizOwner', isEqualTo: user.uid)
    //     .snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 205, 77, 1),
        title: Text(widget.group.name,
            style: GoogleFonts.tajawal(
                fontSize: 28,
                color: Color.fromARGB(255, 19, 1, 96),
                fontWeight: FontWeight.bold)),
        leading: BackButton(
          color: Color.fromARGB(255, 19, 1, 96),
          onPressed: (() {
            /* if (!(nameController.text.isEmpty) ||
                  !(dateController.text.isEmpty) ||
                  !(catController.text.isEmpty) ||
                  result != null) {
                //showPopup();
              } else */
            Navigator.pop(context);
          }),
        ),
        actions: [
          if (widget.group.ownerId == FirebaseAuth.instance.currentUser!.email)
            PopupMenuButton(
              // Initial Value

              // Down Arrow Icon
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                switch (value) {
                  case PopUpItems.groupStatistics:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => GroupStatistics(
                              group: widget.group,
                            )));
                    break;
                  case PopUpItems.editGroup:
                    // TODO: Handle this case.
                    break;
                  case PopUpItems.quizesInformation:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => QuizesInfo(
                              group: widget.group,
                            )));
                    break;
                }
              },

              // Array list of items
              itemBuilder: (context) =>
                  PopUpItems.values.map((PopUpItems item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(
                    item.getName(),
                    style: GoogleFonts.tajawal(
                        fontSize: 15,
                        color: Color.fromARGB(255, 19, 1, 96),
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
            ),
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (_) => GroupStatistics(
          //                 group: widget.group,
          //               )));
          //     },
          //     icon: Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "الاختبارات",
                                style: GoogleFonts.tajawal(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 19, 1, 96),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 200,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TabBar(
                                  onTap: (value) {
                                    setState(() {});
                                  },
                                  indicator: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tabs: [
                                    Tab(
                                        child: Text(
                                      ' مجدول',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )),
                                    Tab(
                                        child: Text(
                                      ' مباشر',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ]),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Center(
                                    child: StreamBuilder(
                                        stream: stream1,
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          log("351651651g651e6r16gr");
                                          log(snapshot.hasData.toString());
                                          log(snapshot.data?.docs.length
                                                  .toString() ??
                                              "");
                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Text(
                                              "ليس لديك اختبارات مجدولة ",
                                              style: GoogleFonts.tajawal(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 19, 1, 96),
                                                  fontWeight: FontWeight.bold),
                                            );
                                          } else {
                                            return ListView.separated(
                                              padding: EdgeInsets.all(15.0),
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> document =
                                                    snapshot.data!.docs[index]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                String image = document['img'];
                                                String name = document['name'];
                                                String category =
                                                    document['category'];
                                                bool isActive = (DateTime.tryParse(
                                                                (document[
                                                                        'deadline']
                                                                    as String))
                                                            ?.compareTo(DateTime
                                                                .now()) ??
                                                        10) >
                                                    0;
                                                log("465s46f4s6f4s6a5f46e");
                                                log(DateTime.tryParse((document[
                                                            'deadline']))
                                                        ?.compareTo(
                                                            DateTime.now())
                                                        .toString() ??
                                                    "");
                                                log("isActive: $isActive");
                                                String numberOfQuestios =
                                                    document['questions number']
                                                        .toString();
                                                // switch (document['category']) {
                                                //   case "الرياضيات":
                                                //     image =
                                                //         'assets/images/math.png';
                                                //     break;

                                                //   case "العلوم":
                                                //     image =
                                                //         'assets/images/physics.png';
                                                //     break;

                                                //   case "الفيزياء":
                                                //     image =
                                                //         'assets/images/physics.png';
                                                //     break;

                                                //   case "احياء":
                                                //     image =
                                                //         'assets/images/biology.png';
                                                //     break;

                                                //   default:
                                                //     image =
                                                //         'assets/images/biology.png';
                                                // }
                                                return Stack(
                                                  children: [
                                                    QuizCard(
                                                      widget: Column(
                                                        children: [
                                                          IndicateIsActiveWidget(
                                                            color: isActive
                                                                ? Colors
                                                                    .green[900]
                                                                : Colors
                                                                    .red[900],
                                                            icon: isActive
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons.error,
                                                            title: isActive
                                                                ? "نشط"
                                                                : "انتهى",
                                                          ),
                                                        ],
                                                      ),
                                                      image: image,
                                                      name: name,
                                                      category: category,
                                                      isActive: isActive,
                                                      numberOfQuestios:
                                                          numberOfQuestios,
                                                      onTap: () {
                                                        log(DateTime.tryParse(
                                                                (document[
                                                                        'deadline']
                                                                    as String))
                                                            .toString());
                                                        if ((DateTime.tryParse((document[
                                                                            'deadline']
                                                                        as String))
                                                                    ?.compareTo(
                                                                        DateTime
                                                                            .now()) ??
                                                                10) >
                                                            0) {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (builder) =>
                                                                      StartQuiz(
                                                                groupPin: widget
                                                                    .group.pin,
                                                                pin: document[
                                                                    'pin'],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      SizedBox(
                                                height: 10,
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                  Center(
                                    child: StreamBuilder(
                                        stream: stream2,
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData ||
                                              snapshot.data!.docs.isEmpty) {
                                            return Text(
                                              "ليس لديك اختبارات مباشرة ",
                                              style: GoogleFonts.tajawal(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                  255,
                                                  19,
                                                  1,
                                                  96,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return ListView.separated(
                                              padding: EdgeInsets.all(15.0),
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> document =
                                                    snapshot.data!.docs[index]
                                                            .data()
                                                        as Map<String, dynamic>;

                                                log(document['ownerId']);
                                                log(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString());
                                                log((document['ownerId'] ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.email)
                                                    .toString());
                                                String image = document['img'];
                                                String name = document['name'];
                                                String category =
                                                    document['category'];
                                                bool isActive = (DateTime.tryParse(
                                                                (document[
                                                                        'deadline']
                                                                    as String))
                                                            ?.compareTo(DateTime
                                                                .now()) ??
                                                        10) >
                                                    0;
                                                String numberOfQuestios =
                                                    document['questions number']
                                                        .toString();
                                                // switch (document['category']) {
                                                //   case "الرياضيات":
                                                //     image =
                                                //         'assets/images/math.png';
                                                //     break;

                                                //   case "العلوم":
                                                //     image =
                                                //         'assets/images/physics.png';
                                                //     break;

                                                //   case "الفيزياء":
                                                //     image =
                                                //         'assets/images/physics.png';
                                                //     break;

                                                //   case "احياء":
                                                //     image =
                                                //         'assets/images/biology.png';
                                                //     break;

                                                //   default:
                                                //     image =
                                                //         'assets/images/biology.png';
                                                // }
                                                return Stack(
                                                  children: [
                                                    QuizCard(
                                                      widget: Column(
                                                        children: [
                                                          IndicateIsActiveWidget(
                                                            color: isActive
                                                                ? Colors
                                                                    .green[900]
                                                                : Colors
                                                                    .red[900],
                                                            icon: isActive
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons.error,
                                                            title: isActive
                                                                ? "نشط"
                                                                : "انتهى",
                                                          ),
                                                        ],
                                                      ),
                                                      image: image,
                                                      name: name,
                                                      category: category,
                                                      isActive: isActive,
                                                      numberOfQuestios:
                                                          numberOfQuestios,
                                                      onTap: () {
                                                        log(DateTime.tryParse(
                                                                    (document[
                                                                            'deadline']
                                                                        as String))
                                                                ?.compareTo(
                                                                    DateTime
                                                                        .now())
                                                                .toString() ??
                                                            "");
                                                        if ((DateTime.tryParse((document[
                                                                            'deadline']
                                                                        as String))
                                                                    ?.compareTo(
                                                                        DateTime
                                                                            .now()) ??
                                                                10) >
                                                            0) {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (builder) =>
                                                                      StartQuiz(
                                                                groupPin: widget
                                                                    .group.pin,
                                                                pin: document[
                                                                    'pin'],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      SizedBox(
                                                height: 10,
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
