// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:faheem/QuizList.dart';
// import 'package:faheem/groupList.dart';
// import 'package:faheem/joinQR.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'CreateQuiz.dart';
// import 'joinQR.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gradient_widgets/gradient_widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'CreateGroup.dart';
// import 'joinQuizPIN.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'style.dart';

// class HomeExpert extends StatefulWidget {
//   const HomeExpert({super.key});

//   @override
//   State<HomeExpert> createState() => _HomeExpertState();
// }

// class _HomeExpertState extends State<HomeExpert> {
//   String name = '';

//   //void getUserName() async {
//   // var id = FirebaseAuth.instance.currentUser?.uid;
//   // var data =
//   //     await FirebaseFirestore.instance.collection('User').doc(id).get();
//   // setState(() {
//   //    name = data['firstName'];
//   //   });
//   // }

//   @override
//   void initState() {
//     //  getUserName();
//     super.initState();
//   }

//   //final user = FirebaseAuth.instance.currentUser!;
//   var scaffoldKey = GlobalKey<ScaffoldState>();

//   List<Categories> homecat = [
//     Categories(
//       "assets/img/Frame.png",
//       "الكل",
//     ),
//     Categories(
//       "assets/img/x2.png",
//       "الرياضيات",
//     ),
//     Categories(
//       "assets/img/pc.png",
//       "حاسب",
//     ),
//     Categories(
//       "assets/img/eng.png",
//       "إنجليزي",
//     ),
//     Categories(
//       "assets/img/science.png",
//       "علوم",
//     ),
//     Categories(
//       "assets/img/pc.png",
//       "تاريخ",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         splitScreenMode: false,
//         builder: (context, child) {
//           return SafeArea(
//             child: Scaffold(
//               key: scaffoldKey,
//               backgroundColor: Colors.white,
//               body: Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: ListView(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(),
//                         Padding(
//                           padding: EdgeInsets.only(left: 18.0),
//                           child: IconButton(
//                               onPressed: () {
//                                 FirebaseAuth.instance.signOut();
//                               },
//                               icon: Padding(
//                                 padding: const EdgeInsets.all(3.0),
//                                 child: Image.asset("assets/img/logout.png"),
//                               )),
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         "مرحبا، ",
//                         // + $name",
//                         style: Style.titleTextStyle,
//                       ),
//                     ),
//                     Container(
//                       height: 110.h,
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         reverse: true,
//                         itemCount: 6,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         itemBuilder: (context, i) {
//                           return InkWell(
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             onTap: () {},
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 12),
//                                     height: 56,
//                                     width: 56,
//                                     decoration: BoxDecoration(
//                                       color: i == 0
//                                           ? Color(0xFF677FFF)
//                                           : Color(0xFFC1CDDB).withOpacity(0.3),
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     child: Container(
//                                       height: 20,
//                                       width: 20,
//                                       alignment: i == 1
//                                           ? Alignment(2.7, -0.2)
//                                           : Alignment.center,
//                                       child: Image.asset(
//                                         homecat[i].image,
//                                       ),
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     homecat[i].name,
//                                     style: TextStyle(
//                                       color: Color(0xffA0A3B1),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       child: Container(
//                         height: 95.h,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF333242),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(width: 28),
//                             Text(
//                               "شاهدت مؤخرا",
//                               style: Style.subtitleTextStyle.copyWith(
//                                 fontSize: 24,
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 color: Colors.white,
//                               ),
//                               child: Image.asset("assets/img/left.png"),
//                             ),
//                             SizedBox(width: 17.h),
//                           ],
//                         ),
//                       ),
//                       // ),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 180,
//                           width: 160.w,
//                           decoration: BoxDecoration(
//                             color: Color(0xFFFFC97E),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               InkWell(
//                                 child: Container(
//                                   height: 61,
//                                   alignment: Alignment.topRight,
//                                   child: Image.asset(
//                                     "assets/img/test.png",
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => QuizListScreen()));
//                                 },
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 12),
//                                 child: Text(
//                                   "اختبارات",
//                                   style: Style.subsubTextStyle(
//                                     colo: Color(0xFF333242),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 15),
//                               Row(
//                                 children: [
//                                   Spacer(),
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       color: Color(0xFFF1B869),
//                                     ),
//                                     child: Image.asset("assets/img/left.png"),
//                                   ),
//                                   SizedBox(width: 20),
//                                 ],
//                               ),
//                               SizedBox(height: 25)
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 180,
//                           width: 160.w,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF8E97FD),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               InkWell(
//                                 child: Container(
//                                   height: 61,
//                                   child: Image.asset("assets/img/Group.png"),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) => groupList()));
//                                 },
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 12),
//                                 child: Text(
//                                   "مجموعات",
//                                   style: Style.subsubTextStyle(
//                                     colo: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 15),
//                               Row(
//                                 children: [
//                                   Spacer(),
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       color: Color(0xFF808AFF),
//                                     ),
//                                     child: Image.asset("assets/img/left.png"),
//                                   ),
//                                   SizedBox(width: 20),
//                                 ],
//                               ),
//                               SizedBox(height: 25)
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 3),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Text(
//                         "قد يعجبك",
//                         style: Style.titleTextStyle,
//                       ),
//                     ),
//                     Container(
//                       height: 160,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 3,
//                           padding: EdgeInsets.symmetric(horizontal: 12),
//                           itemBuilder: (context, i) {
//                             return Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 115,
//                                     width: 150.w,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xFF8E97FD),
//                                       borderRadius: BorderRadius.circular(10),
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           "assets/img/$i.png",
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     li[i],
//                                     style: Style.subsubTextStyle(
//                                       colo: Color(0xFF333242),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                     ),
//                     SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   List<String> li = [
//     "مبادئ الجمع",
//     "مملكة الحيوان",
//     "الحروف",
//   ];
// }

// class Categories {
//   String image;
//   String name;

//   Categories(this.image, this.name);
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faheem/Login.dart';
import 'package:faheem/QuizList.dart';
import 'package:faheem/StartQuiz.dart';
import 'package:faheem/cubit/cubit.dart';
import 'package:faheem/cubit/state.dart';
import 'package:faheem/publicGroup.dart';
import 'package:faheem/publicQuiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'componanet/app_card.dart';
import 'componanet/titles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'RecommendQuiz.dart';
import 'cubit/profile_new/cubit/profile_new_cubit.dart';

class HomeExpert extends StatefulWidget {
  const HomeExpert({super.key});

  @override
  State<HomeExpert> createState() => _HomeExpertState();
}

class _HomeExpertState extends State<HomeExpert> {
  String name = '';

  void getUserName() async {
    var id = FirebaseAuth.instance.currentUser?.uid;
    var data =
        await FirebaseFirestore.instance.collection('User').doc(id).get();
    setState(() {
      name = data['firstName'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
    final userEmail = FirebaseAuth.instance.currentUser!.email!;
    HomeCubit.get(context).getHomeData(userEmail);
    BlocProvider.of<ProfileNewCubit>(context).getProfileNewData(userEmail);
  }

  final user = FirebaseAuth.instance.currentUser!;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Categories> homecat = [
    Categories(
      "assets/home_img/1.png",
      "الجمع",
    ),
    Categories(
      "assets/home_img/2.png",
      "الرياضيات",
    ),
    Categories(
      "assets/home_img/3.png",
      "حاسب",
    ),
    Categories(
      "assets/img/eng.png",
      "إنجليزي",
    ),
    Categories(
      "assets/img/science.png",
      "علوم",
    ),
    Categories(
      "assets/img/pc.png",
      "تاريخ",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state is HomeSuccess) {
                final cubit = BlocProvider.of<HomeCubit>(context);
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            icon: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.asset("assets/img/logout.png"),
                            )),
                        Text(
                          "مرحبا،  $name ",
                          style: GoogleFonts.tajawal(
                              fontSize: 22,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTitles(
                        name: "الأختبارات",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => publicQuiz(
                                      groups: BlocProvider.of<ProfileNewCubit>(
                                              context)
                                          .groupsDataModel,
                                      quizes: cubit.testDataModel)));
                        }),
                    Container(
                      height: 130.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(bottom: 10),
                        reverse: true,
                        itemCount: cubit.testDataModel.length > 4
                            ? 4
                            : cubit.testDataModel.length,
                        itemBuilder: (context, i) {
                          return AppCard(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                builder: (context) => StartQuiz(
                                  pin: cubit.testDataModel[i].pin,
                                  groupPin: null,
                                ),
                              ));
                            },
                            img: cubit.testDataModel[i].img,
                            name: cubit.testDataModel[i].name,
                            onCard:
                                "${cubit.testDataModel[i].questionsNumber}س",
                            onCardRight: cubit.testDataModel[i].category,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTitles(
                      name: "المجموعات",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => publicGroup(
                                    groups: cubit.groupsDataModel)));
                      },
                    ),
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(bottom: 10),
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        itemCount: cubit.groupsDataModel.length > 4
                            ? 4
                            : cubit.groupsDataModel.length,
                        itemBuilder: (context, i) {
                          return AppCard(
                            width: 180,
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                builder: (context) => QuizListScreen(
                                    group: cubit.groupsDataModel[i]),
                              ));
                            },
                            name: cubit.groupsDataModel[i].name,
                            img: cubit.groupsDataModel[i].image,
                            onCard:
                                "${cubit.groupsDataModel[i].numberOfMembers}  أعضاء",
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: const AppTitles(
                        name: 'اختبارات قد تعجبك',
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => const RecommendQuiz(),
                        ));
                      },
                    ),
                    SizedBox(
                      height: 150.h,
                      child: ListView.separated(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, i) {
                          return AppCard(
                            width: 200,
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                builder: (context) => const RecommendQuiz(),
                              ));
                            },
                            name: li[i],
                            img: "",
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ErrorOccurred) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  List<String> li = [
    "مبادئ الجمع",
    "مملكة الحيوان",
    "الحروف",
  ];
}

class Categories {
  String image;
  String name;

  Categories(this.image, this.name);
}
