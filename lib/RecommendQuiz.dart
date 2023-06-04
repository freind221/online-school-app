import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';

class RecommendQuiz extends StatefulWidget {
  const RecommendQuiz({super.key});

  @override
  _RecommendQuizState createState() => _RecommendQuizState();
}

class _RecommendQuizState extends State<RecommendQuiz> {
  Stream<QuerySnapshot> _regStream =
      FirebaseFirestore.instance.collection('quiz').snapshots();

  var fullname;
  var category;
  var description;
  var certification;
  var email; //
  var profilepic;

  ///

  makeListTile(QuerySnapshot<Object?> data, int index) => ListTile(
        //  pic = data.docs[index]['profilepic'];
        //contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        //contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        // isThreeLine: true,
        //contentPadding: EdgeInsets.all(40.0),

        // leading: ConstrainedBox(
        //   constraints: BoxConstraints(
        //     minWidth: 0.0,
        //     minHeight: 66,
        //     maxWidth: 130,
        //     maxHeight: 200,
        //   ),
        //   child: Image.asset("assets/avatar.png"),
        // ),

        // leading:
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       // fit: BoxFit
        //       //     .cover, //I assumed you want to occupy the entire space of the card
        //       image: AssetImage(
        //         ("assets/avatar.png"),
        //       ),
        //     ),
        //   ),
        // ),

        //     ClipRRect(
        //   borderRadius: BorderRadius.circular(0.0), //or 15.0
        //   child: Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         // fit: BoxFit
        //         //     .cover, //I assumed you want to occupy the entire space of the card
        //         image: AssetImage(
        //           ("assets/avatar.png"),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        // leading: CircleAvatar(
        //   radius: 27,
        //   backgroundColor: Color(0xFFd6cdfe),
        //   child: CircleAvatar(
        //     radius: 25,
        //     backgroundColor: Colors.white,
        //     //backgroundImage: NetworkImage(data.docs[index]['profilepic'])
        //   ),
        // ),

        // Image(image: NetworkImage(data.docs[index]['profilepic'])),

        //صورة مربعة
        //     ClipRRect(
        //   borderRadius: BorderRadius.circular(20.0), //or 15.0
        //   child: Container(
        //     height: 70.0,
        //     width: 70.0,
        //     color: Color(0xffFF0E58),
        //    // backgroundImage: NetworkImage(''),
        //     // child: Icon(Icons.volume_up, color: Colors.white, size: 50.0),
        //   ),
        // ),

        /// صورة دائرية
        //     CircleAvatar(
        //   radius: 27,
        //   backgroundColor: Color(0xFFd6cdfe),

        //   // هنا نحط صورة الاختبار
        //   child: CircleAvatar(
        //     radius: 25,
        //     backgroundColor: Colors.white,
        //     backgroundImage: NetworkImage(''),
        //   ),
        // ),

        // leading: Column(
        //   children: <Widget>[
        //     Container(
        //       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        //       margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //       // width: double.infinity,
        //       height: 50,
        //       decoration: BoxDecoration(
        //         color: Color.fromARGB(255, 237, 236, 241),
        //       ),
        //       child: Text(
        //         data.docs[index]['name'],
        //         // "مبادئ الجمع",
        //         style: GoogleFonts.comfortaa(
        //           color: Color.fromARGB(255, 15, 14, 22),
        //           fontSize: 25,
        //           fontWeight: FontWeight.bold,

        //           //backgroundColor: Color.fromARGB(255, 243, 243, 247)
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        //style: ListTileStyle.list,

        // title: Text(
        //   data.docs[index]['name'],
        //   // "مبادئ الجمع",
        //   style: GoogleFonts.comfortaa(
        //     color: Color.fromARGB(255, 237, 236, 241),
        //     fontSize: 25,
        //     fontWeight: FontWeight.bold,

        //     //backgroundColor: Color.fromARGB(255, 243, 243, 247)
        //   ),
        // ),
        // // subtitle: Column(
        // //   children: <Widget>[
        // //     //Icon(Icons.numbers_sharp, color: Color(0xFFfca34d)),
        // //     Text(
        // //         //data.docs[index]['email'],
        // //         'عدد الاسئلة : 22',
        // //         style: GoogleFonts.comfortaa(
        // //             color: Color.fromARGB(255, 237, 236, 241), fontSize: 15)),
        // //   ],
        // // ),

        title: Text(
          data.docs[index]['name'],
          // "مبادئ الجمع",
          style: GoogleFonts.comfortaa(
            color: Color.fromARGB(255, 8, 2, 32),
            fontSize: 17,
            fontWeight: FontWeight.bold,

            //backgroundColor: Color.fromARGB(255, 243, 243, 247)
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            //Icon(Icons.numbers_sharp, color: Color(0xFFfca34d)),
            Text(
                //data.docs[index]['email'],
                'عدد الاسئلة : 22',
                style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 4, 1, 18), fontSize: 17)),
          ],
        ),

        ////////////////// oooo /////////////////

        // trailing:
        //     Icon(Icons.keyboard_arrow_left, color: Color(0xFF130160), size: 30.0),
        // onTap: () {
        //   // fullname = data.docs[index]['fullname'];
        //   // category = data.docs[index]['category'];
        //   // description = data.docs[index]['description'];
        //   // certification = data.docs[index]['certification'];
        //   // email = data.docs[index]['email']; //
        //   // profilepic = data.docs[index]['profilepic']; ////
        //   // Navigator.push(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //         builder: (context) => detailed_regestration(fullname, category,
        //   //             description, certification, email, profilepic)));
        // }
      );

  makeCard(QuerySnapshot<Object?> d, int index) => Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
      // ignore: prefer_const_constructors
       
      /// Down ////
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage("assets/group1_image.png"),
                  fit: BoxFit.cover,
                ),
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.20))
                ]),
            //child: makeListTile(d, index),
          ),
          Container(
            height: 67,

            //padding: EdgeInsets.all(80.0),
            // decoration: BoxDecoration(
            //     image: new DecorationImage(
            //       image: new ExactAssetImage("assets/group1_image.png"),
            //       fit: BoxFit.cover,
            //     ),
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     borderRadius: BorderRadius.circular(25),
            //     boxShadow: [
            //       BoxShadow(
            //           blurRadius: 10,
            //           offset: Offset(1, 1),
            //           color: Colors.grey.withOpacity(0.20))
            //     ]),
            child: makeListTile(d, index),
          ),
        ],
      )

      ////// Up ////

      // child: Column(
      //   children: [
      //     Container(
      //       height: 67,

      //       //padding: EdgeInsets.all(80.0),
      //       // decoration: BoxDecoration(
      //       //     image: new DecorationImage(
      //       //       image: new ExactAssetImage("assets/group1_image.png"),
      //       //       fit: BoxFit.cover,
      //       //     ),
      //       //     color: Color.fromARGB(255, 255, 255, 255),
      //       //     borderRadius: BorderRadius.circular(25),
      //       //     boxShadow: [
      //       //       BoxShadow(
      //       //           blurRadius: 10,
      //       //           offset: Offset(1, 1),
      //       //           color: Colors.grey.withOpacity(0.20))
      //       //     ]),
      //       child: makeListTile(d, index),
      //     ),
      //     Container(
      //       height: 120,
      //       decoration: BoxDecoration(
      //           image: new DecorationImage(
      //             image: new ExactAssetImage("assets/group1_image.png"),
      //             fit: BoxFit.cover,
      //           ),
      //           color: Color.fromARGB(255, 255, 255, 255),
      //           borderRadius: BorderRadius.circular(25),
      //           boxShadow: [
      //             BoxShadow(
      //                 blurRadius: 10,
      //                 offset: Offset(1, 1),
      //                 color: Colors.grey.withOpacity(0.20))
      //           ]),
      //       //child: makeListTile(d, index),
      //     ),
      //   ],
      // )
      );

  makeBody() {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: _regStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("");
        }

        final data = snapshot.requireData;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          shrinkWrap: true,
          itemCount: data.size,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 5),
          itemBuilder: (BuildContext context, int index) {
            return makeCard(data, index);
          },
        );
      },
    ));
  }

  final topAppBar = AppBar(
    centerTitle: true,
    elevation: 0.1,
    foregroundColor: Color(0xFF130160),
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    title: Text(' المقترحة',
        style: GoogleFonts.comfortaa(
          color: Color(0xFF130160),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        textAlign: TextAlign.center),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCD4D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomeExpert(),
            //   ),
            // );
          },
        ),
        title: Text(
          'الاختبارات المقترحة',
          style: GoogleFonts.tajawal(
              fontSize: 25,
              color: Color.fromARGB(255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: makeBody(),
    );
  }
}
