// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  //var ind =  1 +  Random().nextInt(4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromRGBO(255, 205, 77, 1),
          title: Text("  مجموعة 1 ",
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
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                      child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(children: [
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
                                    fontSize: 28,
                                    color: Color.fromARGB(255, 19, 1, 96),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                width: 200,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  tabs: [
                                    Tab(
                                        child: Text(
                                      ' مجدول',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )),
                                    Tab(
                                        child: Text(
                                      ' مباشر',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 19, 1, 96),
                                        //fontWeight: FontWeight.bold
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ]),
                            Expanded(
                                child: TabBarView(children: [
                              ListView.builder(
                                itemBuilder: (Context, index) {
                                  /*  Map<String, dynamic> document =
                                                snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>; */

                                  String image;
                                  switch (/* document['category'] */
                                      'category') {
                                    case "الرياضيات":
                                      image = 'assest/images/math.png';
                                      break;

                                    case "الفيزياء":
                                      image = 'assest/images/physics.png';
                                      break;

                                    case "احياء":
                                      image = 'assest/images/biology.png';
                                      break;

                                    default:
                                      image = 'assest/images/math.png';
                                  }
                                  return Card(
                                      elevation: 5,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10,
                                      ),
                                      child: new Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: new ListTile(
                                                leading: Card(
                                                    /*  child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0), */
                                                    /*  child: Container(
                                                              height: 500,
                                                              width: 50, */
                                                    child:
                                                        /*  Image.network(
                                                              'https://cdn-icons-png.flaticon.com/512/74/74577.png',
                                                              width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ) */ /* 
                                                                   Image.asset(
                                                                      image), */
                                                        Image.asset(
                                                            'assets/images/math.png',
                                                            width: 50,
                                                            height: 350,
                                                            fit: BoxFit.fill)
                                                    /*  width: 100,
                                                                              height: 150,
                                                                              fit: BoxFit.contain, */

                                                    //)
                                                    // ),
                                                    ),
                                                title: Column(children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        //document['taskName']
                                                        'عنوان',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'عدد الاسئلة',
                                                        //'${document['asignedKid']}\n${document['points']}🌟/*  | ${_colors(document['state'], document['asignedKid'])} */',
                                                        style:
                                                            GoogleFonts.tajawal(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          height: 25,
                                                          width: 80,
                                                          child: Center(
                                                            child: Text(
                                                                'رياضيات',
                                                                style:
                                                                    GoogleFonts
                                                                        .tajawal(
                                                                  fontSize: 15,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          19,
                                                                          1,
                                                                          96),
                                                                )),
                                                          )),
                                                    ],
                                                  )
                                                ]),
                                                onTap: () {
                                                  /*  Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (builder) => View_task(
                                                                    document:
                                                                        document,
                                                                    id: snapshot
                                                                        .data
                                                                        ?.docs[
                                                                            index]
                                                                        .id as String
                                                                    //pass doc
                                                                    ))); */
                                                },
                                                trailing: Wrap(
                                                    spacing: 1,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.circle,
                                                        color: Colors.green,
                                                        size: 15,
                                                      ),
                                                      Text('نشط الان',
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 15,
                                                            color: Colors.green,
                                                          )),
                                                      /* if (document[
                                                                    'state'] ==
                                                                'pending')
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .check),
                                                                color: Colors
                                                                    .black,
                                                                onPressed: () =>
                                                                    {
                                                                  if (document[
                                                                          'state'] ==
                                                                      'pending')
                                                                    _showDialog(
                                                                        document[
                                                                            'tid'],
                                                                        document[
                                                                            'adult'],
                                                                        document[
                                                                            'asignedKid'],
                                                                        document[
                                                                            'points'])
                                                                  else
                                                                    _showDialog2()
                                                                },
                                                              ), */
                                                    ])),
                                          )));
                                },
                                //itemCount: snapshot.data!.docs.length,
                              ),
                              ListView.builder(
                                itemBuilder: (Context, index) {
                                  /*  Map<String, dynamic> document =
                                                snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>; */

                                  String image;
                                  switch (/* document['category'] */
                                      'category') {
                                    case "الرياضيات":
                                      image = 'assets/images/math.png';
                                      break;

                                    case "الفيزياء":
                                      image = 'assets/images/physics.png';
                                      break;

                                    case "احياء":
                                      image = 'assets/images/biology.png';
                                      break;

                                    default:
                                      image = 'assets/images/physics.png';
                                  }
                                  var ind = 1 + Random().nextInt(4);
                                  return Container(
                                      height: 200,
                                      //width: 300,
                                      child: Card(
                                          elevation: 5,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 20,
                                          ),
                                          child: new Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/group' +
                                                          ind.toString() +
                                                          '_image.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              /*  child: Padding(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        3), */
                                              child: new ListTile(
                                                  //style: ,
                                                  /*  leading:Card(
                                                          child: Padding(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        2),
                                                                child: Container(
                                                                  height: 300,
                                                                  width: 50,
                                                                  child:
                                                                  Image.asset('assets/Flogo.jpg')
                                                                  /* Image.network(
                                                                  'https://cdn-icons-png.flaticon.com/512/74/74577.png',
                                                                  /* width: 100,
                                                                          height: 150, */
                                                                          fit: BoxFit.contain,
                                                                        ) */
                                                                    /*   Image.asset(
                                                                          image), */
                                                                )),
                                                          ), */
                                                  title: Column(children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          //document['taskName']
                                                          'المجموعة',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.person,
                                                            color: Colors
                                                                .grey[600]),
                                                        Text(
                                                          ' عدد الاعضاء',
                                                          //'${document['asignedKid']}\n${document['points']}🌟/*  | ${_colors(document['state'], document['asignedKid'])} */',
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                                  onTap: () {
                                                    /*  Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder: (builder) => View_task(
                                                                        document:
                                                                            document,
                                                                        id: snapshot
                                                                            .data
                                                                            ?.docs[
                                                                                index]
                                                                            .id as String
                                                                        //pass doc
                                                                        ))); */
                                                  },
                                                  trailing: Wrap(
                                                      spacing: 1,
                                                      children: <Widget>[
                                                        IconButton(
                                                          /*  borderColor: Color(0xFFF1F4F8),
                                                                    borderRadius: 8,
                                                                    borderWidth: 2,
                                                                    buttonSize: 40, */
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    19,
                                                                    1,
                                                                    96),
                                                            //color: Color(0xFF57636C),
                                                            size: 30,
                                                          ),
                                                          onPressed: () {
                                                            print(
                                                                'IconButton pressed ...');
                                                          },
                                                        ),
                                                        /* if (document[
                                                                        'state'] ==
                                                                    'pending')
                                                                  IconButton(
                                                                    icon: Icon(Icons
                                                                        .check),
                                                                    color: Colors
                                                                        .black,
                                                                    onPressed: () =>
                                                                        {
                                                                      if (document[
                                                                              'state'] ==
                                                                          'pending')
                                                                        _showDialog(
                                                                            document[
                                                                                'tid'],
                                                                            document[
                                                                                'adult'],
                                                                            document[
                                                                                'asignedKid'],
                                                                            document[
                                                                                'points'])
                                                                      else
                                                                        _showDialog2()
                                                                    },
                                                                  ), */
                                                      ])),
                                            ),
                                          )));
                                  //);
                                },
                                //itemCount: snapshot.data!.docs.length,
                                // )
                              )
                            ]))
                          ])))
                ]))));
  }
}
