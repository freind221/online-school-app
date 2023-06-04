// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:faheem/cubit/groups_statistics/cubit/group_statistics_cubit.dart';

import 'models/group_data_model.dart';
import 'models/user_model.dart';

class GroupStatistics extends StatefulWidget {
  final GroupDataModel group;
  const GroupStatistics({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  _GroupStatisticsState createState() => _GroupStatisticsState();
}

class _GroupStatisticsState extends State<GroupStatistics>
    with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupStatisticsCubit(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: const Color(0xFFFFCD4D),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => groupList(),
                    ),
                  ); */
              },
            ),
            title: Text(
              'إحصائيات المجموعة',
              style: GoogleFonts.tajawal(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: GroupStatisticsView(
          group: widget.group,
        ),
      ),
    );
  }
}

class GroupStatisticsView extends StatefulWidget {
  final GroupDataModel group;
  const GroupStatisticsView({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<GroupStatisticsView> createState() => _GroupStatisticsViewState();
}

class _GroupStatisticsViewState extends State<GroupStatisticsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GroupStatisticsCubit>(context)
        .getGroupStatistics(widget.group.pin);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupStatisticsCubit, GroupStatisticsState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<GroupStatisticsCubit>(context);
        final sortedTestsScore =
            cubit.testsMap.values.toList().reversed.toList();
        final sortedTestsName = cubit.testsMap.keys.toList().reversed.toList();

        final sortedPlayersScore =
            cubit.playersMap.values.toList().reversed.toList();
        final sortedPlayers = cubit.playersMap.keys.toList().reversed.toList();

        log(sortedPlayers.length.toString());
        if (state is GroupStatisticsSuccess) {
          if (sortedPlayers.isEmpty) {
            return Center(
                child: Text(
              " لا يوجد اختبارات في المجموعة",
              style: GoogleFonts.tajawal(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold),
            ));
          }
          return SafeArea(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 195,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F4F8),
                                boxShadow: const [],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFF1F4F8),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12, 15, 12, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 59, 0, 0),
                                          child: Container(
                                            width: 110,
                                            height: 94,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFFFCD4D),
                                                borderRadius: BorderRadius.only(
                                                    // topLeft: Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15)
                                                    // bottomRight: bottom right
                                                    )),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 25, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedPlayers.length <
                                                                  3
                                                              ? ""
                                                              : sortedPlayers[2]
                                                                  .firstName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.tajawal(
                                                              fontSize: 14,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255, 0, 0, 0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('٣',
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 40,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 3, 0, 0),
                                          child: Container(
                                            width: 110,
                                            height: 150,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFFFCD4D),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)
                                                    //  bottomLeft:, bottom left
                                                    // bottomRight: bottom right
                                                    )),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 50, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedPlayers.isEmpty
                                                              ? "NONE"
                                                              : sortedPlayers[0]
                                                                  .firstName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.tajawal(
                                                              fontSize: 14,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255, 0, 0, 0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('١',
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 40,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 59, 0, 0),
                                          child: Container(
                                            width: 110,
                                            height: 94,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFFFCD4D),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    //    topRight: Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)
                                                    //  bottomLeft:, bottom left
                                                    // bottomRight: bottom right
                                                    )),
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 25, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedPlayers.length <
                                                                  2
                                                              ? "NONE"
                                                              : sortedPlayers[1]
                                                                  .firstName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.tajawal(
                                                              fontSize: 14,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255, 0, 0, 0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('٢',
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 40,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 0, 16, 0),
                            child: Container(
                              width: double.infinity,
                              //  height: 350,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 8, 16, 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(4, 12, 12, 12),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ترتيب اللاعبين',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 18,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 19, 1, 96),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 24,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color(0xFFE5E5EF),
                                    ),
                                    ListView.builder(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(40, 0, 40, 0),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: sortedPlayers.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Card(
                                              margin: EdgeInsets.zero,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              child: ListTile(
                                                leading: Expanded(
                                                  child: Text(
                                                      ((index + 1)
                                                              .toArabicNumbers)
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.tajawal(
                                                              fontSize: 18,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  19,
                                                                  1,
                                                                  96),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                                title: Text(
                                                    "${sortedPlayers[index].firstName} ${sortedPlayers[index].lastName}",
                                                    style: GoogleFonts.tajawal(
                                                      fontSize: 18,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 19, 1, 96),
                                                    )),
                                                trailing: Text(
                                                  sortedPlayersScore[index]
                                                      .toArabicNumbers
                                                      .toString(),
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 18,
                                                    color: const Color.fromARGB(
                                                        255, 19, 1, 96),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ));
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 20, 16, 0),
                            child: Container(
                              width: double.infinity,
                              height: 226,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12, 15, 12, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('  أعلى ثلاث اختبارات   ',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.tajawal(
                                                      fontSize: 18,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 19, 1, 96),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 24,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Color(0xFFE5E5EF),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 4, 0),
                                          child: Container(
                                            width: 95,
                                            height: 134,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF7ED09E),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 20, 0, 0),
                                                          child: Container(
                                                            width: 60,
                                                            height: 50,
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxWidth: 30,
                                                              maxHeight: 36,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFF7ED09E),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    Image.asset(
                                                                  'assets/images/top_one.png',
                                                                ).image,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 10, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedTestsName
                                                                  .isEmpty
                                                              ? "NONE"
                                                              : sortedTestsName[
                                                                  0],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text(
                                                          sortedTestsScore
                                                                  .isEmpty
                                                              ? "NONE"
                                                              : sortedTestsScore[
                                                                      0]
                                                                  .toString()
                                                                  .toArabicNumbers,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 0, 4, 0),
                                          child: Container(
                                            width: 95,
                                            height: 134,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0D276B),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 20, 0, 0),
                                                          child: Container(
                                                            width: 60,
                                                            height: 50,
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxWidth: 28,
                                                              maxHeight: 36,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFF0D276B),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    Image.asset(
                                                                  'assets/images/top_two.png',
                                                                ).image,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 10, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedTestsName
                                                                      .length <
                                                                  2
                                                              ? "NONE"
                                                              : sortedTestsName[
                                                                  1],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text(
                                                          sortedTestsScore
                                                                      .length <
                                                                  2
                                                              ? "NONE"
                                                              : sortedTestsScore[
                                                                      1]
                                                                  .toString()
                                                                  .toArabicNumbers,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 0, 0, 0),
                                          child: Container(
                                            width: 95,
                                            height: 134,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFCD4D),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              shape: BoxShape.rectangle,
                                            ),
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0, 20, 0, 0),
                                                          child: Container(
                                                            width: 60,
                                                            height: 50,
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxWidth: 28,
                                                              maxHeight: 36,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xFFFFCD4D),
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    Image.asset(
                                                                  'assets/images/top_3.png',
                                                                ).image,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 10, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                          sortedTestsName
                                                                      .length <
                                                                  3
                                                              ? "NONE"
                                                              : sortedTestsName[
                                                                  2],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      Text(
                                                          sortedTestsScore
                                                                      .length <
                                                                  3
                                                              ? "NONE"
                                                              : sortedTestsScore[
                                                                      2]
                                                                  .toString()
                                                                  .toArabicNumbers,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 45,
                        right: 30,
                        child: CircleAvatar(
                          radius: 80 / 2,
                          backgroundImage: getImage(sortedPlayers, 2),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 140,
                        child: CircleAvatar(
                          radius: 80 / 2,
                          backgroundImage: getImage(sortedPlayers, 0),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        right: 250,
                        child: CircleAvatar(
                          radius: 80 / 2,
                          backgroundImage: getImage(sortedPlayers, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ImageProvider<Object> getImage(List<UserModel> players, int index) {
    if (players.length < (index + 1)) {
      return const AssetImage('assets/avatar.png');
    } else {
      if (players.elementAt(index).image.isEmpty) {
        return const AssetImage('assets/avatar.png');
      } else {
        return NetworkImage(players.elementAt(index).image);
      }
    }
  }
}

class _ArabicNumbers {
  static String convert(Object value) {
    assert(
      value is int || value is String,
      "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toArabicNumbers(value.toString());
    } else {
      return _toArabicNumbers(value as String);
    }
  }

  static String _toArabicNumbers(String value) {
    return value
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }
}

extension IntExtensions on int {
  String get toArabicNumbers {
    return _ArabicNumbers.convert(this);
  }
}

extension StringExtensions on String {
  String get toArabicNumbers {
    return _ArabicNumbers.convert(this);
  }
}
