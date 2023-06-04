import 'package:faheem/CreateGroup.dart';
import 'package:faheem/cubit/profile_new/cubit/profile_new_cubit.dart';
import 'package:faheem/groupList.dart';
import 'package:faheem/joinQuizPIN.dart';
import 'package:faheem/profile_new/profile_new.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'joinGroupPIN.dart';
import 'CreateQuiz.dart';
import 'package:faheem/Home.dart';
import 'style.dart';
import 'package:flutter/material.dart';

class BottomTabBarr extends StatefulWidget {
  static const routeName = 'bottomtab';

  Widget? widgetoutside;

  BottomTabBarr({super.key, this.widgetoutside});

  @override
  State<BottomTabBarr> createState() => _BottomTabBarrState();
}

class _BottomTabBarrState extends State<BottomTabBarr> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      bottom();
      //
    }
    if (index == 1) {
      bottom1();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  static final List _widgetOptions = [
    const HomeExpert(),
    Container(),
    const HomeExpert(),
    const groupList(),
    const ProfileWidget(),
  ];
  List<String> names = [
    'الرئيسية',
    'إنضمام',
    '',
    'مجموعاتي',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileNewCubit(),
      child: ScreenUtilInit(
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => Scaffold(
          // extendBody: true,
          body:
              widget.widgetoutside ?? _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: SizedBox(
            height: 120,
            width: double.infinity,
            child: BottomAppBar(
                notchMargin: 4.0,
                color: Colors.white,
                elevation: 20,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      costumcollum(Icons.home, Icons.home_outlined, 0),
                      costumcollum(Icons.group, Icons.group_outlined, 3),
                      costumcollum(Icons.add_circle_outline_rounded,
                          Icons.add_circle_outline_rounded, 2),
                      costumcollum(Icons.person_add, Icons.person_add, 1),
                      costumcollum(Icons.person, Icons.person_outline, 4),
                    ])),
          ),
        ),
      ),
    );
  }

//
  costumcollum(ico, txt, numb) {
    return InkWell(
        onTap: () => _onItemTapped(numb),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: numb == 2
                    ? const BoxDecoration()
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: _selectedIndex == numb
                            ? const Color(0xffFFCB45)
                            : Colors.transparent,
                      ),
                child: Icon(
                  _selectedIndex == numb ? txt : ico,
                  size: numb == 2 ? 38 : 28,
                  color: numb == 2
                      ? const Color(0xFFA0A3B1)
                      : _selectedIndex == numb
                          ? Colors.white
                          : const Color(0xFFA0A3B1),
                  // color: Style.primarycolo,
                ),
              ),
              numb == 2
                  ? const SizedBox(height: 12)
                  : Text(
                      names[numb],
                      style: TextStyle(
                        color: _selectedIndex == numb
                            ? const Color(0xffFFCB45)
                            : const Color(0xFFA0A3B1),
                      ),
                    ),
            ],
          ),
        ));
  }

  bottom() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // elevation: .2,
      barrierColor: Colors.white.withOpacity(.2),
      context: context,
      builder: (BuildContext contxt) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          height: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "هل تريد إنشاء",
                style: Style.subsubTextStyle(colo: const Color(0xFF130160)),
              ),
              const SizedBox(height: 25),
              Container(
                width: 215,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const RequestForm()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(width: 20),
                      Text(
                        "مجموعة",
                        style: Style.subsubTextStyle(
                            colo: const Color(0xFF130160)),
                      ),
                      Image.asset("assets/img/ppl.png"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: 215,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CreateQuiz()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(width: 20),
                      Text(
                        "اختبار",
                        style: Style.subsubTextStyle(
                            colo: const Color(0xFF130160)),
                      ),
                      // SizedBox(width: 8),
                      Image.asset("assets/img/testcr.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottom1() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // elevation: .2,
      barrierColor: Colors.white.withOpacity(.2),
      context: context,
      builder: (BuildContext contxt) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          height: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "هل تريد الانضمام إلى",
                style: Style.subsubTextStyle(colo: const Color(0xFF130160)),
              ),
              const SizedBox(height: 25),
              Container(
                width: 215,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => JoinGroupPIN()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(width: 20),
                      Container(
                        child: Text(
                          "مجموعة",
                          style: Style.subsubTextStyle(
                              colo: const Color(0xFF130160)),
                        ),
                      ),
                      Image.asset("assets/img/ppl.png"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: 215,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const JoinQuizPIN()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(width: 20),
                      Text(
                        "اختبار",
                        style: Style.subsubTextStyle(
                            colo: const Color(0xFF130160)),
                      ),
                      // SizedBox(width: 8),
                      Image.asset("assets/img/testcr.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
