import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/componanet/after_quiz.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:faheem/TestReport.dart';
import 'package:google_fonts/google_fonts.dart';

int correctAnswers = 0;
int wrongAnswers = 0;
int totalScore = 0;
int questionsNum = 0;

class AnswerQuestion extends StatefulWidget {
  AnswerQuestion(
      {super.key, required this.pin, required this.id, this.groupPin});
  late String pin;
  late DocumentReference request;
  final String? groupPin;
  // late Map<String, dynamic> questions;
  late int id;

  @override
  _AnswerQuestion createState() => _AnswerQuestion();
}

class _AnswerQuestion extends State<AnswerQuestion> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int documents = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uemail;
  var Uid;
  var _correctAnswer = '';
  Duration? time = const Duration(minutes: 10);

  var title = '';
  String selectedtime = '10د';

  late Timestamp start;
  late Timestamp end;
  String uAnswer = '';
  double timerCount = 1;
  List<Color> colors = [
    const Color.fromARGB(255, 251, 248, 239),
    const Color.fromRGBO(255, 205, 77, 1)
  ];
  List<Color> background = [
    const Color.fromARGB(255, 251, 248, 239),
    const Color.fromARGB(255, 251, 248, 239),
    const Color.fromARGB(255, 251, 248, 239),
    const Color.fromARGB(255, 251, 248, 239)
  ];
  var timeBar;

  late String? _type = "اختيار من متعدد";
  int index = 1;

  int _score = 0;
  int uScore = 0;
  TextEditingController answerController = TextEditingController();
  List<String> answers = [
    '',
    '',
    '',
    '',
  ];
  Map<String, dynamic> questions = {};
  int c = 0;

  List<String> AnswertOrf = ['صح', 'خطأ'];
  // Future getQCount() async {
  //   print('entered');
  //   Stream<QuerySnapshot<Map<String, dynamic>>> n = await FirebaseFirestore
  //       .instance
  //       .collection('quiz')
  //       .doc(widget.pin)
  //       .collection('questions')
  //       .snapshots();
  //   print('in');
  //   int f = await n.length;

  //   // StreamBuilder<QuerySnapshot>(
  //   //     stream: n,
  //   //     builder: (context, snapshot) {
  //   //       if (!snapshot.hasData) {
  //   //         return Text("Loading");
  //   //       } else {
  //   //         List<DropdownMenuItem> categoryItem = [];
  //   //         for (int i = 0; i < (snapshot.data)!.docs.length; i++) {
  //   //           documents++;
  //   //         }
  //   //       }

  //   //       return SizedBox();
  //   //     });
  //   setState(() {
  //     documents = f;
  //   });

  //   // setState(() {
  //   //   documents = int.parse(n.toString());
  //   // });
  // }

  Future getQuestions() async {
    DocumentSnapshot retQuestions = await FirebaseFirestore.instance
        .collection('quiz')
        .doc(widget.pin)
        .collection('questions')
        .doc('${widget.id}')
        .get()
        .then((snapshot) {
      setState(() {
        //questions = value.data() as Map<String, dynamic>;
        title = snapshot['title'];
        //documents = questions['questions number'];
        selectedtime = snapshot['time'];
        timeBar = Duration(
            minutes: int.parse(
                selectedtime.substring(0, selectedtime.indexOf('د'))));
        _score = snapshot['score'];
        _type = snapshot['type'];
        _correctAnswer = snapshot['answers']['correctAnswer'];
        if (_type == list[0]) {
          answers[0] = snapshot['answers']['answer1'];
          answers[1] = snapshot['answers']['answer2'];
          answers[2] = snapshot['answers']['answer3'];
          answers[3] = snapshot['answers']['answer4'];
        }
        timer();
      });

      return snapshot;
    }, onError: (e) => print("Error getting document: $e"));
  }

  Future assignQuestions() async {
    await getQuestions();
    await FirebaseFirestore.instance
        .collection('quiz')
        .doc(widget.pin)
        .get()
        .then((snapshot) {
      Map<String, dynamic> qn = snapshot.data() as Map<String, dynamic>;
      setState(() {
        documents = qn['questions number'];
      });
    });
  }

  getCurrentUser() {
    final User user = _auth.currentUser!;
    Uid = user.uid.toString();

    uemail = user.email.toString();

    //   print(uemail);
  }

  createPlayer() async {
    getCurrentUser();
    final userData = await FirebaseFirestore.instance
        .collection('User')
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final name = userData.docs[0].data()["firstName"];
    final userId = FirebaseAuth.instance.currentUser!.uid;

    RequestuAnswer req = RequestuAnswer(
        ID: uemail,
        answer: uAnswer,
        end: end,
        start: start,
        score: uScore,
        name: name,
        userId: userId);

    if (widget.groupPin != null) {
      await FirebaseFirestore.instance
          .collection('group')
          .doc(widget.groupPin)
          .collection('quiz')
          .doc(widget.pin)
          .collection('questions')
          .doc('$index')
          .collection('players')
          .doc(uemail)
          .set(req.toJson());
    } else {
      await FirebaseFirestore.instance
          .collection('quiz')
          .doc(widget.pin)
          .collection('questions')
          .doc('$index')
          .collection('players')
          .doc(uemail)
          .set(req.toJson());
    }
  }

  addToUser() async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(Uid)
        .collection('quizzes')
        .doc(widget.pin)
        .set({'time played': Timestamp.now()});
  }

  late Timer timeri;

  timer() {
    timeri = Timer.periodic(
        Duration(
            minutes: int.parse(
                selectedtime.substring(0, selectedtime.indexOf('د')))),
        (timer) {
      if (index < documents) {
        timeri.cancel();
        timer.cancel();
        end = Timestamp.now();
        createPlayer();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => AnswerQuestion(
                  pin: widget.pin,
                  id: ++index,
                )));
      } else {
        timer.cancel();
        timeri.cancel();
        end = Timestamp.now();
        createPlayer();
        addToUser();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => TestReport(
                  pin: widget.pin,
                  groupPin: widget.groupPin,
                )));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    assignQuestions();
    index = widget.id;
    start = Timestamp.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (c == 0) {
    //   assignQuestions();
    //   c++;
    // }
    // index = widget.id;

    // setState(() {
    //   if (questions.isNotEmpty) {
    //     title = questions['title'];
    //     //documents = questions['questions number'];
    //     selectedtime = questions['time'];
    //     timeBar = Duration(minutes: int.parse(selectedtime.substring(0, 2)));
    //     _score = questions['score'];
    //     _type = questions['type'];
    //     _correctAnswer = questions['answers']['correctAnswer'];
    //     if (_type == list[0]) {
    //       answers[0] = questions['answers']['answer1'];
    //       answers[1] = questions['answers']['answer2'];
    //       answers[2] = questions['answers']['answer3'];
    //       answers[3] = questions['answers']['answer4'];
    //     }
    //   }
    // });

    // timeBar = Duration(minutes: int.parse(selectedtime.substring(0, 2)));

    // timer();
    // start = Timestamp.now();

    // background = [
    //   Color.fromARGB(255, 251, 248, 239),
    //   Color.fromARGB(255, 251, 248, 239),
    //   Color.fromARGB(255, 251, 248, 239),
    //   Color.fromARGB(255, 251, 248, 239)
    // ];
    // questions = retQuestions.data() as Map<String, dynamic>;

    return ScreenUtilInit(
        splitScreenMode: false,
        builder: (context, child) {
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: const Color.fromRGBO(255, 205, 77, 1),
              body: Directionality(
                textDirection: TextDirection.rtl,
                // textDirection: TextDirection.ltr,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 12),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: ListView(
                            children: [
                              const SizedBox(height: 16),
                              const SizedBox(height: 16),
                              Center(
                                  child: Text("السؤال $index من $documents",
                                      style: GoogleFonts.tajawal(
                                          color: const Color(0xFF130160),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8.0),
                                  child: timeBar != null
                                      ? LinearPercentIndicator(
                                          progressColor: const Color.fromARGB(
                                              255, 19, 1, 96),
                                          lineHeight: 40,
                                          isRTL: true,
                                          percent: timerCount,
                                          backgroundColor: const Color.fromARGB(
                                              255, 176, 175, 175),
                                          animation: true,
                                          animationDuration:
                                              timeBar.inMilliseconds,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          barRadius: const Radius.circular(20),
                                        )
                                      : Container()
                                  // LinearProgressIndicator(
                                  //   minHeight: 20,
                                  //   value: timeBar.value,
                                  //   valueColor: AlwaysStoppedAnimation<Color>(
                                  //       Color.fromARGB(255, 19, 1, 96)),
                                  //   backgroundColor:
                                  //       Color.fromRGBO(255, 205, 77, 1),
                                  // )
                                  ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8.0),
                                  child: Container(
                                      height: 170,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 20,
                                                offset: const Offset(1, 1),
                                                color: Colors.grey
                                                    .withOpacity(0.26))
                                          ]),
                                      margin: const EdgeInsets.only(
                                          bottom: 50, top: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            title,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 19, 1, 96),
                                            ),
                                          )
                                        ],
                                      )
                                      //  TextFormField(
                                      //   readOnly: true,
                                      //   autovalidateMode:
                                      //       AutovalidateMode.onUserInteraction,
                                      //   maxLengthEnforcement:
                                      //       MaxLengthEnforcement.enforced,
                                      //   controller: questionController,
                                      //   // validator: (value) {
                                      //   //   if (value == null || value.isEmpty) {
                                      //   //     return 'هذه الخانة مطلوبة';
                                      //   //   }
                                      //   // },
                                      //   keyboardType: TextInputType.text,
                                      //   maxLines: 5,
                                      //   decoration:
                                      //       Style.inputregular(" ", radius: 20.0),
                                      // ),
                                      )),
                              const SizedBox(height: 16),
                              _type == list[0]
                                  ? multipleChoice()
                                  : _type == list[1]
                                      ? trueORfalse()
                                      : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerFloat,
              // floatingActionButton: GestureDetector(
              //   child: Container(
              //     width: double.infinity,
              //     margin: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
              //     height: 56,
              //     decoration: BoxDecoration(
              //       color: Color.fromRGBO(255, 205, 77, 1),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     alignment: Alignment.center,
              //     child: Text(
              //       "انشاء الاختبار",
              //       style: TextStyle(
              //         color: Color(0xFF130160),
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         height: 1.5,
              //       ),
              //     ),
              //   ),
              //   onTap: () async {
              //     if (questionController.text.isEmpty || _correctAnswer == '') {
              //       ShowAlert();
              //       return;
              //     } else if (_type == list[0]) {
              //       if (answers.any((element) => element == '')) {
              //         ShowAlert();
              //         return;
              //       }
              //       if (questions.containsKey(widget.id.toString())) {
              //         questions['$index']['title'] =
              //             questionController.text;
              //         questions['$index']['time'] = selectedtime;
              //         questions['$index']['score'] = _score;
              //         questions['$index']['type'] = _type;
              //         questions['$index']['answers']['answer1'] =
              //             answers[0];
              //         questions['$index']['answers']['answer2'] =
              //             answers[1];
              //         questions['$index']['answers']['answer3'] =
              //             answers[2];
              //         questions['$index']['answers']['answer4'] =
              //             answers[3];
              //         questions['$index']['answers']['correctAnswer'] =
              //             _correctAnswer;
              //         setState(() {
              //           Navigator.pop(context);
              //         });
              //         return;
              //       }
              //       final req = RequestQuestion(
              //           ID: widget.id.toString(),
              //           title: questionController.text,
              //           answer1: answers[0],
              //           answer2: answers[1],
              //           answer3: answers[2],
              //           answer4: answers[3],
              //           correctAnswer: _correctAnswer,
              //           selectedtime: selectedtime,
              //           score: _score,
              //           type: _type);
              //       addQuestion(req);
              //     } else if (_type == list[1]) {
              //       if (questions.containsKey(widget.id.toString())) {
              //         questions['$index']['title'] =
              //             questionController.text;
              //         questions['$index']['time'] = selectedtime;
              //         questions['$index']['score'] = _score;
              //         questions['$index']['type'] = _type;
              //         questions['$index']['answers']['answer1'] =
              //             AnswertOrf[0];
              //         questions['$index']['answers']['answer2'] =
              //             AnswertOrf[1];
              //         questions['$index']['answers']['correctAnswer'] =
              //             _correctAnswer;
              //         Navigator.pop(context);
              //         return;
              //       }
              //       final req = RequestQuestionTF(
              //           ID: widget.id.toString(),
              //           title: questionController.text,
              //           answer1: AnswertOrf[0],
              //           answer2: AnswertOrf[1],
              //           correctAnswer: _correctAnswer,
              //           selectedtime: selectedtime,
              //           score: _score,
              //           type: _type);
              //       addQuestionTF(req);
              //     }

              //     print(questions.length);
              //     print(questions);
              //     print(widget.id);

              //     Navigator.pop(context);

              //     // final reqa = RequestAnswer(
              //     //     answer1: answers[0],
              //     //     answer2: answers[1],
              //     //     answer3: answers[2],
              //     //     answer4: answers[3]);
              //     // RequestAnswers(reqa);
              //   },
              // ),
            ),
          );
        });
  }

  List<String> list = [
    "اختيار من متعدد",
    "صح وخطأ",
    "ترتيب",
  ];

  AnswerSheet(String answer, int color) {
    end = Timestamp.now();
    setState(() {
      background[color] = colors[1];
    });

    uAnswer = answer;

    if (answer == _correctAnswer) {
      correctAnswers++;
      uScore = _score;
      log("This is the score: $_score");
      totalScore += _score;
    } else {
      wrongAnswers++;
    }

    log(totalScore.toString());

    log(correctAnswers.toString());

    timeri.cancel();
    createPlayer();

    if (index < documents) {
      timeri.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AnswerQuestion(
                pin: widget.pin,
                id: ++index,
              )));
    } else {
      timeri.cancel();
      addToUser();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => AfterQuiz(
                  groupPin: widget.groupPin,
                  pin: widget.pin,
                  correctAnswers: correctAnswers,
                  wrongAnswers: wrongAnswers,
                  score: totalScore,
                  questionsNum: (correctAnswers + wrongAnswers).toInt(),
                  completed:
                      ((correctAnswers / (correctAnswers + wrongAnswers)) * 100)
                          .toInt(),
                )),
      );
    }

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => AnswerQuestion(
    //           pin: widget.pin,
    //           id: index,
    //         )));
  }

  // AnswerSheetTF(int a) {
  //   answerController.text = AnswertOrf[a];
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(20.0),
  //               topLeft: Radius.circular(20.0))),
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //             alignment: Alignment.topRight,
  //             margin: EdgeInsets.only(top: 20, right: 20),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // Row(
  //                 //   crossAxisAlignment:
  //                 //       CrossAxisAlignment
  //                 //           .end,
  //                 //   children: [
  //                 Text(
  //                   'الإجابة:',
  //                   style: TextStyle(fontSize: 30),
  //                   textAlign: TextAlign.start,
  //                   textDirection: TextDirection.rtl,
  //                 ),
  //                 //],
  //                 //),
  //                 TextFormField(
  //                   readOnly: true,

  //                   autovalidateMode: AutovalidateMode.onUserInteraction,
  //                   maxLengthEnforcement: MaxLengthEnforcement.enforced,
  //                   controller: answerController,
  //                   validator: (value) {
  //                     if (value == null || value.isEmpty) {
  //                       return 'هذه الخانة مطلوبة';
  //                     }
  //                   },
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.start,
  //                   keyboardType: TextInputType.text,
  //                   // controller: feedbackController,
  //                   maxLines: 3,
  //                   minLines: 3,

  //                   decoration: InputDecoration(
  //                     hintStyle: TextStyle(
  //                         fontSize: 14.0,
  //                         color: const Color.fromRGBO(106, 119, 145, 1)
  //                             .withOpacity(.5),
  //                         fontWeight: FontWeight.normal,
  //                         fontFamily:
  //                             'assets/font/Urbanist-VariableFont_wght.ttf'),
  //                     filled: true,
  //                     fillColor: Colors.white,
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(7),
  //                       borderSide: const BorderSide(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(20),
  //                         borderSide: const BorderSide(color: Colors.white)),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         vertical: 20.0, horizontal: 20),
  //                   ),
  //                 ),

  //                 Row(
  //                   children: [
  //                     Text('الإجابة الصحيحة',
  //                         style: GoogleFonts.tajawal(
  //                           color: Color(0xFF130160),
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold,
  //                           height: 1.5,
  //                         )),
  //                     Container(
  //                         padding: EdgeInsets.only(right: 200),
  //                         alignment: Alignment.centerLeft,
  //                         child: Switch(
  //                           value: _correctAnswer == answerController.text &&
  //                               answerController.text.isNotEmpty,
  //                           onChanged: (newValue) async {
  //                             setState(() {
  //                               if (newValue == true &&
  //                                   answerController.text.isNotEmpty) {
  //                                 _correctAnswer = answerController.text;
  //                               } else {
  //                                 _correctAnswer = "";
  //                               }
  //                               // print(_correctAnswer);
  //                             });
  //                           },
  //                         ))
  //                   ],
  //                 ),
  //                 GestureDetector(
  //                     child: Container(
  //                         alignment: Alignment.center,
  //                         margin: EdgeInsets.only(top: 40),
  //                         child: ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                                 primary: Color.fromRGBO(255, 205, 77, 1),
  //                                 shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10)),
  //                                 fixedSize: Size(250, 56),
  //                                 alignment: Alignment.center),
  //                             child: Text(
  //                               "اضف الإجابة ",
  //                               style: GoogleFonts.tajawal(
  //                                 color: Color(0xFF130160),
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold,
  //                                 height: 1.5,
  //                               ),
  //                             ),
  //                             onPressed: () {
  //                               setState(() {
  //                                 answers[a] = answerController.text;
  //                               });
  //                               answerController.text = '';

  //                               Navigator.pop(context);
  //                             })))
  //               ],
  //             ));
  //       });
  // }

  // Future RequestAnswers(RequestAnswer req) async {
  //   final json = req.toJson();
  //   widget.request.collection('questions').doc().set(json);
  // }

  // Future addQuestion(RequestQuestion req) async {
  //   final json = req.toJson();
  //   setState(() {
  //     questions.addAll(json);
  //   });
  //   //widget.request.collection('questions').doc().set(json);
  // }

  // // Future addQuestionTF(RequestQuestionTF req) async {
  // //   final json = req.toJson();
  // //   setState(() {
  // //     questions.addAll(json);
  // //   });
  // //   //widget.request.collection('questions').doc().set(json);
  // // }

  // void ShowAlert() {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Color.fromARGB(0, 215, 147, 147),
  //       elevation: 0,
  //       content: Container(
  //         height: 70,
  //         padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //             color: Colors.red,
  //             borderRadius: BorderRadius.all(Radius.circular(20))),
  //         child: Stack(children: [
  //           Column(
  //             children: [
  //               Text(""),
  //               Text(
  //                 " يجب اكمال جميع البيانات للاستمرار",
  //                 style: GoogleFonts.tajawal(
  //                   fontSize: 13,
  //                 ),
  //               )
  //             ],
  //           ),
  //         ]),
  //       )));
  // }

  multipleChoice() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                height: 100,
                width: 150.w,
                decoration: BoxDecoration(
                  color: background[0],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Visibility(
                    //     visible: (answers[0].isEmpty || answers[0] == null)
                    //         ? true
                    //         : false,
                    //     child: Icon(
                    //       Icons.add,
                    //       color: Color(0xFF130160),
                    //     )),
                    const SizedBox(height: 3),
                    Text(
                      (answers[0].isEmpty) ? " " : answers[0],
                      style: const TextStyle(
                        color: Color(0xFF130160),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => AnswerSheet(answers[0], 0),
            ),
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: background[1],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Visibility(
                      //     visible: (answers[1].isEmpty || answers[1] == null)
                      //         ? true
                      //         : false,
                      //     child: Icon(
                      //       Icons.add,
                      //       color: Color(0xFF130160),
                      //     )),
                      const SizedBox(height: 3),
                      Text(
                        (answers[1].isEmpty) ? " " : answers[1],
                        style: const TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(answers[1], 1))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: background[2],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Visibility(
                      //     visible: (answers[2].isEmpty || answers[2] == null)
                      //         ? true
                      //         : false,
                      //     child: Icon(
                      //       Icons.add,
                      //       color: Color(0xFF130160),
                      //     )),
                      const SizedBox(height: 3),
                      Text(
                        (answers[2].isEmpty) ? " " : answers[2],
                        style: const TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(answers[2], 2)),
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: background[3],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Visibility(
                      //     visible: (answers[3].isEmpty || answers[3] == null)
                      //         ? true
                      //         : false,
                      //     child: Icon(
                      //       Icons.add,
                      //       color: Color(0xFF130160),
                      //     )),
                      const SizedBox(height: 3),
                      Text(
                        (answers[3].isEmpty) ? " " : answers[3],
                        style: const TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(answers[3], 3)),
          ],
        ),
      ],
    );
  }

  trueORfalse() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              height: 100,
              width: 150.w,
              decoration: BoxDecoration(
                color: background[0],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 3),
                  Text(
                    AnswertOrf[0],
                    style: const TextStyle(
                      color: Color(0xFF130160),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => AnswerSheet(AnswertOrf[0], 0),
          ),
          GestureDetector(
              child: Container(
                height: 100,
                width: 150.w,
                decoration: BoxDecoration(
                  color: background[1],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 3),
                    Text(
                      AnswertOrf[1],
                      style: const TextStyle(
                        color: Color(0xFF130160),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => AnswerSheet(AnswertOrf[1], 1))
        ],
      ),
    ]);
  }
}

class RequestQuestion {
  late String ID;
  late String title;
  late String answer1;
  late String answer2;
  late String answer3;
  late String answer4;
  late String correctAnswer;
  late String selectedtime;
  late int score;
  late String? type;

  RequestQuestion(
      {required this.ID,
      required this.title,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.correctAnswer,
      required this.selectedtime,
      required this.score,
      required this.type});

  Map<String, dynamic> toJson() => {
        ID: {
          'title': title,
          'answers': {
            'answer1': answer1,
            'answer2': answer2,
            'answer3': answer3,
            'answer4': answer4,
            'correctAnswer': correctAnswer
          },
          'time': selectedtime,
          'score': score,
          'type': type
        }
      };
}

class RequestuAnswer {
  late String ID;
  late int score;
  late Timestamp start;
  late Timestamp end;
  late String answer;
  late String name;
  late String userId;
  RequestuAnswer({
    required this.ID,
    required this.answer,
    required this.end,
    required this.start,
    required this.score,
    required this.name,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        ID: {
          'score': score,
          'start time': start,
          'end time': end,
          'answer': answer,
          'name': name,
          'userId': userId,
        }
      };
}

class RequestAnswer {
  late String answer1;
  late String answer2;
  late String answer3;
  late String answer4;
  RequestAnswer(
      {required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4});

  Map<String, dynamic> toJson() => {
        'answers': {
          'answer1': answer1,
          'answer2': answer2,
          'answer3': answer3,
          'answer4': answer4,
        }
      };
}
