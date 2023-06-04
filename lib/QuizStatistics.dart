// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'cubit/quiz_statistics/cubit/quiz_statistics_cubit.dart';
import 'models/user_model.dart';

class QuizStatistics extends StatefulWidget {
  final String groupPin;
  final String quizPin;
  const QuizStatistics({
    Key? key,
    required this.groupPin,
    required this.quizPin,
  }) : super(key: key);

  @override
  _QuizStatisticsState createState() => _QuizStatisticsState();
}

class _QuizStatisticsState extends State<QuizStatistics>
    with TickerProviderStateMixin {
  final arabicNumber = ArabicNumbers();
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final itemController = TextEditingController();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizStatisticsCubit()
        ..getQuizStatistics(widget.groupPin, widget.quizPin),
      // child: Scaffold(
      //     key: scaffoldKey,
      //     backgroundColor: const Color(0xFFF1F4F8),
      //     appBar: PreferredSize(
      //       preferredSize: const Size.fromHeight(70),
      //       child: AppBar(
      //         backgroundColor: const Color(0xFFFFCD4D),
      //         automaticallyImplyLeading: false,
      //         leading: IconButton(
      //           icon: const Icon(
      //             Icons.arrow_back_ios,
      //             color: Colors.black,
      //           ),
      //           onPressed: () {
      //             Navigator.pop(context);
      //             /*  Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => HomeExpert(),
      //               ),
      //             ); */
      //           },
      //         ),
      //         title: Text(
      //           'إحصائيات الاختبار',
      //           style: GoogleFonts.tajawal(
      //               fontSize: 25,
      //               color: const Color.fromARGB(255, 19, 1, 96),
      //               fontWeight: FontWeight.bold),
      //         ),
      //         centerTitle: true,
      //         elevation: 0,
      //       ),
      //     ),
      //     body: const QuizStatisticsView()),
    );
  }
}

class QuizStatisticsView extends StatefulWidget {
  const QuizStatisticsView({super.key});

  @override
  State<QuizStatisticsView> createState() => _QuizStatisticsViewState();
}

class _QuizStatisticsViewState extends State<QuizStatisticsView> {
  List<_ChartData> data = [];
  List<ChartData> chartData = [];
  // late TooltipBehavior _tooltip;
  @override
  void initState() {
    // _tooltip = TooltipBehavior(
    //     enable: true,
    //     borderColor: const Color.fromARGB(255, 143, 139, 139),
    //     borderWidth: 5,
    //     color: const Color.fromARGB(255, 143, 139, 139));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizStatisticsCubit, QuizStatisticsState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<QuizStatisticsCubit>(context);

        if (state is QuizStatisticsSuccess) {
          final sortedPlayersScore =
              cubit.quizReportModel.users.values.toList().reversed.toList();
          final sortedPlayers =
              cubit.quizReportModel.users.keys.toList().reversed.toList();

          cubit.quizReportModel.users.forEach(
            (key, value) {
              log("key: $key");
              log("value: $value");
              chartData.add(ChartData(key.firstName, value.toDouble()));
            },
          );

          for (int i = 0;
              i < cubit.quizReportModel.correctAndWrongNumbers.length;
              i++) {
            data.add(
              _ChartData(
                  'السؤال${(i + 1).toArabicNumbers}',
                  cubit.quizReportModel.correctAndWrongNumbers[i].falseNumber
                      .toDouble(),
                  cubit.quizReportModel.correctAndWrongNumbers[i].correctNumber
                      .toDouble()),
            );
          }
          return Container();
          // return SafeArea(
          //   child: GestureDetector(
          //     child: Padding(
          //       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
          //       child: SingleChildScrollView(
          //         child: Stack(
          //           children: [
          //             Column(
          //               mainAxisSize: MainAxisSize.max,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       0, 20, 0, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     height: 195,
          //                     decoration: BoxDecoration(
          //                       color: const Color(0xFFF1F4F8),
          //                       boxShadow: const [],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Row(
          //                             mainAxisSize: MainAxisSize.max,
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               Padding(
          //                                 padding: const EdgeInsetsDirectional
          //                                     .fromSTEB(12, 15, 12, 12),
          //                                 child: Column(
          //                                   mainAxisSize: MainAxisSize.max,
          //                                   mainAxisAlignment:
          //                                       MainAxisAlignment.center,
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           Row(
          //                             mainAxisSize: MainAxisSize.max,
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.center,
          //                             children: [
          //                               Padding(
          //                                 padding: const EdgeInsetsDirectional
          //                                     .fromSTEB(0, 59, 0, 0),
          //                                 child: Container(
          //                                   width: 110,
          //                                   height: 94,
          //                                   decoration: const BoxDecoration(
          //                                       color: Color(0xFFFFCD4D),
          //                                       borderRadius: BorderRadius.only(
          //                                           // topLeft: Radius.circular(15),
          //                                           topRight:
          //                                               Radius.circular(15),
          //                                           bottomRight:
          //                                               Radius.circular(15)
          //                                           // bottomRight: bottom right
          //                                           )),
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.max,
          //                                     children: [
          //                                       Padding(
          //                                         padding:
          //                                             const EdgeInsetsDirectional
          //                                                     .fromSTEB(
          //                                                 0, 25, 0, 0),
          //                                         child: Column(
          //                                           mainAxisSize:
          //                                               MainAxisSize.max,
          //                                           children: [
          //                                             Text(
          //                                                 sortedPlayers.length <
          //                                                         3
          //                                                     ? "NONE"
          //                                                     : sortedPlayers[2]
          //                                                         .firstName,
          //                                                 textAlign:
          //                                                     TextAlign.center,
          //                                                 style: GoogleFonts.tajawal(
          //                                                     fontSize: 14,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255, 0, 0, 0),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                             Text('٣',
          //                                                 style: GoogleFonts
          //                                                     .tajawal(
          //                                                   fontSize: 40,
          //                                                   color: Colors.white,
          //                                                   fontWeight:
          //                                                       FontWeight.bold,
          //                                                 )),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsetsDirectional
          //                                     .fromSTEB(0, 3, 0, 0),
          //                                 child: Container(
          //                                   width: 110,
          //                                   height: 150,
          //                                   decoration: const BoxDecoration(
          //                                       color: Color(0xFFFFCD4D),
          //                                       borderRadius: BorderRadius.only(
          //                                           topLeft:
          //                                               Radius.circular(15),
          //                                           topRight:
          //                                               Radius.circular(15)
          //                                           //  bottomLeft:, bottom left
          //                                           // bottomRight: bottom right
          //                                           )),
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.max,
          //                                     children: [
          //                                       Padding(
          //                                         padding:
          //                                             const EdgeInsetsDirectional
          //                                                     .fromSTEB(
          //                                                 0, 50, 0, 0),
          //                                         child: Column(
          //                                           mainAxisSize:
          //                                               MainAxisSize.max,
          //                                           children: [
          //                                             Text(
          //                                                 sortedPlayers.isEmpty
          //                                                     ? "NONE"
          //                                                     : sortedPlayers[0]
          //                                                         .firstName,
          //                                                 textAlign:
          //                                                     TextAlign.center,
          //                                                 style: GoogleFonts.tajawal(
          //                                                     fontSize: 14,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255, 0, 0, 0),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                             Text('١',
          //                                                 style: GoogleFonts
          //                                                     .tajawal(
          //                                                   fontSize: 40,
          //                                                   color: Colors.white,
          //                                                   fontWeight:
          //                                                       FontWeight.bold,
          //                                                 )),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsetsDirectional
          //                                     .fromSTEB(0, 59, 0, 0),
          //                                 child: Container(
          //                                   width: 110,
          //                                   height: 94,
          //                                   decoration: const BoxDecoration(
          //                                       color: Color(0xFFFFCD4D),
          //                                       borderRadius: BorderRadius.only(
          //                                           topLeft:
          //                                               Radius.circular(15),
          //                                           //    topRight: Radius.circular(15),
          //                                           bottomLeft:
          //                                               Radius.circular(15)
          //                                           //  bottomLeft:, bottom left
          //                                           // bottomRight: bottom right
          //                                           )),
          //                                   alignment:
          //                                       const AlignmentDirectional(
          //                                           0, 0),
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.max,
          //                                     children: [
          //                                       Padding(
          //                                         padding:
          //                                             const EdgeInsetsDirectional
          //                                                     .fromSTEB(
          //                                                 0, 25, 0, 0),
          //                                         child: Column(
          //                                           mainAxisSize:
          //                                               MainAxisSize.max,
          //                                           children: [
          //                                             Text(
          //                                                 sortedPlayers.length <
          //                                                         2
          //                                                     ? "NONE"
          //                                                     : sortedPlayers[1]
          //                                                         .firstName,
          //                                                 textAlign:
          //                                                     TextAlign.center,
          //                                                 style: GoogleFonts.tajawal(
          //                                                     fontSize: 14,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255, 0, 0, 0),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                             Text('٢',
          //                                                 style: GoogleFonts
          //                                                     .tajawal(
          //                                                   fontSize: 40,
          //                                                   color: Colors.white,
          //                                                   fontWeight:
          //                                                       FontWeight.bold,
          //                                                 )),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       16, 0, 16, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     // height: 275.8,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: const [
          //                         BoxShadow(
          //                           blurRadius: 4,
          //                           color: Color(0x1F000000),
          //                           offset: Offset(0, 2),
          //                         )
          //                       ],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsetsDirectional.fromSTEB(
          //                                     12, 8, 16, 4),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.max,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               children: [
          //                                 Padding(
          //                                   padding: const EdgeInsetsDirectional
          //                                       .fromSTEB(4, 12, 12, 12),
          //                                   child: Column(
          //                                     mainAxisSize: MainAxisSize.max,
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.center,
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       Text(
          //                                         'ترتيب اللاعبين',
          //                                         textAlign: TextAlign.center,
          //                                         style: GoogleFonts.tajawal(
          //                                             fontSize: 18,
          //                                             color:
          //                                                 const Color.fromARGB(
          //                                                     255, 19, 1, 96),
          //                                             fontWeight:
          //                                                 FontWeight.bold),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const Divider(
          //                             height: 24,
          //                             thickness: 1,
          //                             indent: 20,
          //                             endIndent: 20,
          //                             color: Color(0xFFE5E5EF),
          //                           ),
          //                           SizedBox(
          //                             //height: 150.0,
          //                             child: ListView.builder(
          //                                 physics:
          //                                     const BouncingScrollPhysics(),
          //                                 padding: const EdgeInsetsDirectional
          //                                     .fromSTEB(40, 0, 40, 0),
          //                                 shrinkWrap: true,
          //                                 itemCount: sortedPlayers.length,
          //                                 itemBuilder: (BuildContext context,
          //                                     int index) {
          //                                   return Card(
          //                                       margin: EdgeInsets.zero,
          //                                       elevation: 0,
          //                                       shape: RoundedRectangleBorder(
          //                                         borderRadius:
          //                                             BorderRadius.circular(0),
          //                                       ),
          //                                       child: Container(
          //                                           child: ListTile(
          //                                         leading: Text(
          //                                             ((index + 1)
          //                                                     .toArabicNumbers)
          //                                                 .toString(),
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                                     fontSize: 18,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255,
          //                                                         19,
          //                                                         1,
          //                                                         96),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                         title: Text(
          //                                             "${sortedPlayers[index].firstName} ${sortedPlayers[index].lastName}",
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                               fontSize: 18,
          //                                               color: const Color
          //                                                       .fromARGB(
          //                                                   255, 19, 1, 96),
          //                                             )),
          //                                         trailing: Text(
          //                                           sortedPlayersScore[index]
          //                                               .toArabicNumbers,
          //                                           style: GoogleFonts.tajawal(
          //                                             fontSize: 18,
          //                                             color:
          //                                                 const Color.fromARGB(
          //                                                     255, 19, 1, 96),
          //                                             fontWeight:
          //                                                 FontWeight.bold,
          //                                           ),
          //                                         ),
          //                                       )));
          //                                 }),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       16, 12, 16, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     height: 450,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: const [
          //                         BoxShadow(
          //                           blurRadius: 4,
          //                           color: Color(0x1F000000),
          //                           offset: Offset(0, 2),
          //                         )
          //                       ],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsetsDirectional.fromSTEB(
          //                                     12, 8, 16, 4),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.max,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               children: [
          //                                 Padding(
          //                                   padding: const EdgeInsetsDirectional
          //                                       .fromSTEB(4, 12, 12, 12),
          //                                   child: Row(
          //                                       mainAxisSize: MainAxisSize.max,
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Text('الإجابات',
          //                                             textAlign:
          //                                                 TextAlign.center,
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                                     fontSize: 18,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255,
          //                                                         19,
          //                                                         1,
          //                                                         96),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                       ]),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const Divider(
          //                             height: 24,
          //                             thickness: 1,
          //                             indent: 20,
          //                             endIndent: 20,
          //                             color: Color(0xFFE5E5EF),
          //                           ),
          //                           Container(
          //                               child: SfCartesianChart(
          //                                   legend: Legend(
          //                                       alignment:
          //                                           ChartAlignment.center,
          //                                       position: LegendPosition.top,
          //                                       isVisible: true,
          //                                       borderWidth: 2),
          //                                   plotAreaBorderWidth: 0,
          //                                   zoomPanBehavior: ZoomPanBehavior(
          //                                       enablePanning: true),
          //                                   primaryXAxis: CategoryAxis(
          //                                     autoScrollingMode:
          //                                         AutoScrollingMode.start,
          //                                     axisLine:
          //                                         const AxisLine(width: 0),
          //                                     majorTickLines:
          //                                         const MajorTickLines(
          //                                             width: 0),
          //                                     majorGridLines:
          //                                         const MajorGridLines(
          //                                             width: 0),
          //                                   ),
          //                                   primaryYAxis: NumericAxis(
          //                                     majorGridLines:
          //                                         const MajorGridLines(
          //                                             width: 0),
          //                                     axisLine:
          //                                         const AxisLine(width: 0),
          //                                     isVisible: false,
          //                                   ),
          //                                   tooltipBehavior: _tooltip,
          //                                   series: <
          //                                       ChartSeries<_ChartData,
          //                                           String>>[
          //                                 ColumnSeries<_ChartData, String>(
          //                                     dataSource: data,
          //                                     xValueMapper:
          //                                         (_ChartData data, _) =>
          //                                             data.x,
          //                                     yValueMapper:
          //                                         (_ChartData data, _) =>
          //                                             data.z,
          //                                     name: 'اجابة صحيحة',
          //                                     color: const Color(0xFFFFCD4D),
          //                                     width: 0.8,
          //                                     dataLabelSettings:
          //                                         const DataLabelSettings(
          //                                       isVisible: true,
          //                                     ),
          //                                     emptyPointSettings:
          //                                         EmptyPointSettings(
          //                                             mode: EmptyPointMode
          //                                                 .average,
          //                                             color: Colors.green,
          //                                             borderColor: Colors.black,
          //                                             borderWidth: 2)),
          //                                 ColumnSeries<_ChartData, String>(
          //                                     dataSource: data,
          //                                     xValueMapper:
          //                                         (_ChartData data, _) =>
          //                                             data.x,
          //                                     yValueMapper:
          //                                         (_ChartData data, _) =>
          //                                             data.y,
          //                                     animationDuration: 1000,
          //                                     name: 'اجابة خاطئة',
          //                                     color: const Color.fromARGB(
          //                                         255, 143, 139, 139),
          //                                     width: 0.8,
          //                                     dataLabelSettings:
          //                                         const DataLabelSettings(
          //                                       isVisible: true,
          //                                     ),
          //                                     emptyPointSettings:
          //                                         EmptyPointSettings(
          //                                       mode: EmptyPointMode.average,
          //                                       color: const Color.fromARGB(
          //                                           255, 227, 138, 132),
          //                                     )),
          //                               ])),

          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       16, 12, 16, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     height: 120,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: const [
          //                         BoxShadow(
          //                           blurRadius: 4,
          //                           color: Color(0x1F000000),
          //                           offset: Offset(0, 2),
          //                         )
          //                       ],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsetsDirectional.fromSTEB(
          //                                     12, 8, 16, 4),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.max,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               children: [
          //                                 Padding(
          //                                   padding: const EdgeInsetsDirectional
          //                                       .fromSTEB(0, 9, 0, 0),
          //                                   child: Row(
          //                                       mainAxisSize: MainAxisSize.max,
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Text(
          //                                             ' متوسط الوقت المستغرق لحل الاختبار',
          //                                             textAlign:
          //                                                 TextAlign.center,
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                                     fontSize: 15,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255,
          //                                                         19,
          //                                                         1,
          //                                                         96),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                       ]),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const Divider(
          //                             height: 0,
          //                             thickness: 1,
          //                             indent: 20,
          //                             endIndent: 20,
          //                             color: Color(0xFFE5E5EF),
          //                           ),
          //                           const SizedBox(
          //                             height: 10,
          //                           ),
          //                           Row(
          //                             mainAxisSize: MainAxisSize.min,
          //                             children: [
          //                               const Icon(
          //                                 Icons.access_time,
          //                                 color:
          //                                     Color.fromARGB(255, 79, 79, 79),
          //                                 size: 24,
          //                               ),
          //                               Text(
          //                                 "${cubit.quizReportModel.averageTime.toArabicNumbers} ${int.parse(cubit.quizReportModel.averageTime) > 60 ? 'د' : 'ث'}",
          //                                 style: GoogleFonts.tajawal(
          //                                   fontSize: 34,
          //                                   color: const Color.fromARGB(
          //                                       255, 19, 1, 96),
          //                                 ),
          //                               ),
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       16, 12, 16, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     height: 450,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: const [
          //                         BoxShadow(
          //                           blurRadius: 4,
          //                           color: Color(0x1F000000),
          //                           offset: Offset(0, 2),
          //                         )
          //                       ],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsetsDirectional.fromSTEB(
          //                                     12, 8, 16, 4),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.max,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               children: [
          //                                 Padding(
          //                                   padding: const EdgeInsetsDirectional
          //                                       .fromSTEB(4, 12, 12, 12),
          //                                   child: Row(
          //                                       mainAxisSize: MainAxisSize.max,
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Text('متوسط نقاط اللاعبين',
          //                                             textAlign:
          //                                                 TextAlign.center,
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                                     fontSize: 18,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255,
          //                                                         19,
          //                                                         1,
          //                                                         96),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                       ]),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const Divider(
          //                             height: 24,
          //                             thickness: 1,
          //                             indent: 20,
          //                             endIndent: 20,
          //                             color: Color(0xFFE5E5EF),
          //                           ),
          //                           SizedBox(
          //                             height: 280,
          //                             width: 280,
          //                             child: SfRadialGauge(axes: <RadialAxis>[
          //                               RadialAxis(
          //                                 annotations: <GaugeAnnotation>[
          //                                   GaugeAnnotation(
          //                                       positionFactor: 0.1,
          //                                       angle: 90,
          //                                       widget: Text(
          //                                         '${cubit.quizReportModel.pointsAverage.toArabicNumbers} من ${cubit.quizScore.toArabicNumbers}',
          //                                         style: const TextStyle(
          //                                             fontSize: 40),
          //                                       ))
          //                                 ],
          //                                 minimum: 0,
          //                                 maximum: cubit.quizScore.toDouble(),
          //                                 showLabels: false,
          //                                 showTicks: false,
          //                                 axisLineStyle: const AxisLineStyle(
          //                                   thickness: 0.2,
          //                                   color: Color.fromARGB(
          //                                       30, 180, 201, 202),
          //                                   thicknessUnit: GaugeSizeUnit.factor,
          //                                 ),
          //                                 pointers: <GaugePointer>[
          //                                   RangePointer(
          //                                       value: double.parse(cubit
          //                                           .quizReportModel
          //                                           .pointsAverage),
          //                                       width: 0.2,
          //                                       sizeUnit: GaugeSizeUnit.factor,
          //                                       gradient: const SweepGradient(
          //                                           colors: <Color>[
          //                                             Color.fromARGB(
          //                                                 255, 143, 139, 139),
          //                                             Color(0xFFFFCD4D),
          //                                           ],
          //                                           stops: <double>[
          //                                             0.25,
          //                                             0.75
          //                                           ])),
          //                                   MarkerPointer(
          //                                     markerWidth: 35,
          //                                     markerHeight: 35,
          //                                     value: double.parse(cubit
          //                                         .quizReportModel
          //                                         .pointsAverage),
          //                                     markerType: MarkerType.circle,
          //                                     color: const Color.fromARGB(
          //                                         255, 244, 187, 42),
          //                                   )
          //                                 ],
          //                               )
          //                             ]),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsetsDirectional.fromSTEB(
          //                       16, 12, 16, 0),
          //                   child: Container(
          //                     width: double.infinity,
          //                     height: 450,
          //                     decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: const [
          //                         BoxShadow(
          //                           blurRadius: 4,
          //                           color: Color(0x1F000000),
          //                           offset: Offset(0, 2),
          //                         )
          //                       ],
          //                       borderRadius: BorderRadius.circular(8),
          //                       border: Border.all(
          //                         color: const Color(0xFFF1F4F8),
          //                         width: 1,
          //                       ),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsetsDirectional.fromSTEB(
          //                           0, 0, 0, 12),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.max,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding:
          //                                 const EdgeInsetsDirectional.fromSTEB(
          //                                     12, 8, 16, 4),
          //                             child: Row(
          //                               mainAxisSize: MainAxisSize.max,
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                               children: [
          //                                 Padding(
          //                                   padding: const EdgeInsetsDirectional
          //                                       .fromSTEB(4, 12, 12, 12),
          //                                   child: Row(
          //                                       mainAxisSize: MainAxisSize.max,
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.center,
          //                                       crossAxisAlignment:
          //                                           CrossAxisAlignment.start,
          //                                       children: [
          //                                         Text(' نقاط اللاعبين',
          //                                             textAlign:
          //                                                 TextAlign.center,
          //                                             style:
          //                                                 GoogleFonts.tajawal(
          //                                                     fontSize: 18,
          //                                                     color: const Color
          //                                                             .fromARGB(
          //                                                         255,
          //                                                         19,
          //                                                         1,
          //                                                         96),
          //                                                     fontWeight:
          //                                                         FontWeight
          //                                                             .bold)),
          //                                       ]),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           const Divider(
          //                             height: 24,
          //                             thickness: 1,
          //                             indent: 20,
          //                             endIndent: 20,
          //                             color: Color(0xFFE5E5EF),
          //                           ),
          //                           SfCartesianChart(
          //                               primaryXAxis: CategoryAxis(
          //                                 majorGridLines:
          //                                     const MajorGridLines(width: 0),
          //                               ),
          //                               primaryYAxis: NumericAxis(
          //                                   majorGridLines:
          //                                       const MajorGridLines(width: 0),
          //                                   axisLine: const AxisLine(width: 0)),
          //                               series: <AreaSeries<ChartData, String>>[
          //                                 AreaSeries<ChartData, String>(
          //                                   dataSource: chartData,
          //                                   xValueMapper: (ChartData data, _) =>
          //                                       data.x,
          //                                   yValueMapper: (ChartData data, _) {
          //                                     return data.y;
          //                                   },
          //                                   borderWidth: 4,
          //                                   color: const Color(0xFFFFCD4D),
          //                                   borderGradient:
          //                                       const LinearGradient(
          //                                     colors: <Color>[
          //                                       Color.fromARGB(
          //                                           255, 143, 139, 139),
          //                                       Color(0xFFFFCD4D)
          //                                     ],
          //                                   ),
          //                                 )
          //                               ])
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Positioned(
          //               top: 45,
          //               right: 30,
          //               child: CircleAvatar(
          //                 radius: 80 / 2,
          //                 backgroundImage: getImage(sortedPlayers, 2),
          //               ),
          //             ),
          //             Positioned(
          //               top: 5,
          //               right: 140,
          //               child: CircleAvatar(
          //                 radius: 80 / 2,
          //                 backgroundImage: getImage(sortedPlayers, 0),
          //               ),
          //             ),
          //             Positioned(
          //               top: 45,
          //               right: 250,
          //               child: CircleAvatar(
          //                 radius: 80 / 2,
          //                 backgroundImage: getImage(sortedPlayers, 1),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // );

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

class _ChartData {
  _ChartData(this.x, this.y, this.z);

  final String x;
  final double y;
  final double z;
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
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
