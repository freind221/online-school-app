import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserParticipationInfoWidget extends StatelessWidget {
  final int number;
  final String text;
  final IconData icon;
  const UserParticipationInfoWidget({
    Key? key,
    required this.number,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x1F000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFF1F4F8),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F4F8),
                shape: BoxShape.circle,
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0xFFFFCD4D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Text(
                      number.toString(),
                      style: GoogleFonts.tajawal(
                          fontSize: 34,
                          color: const Color.fromARGB(255, 19, 1, 96),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 19, 1, 96),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
