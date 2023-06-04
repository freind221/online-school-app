import 'package:faheem/Login.dart';
import 'package:faheem/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: false,
        builder: (context, child) {
          return ChangeNotifierProvider(
            create: (context) => SignUpViewModel(),
            child: Consumer<SignUpViewModel>(
              builder: (context, model, child) => ModalProgressHUD(
                inAsyncCall: model.isLoading,
                child: Scaffold(
                  backgroundColor: const Color(0xFFF5F5F5),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
                      child: Form(
                        key: model.formKey,
                        child: Column(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_back_ios)),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('انشاء حساب ',
                                    style: GoogleFonts.tajawal(
                                        fontSize: 28,
                                        color: const Color.fromARGB(
                                            255, 19, 1, 96),
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),

                              Text(
                                'الأسم الأول',
                                style: GoogleFonts.tajawal(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 19, 1, 96),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),

                              CustomTextField(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(
                                    Icons.check,
                                    color: model.firstNameisValide
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 227, 224, 224),
                                  ),
                                ),
                                onSaved: (value) {
                                  model.signUpBody.firstName = value.trim();
                                },
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    model.updateFirstNameValidate(false);
                                  } else if (RegExp(r'[a-zA-Z\u0600-\u06FF]')
                                      .hasMatch(value)) {
                                    model.updateFirstNameValidate(true);
                                  } else {
                                    model.updateFirstNameValidate(false);
                                  }
                                },
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  // english and arabic letters only
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z\u0600-\u06FF]')),
                                ],
                                hintText: 'ادخل الأسم الأول',
                                fontSize: 14,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'الرجاء ادخال الأسم الأول';
                                  } else if (RegExp(r'[a-zA-Z\u0600-\u06FF]')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'الرجاء ادخال الأسم الأول';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'الأسم الأخير',
                                style: GoogleFonts.tajawal(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 19, 1, 96),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),

                              CustomTextField(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(
                                    Icons.check,
                                    color: model.lastNameisValide
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 227, 224, 224),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    model.updateLastNameValidate(false);
                                  } else if (RegExp(r'[a-zA-Z\u0600-\u06FF]')
                                      .hasMatch(value)) {
                                    model.updateLastNameValidate(true);
                                    return null;
                                  } else {
                                    model.updateLastNameValidate(false);
                                  }
                                },
                                onSaved: (value) {
                                  model.signUpBody.lastName = value.trim();
                                },
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  // english and arabic letters only
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z\u0600-\u06FF]')),
                                ],
                                //last name
                                hintText: 'ادخل الأسم الأخير',
                                fontSize: 14,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'الرجاء ادخال الأسم الأخير';
                                  }
                                  // else check only english and arabic letters
                                  else if (RegExp(r'[a-zA-Z\u0600-\u06FF]')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'الرجاء ادخال الأسم الأخير';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'البريد الالكتروني',
                                style: GoogleFonts.tajawal(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 19, 1, 96),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),

                              CustomTextField(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Icon(
                                    Icons.check,
                                    color: model.emailisValide
                                        ? Colors.green
                                        : const Color.fromARGB(
                                            255, 227, 224, 224),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value!.isEmpty) {
                                    model.updateEmailValidate(false);
                                  } else if (RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value)) {
                                    model.updateEmailValidate(true);
                                  } else {
                                    model.updateEmailValidate(false);
                                  }
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  model.signUpBody.email = value.trim();
                                },
                                hintText: 'ادخل البريد الالكتروني',
                                fontSize: 14,
                                validator: (value) {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = RegExp(pattern);
                                  if (value!.trim().isNotEmpty) {
                                    if (regex.hasMatch(value.trim())) {
                                      return null;
                                    } else {
                                      // in arabic
                                      return "البريد الالكتروني غير صحيح";
                                    }
                                  } else {
                                    return "الرجاء ادخال البريد الالكتروني";
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              //
                              //
                              //
                              //
                              //
                              ///
                              /////
                              /////
                              Text('كلمة المرور ',
                                  style: GoogleFonts.tajawal(
                                      fontSize: 21,
                                      color:
                                          const Color.fromARGB(255, 19, 1, 96),
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 6.h,
                              ),

                              CustomTextField(
                                onSaved: (value) {
                                  model.signUpBody.password = value.trim();
                                },
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  model.updateIsValueSpecialChar(value);
                                  model.updateIsvalueGraterThan8(value);
                                  model.updateIsValueNumber(value);
                                  model.updateIsValueUpperCase(value);
                                  model.updateIsValueLowerCase(value);
                                  if (model.isValueGraterThan8) {
                                    if (model.isValueSpecialChar) if (model
                                        .isValueNumber) {
                                      if (model.isValueUpperCase) {
                                        if (model.isValueLowerCase) {
                                          model.updatePasswordValidate(true);
                                        } else {
                                          model.updatePasswordValidate(false);
                                        }
                                      } else {
                                        model.updatePasswordValidate(false);
                                      }
                                    } else {
                                      model.updatePasswordValidate(false);
                                    }
                                    else {
                                      model.updatePasswordValidate(false);
                                    }
                                  }
                                },
                                validator: (value) {
                                  if (model.isValueGraterThan8) {
                                    if (model.isValueSpecialChar) if (model
                                        .isValueNumber) {
                                      if (model.isValueUpperCase) {
                                        if (model.isValueLowerCase) {
                                          return null;
                                        } else {
                                          return '';
                                        }
                                      } else {
                                        return '';
                                      }
                                    } else {
                                      return '';
                                    }
                                    else {
                                      return '';
                                    }
                                  }
                                  // return '';
                                  else if (value!.isEmpty) {
                                    return 'الرجاء ادخال كلمة المرور';
                                  }
                                },
                                hintText: 'ادخل كلمة المرور',
                                fontSize: 14,
                                obscure: model.passwordVisibility,
                                suffixIcon: IconButton(
                                  splashRadius: 15.r,
                                  onPressed: model.togglePasswordVisibility,
                                  icon: model.passwordVisibility
                                      ? Icon(
                                          Icons.visibility_off_outlined,
                                          color: model.passwordisValide
                                              ? Colors.green
                                              : const Color(0xff9CA4AB),
                                        )
                                      : Icon(
                                          Icons.visibility_outlined,
                                          color: model.passwordisValide
                                              ? Colors.green
                                              : const Color(0xff9CA4AB),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),

                              validationTexts(
                                  model.isValueGraterThan8,
                                  // arabic
                                  'يجب أن تحتوي على 8 أحرف على الأقل'),
                              validationTexts(
                                  model.isValueUpperCase,
                                  //arabic
                                  'يجب أن تحتوي على حرف كبير على الأقل'),
                              validationTexts(
                                  model.isValueLowerCase,
                                  //arabic
                                  'يجب أن تحتوي على حرف صغير على الأقل'),
                              validationTexts(
                                  model.isValueSpecialChar,
                                  //arabic
                                  'يجب أن تحتوي على حرف خاص على الأقل'),
                              validationTexts(
                                  //arabic
                                  model.isValueNumber,
                                  'يجب أن تحتوي على رقم على الأقل'),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (model.formKey.currentState!
                                        .validate()) {
                                      model.formKey.currentState!.save();
                                      model.createUserWithEmailAndPassword();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFFFFCD4D),
                                    //shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(10.r),
                                    // ),
                                    // minimumSize: Size(100.w, 50.h),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                    child: Text('إنشاء',
                                        style: GoogleFonts.tajawal(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 19, 1, 96),
                                        )),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'لديك حساب؟',
                                      style: GoogleFonts.tajawal(
                                        fontSize: 19,
                                        color: const Color(0xff9CA4AB),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: GoogleFonts.tajawal(
                                          fontSize: 19,
                                          color: const Color.fromARGB(
                                              218, 241, 186, 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Row validationTexts(
    bool isValide,
    text,
  ) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 20.h,
          color: isValide ? const Color(0xff00C566) : const Color(0xff9CA4AB),
        ),
        Text(
          '  $text',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isValide ? const Color(0xff00C566) : const Color(0xff9CA4AB),
          ),
        ),
      ],
    );
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
  final List<TextInputFormatter>? inputFormatters;
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
    this.inputFormatters,
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
      inputFormatters: inputFormatters,
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
        suffixIcon: suffixIcon,
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
        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 20, 16, 20),
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

class SignUpViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  SignUpBody signUpBody = SignUpBody();
  //form key
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  bool isValueGraterThan8 = false;
  bool isValueSpecialChar = false;
  bool isValueNumber = false;
  bool isValueUpperCase = false;
  bool isValueLowerCase = false;
  bool isLoading = false;

  bool firstNameisValide = false;
  bool lastNameisValide = false;
  bool emailisValide = false;
  bool passwordisValide = false;

  updateFirstNameValidate(value) {
    firstNameisValide = value;
    notifyListeners();
  }

  updateLastNameValidate(value) {
    lastNameisValide = value;
    notifyListeners();
  }

  updateEmailValidate(value) {
    emailisValide = value;
    notifyListeners();
  }

  updatePasswordValidate(value) {
    passwordisValide = value;
    notifyListeners();
  }

  updateIsloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool updateIsvalueGraterThan8(Value) {
    if (Value.length > 7) {
      isValueGraterThan8 = true;
    } else {
      isValueGraterThan8 = false;
    }

    notifyListeners();
    return isValueGraterThan8;
  }

  bool updateIsValueSpecialChar(value) {
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      isValueSpecialChar = true;
    } else {
      isValueSpecialChar = false;
    }
    notifyListeners();
    return isValueSpecialChar;
  }

  bool updateIsValueNumber(value) {
    if (value.contains(RegExp(r'[0-9]'))) {
      isValueNumber = true;
    } else {
      isValueNumber = false;
    }
    notifyListeners();
    return isValueNumber;
  }

  bool updateIsValueUpperCase(value) {
    if (value.contains(RegExp(r'[A-Z]'))) {
      isValueUpperCase = true;
    } else {
      isValueUpperCase = false;
    }
    notifyListeners();
    return isValueUpperCase;
  }

  bool updateIsValueLowerCase(value) {
    if (value.contains(RegExp(r'[a-z]'))) {
      isValueLowerCase = true;
    } else {
      isValueLowerCase = false;
    }
    notifyListeners();
    return isValueLowerCase;
  }

  togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

// create function to create account in firebase and send data to firestore
  createUserWithEmailAndPassword() async {
    updateIsloading(true);
    print(signUpBody.toJson());
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: signUpBody.email!, password: signUpBody.password!);
      if (credential.user != null) {
        //snackbar to show success message account created successfully
        await FirebaseFirestore.instance
            .collection('User')
            .doc(credential.user!.uid)
            .set({
          'userID': credential.user!.uid,
          'firstName': signUpBody.firstName,
          'lastName': signUpBody.lastName,
          'email': signUpBody.email?.toLowerCase(),
        });

        Get.snackbar('انشاء حساب ', 'لقد تم انشاء الحساب بنجاح  ',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        updateIsloading(false);
        Get.snackbar('انشاء حساب ', 'لم يتم انشاء الحساب',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } on FirebaseAuthException catch (e) {
      updateIsloading(false);
      Get.snackbar('SignUp', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    updateIsloading(false);
  }

  resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}

class SignUpBody {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  SignUpBody({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  SignUpBody.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
