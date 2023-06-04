import 'package:faheem/cubit/profile_new/cubit/profile_new_cubit.dart';
import 'package:faheem/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileNewCubit>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
          width: double.infinity,
          height: cubit.state is ProfileNewStateSuccess ? null : 200.0,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 10),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFFFFCD4D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: cubit.image.isEmpty
                          ? Image.asset(
                              'assets/avatar.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              cubit.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Text(
                //'لينا الزمامي ',
                cubit.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 19, 1, 96),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                //'leena22@gmail.com',
                cubit.email,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 19, 1, 96),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFFCD4D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => editProfile(
                        firstname: cubit.name.split(" ")[0],
                        lastname: cubit.name.split(" ")[1],
                        image: cubit.image,
                      ),
                    ),
                  )
                      .then((value) {
                    cubit.getProfileNewData(cubit.email);
                  });
                },
                child: SizedBox(
                  width: 15.0,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 15,
                      ),
                      /* SizedBox(
                          width: 8.0,
                        ), */
                      // Text("تعديل الملف الشخصي"),
                    ],
                  ),
                ),
              ), //show in center

              /*  ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCD4D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => editProfile(
                        firstname: cubit.name.split(" ")[0],
                        lastname: cubit.name.split(" ")[1],
                        image: cubit.image,
                      ),
                    ),
                  )
                      .then((value) {
                    cubit.getProfileNewData(cubit.email);
                  });
                },
                child: Text(
                  "تعديل الملف الشخصي",
                  style: GoogleFonts.tajawal(
                      fontSize: 15,
                      // color: const Color.fromARGB(255, 19, 1, 96),
                      fontWeight: FontWeight.bold),
                ),
              ), */
            ],
          )),
    );
  }
}

/* import 'package:faheem/cubit/profile_new/cubit/profile_new_cubit.dart';
import 'package:faheem/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileNewCubit>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
          width: double.infinity,
          height: cubit.state is ProfileNewStateSuccess ? null : 200.0,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 10),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: const Color(0xFFFFCD4D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: cubit.image.isEmpty
                          ? Image.asset(
                              'assets/avatar.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              cubit.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Text(
                //'لينا الزمامي ',
                cubit.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 19, 1, 96),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                //'leena22@gmail.com',
                cubit.email,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 19, 1, 96),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCD4D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => editProfile(
                          firstname: cubit.name.split(" ")[0],
                          lastname: cubit.name.split(" ")[1],
                          image: cubit.image,
                        ),
                      ),
                    )
                        .then((value) {
                      cubit.getProfileNewData(cubit.email);
                    });
                  },
                  child: SizedBox(
                    width: 150.0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          size: 15,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text("تعديل الملف الشخصي"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
 */
