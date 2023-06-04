import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:async';

class groupMemberList extends StatefulWidget {
  const groupMemberList({super.key});

  @override
  _groupMemberListState createState() => _groupMemberListState();
}

class _groupMemberListState extends State<groupMemberList> {
  Stream<QuerySnapshot> _regStream =
      FirebaseFirestore.instance.collection('User').snapshots();

  var fullname;

  var email;
  var profilepic;

  ///

  makeListTile(QuerySnapshot<Object?> data, int index) => ListTile(
        //  pic = data.docs[index]['profilepic'];
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: Color(0xFFFCE097),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            //backgroundImage: NetworkImage( data.docs[index]['profilepic'])
          ),
        ),

        title: Text(
          data.docs[index]['firstName'],
          // "مبادئ الجمع",
          style: GoogleFonts.comfortaa(
              color: Color(0xFF130160),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            //Icon(Icons.numbers_sharp, color: Color(0xFFfca34d)),
            Text(data.docs[index]['email'],
                style: GoogleFonts.comfortaa(
                    color: Color(0xFF130160), fontSize: 15)),
          ],
        ),
      );

  makeCard(QuerySnapshot<Object?> d, int index) => Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.grey.withOpacity(0.20))
              ]),
          child: makeListTile(d, index),
        ),
      );

  makeBody() => Container(
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

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.size,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(data, index);
            },
          );
        },
      ));

  final topAppBar = AppBar(
    centerTitle: true,
    elevation: 0.1,
    foregroundColor: Color(0xFF130160),
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    title: Text(' أعضاء المجموعة',
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
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
            'أعضاء المجموعة',
            style: GoogleFonts.tajawal(
                fontSize: 25,
                color: Color.fromARGB(255, 19, 1, 96),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: makeBody(),
    );
  }
}
