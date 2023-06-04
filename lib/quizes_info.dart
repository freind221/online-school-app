// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, unnecessary_new, sort_child_properties_last

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/StartQuiz.dart';
import 'package:faheem/models/group_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'QuizStatistics.dart';
import 'componanet/quiz_card.dart';

int pn = 0;

class QuizesInfo extends StatefulWidget {
  final GroupDataModel group;
  const QuizesInfo({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<QuizesInfo> createState() => _QuizesInfoState();
}

class _QuizesInfoState extends State<QuizesInfo> {
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
        title: Text("معلومات الاختبارات",
            style: GoogleFonts.tajawal(
                fontSize: 28,
                color: Color.fromARGB(255, 19, 1, 96),
                fontWeight: FontWeight.bold)),
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
                                    fontSize: 20,
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
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )),
                                    Tab(
                                        child: Text(
                                      ' مباشر',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 18,
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
                                                  fontSize: 20,
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
                                                bool isActive = document[
                                                            'ownerId'] ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid &&
                                                    (DateTime.tryParse((document[
                                                                        'deadline']
                                                                    as String))
                                                                ?.compareTo(
                                                                    DateTime
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
                                                return QuizCard(
                                                  widget: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (document[
                                                                    'ownerId'] ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid &&
                                                            (DateTime.tryParse((document['deadline']
                                                                            as String))
                                                                        ?.compareTo(
                                                                            DateTime.now()) ??
                                                                    10) <
                                                                0)
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return QuizStatistics(
                                                                    groupPin:
                                                                        widget
                                                                            .group
                                                                            .pin,
                                                                    quizPin:
                                                                        document[
                                                                            'pin'],
                                                                  );
                                                                }));
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 18.0,
                                                              ))
                                                        else if (document[
                                                                    'ownerId'] ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid &&
                                                            (DateTime.tryParse((document['deadline']
                                                                            as String))
                                                                        ?.compareTo(
                                                                            DateTime.now()) ??
                                                                    10) >
                                                                0)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child: IconButton(
                                                                      onPressed: () {},
                                                                      icon: Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            20.0,
                                                                      )),
                                                                ),
                                                                Expanded(
                                                                  child: IconButton(
                                                                      onPressed: () async {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('group')
                                                                            .doc(widget.group.pin)
                                                                            .collection('quiz')
                                                                            .doc(document['pin'])
                                                                            .delete();
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('group')
                                                                            .doc(widget.group.pin)
                                                                            .collection('quiz')
                                                                            .doc(document['pin'])
                                                                            .collection('questions')
                                                                            .doc()
                                                                            .delete();
                                                                      },
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        size:
                                                                            20.0,
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      ]),
                                                  image: image,
                                                  name: name,
                                                  category: category,
                                                  isActive: isActive,
                                                  numberOfQuestios:
                                                      numberOfQuestios,
                                                  onTap: () {
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
                                                          builder: (builder) =>
                                                              StartQuiz(
                                                            groupPin: widget
                                                                .group.pin,
                                                            pin:
                                                                document['pin'],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
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
                                                fontSize: 20,
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.0),
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
                                                bool isActive = document[
                                                            'ownerId'] ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid &&
                                                    (DateTime.tryParse((document[
                                                                        'deadline']
                                                                    as String))
                                                                ?.compareTo(
                                                                    DateTime
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
                                                return QuizCard(
                                                  widget: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        if (document[
                                                                    'ownerId'] ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid &&
                                                            (DateTime.tryParse((document['deadline']
                                                                            as String))
                                                                        ?.compareTo(
                                                                            DateTime.now()) ??
                                                                    10) <
                                                                0)
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return QuizStatistics(
                                                                    groupPin:
                                                                        widget
                                                                            .group
                                                                            .pin,
                                                                    quizPin:
                                                                        document[
                                                                            'pin'],
                                                                  );
                                                                }));
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 18.0,
                                                              ))
                                                        else if (document[
                                                                    'ownerId'] ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid &&
                                                            (DateTime.tryParse((document['deadline']
                                                                            as String))
                                                                        ?.compareTo(
                                                                            DateTime.now()) ??
                                                                    10) >
                                                                0)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child: IconButton(
                                                                      onPressed: () {},
                                                                      icon: Icon(
                                                                        Icons
                                                                            .edit,
                                                                        size:
                                                                            20.0,
                                                                      )),
                                                                ),
                                                                Expanded(
                                                                  child: IconButton(
                                                                      onPressed: () async {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('group')
                                                                            .doc(widget.group.pin)
                                                                            .collection('quiz')
                                                                            .doc(document['pin'])
                                                                            .delete();
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('group')
                                                                            .doc(widget.group.pin)
                                                                            .collection('quiz')
                                                                            .doc(document['pin'])
                                                                            .collection('questions')
                                                                            .doc()
                                                                            .delete();
                                                                      },
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        size:
                                                                            20.0,
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      ]),
                                                  image: image,
                                                  name: name,
                                                  category: category,
                                                  isActive: isActive,
                                                  numberOfQuestios:
                                                      numberOfQuestios,
                                                  onTap: () {
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
                                                          builder: (builder) =>
                                                              StartQuiz(
                                                            groupPin: widget
                                                                .group.pin,
                                                            pin:
                                                                document['pin'],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
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
