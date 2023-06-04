import 'package:faheem/Login.dart';
import 'package:faheem/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgetPassWordMethods extends StatefulWidget {
  const ForgetPassWordMethods({super.key});

  @override
  State<ForgetPassWordMethods> createState() => _ForgetPassWordMethodsState();
}

class _ForgetPassWordMethodsState extends State<ForgetPassWordMethods> {
  final emailController = TextEditingController();
  final _auth = SignUpViewModel();
  final fromKey = GlobalKey<FormState>();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: false,
        builder: (context, child) {
          return Scaffold(
              backgroundColor: Color(0xFFF5F5F5),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Color(0xFFF5F5F5),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
                title: Text(
                  'اعادة تعيين كلمة المرور ',
                  style: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Color.fromARGB(255, 19, 1, 96),
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: ModalProgressHUD(
                inAsyncCall: isLoding,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/ForgotPassword.png',
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'قم بارخال بريدك الإلكتروني وسيتم ارسال رابط للتحقق من هويتك  ',
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
                            color: Color.fromARGB(255, 19, 1, 96),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: fromKey,
                          child: CustomTextField(
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
                            },
                            //decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.black),
                            hintText: 'ادخل البريد الالكتروني ',

                            fillColor: Colors.white,
                          ),
                        ),
                        // ),
                        SizedBox(
                          height: 70,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // setState(() {
                            // isLoding = true;
                            // });
                            if (fromKey.currentState!.validate()) {
                              String email = emailController.text.trim();
                              try {
                                await _auth.resetPassword(email);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'تم ارسال رسالة تعيين كلمة المرور',
                                  ),
                                ));
                                _dialogBuilder(context);
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.message.toString()),
                                ));
                              }
                              //setState(() {
                              //isLoding = false;
                              // }
                              //  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Color(0xFFFFCD4D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            minimumSize: Size(343.w, 50.h),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text('تحقق',
                                style: GoogleFonts.tajawal(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 19, 1, 96),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

class CustomTextField extends StatelessWidget {
  final controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final validator;
  final double? fontSize;
  final String? label;
  final onSaved;
  final onTap;
  final bool disableBorder;
  final onChanged;
  final Widget? prefixWidget;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final TextStyle? hintstyle;
  final double? borderRadius;
  final Color? fillColor;

  const CustomTextField({
    Key? key,
    this.borderRadius,
    this.hintstyle,
    this.controller,
    this.onTap,
    this.disableBorder = true,
    this.label,
    this.obscure = false,
    this.enabled = true,
    this.validator,
    this.errorText,
    this.fontSize = 14.0,
    this.hintText,
    this.onSaved,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixWidget,
    this.onChanged,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.borderColor,
    this.fillColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      enabled: enabled,
      controller: controller,
      obscureText: obscure!,
      validator: validator ??
          (value) {
            if (value != null) {
              return errorText;
            } else {
              return null;
            }
          },
      style: TextStyle(
        fontSize: fontSize!.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      cursorColor: Get.theme.primaryColor,
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.white,
        filled: true,
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: prefixWidget ??
            Padding(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 20.h, left: 10.w, right: 10.w),
              child: prefixIcon,
            ),
        suffixIcon: suffixIcon ?? null,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 70),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : borderColor ?? const Color(0xFFE3E7EC)),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : borderColor ?? const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 20, 16, 20),
        hintText: hintText,
        hintStyle: hintstyle ??
            TextStyle(
              fontSize: fontSize!.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.005,
              color: const Color(0xFF9ca4ab),
            ),
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 3,
                color: Color(0xFFFFCD4D),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFFCD4D)),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'تحقق من بريدك الالكتروني',
                  style: GoogleFonts.tajawal(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 1, 96),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'تم ارسال رسالة تعيين كلمةالمرور إلى بريدك الإلكتروني',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 1, 96),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color(0xFFFFCD4D),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: Text('حسنا',
                          style: GoogleFonts.tajawal(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 1, 96),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
