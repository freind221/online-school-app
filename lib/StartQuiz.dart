import 'package:faheem/QuizStatistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Question/QuestionsAnswer.dart';
// import 'Revision Request Form.dart';
// import 'Labeling Request Form.dart';
//import 'package:tagie/Login.dart';
import 'bottom_tab.dart';
import 'cubit/start_quiz/cubit/start_quiz_cubit.dart';

//import 'SignUp.dart';

class StartQuiz extends StatefulWidget {
  StartQuiz({super.key, required this.pin, required this.groupPin});
  late String pin;
  final String? groupPin;
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => StartQuizCubit()..getQuize(widget.pin),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
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
          centerTitle: true,
          elevation: 0,
        ),
        body: StartQuizView(h: h, widget: widget),
      ),
    );
  }
}

class StartQuizView extends StatelessWidget {
  const StartQuizView({
    super.key,
    required this.h,
    required this.widget,
  });

  final double h;
  final StartQuiz widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartQuizCubit, StartQuizState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<StartQuizCubit>(context);
        if (state is StartQuizSuccess) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 1, right: 1),
                      child: Text(
                        cubit.testDataModel.category,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.tajawal(
                            fontSize: 35,
                            color: const Color.fromARGB(255, 19, 1, 96),
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                  //     child: Text(
                  //       'هل انت جاهز لبدء الاختبار ',
                  //       style: GoogleFonts.tajawal(
                  //           fontSize: 28,
                  //           color: Color.fromARGB(255, 19, 1, 96),
                  //           fontWeight: FontWeight.bold),
                  //       textAlign: TextAlign.center,
                  //     )),
                  // SizedBox(
                  //   height: h * 0.1,
                  // ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 10),
                    child: Container(
                      width: 300,
                      height: 270,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        image: DecorationImage(
                          image: Image.network(
                            cubit.testDataModel.img,
                          ).image,
                        ),
                      ),
                    ),
                  ),
                  // SvgPicture.asset(
                  //   'assets/Flogo.jpg',
                  //   width: w * 0.6,
                  // ),
                  SizedBox(
                    height: h * 0.1,
                  ),
                  Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        'الوقت :  ${cubit.quizTime.toArabicNumbers} د',
                        style: GoogleFonts.tajawal(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 143, 139, 139),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        'عدد الاسئلة : ${cubit.testDataModel.questionsNumber} ',
                        style: GoogleFonts.tajawal(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 143, 139, 139),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),

                  // SizedBox(
                  //   width: w * 0.9,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => RequestForm()));
                  //       },
                  //       style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all<Color>(
                  //               Color.fromARGB(255, 255, 255, 255)),
                  //           shape:
                  //               MaterialStateProperty.all<RoundedRectangleBorder>(
                  //                   RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(15),
                  //                       side: BorderSide(
                  //                           width: 2,
                  //                           color:
                  //                               Color.fromARGB(255, 19, 1, 96))))),
                  //       child: Text(
                  //         'Full Labeling Request',
                  //         style: GoogleFonts.comfortaa(
                  //             color: Color.fromARGB(255, 19, 1, 96), fontSize: 22),
                  //       )),
                  // ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  // SizedBox(
                  //   width: w * 0.9,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: (context) => RivisonRequestForm()));
                  //       },
                  //       style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all<Color>(
                  //               Color.fromARGB(255, 255, 255, 255)),
                  //           shape:
                  //               MaterialStateProperty.all<RoundedRectangleBorder>(
                  //                   RoundedRectangleBorder(
                  //                       borderRadius: BorderRadius.circular(15),
                  //                       side: BorderSide(
                  //                           width: 2,
                  //                           color:
                  //                               Color.fromARGB(255, 19, 1, 96))))),
                  //       child: Text(
                  //         'Revision Labeling Request',
                  //         style: GoogleFonts.comfortaa(
                  //             color: Color.fromARGB(255, 19, 1, 96), fontSize: 22),
                  //       )),
                  // ),
                  Container(
                    child: MaterialButton(
                      minWidth: 300,
                      height: 60,
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnswerQuestion(
                                  groupPin: widget.groupPin,
                                  pin: widget.pin,
                                  id: 1,
                                )));
                      },
                      color: const Color.fromRGBO(255, 205, 77, 1),
                      elevation: 0,
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 205, 77, 1),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text("ابدأ الاختبار ",
                          style: GoogleFonts.tajawal(
                              fontSize: 22,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is StartQuizFailure) {
          return const Center(child: Text("Error Occured"));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
