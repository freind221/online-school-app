import 'dart:async';
import 'package:faheem/bottom_tab.dart';
import 'package:faheem/forgotPassword.dart';

import 'SignUp.dart';
import 'package:faheem/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottom_tab.dart';

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final debouncer = Debouncer(milliseconds: 500);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  late bool emailAddressVisibility;
  final formKey1 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailAddressVisibility = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 10),
                  child: Container(
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      image: DecorationImage(
                        image: Image.asset(
                          'assets/Flogo.jpg',
                        ).image,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.tajawal(
                          fontSize: 28,
                          color: const Color.fromARGB(255, 19, 1, 96),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Text(
                          'البريد الإلكتروني',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.tajawal(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Form(
                        key: formKey1,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'الرجاء ادخال البريد الإلكتروني';
                                }
                                bool emailValid = RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value);
                                if (!emailValid) {
                                  return 'الرجاء ادخال بريد الكتروني صحيح';
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
                                hintText: 'ادخل البريد الالكتروني',
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 16, 20),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF1D2429),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.right,
                              minLines: 1,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Text(
                          'كلمة المرور',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.tajawal(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 19, 1, 96),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Form(
                        key: formKey2,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'الرجاء ادخال كلمة المرور';
                                } else if (value.length < 5) {
                                  return 'كلمة المرور لايجب ان تقل عن 5 احرف ';
                                } else if (value.length > 20) {
                                  return 'كلمة المرور لايجب ان تكون اكثر من 20 حرف';
                                }
                                return null;
                              },
                              onChanged: (_) => debouncer.run(() {}),
                              autofocus: true,
                              obscureText: !emailAddressVisibility,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintText: 'ادخل كلمة المرور',
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 16, 20),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => emailAddressVisibility =
                                        !emailAddressVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    emailAddressVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF757575),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF1D2429),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.right,
                              minLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgetPassWordMethods() //  HomeExpert(), //change it to forgot pass screen
                            ));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
                          child: Text(
                            'نسيت كلمة المرور؟ ',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.tajawal(
                                fontSize: 19,
                                color: const Color(0xFFA1A4B2),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: GestureDetector(
                    // onTap: signIn,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 20, 20, 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey1.currentState!.validate() &
                                formKey2.currentState!.validate()) {
                              signIn();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BottomTabBarr(), //change it to forgot pass screen
                                  ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFFCD4D),
                          ),
                          child: Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.tajawal(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 19, 1, 96),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' لا يوجد لديك حساب؟',
                            style: GoogleFonts.tajawal(
                                fontSize: 20,
                                color: const Color(0xFFA1A4B2),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(" سجل الان",
                              style: GoogleFonts.tajawal(
                                  fontSize: 19,
                                  color: const Color(0xFFFFCD4D),
                                  fontWeight: FontWeight.bold)
                              // color: Color(0xFFFFCD4D),
                              ),
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
    );
  }
}
