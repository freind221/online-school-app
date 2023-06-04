import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/Question/style';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateQuestion extends StatefulWidget {
  CreateQuestion(
      { //required this.pin,
      required this.id,
      required this.questions});
  //late String pin;
  late DocumentReference request;
  late Map<String, dynamic> questions;
  late int id;

  @override
  _CreateQuestionState createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _correctAnswer = '';
  Duration? time = Duration(minutes: 10);
  int c = 0;
  bool isCorrect = false;
  String selectedtime = '10د';

  late String? _type = "اختيار من متعدد";

  TextEditingController questionController = TextEditingController();
  int _score = 10;
  TextEditingController answerController = TextEditingController();
  List<String> answers = [
    '',
    '',
    '',
    '',
  ];
  List<String> AnswertOrf = ['صح', 'خطأ'];

  @override
  Widget build(BuildContext context) {
    int index = widget.id;
    if (widget.questions.containsKey('$index') && c == 0) {
      questionController.text = widget.questions['$index']['title'];
      selectedtime = widget.questions['$index']['time'];
      _score = widget.questions['$index']['score'];
      _type = widget.questions['$index']['type'];
      _correctAnswer = widget.questions['$index']['answers']['correctAnswer'];
      if (_type == list[0]) {
        answers[0] = widget.questions['$index']['answers']['answer1'];
        answers[1] = widget.questions['$index']['answers']['answer2'];
        answers[2] = widget.questions['$index']['answers']['answer3'];
        answers[3] = widget.questions['$index']['answers']['answer4'];
      }
      c++;
    }
    return ScreenUtilInit(
        splitScreenMode: false,
        builder: (context, child) {
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Color.fromRGBO(255, 205, 77, 1),
              body: Directionality(
                textDirection: TextDirection.rtl,
                // textDirection: TextDirection.ltr,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlign/z
                        children: [
                          Positioned(
                            right: 10,
                            top: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF130160),
                              ),
                            ),
                          ),
                          Center(
                              child: Text("انشاء سؤال",
                                  style: GoogleFonts.tajawal(
                                      color: Color(0xFF130160),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          // Positioned(
                          //   left: 10,
                          //   top: 0,
                          //   bottom: 0,
                          //   child: DropdownButton(
                          //     elevation: 0,
                          //     dropdownColor: Colors.white,
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: Color(0xFF130160),
                          //     ),
                          //     underline: SizedBox(),
                          //     items: [
                          //       DropdownMenuItem(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             Icon(
                          //               Icons.copy,
                          //               color: Colors.black,
                          //             ),
                          //             SizedBox(width: 8),
                          //             Text(
                          //               "نسخ",
                          //               textAlign: TextAlign.right,
                          //             ),
                          //           ],
                          //         ),
                          //         value: 1,
                          //       ),
                          //       DropdownMenuItem(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             Icon(
                          //               Icons.delete,
                          //               color: Colors.red,
                          //             ),
                          //             SizedBox(width: 8),
                          //             Text(
                          //               "الغاء",
                          //               style: TextStyle(color: Colors.red),
                          //               textAlign: TextAlign.right,
                          //             ),
                          //           ],
                          //         ),
                          //         value: 2,
                          //       ),
                          //     ],
                          //     onChanged: (v) {
                          //       if (v == 2) {
                          //         // LogModel.test.remove(0);
                          //         // print(v);
                          //       }
                          //       // print(v);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
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
                              SizedBox(height: 16),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: List.generate(
                              //     8,
                              //     (index) => Container(
                              //       height: 35,
                              //       width: 35,
                              //       decoration: BoxDecoration(
                              //         color: index == 3
                              //             ? Colors.black
                              //             : Colors.white,
                              //         borderRadius: BorderRadius.circular(100),
                              //       ),
                              //       alignment: Alignment.center,
                              //       child: Text(
                              //         (index + 1).toString(),
                              //         style: TextStyle(
                              //           color: index == 3
                              //               ? Colors.white
                              //               : Colors.grey,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Row(children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("نوع السؤال:",
                                      style: GoogleFonts.tajawal(
                                          color: Color(0xFF130160),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 75),
                                    child: Text("النقاط:",
                                        style: GoogleFonts.tajawal(
                                            color: Color(0xFF130160),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                Container(
                                    padding: EdgeInsets.only(right: 55),
                                    child: Text("الوقت:",
                                        style: GoogleFonts.tajawal(
                                            color: Color(0xFF130160),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                              ]),
                              Container(
                                width: 200,
                                height: 60,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Container(
                                        width: 150,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 2),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 13),
                                            child: DropdownButton(
                                              // dropdownColor: Colors.black,
                                              value: _type,
                                              underline: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black),
                                              ),
                                              icon: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Icon(Icons
                                                      .keyboard_arrow_down_sharp)),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _type = newValue;
                                                });
                                              },
                                              iconSize: 30,
                                              isExpanded: false,
                                              items: list.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    value,
                                                    style: Style
                                                        .subtitleTextStyle
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    GestureDetector(
                                      child: Container(
                                          width: 100,
                                          height: 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.grey[300]!,
                                                  width: 2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(width: 13),
                                                NumberPicker(
                                                    step: 10,
                                                    itemCount: 2,
                                                    itemWidth: 50,
                                                    itemHeight: 30,
                                                    minValue: 10,
                                                    maxValue: 5000,
                                                    value: _score,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _score = value;
                                                      });
                                                    }),
                                                // Text(
                                                //   selectedtime,
                                                //   style: Style.subtitleTextStyle
                                                //       .copyWith(
                                                //     color: Colors.black,
                                                //     fontSize: 16,
                                                //   ),
                                                // ),
                                                SizedBox(width: 6),
                                                Icon(
                                                  IconData(0xe22c,
                                                      fontFamily:
                                                          'MaterialIcons'),
                                                  color: Color(0xFF130160),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                          width: 75,
                                          height: 60,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.grey[300]!,
                                                  width: 2),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(width: 13),
                                                Text(
                                                  selectedtime,
                                                  style: Style.subtitleTextStyle
                                                      .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Icon(
                                                  Icons.timer_sharp,
                                                  color: Color(0xFF130160),
                                                ),
                                              ],
                                            ),
                                          )),
                                      onTap: () async {
                                        time = await showDurationPicker(
                                            context: context,
                                            initialTime:
                                                const Duration(minutes: 10));
                                        setState(() {
                                          selectedtime =
                                              time.toString().substring(2, 4);
                                          selectedtime += 'د';
                                        });
                                      },
                                    ),
                                    // GestureDetector(
                                    //   child: Container(
                                    //       width: 80,
                                    //       height: 60,
                                    //       child: Container(
                                    //         decoration: BoxDecoration(
                                    //           color: Colors.white,
                                    //           borderRadius:
                                    //               BorderRadius.circular(15),
                                    //           border: Border.all(
                                    //               color: Colors.grey[300]!,
                                    //               width: 2),
                                    //         ),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.start,
                                    //           mainAxisSize: MainAxisSize.max,
                                    //           children: [
                                    //             SizedBox(width: 13),
                                    //             Text(
                                    //               selectedtime,
                                    //               style: Style.subtitleTextStyle
                                    //                   .copyWith(
                                    //                 color: Colors.black,
                                    //                 fontSize: 16,
                                    //               ),
                                    //             ),
                                    //             SizedBox(width: 6),
                                    //             Icon(
                                    //               IconData(0xe22c,
                                    // fontFamily:
                                    //   'MaterialIcons'),
                                    //               color: Color(0xFF130160),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )),
                                    // )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "السؤال",
                                  style: Style.subtitleTextStyle.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    height: .5,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  controller: questionController,
                                  maxLength: 150,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'هذه الخانة مطلوبة';
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  decoration: Style.inputregular("اضف السؤال",
                                      radius: 5.0),
                                ),
                              ),
                              SizedBox(height: 16),
                              _type == list[0]
                                  ? multipleChoice()
                                  : _type == list[1]
                                      ? trueORfalse()
                                      : Container()

                              // Column(
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       children: [
                              //         GestureDetector(
                              //           child: Container(
                              //             height: 100,
                              //             width: 150.w,
                              //             decoration: BoxDecoration(
                              //               color: Color.fromARGB(
                              //                   255, 251, 248, 239),
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //             ),
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.center,
                              //               children: [
                              //                 Visibility(
                              //                     visible: (answers[0]
                              //                                 .isEmpty ||
                              //                             answers[0] == null)
                              //                         ? true
                              //                         : false,
                              //                     child: Icon(
                              //                       Icons.add,
                              //                       color: Color(0xFF130160),
                              //                     )),
                              //                 SizedBox(height: 3),
                              //                 Text(
                              //                   (answers[0].isEmpty ||
                              //                           answers[0] == null)
                              //                       ? "أضف إجابة"
                              //                       : answers[0],
                              //                   style: TextStyle(
                              //                     color: Color(0xFF130160),
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //           onTap: () => AnswerSheet(0),
                              //         ),
                              //         GestureDetector(
                              //             child: Container(
                              //               height: 100,
                              //               width: 150.w,
                              //               decoration: BoxDecoration(
                              //                 color: Color.fromARGB(
                              //                     255, 251, 248, 239),
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //               ),
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 children: [
                              //                   Visibility(
                              //                       visible: (answers[1]
                              //                                   .isEmpty ||
                              //                               answers[1] == null)
                              //                           ? true
                              //                           : false,
                              //                       child: Icon(
                              //                         Icons.add,
                              //                         color: Color(0xFF130160),
                              //                       )),
                              //                   SizedBox(height: 3),
                              //                   Text(
                              //                     (answers[1].isEmpty ||
                              //                             answers[1] == null)
                              //                         ? "أضف إجابة"
                              //                         : answers[1],
                              //                     style: TextStyle(
                              //                       color: Color(0xFF130160),
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             onTap: () => AnswerSheet(1))
                              //       ],
                              //     ),
                              //     SizedBox(height: 12),
                              //     Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       children: [
                              //         GestureDetector(
                              //             child: Container(
                              //               height: 100,
                              //               width: 150.w,
                              //               decoration: BoxDecoration(
                              //                 color: Color.fromARGB(
                              //                     255, 251, 248, 239),
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //               ),
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 children: [
                              //                   Visibility(
                              //                       visible: (answers[2]
                              //                                   .isEmpty ||
                              //                               answers[2] == null)
                              //                           ? true
                              //                           : false,
                              //                       child: Icon(
                              //                         Icons.add,
                              //                         color: Color(0xFF130160),
                              //                       )),
                              //                   SizedBox(height: 3),
                              //                   Text(
                              //                     (answers[2].isEmpty ||
                              //                             answers[2] == null)
                              //                         ? "أضف إجابة"
                              //                         : answers[2],
                              //                     style: TextStyle(
                              //                       color: Color(0xFF130160),
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             onTap: () => AnswerSheet(2)),
                              //         GestureDetector(
                              //             child: Container(
                              //               height: 100,
                              //               width: 150.w,
                              //               decoration: BoxDecoration(
                              //                 color: Color.fromARGB(
                              //                     255, 251, 248, 239),
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //               ),
                              //               child: Column(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.center,
                              //                 children: [
                              //                   Visibility(
                              //                       visible: (answers[3]
                              //                                   .isEmpty ||
                              //                               answers[3] == null)
                              //                           ? true
                              //                           : false,
                              //                       child: Icon(
                              //                         Icons.add,
                              //                         color: Color(0xFF130160),
                              //                       )),
                              //                   SizedBox(height: 3),
                              //                   Text(
                              //                     (answers[3].isEmpty ||
                              //                             answers[3] == null)
                              //                         ? "أضف إجابة"
                              //                         : answers[3],
                              //                     style: TextStyle(
                              //                       color: Color(0xFF130160),
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             onTap: () => AnswerSheet(3)),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: GestureDetector(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 205, 77, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "انشاء السؤال",
                    style: TextStyle(
                      color: Color(0xFF130160),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),
                onTap: () async {
                  if (questionController.text.isEmpty || _correctAnswer == '') {
                    ShowAlert();
                    return;
                  } else if (_type == list[0]) {
                    if (answers.any((element) => element == '')) {
                      ShowAlert();
                      return;
                    }
                    if (widget.questions.containsKey(widget.id.toString())) {
                      widget.questions['$index']['title'] =
                          questionController.text;
                      widget.questions['$index']['time'] = selectedtime;
                      widget.questions['$index']['score'] = _score;
                      widget.questions['$index']['type'] = _type;
                      widget.questions['$index']['answers']['answer1'] =
                          answers[0];
                      widget.questions['$index']['answers']['answer2'] =
                          answers[1];
                      widget.questions['$index']['answers']['answer3'] =
                          answers[2];
                      widget.questions['$index']['answers']['answer4'] =
                          answers[3];
                      widget.questions['$index']['answers']['correctAnswer'] =
                          _correctAnswer;
                      setState(() {
                        Navigator.pop(context);
                      });
                      return;
                    }
                    final req = RequestQuestion(
                        ID: widget.id.toString(),
                        title: questionController.text,
                        answer1: answers[0],
                        answer2: answers[1],
                        answer3: answers[2],
                        answer4: answers[3],
                        correctAnswer: _correctAnswer,
                        selectedtime: selectedtime,
                        score: _score,
                        type: _type);
                    addQuestion(req);
                  } else if (_type == list[1]) {
                    if (widget.questions.containsKey(widget.id.toString())) {
                      widget.questions['$index']['title'] =
                          questionController.text;
                      widget.questions['$index']['time'] = selectedtime;
                      widget.questions['$index']['score'] = _score;
                      widget.questions['$index']['type'] = _type;
                      widget.questions['$index']['answers']['answer1'] =
                          AnswertOrf[0];
                      widget.questions['$index']['answers']['answer2'] =
                          AnswertOrf[1];
                      widget.questions['$index']['answers']['correctAnswer'] =
                          _correctAnswer;
                      Navigator.pop(context);
                      return;
                    }
                    final req = RequestQuestionTF(
                        ID: widget.id.toString(),
                        title: questionController.text,
                        answer1: AnswertOrf[0],
                        answer2: AnswertOrf[1],
                        correctAnswer: _correctAnswer,
                        selectedtime: selectedtime,
                        score: _score,
                        type: _type);
                    addQuestionTF(req);
                  }

                  // print(widget.questions.length);
                  // print(widget.questions);
                  // print(widget.id);

                  Navigator.pop(context);

                  // final reqa = RequestAnswer(
                  //     answer1: answers[0],
                  //     answer2: answers[1],
                  //     answer3: answers[2],
                  //     answer4: answers[3]);
                  // RequestAnswers(reqa);
                },
              ),
            ),
          );
        });
  }

  List<String> list = [
    "اختيار من متعدد",
    "صح وخطأ",
    "ترتيب",
  ];
  AnswerSheet(int a) {
    answerController.text = answers[a];
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   crossAxisAlignment:
                  //       CrossAxisAlignment
                  //           .end,
                  //   children: [
                  Text(
                    'الإجابة:',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                  ),
                  //],
                  //),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: answerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذه الخانة مطلوبة';
                      }
                    },
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    // controller: feedbackController,
                    maxLines: 3,
                    minLines: 3,
                    maxLength: 150,
                    decoration: InputDecoration(
                      hintText: 'ادخل الإجابة...',
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: const Color.fromRGBO(106, 119, 145, 1)
                              .withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontFamily:
                              'assets/font/Urbanist-VariableFont_wght.ttf'),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                    ),
                  ),
                  // SwitchListTile(
                  //   enableFeedback: true,
                  //   onChanged: (newValue) async {
                  //     setState(() {
                  //       if (newValue == true) {
                  //         correctAnswer = answers[a];
                  //       } else {
                  //         correctAnswer = "/";
                  //       }
                  //       print(correctAnswer);
                  //     });
                  //   },
                  //   value: correctAnswer == answers[a] ? true : false,
                  //   title: Text(
                  //     'الإجابة الصحيحة',
                  //     style: GoogleFonts.tajawal(
                  //       color: Color(0xFF130160),
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       height: 1.5,
                  //     ),
                  //   ),
                  //   tileColor: Color(0xFFF5F5F5),
                  //   dense: false,
                  //   controlAffinity: ListTileControlAffinity.trailing,
                  // ),
                  Row(
                    children: [
                      Text('الإجابة الصحيحة',
                          style: GoogleFonts.tajawal(
                            color: Color(0xFF130160),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          )),
                      Container(
                          padding: EdgeInsets.only(right: 200),
                          alignment: Alignment.centerLeft,
                          child: Switch(
                            value: _correctAnswer == answerController.text &&
                                answerController.text.isNotEmpty,
                            onChanged: (newValue) async {
                              setState(() {
                                if (newValue == true &&
                                    answerController.text.isNotEmpty) {
                                  _correctAnswer = answerController.text;
                                } else {
                                  _correctAnswer = "";
                                }
                                print(_correctAnswer);
                              });
                            },
                          ))
                    ],
                  ),
                  GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 205, 77, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: Size(250, 56),
                                  alignment: Alignment.center),
                              child: Text(
                                "اضف الإجابة ",
                                style: GoogleFonts.tajawal(
                                  color: Color(0xFF130160),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  answers[a] = answerController.text;
                                });
                                answerController.text = '';

                                Navigator.pop(context);
                              })))
                ],
              ));
        });
  }

  AnswerSheetTF(int a) {
    answerController.text = AnswertOrf[a];
    isCorrect = _correctAnswer == answerController.text &&
        answerController.text.isNotEmpty;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   crossAxisAlignment:
                  //       CrossAxisAlignment
                  //           .end,
                  //   children: [
                  Text(
                    'الإجابة:',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                  ),
                  //],
                  //),
                  TextFormField(
                    readOnly: true,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: answerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذه الخانة مطلوبة';
                      }
                    },
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.text,
                    // controller: feedbackController,
                    maxLines: 3,
                    minLines: 3,

                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: const Color.fromRGBO(106, 119, 145, 1)
                              .withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontFamily:
                              'assets/font/Urbanist-VariableFont_wght.ttf'),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                    ),
                  ),
                  // SwitchListTile(
                  //   enableFeedback: true,
                  //   onChanged: (newValue) async {
                  //     setState(() {
                  //       if (newValue == true) {
                  //         correctAnswer = answers[a];
                  //       } else {
                  //         correctAnswer = "/";
                  //       }
                  //       print(correctAnswer);
                  //     });
                  //   },
                  //   value: correctAnswer == answers[a] ? true : false,
                  //   title: Text(
                  //     'الإجابة الصحيحة',
                  //     style: GoogleFonts.tajawal(
                  //       color: Color(0xFF130160),
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold,
                  //       height: 1.5,
                  //     ),
                  //   ),
                  //   tileColor: Color(0xFFF5F5F5),
                  //   dense: false,
                  //   controlAffinity: ListTileControlAffinity.trailing,
                  // ),
                  Row(
                    children: [
                      Text('الإجابة الصحيحة',
                          style: GoogleFonts.tajawal(
                            color: Color(0xFF130160),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          )),
                      Container(
                          padding: EdgeInsets.only(right: 200),
                          alignment: Alignment.centerLeft,
                          child: Switch(
                            value: isCorrect,
                            onChanged: (newValue) async {
                              setState(() {
                                if (newValue == true &&
                                    answerController.text.isNotEmpty) {
                                  _correctAnswer = answerController.text;
                                } else {
                                  _correctAnswer = "";
                                }
                                isCorrect =
                                    _correctAnswer == answerController.text &&
                                        answerController.text.isNotEmpty;
                                // print(_correctAnswer);
                              });
                            },
                          ))
                    ],
                  ),
                  // GestureDetector(
                  //     child: Container(
                  //         alignment: Alignment.center,
                  //         margin: EdgeInsets.only(top: 40),
                  //         child: ElevatedButton(
                  //             style: ElevatedButton.styleFrom(
                  //                 primary: Color.fromRGBO(255, 205, 77, 1),
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 fixedSize: Size(250, 56),
                  //                 alignment: Alignment.center),
                  //             child: Text(
                  //               "اضف الإجابة ",
                  //               style: GoogleFonts.tajawal(
                  //                 color: Color(0xFF130160),
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold,
                  //                 height: 1.5,
                  //               ),
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 answers[a] = answerController.text;
                  //               });
                  //               answerController.text = '';

                  //               Navigator.pop(context);
                  //             })))
                ],
              ));
        });
  }

  Future RequestAnswers(RequestAnswer req) async {
    final json = req.toJson();
    widget.request.collection('questions').doc().set(json);
  }

  Future addQuestion(RequestQuestion req) async {
    final json = req.toJson();
    setState(() {
      widget.questions.addAll(json);
    });
    //widget.request.collection('questions').doc().set(json);
  }

  Future addQuestionTF(RequestQuestionTF req) async {
    final json = req.toJson();
    setState(() {
      widget.questions.addAll(json);
    });
    //widget.request.collection('questions').doc().set(json);
  }

  void ShowAlert() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 215, 147, 147),
        elevation: 0,
        content: Container(
          height: 70,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(children: [
            Column(
              children: [
                Text(""),
                Text(
                  " يجب اكمال جميع البيانات للاستمرار",
                  style: GoogleFonts.tajawal(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ]),
        )));
  }

  multipleChoice() {
    // int index = widget.id;

    // if (widget.questions.containsKey('$index') && c == 0) {
    //   questionController.text = widget.questions['$index']['title'];
    //   selectedtime = widget.questions['$index']['time'];
    //   _score = widget.questions['$index']['score'];
    //   _type = widget.questions['$index']['type'];
    //   _correctAnswer = widget.questions['$index']['answers']['correctAnswer'];

    //   if (_type == list[0]) {
    //     answers[0] = widget.questions['$index']['answers']['answer1'];
    //     answers[1] = widget.questions['$index']['answers']['answer2'];
    //     answers[2] = widget.questions['$index']['answers']['answer3'];
    //     answers[3] = widget.questions['$index']['answers']['answer4'];
    //   }
    //   c++;
    // }
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
                  color: Color.fromARGB(255, 251, 248, 239),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: (answers[0].isEmpty || answers[0] == null)
                            ? true
                            : false,
                        child: Icon(
                          Icons.add,
                          color: Color(0xFF130160),
                        )),
                    SizedBox(height: 3),
                    Text(
                      (answers[0].isEmpty || answers[0] == null)
                          ? "أضف إجابة"
                          : answers[0],
                      style: TextStyle(
                        color: Color(0xFF130160),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => AnswerSheet(0),
            ),
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 251, 248, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                          visible: (answers[1].isEmpty || answers[1] == null)
                              ? true
                              : false,
                          child: Icon(
                            Icons.add,
                            color: Color(0xFF130160),
                          )),
                      SizedBox(height: 3),
                      Text(
                        (answers[1].isEmpty || answers[1] == null)
                            ? "أضف إجابة"
                            : answers[1],
                        style: TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(1))
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 251, 248, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                          visible: (answers[2].isEmpty || answers[2] == null)
                              ? true
                              : false,
                          child: Icon(
                            Icons.add,
                            color: Color(0xFF130160),
                          )),
                      SizedBox(height: 3),
                      Text(
                        (answers[2].isEmpty || answers[2] == null)
                            ? "أضف إجابة"
                            : answers[2],
                        style: TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(2)),
            GestureDetector(
                child: Container(
                  height: 100,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 251, 248, 239),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                          visible: (answers[3].isEmpty || answers[3] == null)
                              ? true
                              : false,
                          child: Icon(
                            Icons.add,
                            color: Color(0xFF130160),
                          )),
                      SizedBox(height: 3),
                      Text(
                        (answers[3].isEmpty || answers[3] == null)
                            ? "أضف إجابة"
                            : answers[3],
                        style: TextStyle(
                          color: Color(0xFF130160),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => AnswerSheet(3)),
          ],
        ),
      ],
    );
  }

  // cleanAll() {
  //   answers[0] = '';
  //   answers[1] = '';
  //   answers[2] = '';
  //   answers[3] = '';
  //   selectedtime = '10د';
  //   _score = 100;
  // }

  trueORfalse() {
    // int index = widget.id;
    // if (widget.questions.containsKey('$index')) {
    //   questionController.text = widget.questions['$index']['title'];
    //   selectedtime = widget.questions['$index']['time'];
    //   _score = widget.questions['$index']['score'];
    //   _type = widget.questions['$index']['type'];
    //   _correctAnswer = widget.questions['$index']['answers']['correctAnswer'];
    //   if (_type == list[0]) {
    //     answers[0] = widget.questions['$index']['answers']['answer1'];
    //     answers[1] = widget.questions['$index']['answers']['answer2'];
    //     answers[2] = widget.questions['$index']['answers']['answer3'];
    //     answers[3] = widget.questions['$index']['answers']['answer4'];
    //   }
    // }
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
                color: Color.fromARGB(255, 251, 248, 239),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 3),
                  Text(
                    AnswertOrf[0],
                    style: TextStyle(
                      color: Color(0xFF130160),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => AnswerSheetTF(0),
          ),
          GestureDetector(
              child: Container(
                height: 100,
                width: 150.w,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 251, 248, 239),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    Text(
                      AnswertOrf[1],
                      style: TextStyle(
                        color: Color(0xFF130160),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => AnswerSheetTF(1))
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
        '$ID': {
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

class RequestQuestionTF {
  late String ID;
  late String title;
  late String answer1;
  late String answer2;
  late String correctAnswer;
  late String selectedtime;
  late int score;
  late String? type;

  RequestQuestionTF(
      {required this.ID,
      required this.title,
      required this.answer1,
      required this.answer2,
      required this.correctAnswer,
      required this.selectedtime,
      required this.score,
      required this.type});

  Map<String, dynamic> toJson() => {
        '$ID': {
          'title': title,
          'answers': {
            'answer1': answer1,
            'answer2': answer2,
            'correctAnswer': correctAnswer
          },
          'time': selectedtime,
          'score': score,
          'type': type
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
