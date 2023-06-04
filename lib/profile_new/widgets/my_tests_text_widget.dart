import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTestsTextWidget extends StatelessWidget {
  const MyTestsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
            child: Text(
              'اختباراتي ',
              textAlign: TextAlign.right,
              style: GoogleFonts.tajawal(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
