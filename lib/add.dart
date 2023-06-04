import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'generaterQR.dart';
import 'source-storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({super.key});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _auth = FirebaseAuth.instance;
  String caregiverID = "";
  late User loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    //String qrData="";
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        caregiverID = loggedInUser.uid;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> _isCollectionExits() async {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('patients')
        .where("caregiverID", isEqualTo: caregiverID)
        .get();

    if (query.docs.isNotEmpty) {
      // Collection exits
      return true;
    } else {
      // Collection not exits
      return false;
    }
  }

  final TextEditingController nameController = TextEditingController();
  StorageService st = StorageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 167, 190),
        title: Center(
            child: Text(
          "إضافة  ",
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
        )),
      ),
      body: Column(children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'من فضلك قم بإدخال اسم مستقبل الرعاية : ',
              style: GoogleFonts.tajawal(
                fontSize: 25,
                color: const Color.fromARGB(255, 140, 167, 190),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 157,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'الاسم ',
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),

                //textAlign: TextAlign.center,
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
        // Center(
        Padding(
          padding: const EdgeInsets.all(30),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color.fromARGB(255, 140, 167, 190),
                onPressed: () async {
                  RegExp r = RegExp(r'\s');
                  if (r.hasMatch(nameController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        // margin: EdgeInsets.only(right: 10),

                        content: Text('يرجى عدم وضع فراغات بالاسم ',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.right),
                      ),
                    );
                  }
                  // String? id = await st.readSecureData("caregiverID");
                  else if (nameController.text.length >= 2 &&
                      nameController.text.length <= 20) {
                    if (await _isCollectionExits()) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          // margin: EdgeInsets.only(right: 10),

                          content: Text('تم إضافة مستقبل رعاية مسبقا',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.right),
                        ),
                      );
                    } else {
                      FirebaseFirestore.instance.collection('patients').add({
                        'name': nameController.text,
                        'caregiverID': caregiverID,
                        'age': '',
                      });
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          // margin: EdgeInsets.only(right: 10),

                          content: Text('تم إضافة مستقبل رعاية بنجاح',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.right),
                        ),
                      );

                      // FirebaseFirestore.instance.collection('patients').add({'caregiverID': '123'});
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GenerateQR("")));
                    }
                  } else {
                    if (nameController.text.length < 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          // margin: EdgeInsets.only(right: 10),

                          content: Text(
                              'يجب أن يحتوي اسم مستقبل الرعاية على حرفين أو أكثر ',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.right),
                        ),
                      );
                    } else if (nameController.text.length >= 20) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          // margin: EdgeInsets.only(right: 10),

                          content: Text(
                              'يجب أن يحتوي اسم مستقبل الرعاية على أقل من عشرين حرف  ',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.right),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "إضافة ",
                  style: GoogleFonts.tajawal(
                    color: const Color.fromARGB(255, 245, 244, 244),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
