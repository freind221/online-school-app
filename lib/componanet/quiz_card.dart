// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double containerHeight = 80;
double borderRadius = 15.0;

class QuizCard extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  final String numberOfQuestios;
  final bool isActive;
  final VoidCallback onTap;
  final Widget widget;

  const QuizCard({
    Key? key,
    required this.image,
    required this.name,
    required this.category,
    required this.numberOfQuestios,
    required this.isActive,
    required this.onTap,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius)),
                    child: Blur(
                      blur: !isActive ? 1 : 0,
                      colorOpacity: 0.1,
                      child: Image.network(
                        image,
                        width: 80,
                        height: containerHeight,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  width: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.tajawal(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 19, 1, 96),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        category,
                        style: GoogleFonts.tajawal(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "$numberOfQuestios س",
                        style: GoogleFonts.tajawal(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 19, 1, 96),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
            widget
          ],
        ),
      ),
    );
  }
}

class IndicateIsActiveWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  const IndicateIsActiveWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
        ),
      ),
      height: 30.0,
      child: Row(children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        Icon(
          icon,
          color: Colors.white,
          size: 17.0,
        )
      ]),
    );
  }
}
