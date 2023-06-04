import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitles extends StatelessWidget {
  const AppTitles({Key? key, required this.name, this.onPressed}) : super(key: key);
final String name;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child:  Text(
            "مشاهدة الكل",
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
                fontSize: 14,
                color: const Color(0xffFFCB45),
                fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
        ),
        Text(
          name,
          style: GoogleFonts.tajawal(
              fontSize: 22,
              color: const Color.fromARGB(
                  255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
