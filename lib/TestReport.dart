// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:faheem/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'cubit/test_report/cubit/test_report_cubit.dart';
import 'models/test_report_model.dart';

class TestReport extends StatefulWidget {
  final String pin;
  final String? groupPin;
  const TestReport({
    Key? key,
    required this.pin,
    required this.groupPin,
  }) : super(key: key);

  @override
  _TestReportState createState() => _TestReportState();
}

class _TestReportState extends State<TestReport> with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TestReportModel testReportData;

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestReportCubit(),
      child: TestReportView(
          scaffoldKey: scaffoldKey, pin: widget.pin, groupPin: widget.groupPin),
    );
  }
}

class TestReportView extends StatefulWidget {
  const TestReportView({
    super.key,
    required this.scaffoldKey,
    required this.pin,
    required this.groupPin,
  });
  final String pin;
  final String? groupPin;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<TestReportView> createState() => _TestReportViewState();
}

class _TestReportViewState extends State<TestReportView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TestReportCubit>(context)
        .getAnsweredQuestionsData(widget.pin, widget.groupPin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: const Color.fromARGB(255, 19, 1, 96),
            ),
          ),
          backgroundColor: const Color(0xFFFFCD4D),
          automaticallyImplyLeading: false,
          title: Text(
            'تقرير الاختبار',
            style: GoogleFonts.tajawal(
                fontSize: 25,
                color: const Color.fromARGB(255, 19, 1, 96),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: BlocConsumer<TestReportCubit, TestReportState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TestReportLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TestReportSuccess) {
            final testReportData =
                BlocProvider.of<TestReportCubit>(context).testReportData;
            return SafeArea(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          // topLeft: Radius.circular(15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15)
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
                                                            testReportData
                                                                .thirdUser
                                                                .firstName,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts.tajawal(
                                                                fontSize: 14,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('٣',
                                                            style: GoogleFonts
                                                                .tajawal(
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                            testReportData
                                                                .firstUser
                                                                .firstName,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts.tajawal(
                                                                fontSize: 14,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('١',
                                                            style: GoogleFonts
                                                                .tajawal(
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                      topLeft: Radius.circular(15),
                                                      //    topRight: Radius.circular(15),
                                                      bottomLeft: Radius.circular(15)
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
                                                            testReportData
                                                                .secondUser
                                                                .firstName,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts.tajawal(
                                                                fontSize: 14,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('٢',
                                                            style: GoogleFonts
                                                                .tajawal(
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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

                            SizedBox(
                              height: 130,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    child: ListView(
                                      // padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Padding(
                                          //
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 5, 10),
                                          child: Container(
                                            width: 175,
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFFF1F4F8),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(3, 0, 3, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 8, 16, 4),
                                                    child: Row(
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
                                                                  0, 9, 0, 0),
                                                          child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text('وقت الاختبار',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.tajawal(
                                                                        fontSize:
                                                                            18,
                                                                        color: const Color.fromARGB(
                                                                            255,
                                                                            19,
                                                                            1,
                                                                            96),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    height: 0,
                                                    thickness: 1,
                                                    indent: 20,
                                                    endIndent: 20,
                                                    color: Color(0xFFE5E5EF),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Icon(
                                                        Icons.access_time,
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                        size: 24,
                                                      ),
                                                      Text(
                                                        ' ${testReportData.userTestTime.toArabicNumbers} ${testReportData.isUnderMinute ? 'ث' : 'د'}',
                                                        style:
                                                            GoogleFonts.tajawal(
                                                          fontSize: 30,
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 19, 1, 96),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ), //image
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 10, 0, 10),
                                          child: Container(
                                            width: 175,
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFFF1F4F8),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(3, 0, 3, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            12, 8, 16, 4),
                                                    child: Row(
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
                                                                  0, 9, 0, 0),
                                                          child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text('مجموع النقاط',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.tajawal(
                                                                        fontSize:
                                                                            18,
                                                                        color: const Color.fromARGB(
                                                                            255,
                                                                            19,
                                                                            1,
                                                                            96),
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    height: 0,
                                                    thickness: 1,
                                                    indent: 20,
                                                    endIndent: 20,
                                                    color: Color(0xFFE5E5EF),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Icon(
                                                        Icons.wine_bar_outlined,
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                        size: 30,
                                                      ),
                                                      Text(
                                                        testReportData
                                                            .userPoints
                                                            .toArabicNumbers,
                                                        style:
                                                            GoogleFonts.tajawal(
                                                          fontSize: 30,
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 19, 1, 96),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ), ///////
                                            ),
                                          ), //
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 0),
                              child: Container(
                                width: double.infinity,
                                // height: 450,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12, 8, 16, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(4, 12, 12, 12),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('متوسط نقاط اللاعبين',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.tajawal(
                                                            fontSize: 18,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255, 19, 1, 96),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
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
                                      Text("يعبر المؤشر عن مركزك",
                                          style: GoogleFonts.tajawal(
                                            fontSize: 15,
                                            color: const Color.fromARGB(
                                                255, 19, 1, 96),
                                          )),
                                      Container(
                                        child: SfRadialGauge(
                                          axes: <RadialAxis>[
                                            RadialAxis(
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    positionFactor: 0.1,
                                                    angle: 90,
                                                    widget: Text(
                                                      '${testReportData.pointsAverage.toArabicNumbers} من ${BlocProvider.of<TestReportCubit>(context).quizScore.toArabicNumbers}',
                                                      style: const TextStyle(
                                                          fontSize: 40),
                                                    ))
                                              ],
                                              minimum: 0,
                                              maximum: BlocProvider.of<
                                                      TestReportCubit>(context)
                                                  .quizScore
                                                  .toDouble(),
                                              showLabels: false,
                                              showTicks: false,
                                              axisLineStyle:
                                                  const AxisLineStyle(
                                                thickness: 0.2,
                                                //  cornerStyle: CornerStyle.bothCurve,
                                                color: Color.fromARGB(
                                                    30, 180, 201, 202),
                                                thicknessUnit:
                                                    GaugeSizeUnit.factor,
                                              ),
                                              pointers: <GaugePointer>[
                                                RangePointer(
                                                    value: double.parse(
                                                        testReportData
                                                            .pointsAverage),
                                                    width: 0.2,
                                                    sizeUnit:
                                                        GaugeSizeUnit.factor,
                                                    //cornerStyle: CornerStyle.startCurve,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: <Color>[
                                                          Color.fromARGB(255,
                                                              143, 139, 139),
                                                          Color(0xFFFFCD4D),
                                                        ],
                                                            stops: <double>[
                                                          0.25,
                                                          0.75
                                                        ])),
                                                MarkerPointer(
                                                  markerWidth: 35,
                                                  markerHeight: 35,
                                                  value: double.parse(
                                                      testReportData
                                                          .pointsAverage),
                                                  markerType: MarkerType.circle,
                                                  color: const Color.fromARGB(
                                                      255, 244, 187, 42),
                                                ),

                                                //! This is for the user

                                                MarkerPointer(
                                                  enableDragging: true,
                                                  markerWidth: 20,
                                                  markerHeight: 30,
                                                  markerOffset: -30,
                                                  value: double.parse(
                                                      testReportData
                                                          .userPoints),
                                                  //  markerType: MarkerType.,
                                                  color: const Color.fromARGB(
                                                      255, 19, 1, 96),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //
                          ],
                        ),
                        Positioned(
                          top: 45,
                          right: 30,
                          child: CircleAvatar(
                            radius: 80 / 2,
                            backgroundImage: testReportData
                                    .thirdUser.image.isEmpty
                                ? const AssetImage('assets/avatar.png')
                                : NetworkImage(testReportData.thirdUser.image)
                                    as ImageProvider,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 140,
                          child: CircleAvatar(
                            radius: 80 / 2,
                            backgroundImage: testReportData
                                    .firstUser.image.isEmpty
                                ? const AssetImage('assets/avatar.png')
                                : NetworkImage(testReportData.firstUser.image)
                                    as ImageProvider,
                          ),
                        ),
                        Positioned(
                          top: 45,
                          right: 250,
                          child: CircleAvatar(
                            radius: 80 / 2,
                            backgroundImage: testReportData
                                    .secondUser.image.isEmpty
                                ? const AssetImage('assets/avatar.png')
                                : NetworkImage(testReportData.secondUser.image)
                                    as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("Error Occured"));
          }
        },
      ),
    );
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
