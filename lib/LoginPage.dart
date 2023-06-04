// import 'dart:ui';

// import 'package:faheem/Home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// // import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter/src/material/icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// //import 'SignUpOp.dart';
// import 'Home.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   void dispose() {
//     _emailTextController.dispose();
//     _passwordTextController.dispose();
//     super.dispose();
//   }

//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController _emailTextController = TextEditingController();
//   TextEditingController _passwordTextController = TextEditingController();
//   String _error = "";
//   bool obscure = true;
//   bool err = false;

//   bool err2 = false;

//   bool err3 = false;

//   final _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               Container(
//                 height: h * 0.25,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 100,
//                     ),
//                     Text(
//                       'Welcome Back!',
//                       style: GoogleFonts.comfortaa(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 19, 1, 96)),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                         padding: EdgeInsets.only(left: 20, right: 20),
//                         child: Text(
//                           'To Log In to your account,\nplease fill all of your information',
//                           style: GoogleFonts.comfortaa(
//                               fontSize: 15,
//                               color: Color.fromARGB(255, 19, 1, 96)),
//                           textAlign: TextAlign.center,
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 height: h * 0.15,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(right: 220, bottom: 20),
//                       child: Text(
//                         'Email Address',
//                         style: GoogleFonts.comfortaa(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: Color.fromARGB(255, 19, 1, 96)),
//                       ),
//                     ),

//                     //TextField
//                     Container(
//                       width: w * 0.9,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(0, 145, 2, 2),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                                 blurRadius: 20,
//                                 offset: Offset(1, 1),
//                                 color: Colors.grey.withOpacity(0.15))
//                           ]),
//                       child: TextFormField(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         controller: _emailTextController,
//                         validator: validationUser,
//                         decoration: InputDecoration(
//                             fillColor: Color.fromARGB(255, 255, 255, 255),
//                             filled: true,
//                             hintText: ("Email Address"),
//                             //label: Text("Email"),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: Color.fromARGB(255, 19, 1, 96)
//                                   .withOpacity(0.25),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(color: Colors.white)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(color: Colors.white)),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: h * 0.25,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(right: 270, bottom: 20),
//                       child: Text(
//                         'Password',
//                         style: GoogleFonts.comfortaa(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                             color: Color.fromARGB(255, 19, 1, 96)),
//                       ),
//                     ),
//                     Container(
//                       width: w * 0.9,
//                       decoration: BoxDecoration(
//                           color: Color.fromARGB(0, 255, 255, 255),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                                 blurRadius: 20,
//                                 offset: Offset(1, 1),
//                                 color: Colors.grey.withOpacity(0.15))
//                           ]),
//                       child: TextFormField(
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: ValidateEmpty,
//                         controller: _passwordTextController,
//                         obscureText: obscure,
//                         decoration: InputDecoration(
//                             fillColor: Color.fromARGB(255, 255, 255, 255),
//                             filled: true,
//                             hintText: ("Password"),
//                             prefixIcon: Icon(
//                               Icons.password_rounded,
//                               color: Color(0xFF130160).withOpacity(0.25),
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   obscure = !obscure;
//                                 });
//                               },
//                               icon: Icon(
//                                 obscure
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               color: Color.fromARGB(255, 174, 156, 254),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(color: Colors.white)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(color: Colors.white)),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15))),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Row(children: [
//                       Expanded(child: Container()),
//                       GestureDetector(
//                         child: Text('Forgot your Password?      ',
//                             style: GoogleFonts.comfortaa(
//                                 fontSize: 17,
//                                 color: Color.fromARGB(255, 19, 1, 96))),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return ResetPassword();
//                             }),
//                           );
//                         },
//                       )
//                     ])
//                   ],
//                 ),
//               ),
//               Container(
//                 height: h * 0.25,
//                 child: Column(children: [
//                   SizedBox(
//                     width: w * 0.9,
//                     height: 60,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Loginbtn();
//                         },
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color(0xFF130160)),
//                             shape: MaterialStateProperty
//                                 .all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                         side: BorderSide(
//                                           color: Color(0xFF130160),
//                                         )))),
//                         child: Text(
//                           'Login',
//                           style: GoogleFonts.comfortaa(fontSize: 20),
//                         )),
//                   ),
//                   SizedBox(
//                     height: h * 0.01,
//                   ),
//                   Center(
//                     child: Row(
//                       children: [
//                         Expanded(child: Container()),
//                         Text('You dont have an account yet?',
//                             style: GoogleFonts.comfortaa(
//                               color: Color(0xFF130160),
//                               fontSize: 16,
//                             )),
//                         TextButton(
//                             onPressed: () async {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => SignUpOptions()));
//                             },
//                             child: Text(
//                               'SignUp',
//                               style: GoogleFonts.comfortaa(
//                                 color: Color(0xFFFCA34D),
//                                 //fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             )),
//                         Expanded(child: Container()),
//                       ],
//                     ),
//                   ),
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String? ValidateEmpty(value) {
//     if (value != null && value.isEmpty) {
//       return "Required";
//     } else {
//       InputDecoration(
//         errorBorder: UnderlineInputBorder(
//           borderSide: BorderSide.none,
//         ),
//       );
//       return null;
//     }
//   }

//   void Loginbtn() async {
//     if (formKey.currentState!.validate()) {
//       try {
//         await _auth
//             .signInWithEmailAndPassword(
//                 email: _emailTextController.text.trim().toLowerCase(),
//                 password: _passwordTextController.text.trim())
//             .then((value) {
//           AuthorizeAccess(context);
//         });
//       } catch (error) {
//         setState(() {
//           err = true;
//         });
//       }
//     } else {
//       print("not validated");
//     }
//   }

//   String? validationUser(String? User) {
//     if (User == null || User.trim().isEmpty) {
//       err = false;
//       err2 = false;
//       err3 = false;
//       return "Required";
//     }
//     final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     if (!emailRegExp.hasMatch(User)) {
//       return 'Invalid email';
//     }

//     if (err) {
//       err = false;
//       return "Wrong Email or password";
//     }
//     if (err2) {
//       err2 = false;
//       return 'this account is declined';
//     }
//     if (err3) {
//       err3 = false;
//       return 'this account is deactivated';
//     }

//     return null;
//   }

//   AuthorizeAccess(BuildContext context) async {
//     FirebaseFirestore.instance
//         .collection('Users')
//         .where('email',
//             isEqualTo: _emailTextController.text.trim().toLowerCase())
//         .get()
//         .then((snapshot) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//     });
//   }
// }
