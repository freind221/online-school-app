import 'package:faheem/componanet/grid_view_card.dart';
import 'package:faheem/cubit/cubit.dart';
import 'package:faheem/models/group_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'StartQuiz.dart';
import 'bottom_tab.dart';

import 'models/test_data_model.dart';

class publicQuiz extends StatelessWidget {
  final List<TestDataModel> quizes;
  final List<GroupDataModel> groups;
  const publicQuiz({super.key, required this.quizes, required this.groups});

  Widget makeListTile(TestDataModel data) => ListTile(
        title: Text(
          data.name,
          // "مبادئ الجمع",
          style: GoogleFonts.comfortaa(
            color: const Color.fromARGB(255, 8, 2, 32),
            fontSize: 17,
            fontWeight: FontWeight.bold,

            //backgroundColor: Color.fromARGB(255, 243, 243, 247)
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            //Icon(Icons.numbers_sharp, color: Color(0xFFfca34d)),
            Text(
                //data.docs[index]['email'],
                'عدد الاسئلة : ${data.questionsNumber}',
                style: GoogleFonts.comfortaa(
                    color: const Color.fromARGB(255, 4, 1, 18), fontSize: 17)),
          ],
        ),
      );

  makeCard(List<TestDataModel> tests, int index) => GridTile(
        footer:
            Container(color: Colors.black, child: makeListTile(tests[index])),
        child: Card(
          child: Image.network(
            tests[index].img,
            fit: BoxFit.cover,
          ),
        ),
      );
  // Card(
  //     elevation: 3.0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(25),
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
  //     // ignore: prefer_const_constructors

  //     /// Down ////
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 200.0,
  //           decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: NetworkImage(tests[index].img),
  //                 fit: BoxFit.cover,
  //               ),
  //               color: const Color.fromARGB(255, 255, 255, 255),
  //               borderRadius: BorderRadius.circular(25),
  //               boxShadow: [
  //                 BoxShadow(
  //                     blurRadius: 10,
  //                     offset: const Offset(1, 1),
  //                     color: Colors.grey.withOpacity(0.20))
  //               ]),
  //           //child: makeListTile(d, index),
  //         ),
  //         SizedBox(
  //           height: 67,
  //           child: makeListTile(tests[index]),
  //         ),
  //       ],
  //     ));

  makeBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 20.0),
        shrinkWrap: true,
        itemCount: quizes.length,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 5),
        itemBuilder: (BuildContext context, int index) {
          return GridCard(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => StartQuiz(
                  pin: quizes[index].pin,
                  groupPin: null,
                ),
              ));
            },
            name: quizes[index].name,
            img: quizes[index].img,
            onCard: "${quizes[index].questionsNumber} س",
            popUp: PopupMenuButton(
              // Initial Value

              // Down Arrow Icon
              icon: const Icon(Icons.add),
              onSelected: (value) {
                BlocProvider.of<HomeCubit>(context).addQuizToGroup(
                    quizes[index].toRequest(),
                    quizes[index].pin,
                    // value.pin
                    value.toString(),
                    quizes[index].questions);
              },

              // Array list of items
              itemBuilder: (context) => groups.map((GroupDataModel item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(
                    item.name,
                    style: GoogleFonts.tajawal(
                        fontSize: 15,
                        color: Color.fromARGB(255, 19, 1, 96),
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCD4D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => BottomTabBarr(),
            ));
          },
        ),
        title: Text(
          'الاختبارات ',
          style: GoogleFonts.tajawal(
              fontSize: 25,
              color: const Color.fromARGB(255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: makeBody(context),
    );
  }
}
