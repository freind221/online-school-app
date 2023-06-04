// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:faheem/TestReport.dart';

import '../Question/QuestionsAnswer.dart';

class AfterQuiz extends StatefulWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int score;
  final int completed;
  final int questionsNum;

  final String pin;
  final String? groupPin;
  const AfterQuiz({
    Key? key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
    required this.questionsNum,
    required this.completed,
    required this.pin,
    required this.groupPin,
  }) : super(key: key);

  @override
  State<AfterQuiz> createState() => _AfterQuizState();
}

class _AfterQuizState extends State<AfterQuiz> {
  @override
  void dispose() {
    correctAnswers = 0;
    wrongAnswers = 0;
    totalScore = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "عمل جيد !",
            style: GoogleFonts.tajawal(
                fontSize: 30,
                color: const Color.fromARGB(255, 19, 1, 96),
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Text(
              'X',
              style: GoogleFonts.tajawal(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 30),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/after_quiz.png')),
                    color: const Color(0xffFE8FA2),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "لقد حصلت على  ${widget.score} نقطه ",
                  style: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "الاجابات الصحيحة",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 143, 139, 139),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${widget.correctAnswers}  اسئلة",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "الاجابات الخاطئة",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 143, 139, 139),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${widget.wrongAnswers}  اسئلة",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "تم اكمال",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 143, 139, 139),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${widget.completed} ٪ ",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "عدد الاسئلة",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 143, 139, 139),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${widget.questionsNum} ",
                          style: GoogleFonts.tajawal(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffFFCD4D))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => TestReport(
                                pin: widget.pin,
                                groupPin: widget.groupPin,
                              )),
                    );
                  },
                  child: Text(
                    "استمرار الى تقرير الاختبار",
                    style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 19, 1, 96),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
