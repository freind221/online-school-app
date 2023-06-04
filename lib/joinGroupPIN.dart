import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:custom_switch/custom_switch.dart';
import 'QuizList.dart';
// import './constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'joinQR.dart';
import 'bottom_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'RecentlyQuiz.dart';
import 'models/group_data_model.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JoinGroupPIN extends StatefulWidget {
  const JoinGroupPIN({super.key});

  @override
  _JoinGroupPINState createState() => _JoinGroupPINState();
}

const double width = 300.0;
const double height = 60.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _JoinGroupPINState extends State<JoinGroupPIN> {
  final CollectionReference _category =
      FirebaseFirestore.instance.collection('categoies');

  Map<String, dynamic> questions = {};
  late String PIN;
  final _request = FirebaseFirestore.instance.collection('quiz').doc();
  bool created = false;

  String textbutton = "اختر صورة الاختبار ";
  Icon iconbutton = const Icon(
    Icons.upload,
    color: Color.fromARGB(255, 19, 1, 96),
  );

  // UploadTask? uploadTask;
  bool isselect = false;
  var result;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uemail;
  var Usertoken;
  var profilepic;
  var val1 = 2;
  var val2 = 1;
  // var val1 = -1;
  // var val2 = -1;

  String profilePicLink = " ";

  var profilePic = ' ';

  // Future uploadFile() async {
  //   final path = 'files/${pickedfile!.name}';
  //   final file = File(pickedfile!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   uploadTask = ref.putFile(file);

  //   final snapshot = await uploadTask!.whenComplete(() {});

  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   sampleController.text = '$urlDownload';
  //   isselect = true;
  //   print('downlaod :$urlDownload');
  // }

  final formKey = GlobalKey<FormState>(); //key for form

  @override
  void initState() {
    super.initState();

    //dateController.text = "";
    // FirebaseMessaging _firebaseMessaging =
    //     FirebaseMessaging.instance; // Change here
    // _firebaseMessaging.getToken().then((token) {
    //   print("token is $token");
    //   Usertoken = token;
    //   print("token $Usertoken");
    // });

    //getCurrentUser();
    // profile();
  }

  String? type;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      body: PinCodeVerificationScreen(),
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  final String? phoneNumber;

  const PinCodeVerificationScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late var uemail;
  TextEditingController textEditingController = TextEditingController();
  double xAlign = 2.4;
  Color loginColor = Colors.black;
  Color signInColor = Colors.red;
  StreamController<ErrorAnimationType>? errorController;
  bool isSwitched = false;
  bool isVisible = true;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'انضم إلى المجموعة',
          style: GoogleFonts.tajawal(
              fontSize: 25,
              color: const Color.fromARGB(255, 19, 1, 96),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              // const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  // child: Image.asset(Constants.otpGifImage),
                ),
              ),
              const SizedBox(height: 8),

              // title
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 8.0),
              //   child: Text(
              //     'ادخل رمز الدخول  ',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 22,
              //       color: Color.fromARGB(255, 19, 1, 96),
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              // second title
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              //   child: RichText(
              //     text: TextSpan(
              //         text: "ادخل رمز الدخول",
              //         children: [
              //           // TextSpan(
              //           //     text: "${widget.phoneNumber}",
              //           //     style: const TextStyle(
              //           //         color: Colors.black,
              //           //         fontWeight: FontWeight.bold,
              //           //         fontSize: 15)),
              //         ],
              //         style:
              //             const TextStyle(color: Colors.black54, fontSize: 15)),
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'ادخل رمز الدخول ',
                  style: GoogleFonts.tajawal(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(161, 164, 178, 1),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 1, 96),
                        fontWeight: FontWeight.bold,
                      ),
                      length: 5,
                      // obscureText: true,
                      // obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,

                      // validate feild
                      validator: (v) {
                        if (v!.length < 3) {
                          return "الرجاء اكمال جميع الحقول";
                        } else {
                          return null;
                        }
                      },

                      pinTheme: PinTheme(
                        // activeFillColor: Color.fromARGB(255, 19, 1, 96),
                        activeColor: const Color.fromARGB(255, 19, 1, 96),
                        inactiveColor: const Color.fromARGB(255, 19, 1, 96),
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.white,
                        disabledColor: Colors.white,

                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 55,
                        fieldWidth: 55,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),

                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },

                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "الرجاء ادخال رمز الدخول الصحيح" : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 14,
              ),

              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(252, 224, 151, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: Alignment(xAlign, 0),
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: width * 0.5,
                        height: height,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 205, 77, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        QuerySnapshot<Map<String, dynamic>> query2;
                        query2 = await FirebaseFirestore.instance
                            .collection('group')
                            .where("pin", isEqualTo: currentText.toString())
                            .get();

                        if (query2.docs.isNotEmpty) {
                          getCurrentUser();

                          final request = FirebaseFirestore.instance
                              .collection('group')
                              .doc(currentText.toString())
                              .collection('members')
                              .doc(uemail)
                              .set({'id': uemail});

                          final group = await FirebaseFirestore.instance
                              .collection('group')
                              .doc(currentText.toString())
                              .get();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizListScreen(
                                      group: GroupDataModel.fromMap(
                                          group.data()!))));
                        }

                        // QuerySnapshot<Map<String, dynamic>> _query3;
                        // _query3 = await FirebaseFirestore.instance
                        //     .collection('group')
                        //     .where("pin", isEqualTo: currentText)
                        //     .get();

                        // if (_query3.docs.isNotEmpty) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => RecentlyQuiz()));
                        // }

                        setState(() {
                          xAlign = loginAlign;
                          loginColor = selectedColor;

                          signInColor = normalColor;
                        });
                      },
                      child: Align(
                        alignment: const Alignment(-1, 0),
                        child: Container(
                          width: width * 0.5,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: const Text(
                            'رمز الدخول',
                            style: TextStyle(
                              color: Color.fromRGBO(19, 1, 96, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //test
                        // String? id = await st.readSecureData("caregiverID");
                        // print(id);
                        //st.deleteSecureData("caregiverID");
                        String barcodeScanRes;
                        // try {
                        barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666', 'Cancel', true, ScanMode.QR);
                        print(barcodeScanRes);

                        QuerySnapshot<Map<String, dynamic>> query;
                        if (barcodeScanRes.startsWith('1')) {
                          query = await FirebaseFirestore.instance
                              .collection('quiz')
                              .where("pin", isEqualTo: barcodeScanRes)
                              .get();
                        } else {
                          query = await FirebaseFirestore.instance
                              .collection('group')
                              .where("pin", isEqualTo: barcodeScanRes)
                              .get();
                        }

                        if (query.docs.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              // margin: EdgeInsets.only(right: 10),

                              content: Text('خطأ في مسح الكود ',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.right),
                            ),
                          );
                        }

                        setState(() {
                          xAlign = signInAlign;
                          signInColor = selectedColor;

                          loginColor = normalColor;
                        });
                      },
                      child: Align(
                        alignment: const Alignment(1, 0),
                        child: Container(
                          width: width * 0.5,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: const Text(
                            'الماسح الضوئي',
                            style: TextStyle(
                              color: Color.fromRGBO(19, 1, 96, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getCurrentUser() async {
    final User user = _auth.currentUser!;

    uemail = user.email.toString();

    //   print(uemail);
  }
}
