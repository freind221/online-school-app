import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CreateQuiz.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CreateGroup.dart';

class HomeExpert extends StatefulWidget {
  const HomeExpert({super.key});

  @override
  State<HomeExpert> createState() => _HomeExpertState();
}

class _HomeExpertState extends State<HomeExpert> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: 180,
                        width: w * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(255, 205, 77, 1),
                        ),
                        child: Card(
                          color: Color.fromRGBO(255, 205, 77, 1),
                          shadowColor:
                              Gradients.tameer.colors.last.withOpacity(0.25),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Column(
                              children: [
                                //SvgPicture.asset("img/reqlist.svg"),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('انشاء',
                                    style: GoogleFonts.tajawal(
                                        color: Color(0xFF130160),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                MaterialButton(
                                  onPressed: () {},
                                  color: Colors.yellow,
                                  child: Text('sign out'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateQuiz()));
                      },
                    ),
                  ]),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ])));
  }
}
