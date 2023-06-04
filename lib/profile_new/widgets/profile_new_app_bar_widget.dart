import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileNewAppBarWidget extends StatelessWidget {
  const ProfileNewAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int count=0;
    return AppBar(
      backgroundColor: const Color(0xFFF3F4F8),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
      //barrierDismissible = false;
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "تسجيل خروج",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
           'هل انت متأكد من تسجيل الخروج ؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: const Text("نعم"),
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("لا"),
            )
          ],
        );
      },
    );
            FirebaseAuth.instance.signOut();
          },
          icon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset("assets/img/logout.png"),
          ),
        ),
      ],
      title: Text(
        ' الملف الشخصي',
        style: GoogleFonts.tajawal(
            fontSize: 25,
            color: const Color.fromARGB(255, 19, 1, 96),
            fontWeight: FontWeight.bold),
      ),
      elevation: 0,
    );
  }
}
