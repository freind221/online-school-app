import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    Key? key,
    this.img,
    this.name,
    this.onCard,
    this.popUp,
    required this.onTap,
  }) : super(key: key);
  final String? img;
  final String? name;
  final String? onCard;
  final Widget? popUp;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(img!), fit: BoxFit.cover)),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(name!,
                    style: GoogleFonts.tajawal(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 19, 1, 96),
                        fontWeight: FontWeight.bold)),
                if (popUp != null)
                  Container(alignment: Alignment.bottomLeft, child: popUp!)
              ],
            ),
            onCard == null
                ? Container()
                : Container(
                    alignment: const Alignment(-1, .1),
                    child: Card(
                      color: Colors.white.withOpacity(.7),
                      child: Text(
                        '$onCard',
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.tajawal(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 19, 1, 96),
                            fontWeight: FontWeight.bold),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
