import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'bottom_tab.dart';

import 'dart:async';

class RecentlyQuiz extends StatefulWidget {
  const RecentlyQuiz({super.key});

  @override
  _RecentlyQuizState createState() => _RecentlyQuizState();
}

class _RecentlyQuizState extends State<RecentlyQuiz> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uemail;
  // var dsName;

  Future getCurrentUser() async {
    final User user = _auth.currentUser!;

    uemail = user.email;

    print(uemail);
  }

  late Stream<QuerySnapshot> _reqStream;
  method1() {
    _reqStream = FirebaseFirestore.instance
        .collection('quiz')
        .where('ownerId', isEqualTo: uemail)
        // .orderBy('createAt', descending: true)
        //.where('state', isEqualTo: 'not accepted' )
        .snapshots();
  }

  @override
  void initState() {
    getCurrentUser();
    method1();
    super.initState();
  }

//  @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//     method1();
//     title = widget.name;
//   }

//     Future getCurrentUser() async {
//     final User user = _auth.currentUser!;

//     uemail = user.email;

//     print(uemail);
//   }
//     late  Stream<QuerySnapshot> _offerStream;
//   method1() {
//     _offerStream = FirebaseFirestore.instance
//         .collection('OfferPrice')
//         .where('mlEmail', isEqualTo: uemail)
//         .where('requestID', isEqualTo: widget.requestID)
//         .where('status', isEqualTo: 'waiting')
//         .orderBy('createAt', descending: true)
//         .snapshots();
//   }

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
      stream: _reqStream,
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

  // final topAppBar = AppBar(
  //   backgroundColor: Color(0xFFFFCD4D),
  //   automaticallyImplyLeading: false,
  //   leading: IconButton(
  //     icon: const Icon(
  //       Icons.arrow_back_ios,
  //       color: Colors.black,
  //     ),
  //    onPressed: () {
  //                           Navigator.of(context, rootNavigator: true)
  //                               .push(MaterialPageRoute(
  //                             builder: (context) => RecommendQuiz(),
  //                           ));
  //                         },
  //   ),
  //   title: Text(
  //     'إحصائيات الاختبار',
  //     style: GoogleFonts.tajawal(
  //         fontSize: 25,
  //         color: Color.fromARGB(255, 19, 1, 96),
  //         fontWeight: FontWeight.bold),
  //   ),
  //   centerTitle: true,
  //   elevation: 0,
  // );

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
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => BottomTabBarr(),
            ));
          },
        ),
        title: Text(
          'الاختبارات السابقة',
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
