// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, unnecessary_new

/* import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart'; */
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("الملف الشخصي",
              style: GoogleFonts.tajawal(
                  fontSize: 28,
                  color: Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromARGB(255, 19, 1, 96),
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Color(0x83FEEFC7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0x83FEEFC7),
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            //context.pushNamed('userProfile');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 2, 2, 2),
                                      child: Container(
                                          width: 60,
                                          height: 60,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child:
                                              Image.asset("assets/avatar.png")),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('لينا الزمامي',
                                      //selectionColor: Color.fromARGB(255, 19, 1,96),
                                      style: GoogleFonts.tajawal(
                                          fontSize: 28,
                                          color: Color.fromARGB(255, 19, 1, 96),
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('leen@gmail.com',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        //color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      //WithSaveLayer,
                                      color: Color.fromRGBO(
                                          255, 205, 77, 1), //-----------yeloow
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(
                                        Icons.group,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('15', //---------------------

                                        style: GoogleFonts.tajawal(
                                            fontSize: 25,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                    Text('مجموعة', //---------------

                                        style: GoogleFonts.tajawal(
                                            fontSize: 25,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Card(
                                      clipBehavior: Clip.antiAlias,
                                      //WithSaveLayer,
                                      color: Color.fromRGBO(255, 205, 77, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(
                                        Icons.calculate,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('23', //----------------------------

                                        style: GoogleFonts.tajawal(
                                            fontSize: 25,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        'اختبار', //--------------------------------

                                        style: GoogleFonts.tajawal(
                                            fontSize: 25,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('اختباراتي',
                                style: GoogleFonts.tajawal(
                                    fontSize: 28,
                                    color: Colors.black,
                                    //color: Color.fromARGB(255, 19, 1, 96),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: new Directionality(
                              textDirection: TextDirection.rtl,
                              child: new ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    radius: 30,
                                    child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            child: Image.asset(
                                                'assets/images/math.png')
                                            /* Icon(
                                                                    Icons.calculate), */
                                            )),
                                  ),
                                  title: Text(
                                    //document['taskName'],
                                    'القسمة المطولة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    //'${document['asignedKid']}\n${document['points']}🌟 | ${_colors(document['state'], document['asignedKid'])}',
                                    '22 سؤال | الرياضيات',
                                    style: GoogleFonts.tajawal(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 19, 1, 96),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  isThreeLine: true,
                                  onTap: () {},
                                  trailing: Wrap(
                                    spacing: 0,
                                  )),
                            ),
                          ),
                        ]))
              ],
            ),
          ),
        ));
  }
}
