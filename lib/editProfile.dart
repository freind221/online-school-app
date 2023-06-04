// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

//import 'package:cached_network_image/cached_network_image.dart';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package: fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/edit_profile/cubit/edit_profile_cubit.dart';
//import 'package:test2/new_button.dart';

class editProfile extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String image;
  const editProfile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.image,
  }) : super(key: key);
  @override
  State<editProfile> createState() => _editProfileState();
}

bool isLoading = false;

class _editProfileState extends State<editProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController _familyController;
  bool isEnabled = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.firstname);
    _familyController = TextEditingController(text: widget.lastname);
    log("This is the imageurl: ${widget.image}");
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }

  Future<void> _validate(String image) async {
    if (formKey.currentState!.validate()) {
      updateProfile(image).then((_) {
        Navigator.of(context).pop(true);
      });

      //showToastMessage("تمت إضافة نشاط بنجاح");
    } else {
      _showDialog();
    }
  }

  /*  void showToastMessage(String message) {
    //raghad
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white,

        //message text color

        fontSize: 16.0 //message font size
        );
  } */

  void _showDialogCancel() {
    showDialog(
      //barrierDismissible = false;
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "تسجيل خروج",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'هل انت متأكد من تسجيل الخروج ؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: const Text("نعم"),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("لا"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("تعديل الملف الشخصي",
              style: GoogleFonts.tajawal(
                  fontSize: 28,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: const Color.fromARGB(255, 19, 1, 96),
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
        ),
        /*AppBar(
            back groundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: <Widget>[
             Text(
              'الملف الشخصي',
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 19, 1, 96)),
            ),
            IconButton(
              icon: const Icon(
             Icons.arrow_back_ios,
              color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          //backgroundColor: const Color(0xFFFFCD4D),
         /*  elevation: 0,
          title: Center(
            child: Text(
              'الملف الشخصي',
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 19, 1, 96)),
            ),
          ), */ */
        //),
        body: Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: Form(
              key: formKey,
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<EditProfileCubit>(context);
                  log(cubit.coverImage.toString());
                  log(widget.image.isEmpty.toString());
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundImage: cubit.coverImage == null
                                ? (widget.image.isEmpty
                                    ? AssetImage("assets/avatar.png")
                                    : NetworkImage(widget.image)
                                        as ImageProvider)
                                : FileImage(cubit.coverImage!)
                            // widget.image.isEmpty
                            //     ? AssetImage("assets/avatar.png")
                            //     : cubit.coverImage == null
                            //         ? NetworkImage(widget.image)
                            //         : FileImage(cubit.coverImage!)
                            //             as ImageProvider
                            ,
                            radius: 100,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: const Color(0xFFFFCD4D)),
                            onPressed: () {
                              BlocProvider.of<EditProfileCubit>(context)
                                  .getCoverImage();
                            },
                            child: Text("تعديل الصورة",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 1, 96))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     isEnabled =! isEnabled;
                          //   setState(() {});
                          //     },
                          //   child: Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text('تعديل',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: const Color(0xFFFFCD4D)),)),

                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                    child: Text('الأسم الاول',
                                        style: GoogleFonts.tajawal(
                                            fontSize: 21,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextFormField(
                                        controller: nameController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'الرجاء ادخال الأسم الأول ';
                                          }
                                          bool FnameValid =
                                              RegExp((r'[a-zA-Z\u0600-\u06FF]'))
                                                  .hasMatch(value);
                                          if (!FnameValid) {
                                            return 'الرجاء ادخال أسم أول صحيح';
                                          }
                                          return null;
                                        },
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          hintText: widget.firstname,
                                          //------------------
                                          hintStyle: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(20, 20, 16, 20),
                                        ),
                                        style: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF1D2429),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.right,
                                        minLines: 1,
                                        //keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),

                                    /* TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? ' الرجاء إدخال اسم ' : null,
                                controller: nameController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: widget.firstname,
                                    hintTextDirection: ui.TextDirection.rtl,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    )),
                              ), */
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                    child: Text('الأسم الأخير',
                                        style: GoogleFonts.tajawal(
                                            fontSize: 21,
                                            color:
                                                Color.fromARGB(255, 19, 1, 96),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 20, 0),
                                    child: TextFormField(
                                      controller: _familyController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'الرجاء ادخال الأسم الأخير  ';
                                        }
                                        bool emailValid =
                                            RegExp((r'[a-zA-Z\u0600-\u06FF]'))
                                                .hasMatch(value);
                                        if (!emailValid) {
                                          return 'الرجاء ادخال أسم أخير صحيح';
                                        }
                                        return null;
                                      },
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: widget.lastname,
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(20, 20, 16, 20),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF1D2429),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.right,
                                      minLines: 1,
                                      // keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  /* TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? 'الرجاء إدخال الأسم الأخير  ' : null,
                                controller: _familyController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: widget.lastname,
                                    hintTextDirection: ui.TextDirection.rtl,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    )),
                              ), */
                                ],
                              )),

                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          if (isEnabled == false)
                            NewButton(
                                text: 'تعديل',
                                height: 100,
                                width: 120,
                                onClick: () {
                                  isEnabled = !isEnabled;
                                  setState(() {});
                                }),
                          Row(
                            children: [
                              SizedBox(
                                width: 40,
                              ),
                              NewButton(
                                  height: 100,
                                  width: 150,
                                  text: 'حفظ التغييرات',
                                  onClick: () async {
                                    // resetEmail(_emailController.text)
                                    // .then((_) =>
                                    log("slfmnoesndofdnofsof");
                                    log(cubit.coverImage.toString());

                                    if (cubit.coverImage != null) {
                                      cubit.updateCoverImage();
                                      if (state is EditProfileImageSuccess) {
                                        _validate(
                                          cubit.coverImage == null
                                              ? widget.image
                                              : cubit.imageUrl,
                                        );
                                      }
                                    } else {
                                      log(cubit.coverImage.toString());
                                      _validate(
                                        cubit.coverImage == null
                                            ? widget.image
                                            : cubit.imageUrl,
                                      );
                                    }

                                    // );
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              NewButton(
                                  height: 100,
                                  width: 150,
                                  text: 'إلغاء',
                                  onClick: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          ),
                          /*  NewButton(
                              height: 100,
                              width: 320,
                              text: 'إلغاء',
                              onClick: () {
                                Navigator.of(context).pop();
                              }) */
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  // ImagePicker picker = ImagePicker();
  // File? file;
  // String imageUrl = "";
  // Future getImage(ImageSource source) async {
  //   final pickedFile = await picker.getImage(source: source, imageQuality: 30);
  //   if (pickedFile != null && pickedFile.path != null) {
  //     file = File(pickedFile.path);
  //     setState(() {});
  //     // ignore: use_build_context_synchronously
  //     imageUrl = await UploadFileServices().getUrl(context, file: file!);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
  //   }
  // }
  // Future<void> resetEmail(String newEmail) async {
  //   String message;
  //   User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   firebaseUser
  //       ?.updateEmail(newEmail)
  //       .then(
  //         (value) => message = 'Success',
  //       )
  //       .catchError((onError) => message = 'error');
  //   log(FirebaseAuth.instance.currentUser!.uid);
  // }

  _getUserDetail() {
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      nameController.text = snapshot.get("firstName");
      //image = snapshot.get('image');
      _familyController.text = snapshot.get("lastName");
      setState(() {});
    });
  }

  Future<void> updateProfile(String image) async {
    if (formKey.currentState!.validate() &&
        nameController.text.isNotEmpty &&
        _familyController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": nameController.text,
        "family": _familyController.text,
        "image": image
      }, SetOptions(merge: true)).then((value) {
        print('update');
      });
      setState(() {});
      //  showToastMessage("تمت تعديل نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      // Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }
}

class NewButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onClick;

  const NewButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
        onPressed: () {
          onClick.call();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0xFFFFCD4D).withOpacity(0.5);
            }
            return const Color(0xFFFFCD4D);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 19, 1, 96)),
        ),
      ),
    );
  }
}


/* // ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

//import 'package:cached_network_image/cached_network_image.dart';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package: fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/edit_profile/cubit/edit_profile_cubit.dart';
//import 'package:test2/new_button.dart';

class editProfile extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String image;
  const editProfile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.image,
  }) : super(key: key);
  @override
  State<editProfile> createState() => _editProfileState();
}

bool isLoading = false;

class _editProfileState extends State<editProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController _familyController;
  bool isEnabled = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.firstname);
    _familyController = TextEditingController(text: widget.lastname);
    log("This is the imageurl: ${widget.image}");
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }

  Future<void> _validate(String image) async {
    if (formKey.currentState!.validate()) {
      updateProfile(image).then((_) {
        Navigator.of(context).pop(true);
      });

      //showToastMessage("تمت إضافة نشاط بنجاح");
    } else {
      _showDialog();
    }
  }

  /*  void showToastMessage(String message) {
    //raghad
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white,

        //message text color

        fontSize: 16.0 //message font size
        );
  } */

  void _showDialogCancel() {
    showDialog(
      //barrierDismissible = false;
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "لحظة",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'هل انت متأكد من إلغاء العملية ؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("البقاء"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          backgroundColor: Colors.black,
          elevation: 0,
          title: Center(
            child: Text(
              'الملف الشخصي',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: Form(
              key: formKey,
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<EditProfileCubit>(context);
                  log(cubit.coverImage.toString());
                  log(widget.image.isEmpty.toString());
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundImage: cubit.coverImage == null
                                ? (widget.image.isEmpty
                                    ? AssetImage("assets/avatar.png")
                                    : NetworkImage(widget.image)
                                        as ImageProvider)
                                : FileImage(cubit.coverImage!)
                            // widget.image.isEmpty
                            //     ? AssetImage("assets/avatar.png")
                            //     : cubit.coverImage == null
                            //         ? NetworkImage(widget.image)
                            //         : FileImage(cubit.coverImage!)
                            //             as ImageProvider
                            ,
                            radius: 100,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              BlocProvider.of<EditProfileCubit>(context)
                                  .getCoverImage();
                            },
                            child: Text("تعديل الصورة"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     isEnabled =! isEnabled;
                          //   setState(() {});
                          //     },
                          //   child: Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text('تعديل',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: Colors.black),)),

                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(':الاسم الاول',
                              style: GoogleFonts.tajawal(
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 19, 1, 96),
                                  fontWeight: FontWeight.bold)),
                          Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? ' الرجاء إدخال اسم ' : null,
                              controller: nameController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.firstname,
                                  hintTextDirection: ui.TextDirection.rtl,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(':العائلة',
                              style: GoogleFonts.tajawal(
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 19, 1, 96),
                                  fontWeight: FontWeight.bold)),
                          Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'الرجاء إدخال عائلة  ' : null,
                              controller: _familyController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.lastname,
                                  hintTextDirection: ui.TextDirection.rtl,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          if (isEnabled == false)
                            NewButton(
                                text: 'تعديل',
                                height: 100,
                                width: 320,
                                onClick: () {
                                  isEnabled = !isEnabled;
                                  setState(() {});
                                }),
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'حفظ التغييرات',
                              onClick: () async {
                                // resetEmail(_emailController.text)
                                // .then((_) =>
                                log("slfmnoesndofdnofsof");
                                log(cubit.coverImage.toString());

                                if (cubit.coverImage != null) {
                                  cubit.updateCoverImage();
                                  if (state is EditProfileImageSuccess) {
                                    _validate(
                                      cubit.coverImage == null
                                          ? widget.image
                                          : cubit.imageUrl,
                                    );
                                  }
                                } else {
                                  log(cubit.coverImage.toString());
                                  _validate(
                                    cubit.coverImage == null
                                        ? widget.image
                                        : cubit.imageUrl,
                                  );
                                }

                                // );
                              }),
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'إلغاء',
                              onClick: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  // ImagePicker picker = ImagePicker();
  // File? file;
  // String imageUrl = "";
  // Future getImage(ImageSource source) async {
  //   final pickedFile = await picker.getImage(source: source, imageQuality: 30);
  //   if (pickedFile != null && pickedFile.path != null) {
  //     file = File(pickedFile.path);
  //     setState(() {});
  //     // ignore: use_build_context_synchronously
  //     imageUrl = await UploadFileServices().getUrl(context, file: file!);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
  //   }
  // }
  // Future<void> resetEmail(String newEmail) async {
  //   String message;
  //   User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   firebaseUser
  //       ?.updateEmail(newEmail)
  //       .then(
  //         (value) => message = 'Success',
  //       )
  //       .catchError((onError) => message = 'error');
  //   log(FirebaseAuth.instance.currentUser!.uid);
  // }

  _getUserDetail() {
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      nameController.text = snapshot.get("firstName");
      //image = snapshot.get('image');
      _familyController.text = snapshot.get("lastName");
      setState(() {});
    });
  }

  Future<void> updateProfile(String image) async {
    if (formKey.currentState!.validate() &&
        nameController.text.isNotEmpty &&
        _familyController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": nameController.text,
        "family": _familyController.text,
        "image": image
      }, SetOptions(merge: true)).then((value) {
        print('update');
      });
      setState(() {});
      //  showToastMessage("تمت تعديل نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      // Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }
}

class NewButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onClick;

  const NewButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
        onPressed: () {
          onClick.call();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black.withOpacity(0.5);
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
 */

/* // ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

//import 'package:cached_network_image/cached_network_image.dart';

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package: fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/edit_profile/cubit/edit_profile_cubit.dart';
//import 'package:test2/new_button.dart';

class editProfile extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String image;
  const editProfile({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.image,
  }) : super(key: key);
  @override
  State<editProfile> createState() => _editProfileState();
}

bool isLoading = false;

class _editProfileState extends State<editProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController _familyController;
  bool isEnabled = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.firstname);
    _familyController = TextEditingController(text: widget.lastname);
    log("This is the imageurl: ${widget.image}");
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }

  Future<void> _validate(String image) async {
    if (formKey.currentState!.validate()) {
      updateProfile(image).then((_) {
        Navigator.of(context).pop(true);
      });

      //showToastMessage("تمت إضافة نشاط بنجاح");
    } else {
      _showDialog();
    }
  }

  /*  void showToastMessage(String message) {
    //raghad
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white,

        //message text color

        fontSize: 16.0 //message font size
        );
  } */

  void _showDialogCancel() {
    showDialog(
      //barrierDismissible = false;
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "لحظة",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'هل انت متأكد من إلغاء العملية ؟',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text("البقاء"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          backgroundColor: const Color(0xFFFFCD4D),
          elevation: 0,
          title: Center(
            child: Text(
              'الملف الشخصي',
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 19, 1, 96)),
            ),
          ),
        ),
        body: Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: Form(
              key: formKey,
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<EditProfileCubit>(context);
                  log(cubit.coverImage.toString());
                  log(widget.image.isEmpty.toString());
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundImage: cubit.coverImage == null
                                ? (widget.image.isEmpty
                                    ? AssetImage("assets/avatar.png")
                                    : NetworkImage(widget.image)
                                        as ImageProvider)
                                : FileImage(cubit.coverImage!)
                            // widget.image.isEmpty
                            //     ? AssetImage("assets/avatar.png")
                            //     : cubit.coverImage == null
                            //         ? NetworkImage(widget.image)
                            //         : FileImage(cubit.coverImage!)
                            //             as ImageProvider
                            ,
                            radius: 100,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFCD4D)),
                            onPressed: () {
                              BlocProvider.of<EditProfileCubit>(context)
                                  .getCoverImage();
                            },
                            child: Text("تعديل الصورة",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 19, 1, 96))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     isEnabled =! isEnabled;
                          //   setState(() {});
                          //     },
                          //   child: Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text('تعديل',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600,color: const Color(0xFFFFCD4D)),)),

                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(':الاسم الاول',
                              style: GoogleFonts.tajawal(
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 19, 1, 96),
                                  fontWeight: FontWeight.bold)),
                          Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? ' الرجاء إدخال اسم ' : null,
                              controller: nameController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.firstname,
                                  hintTextDirection: ui.TextDirection.rtl,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(':العائلة',
                              style: GoogleFonts.tajawal(
                                  fontSize: 28,
                                  color: Color.fromARGB(255, 19, 1, 96),
                                  fontWeight: FontWeight.bold)),
                          Container(
                            alignment: Alignment.topRight,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'الرجاء إدخال عائلة  ' : null,
                              controller: _familyController,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget.lastname,
                                  hintTextDirection: ui.TextDirection.rtl,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          if (isEnabled == false)
                            NewButton(
                                text: 'تعديل',
                                height: 100,
                                width: 320,
                                onClick: () {
                                  isEnabled = !isEnabled;
                                  setState(() {});
                                }),
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'حفظ التغييرات',
                              onClick: () async {
                                // resetEmail(_emailController.text)
                                // .then((_) =>
                                log("slfmnoesndofdnofsof");
                                log(cubit.coverImage.toString());

                                if (cubit.coverImage != null) {
                                  cubit.updateCoverImage();
                                  if (state is EditProfileImageSuccess) {
                                    _validate(
                                      cubit.coverImage == null
                                          ? widget.image
                                          : cubit.imageUrl,
                                    );
                                  }
                                } else {
                                  log(cubit.coverImage.toString());
                                  _validate(
                                    cubit.coverImage == null
                                        ? widget.image
                                        : cubit.imageUrl,
                                  );
                                }

                                // );
                              }),
                          NewButton(
                              height: 100,
                              width: 320,
                              text: 'إلغاء',
                              onClick: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  // ImagePicker picker = ImagePicker();
  // File? file;
  // String imageUrl = "";
  // Future getImage(ImageSource source) async {
  //   final pickedFile = await picker.getImage(source: source, imageQuality: 30);
  //   if (pickedFile != null && pickedFile.path != null) {
  //     file = File(pickedFile.path);
  //     setState(() {});
  //     // ignore: use_build_context_synchronously
  //     imageUrl = await UploadFileServices().getUrl(context, file: file!);
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
  //   }
  // }
  // Future<void> resetEmail(String newEmail) async {
  //   String message;
  //   User? firebaseUser = FirebaseAuth.instance.currentUser;
  //   firebaseUser
  //       ?.updateEmail(newEmail)
  //       .then(
  //         (value) => message = 'Success',
  //       )
  //       .catchError((onError) => message = 'error');
  //   log(FirebaseAuth.instance.currentUser!.uid);
  // }

  _getUserDetail() {
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      nameController.text = snapshot.get("firstName");
      //image = snapshot.get('image');
      _familyController.text = snapshot.get("lastName");
      setState(() {});
    });
  }

  Future<void> updateProfile(String image) async {
    if (formKey.currentState!.validate() &&
        nameController.text.isNotEmpty &&
        _familyController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstName": nameController.text,
        "family": _familyController.text,
        "image": image
      }, SetOptions(merge: true)).then((value) {
        print('update');
      });
      setState(() {});
      //  showToastMessage("تمت تعديل نشاط بنجاح");
      // Notifications.showNotification(
      //   title: "EARNILY",
      //   body: ' لديك نشاط جديد بأنتظارك',
      //   payload: 'earnily',
      // );
      // Navigator.of(context).pop();
    } else {
      _showDialog();
    }
  }
}

class NewButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final VoidCallback onClick;

  const NewButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
        onPressed: () {
          onClick.call();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0xFFFFCD4D).withOpacity(0.5);
            }
            return const Color(0xFFFFCD4D);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 19, 1, 96)),
        ),
      ),
    );
  }
}
 */