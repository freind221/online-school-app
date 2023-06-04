// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:itmaen/setting.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// // import 'editPatientProfile.dart';
// // import 'navigation.dart';
// // import 'home.dart';
// // import 'navigation.dart';
// import 'dart:ui' as ui;

// class GenerateQR extends StatefulWidget {
//   GenerateQR(this.ID);
//   late String ID;
//   @override
//   _GenerateQRState createState() => _GenerateQRState();
// }

// class _GenerateQRState extends State<GenerateQR> {
//   final _auth = FirebaseAuth.instance;
//   late User? loggedInUser = _auth.currentUser;
//   List<String> _query = [];
//   var id;

//   Future<List<String>> getName() async {
//     await FirebaseFirestore.instance
//         .collection('patients')
//         .where("caregiverID", isEqualTo: loggedInUser!.uid)
//         .get()
//         .then((value) {
//       _query.add(value.docs[0].get('name'));
//       _query.add(value.docs[0].get('age'));
//       id = value.docs[0].id;
//     });
//     return _query;
//   }

//   //String? qrData = loggedInUser!.uid ;
//   // late User loggedInUser;
//   //@override
//   // void initState() {
//   //   super.initState();
//   // getCurrentUser();
//   // }

//   // void getCurrentUser() async {
//   //   //String qrData="";
//   //   try {
//   //     final user = await _auth.currentUser;
//   //     if (user != null) {
//   //       loggedInUser = user;
//   //       qrData = loggedInUser.uid;
//   //     }
//   //   } catch (e) {
//   //     print(e);
//   //   }

//   // }

// //String qrData="caregiver id"; // the caregiver id shall be passed from the home page to here in order to create the QR code
// // final qrdataFeed = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Directionality(
//         textDirection: ui.TextDirection.rtl,
//         child: Scaffold(
//           //Appbar having title
//           // drawer: NavBar(),
//           appBar: AppBar(
//             backgroundColor: Color.fromRGBO(255, 205, 77, 1),
//             title: Center(
//                 child: Text(
//               "كود الاضافة             ",
//               style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
//             )),
//           ),

//           // container
//           body: Container(
//             margin: EdgeInsets.only(top: 50),
//             alignment: Alignment.topCenter,
//             padding: EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               //Scroll view given to Column
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   QrImage(
//                     data: widget.ID,
//                     backgroundColor: Color.fromRGBO(255, 205, 77, 1),
//                     foregroundColor: Colors.white,
//                     size: 250,
//                     //padding: EdgeInsets.all(50),
//                   ),

//                   SizedBox(height: 20),
//                   Text(
//                     "   الرمز الخاص بالاختبار: ",
//                     style: GoogleFonts.tajawal(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                     textAlign: TextAlign.center,
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: //FutureBuilder(
//                         //   builder: (context, snapshot) {
//                         //       if (snapshot.connectionState == ConnectionState.done) {
//                         //         // If we got an error
//                         //         if (snapshot.hasError) {
//                         //           return Center(
//                         //             child: Text(
//                         //               '${snapshot.error} occurred',
//                         //               style: TextStyle(fontSize: 18),
//                         //             ),
//                         //           );

//                         //           // if we got our data
//                         //         } else if (snapshot.hasData) {
//                         //           // Extracting data from snapshot object
//                         //           final data = snapshot.data as List<String>;
//                         //           return Center(
//                         //               child: Row(
//                         //             children: [
//                         //               SizedBox(width: 120),
//                         //               IconButton(
//                         //                 icon: const Icon(Icons.edit),
//                         //                 color: Color.fromARGB(255, 140, 167, 190),
//                         //                 //tooltip: 'Increase volume by 10',
//                         //                 onPressed: () {
//                         //                   // Navigator.pushReplacement(
//                         //                   //     context,
//                         //                   //     MaterialPageRoute(
//                         //                   //         builder: (context) =>
//                         //                   //             EditPatientProfile(
//                         //                   //               data: data,
//                         //                   //             )));
//                         //                 },
//                         //               ),
//                         Text(
//                       widget.ID,
//                       style: GoogleFonts.tajawal(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                       textAlign: TextAlign.right,
//                     ),
//                     //],
//                   ) //)

//                   //         }
//                   //       }

//                   //       // Displaying LoadingSpinner to indicate waiting state
//                   //       return Center(
//                   //         child: CircularProgressIndicator(),
//                   //       );
//                   //     },

//                   //     // Future that needs to be resolved
//                   //     // inorder to display something on the Canvas
//                   //     future: getName(),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:itmaen/setting.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'editPatientProfile.dart';
// import 'navigation.dart';
// import 'home.dart';
// import 'navigation.dart';
import 'dart:ui' as ui;
import 'bottom_tab.dart';

class GenerateQR extends StatefulWidget {
  GenerateQR(this.ID);
  late String ID;
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser = _auth.currentUser;
  List<String> _query = [];
  var id;

  Future<List<String>> getName() async {
    await FirebaseFirestore.instance
        .collection('patients')
        .where("caregiverID", isEqualTo: loggedInUser!.uid)
        .get()
        .then((value) {
      _query.add(value.docs[0].get('name'));
      _query.add(value.docs[0].get('age'));
      id = value.docs[0].id;
    });
    return _query;
  }

  //String? qrData = loggedInUser!.uid ;
  // late User loggedInUser;
  //@override
  // void initState() {
  //   super.initState();
  // getCurrentUser();
  // }

  // void getCurrentUser() async {
  //   //String qrData="";
  //   try {
  //     final user = await _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       qrData = loggedInUser.uid;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  // }

//String qrData="caregiver id"; // the caregiver id shall be passed from the home page to here in order to create the QR code
// final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    id = widget.ID;
    return SafeArea(
      top: false,
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
          //Appbar having title
          // drawer: NavBar(),
          appBar: AppBar(
            backgroundColor: Color(0xFFFFCD4D),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                  builder: (context) => BottomTabBarr(),
                ));
              },
            ),
            // title: Text(
            //   'الاختبارات المقترحة',
            //   style: GoogleFonts.tajawal(
            //       fontSize: 25,
            //       color: Color.fromARGB(255, 19, 1, 96),
            //       fontWeight: FontWeight.bold),
            // ),
            centerTitle: true,
            elevation: 0,
          ),

          // container
          body: Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              //Scroll view given to Column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QrImage(
                    data: widget.ID,
                    backgroundColor: Color.fromRGBO(255, 205, 77, 1),
                    foregroundColor: Colors.white,
                    size: 250,
                    //padding: EdgeInsets.all(50),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "   الرمز الخاص بالاختبار: $id",
                    style: GoogleFonts.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: //FutureBuilder(
                        //   builder: (context, snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.done) {
                        //         // If we got an error
                        //         if (snapshot.hasError) {
                        //           return Center(
                        //             child: Text(
                        //               '${snapshot.error} occurred',
                        //               style: TextStyle(fontSize: 18),
                        //             ),
                        //           );

                        //           // if we got our data
                        //         } else if (snapshot.hasData) {
                        //           // Extracting data from snapshot object
                        //           final data = snapshot.data as List<String>;
                        //           return Center(
                        //               child: Row(
                        //             children: [
                        //               SizedBox(width: 120),
                        //               IconButton(
                        //                 icon: const Icon(Icons.edit),
                        //                 color: Color.fromARGB(255, 140, 167, 190),
                        //                 //tooltip: 'Increase volume by 10',
                        //                 onPressed: () {
                        //                   // Navigator.pushReplacement(
                        //                   //     context,
                        //                   //     MaterialPageRoute(
                        //                   //         builder: (context) =>
                        //                   //             EditPatientProfile(
                        //                   //               data: data,
                        //                   //             )));
                        //                 },
                        //               ),
                        Text(
                      widget.ID,
                      style: GoogleFonts.tajawal(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.right,
                    ),
                    //],
                  ) //)

                  //         }
                  //       }

                  //       // Displaying LoadingSpinner to indicate waiting state
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     },

                  //     // Future that needs to be resolved
                  //     // inorder to display something on the Canvas
                  //     future: getName(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
