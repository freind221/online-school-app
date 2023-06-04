import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    this.img,
    this.name,
    this.onCard,
    this.onCardRight,
    required this.onTap,
    this.width,
  }) : super(key: key);
  final String? img;
  final String? name;
  final String? onCard;
  final String? onCardRight;
  final double? width;

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
                    flex: 2,
                    child: Container(
                      height: 100,
                      width: width ?? 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        image: img!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(img!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage("assets/home_img/a1.png"),
                                fit: BoxFit.cover,
                              ),
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Text(name!,
                      style: GoogleFonts.tajawal(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 19, 1, 96),
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
            onCard == null
                ? Container()
                : Container(
                    alignment: const Alignment(0, .1),
                    width: onCardRight == null ? null : 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          color: Colors.white.withOpacity(.7),
                          child: Text(
                            '$onCard',
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.tajawal(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 19, 1, 96),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (onCardRight != null)
                          Card(
                            color: Colors.white.withOpacity(.7),
                            child: Text(
                              '$onCardRight',
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.tajawal(
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 19, 1, 96),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
