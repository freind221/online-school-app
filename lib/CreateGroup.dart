import 'dart:io';
import 'dart:math';

import 'package:faheem/models/group_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'QuizList.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({super.key});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestForm> {
  final CollectionReference _category =
      FirebaseFirestore.instance.collection('categoies');

  var selectedCategory;
  TextEditingController dateController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sampleController = TextEditingController();
  late String PIN;
  String imageUrl = '';

  String textbutton = "اختر صورة المجموعة ";
  Icon iconbutton = const Icon(
    Icons.upload,
    color: Color.fromARGB(255, 19, 1, 96),
  );

  PlatformFile? pickedfile;
  // UploadTask? uploadTask;
  bool isselect = false;
  var result;
  Future selectFile() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    setState(() {
      result = file;
    });

    // setState(() {
    //   pickedfile = result.files.first;
    // });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uemail;
  var Usertoken;
  var profilepic;
  var val1 = 2;
  var val2 = 1;
  // var val1 = -1;
  // var val2 = -1;

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
    dateController.text = "";
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
    final double height = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text("انشاء مجموعة جديدة ",
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: TextButton.icon(
                        onPressed: () async {
                          await selectFile();
                          if (result != null) {
                            textbutton = " تم ارفاق الصورة ";
                            iconbutton = const Icon(
                              Icons.check,
                              color: Color.fromARGB(255, 19, 1, 96),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          backgroundColor:
                              const Color.fromARGB(255, 227, 227, 227),
                          alignment: Alignment.center,
                        ),
                        icon: iconbutton,
                        label: Text(
                          textbutton,
                          style: GoogleFonts.tajawal(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 19, 1, 96),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 19,
                ),
                //name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "اسم المجموعة ",
                      style: GoogleFonts.tajawal(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 19, 1, 96),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.26))
                          ]),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 25,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: nameController,
                        validator: (value) {
                          final validCharacters =
                              RegExp(r'[!@#$<>?":_`~;؛[\]\/|=+؟)(*&^%]');
                          final validCharactersN = RegExp(
                              r'[!@#<>?":_`~;[\]\/|=+،..,)(*&^%0-9-٠-٩]');
                          if (value == null || value.isEmpty) {
                            return 'هذه الخانة مطلوبة';
                          } else if ((validCharactersN
                              .hasMatch(value.characters.elementAt(0)))) {
                            return 'هذه الخانة يجب ان تبدأ بحرف';
                          } else if ((validCharacters.hasMatch(value))) {
                            return 'هذه الخانة يجب ان تحتوي على أحرف و أرقام فقط';
                          } else if (value.length < 5) {
                            return 'الرجاء ادخال أكثر من ٤ احرف';
                          } else {
                            return null;
                          }
                        },
                        //keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),

                const SizedBox(
                  height: 19,
                ),

                ////description limit the charcter numbers
                Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "التصنيف ",
                          style: GoogleFonts.tajawal(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 19, 1, 96),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: _category.snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text("Loading");
                            } else {
                              List<DropdownMenuItem> categoryItem = [];
                              for (int i = 0;
                                  i < (snapshot.data)!.docs.length;
                                  i++) {
                                DocumentSnapshot snap =
                                    (snapshot.data)!.docs[i];
                                categoryItem.add(DropdownMenuItem(
                                  value: "${snap.get("name")}",
                                  child: Text(
                                    snap.get("name"),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ));
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<dynamic>(
                                    items: categoryItem,
                                    iconSize: 36,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 19, 1, 96),
                                    ),
                                    onChanged: (categoryValue) {
                                      setState(() {
                                        selectedCategory = categoryValue;
                                        catController.text =
                                            selectedCategory.toString();
                                        print(selectedCategory);
                                      });
                                    },
                                    value: selectedCategory,
                                    isExpanded: false,
                                    hint: Text(
                                        "اختر تصنيف ...                                     ",
                                        style: GoogleFonts.tajawal(
                                            fontSize: 15,
                                            color: const Color.fromARGB(
                                                131, 18, 1, 96))),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 19,
                    ),

                    //الخصوصية
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الخصوصية:',
                        style: GoogleFonts.tajawal(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 19, 1, 96),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: const Text("خاص "),
                            leading: Radio(
                              value: 1,
                              groupValue: val1,
                              onChanged: (value) {
                                setState(() {
                                  val1 = value! as int;
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: const Text("عام "),
                            leading: Radio(
                              value: 2,
                              groupValue: val1,
                              onChanged: (value) {
                                setState(() {
                                  val1 = value! as int;
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'صلاحية الإضافة:',
                        style: GoogleFonts.tajawal(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 19, 1, 96),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: const Text("خاص "),
                            leading: Radio(
                              value: 1,
                              groupValue: val2,
                              onChanged: (value) {
                                setState(() {
                                  val2 = value! as int;
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            title: const Text("للجميع "),
                            leading: Radio(
                              value: 2,
                              groupValue: val2,
                              onChanged: (value) {
                                setState(() {
                                  val2 = value! as int;
                                });
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //button
                    const SizedBox(
                      height: 19,
                    ),

                    Container(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          if (catController.text.isEmpty ||
                              result == null ||
                              !(_formKey.currentState!.validate())) {
                            ShowAlert();
                            return;
                          } else {
                            // await uploadFile();
                            bool Nunique = true;
                            while (Nunique) {
                              int randomNumber = Random().nextInt(9999);
                              PIN = '1$randomNumber';
                              QuerySnapshot<Map<String, dynamic>> pinstream =
                                  await FirebaseFirestore.instance
                                      .collection('group')
                                      .where('pin', isEqualTo: PIN)
                                      .get();

                              if (pinstream.size == 0) {
                                Nunique = false;
                              }
                            }
                            getCurrentUser();
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('Group images');

                            //Create a reference for the image to be stored
                            Reference referenceImageToUpload =
                                referenceDirImages.child(PIN);

                            //Handle errors/success
                            try {
                              //Store the file
                              await referenceImageToUpload
                                  .putFile(File(result!.path));
                              //Success: get the download URL
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (error) {
                              //Some error occurred
                            }

                            final req = Request(
                                uid: uemail,
                                name: nameController.text,
                                accessLevel: val1,
                                manageAdd: val2,
                                category: catController.text,
                                pin: PIN,
                                imgUrl: imageUrl);

                            RequestLabel(req);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        //Todo: See if this is the right PIN
                                        QuizListScreen(
                                          group:
                                              GroupDataModel.fromRequest(req),
                                        )));
                          }
                        },
                        color: const Color.fromRGBO(255, 205, 77, 1),
                        elevation: 0,
                        shape: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 205, 77, 1),
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("انشاء ",
                            style: GoogleFonts.tajawal(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 19, 1, 96),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future RequestLabel(Request req) async {
    final request = FirebaseFirestore.instance.collection('group').doc(PIN);

    final json = req.toJson();
    await request.set(json);
  }

  Future getCurrentUser() async {
    final User user = _auth.currentUser!;

    uemail = user.email.toString();

    //   print(uemail);
  }

  // profile() async {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('email', isEqualTo: uemail)
  //       .get()
  //       .then((snapshot) {
  //     profilepic = snapshot.docs[0].data()['profilepic'];

  //     print(profilepic);
  //   });
  //   print(profilepic);
  // }

  void ShowAlert() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color.fromARGB(0, 215, 147, 147),
        elevation: 0,
        content: Container(
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(children: [
            Column(
              children: [
                const Text(""),
                Text(
                  " يجب اكمال جميع البيانات للاستمرار",
                  style: GoogleFonts.tajawal(
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ]),
        )));
  }

  // showPopup() {
  //   Alert(
  //     closeIcon: Container(),
  //     context: context,
  //     style: AlertStyle(
  //         titleStyle:
  //             GoogleFonts.tajawal(fontSize: 25, fontWeight: FontWeight.bold),
  //         descStyle: GoogleFonts.tajawal(
  //           fontSize: 20,
  //         )),
  //     image: SvgPicture.asset("img/Q.svg"),
  //     title: "تحذير!",
  //     desc: "هل انت متأكد من الغاء الطلب؟ لن تستطيع استرجاعه",
  //     buttons: [
  //       DialogButton(
  //         radius: const BorderRadius.all(Radius.circular(6)),
  //         child: Text(
  //           "نعم",
  //           style: GoogleFonts.tajawal(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () => Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => MLNavBar())),
  //         //to do
  //         color: Color.fromARGB(255, 200, 62, 62),
  //       ),
  //       DialogButton(
  //         child: Text(
  //           "لا",
  //           style: GoogleFonts.tajawal(
  //               color: Color.fromARGB(255, 19, 1, 96), fontSize: 20),
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //         color: Color.fromARGB(0, 0, 179, 134),
  //         radius: BorderRadius.circular(0.0),
  //       ),
  //     ],
  //   ).show();
  // }
}

class Request {
  late String uid;
  late String name;
  late String category;
  late int accessLevel;
  late int manageAdd;
  late String pin;
  late String imgUrl;
  Request(
      {required this.uid,
      required this.name,
      required this.category,
      required this.accessLevel,
      required this.manageAdd,
      required this.pin,
      required this.imgUrl});

  Map<String, dynamic> toJson() => {
        'ownerId': uid,
        'name': name,
        'category': category,
        'accessLevel': accessLevel,
        'manageAdd': manageAdd,
        'pin': pin,
        'img': imgUrl
      };
}
