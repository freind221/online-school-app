import 'dart:io';

//---------------najd
import 'generaterQR.dart';
import 'dart:math';
import 'Question/createQuestion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'bottom_tab.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final CollectionReference _category =
      FirebaseFirestore.instance.collection('categoies');

  var selectedCategory;
  var selectedattempts;
  late String title;
  late String time;
  late String score;

  Map<String, dynamic> questions = {};
  late String PIN;
  final _request = FirebaseFirestore.instance.collection('quiz').doc();
  bool created = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController attemController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sampleController = TextEditingController();
  String imageUrl = '';

  String textbutton = "اختر صورة الاختبار ";
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          centerTitle: true,
          elevation: 0,
          title: Text("انشاء اختبار جديد ",
              style: GoogleFonts.tajawal(
                  fontSize: 28,
                  color: const Color.fromARGB(255, 19, 1, 96),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          // leading: BackButton(
          //   color: Color.fromARGB(255, 19, 1, 96),
          //   onPressed: (() {
          //     if (!(nameController.text.isEmpty) ||
          //         !(dateController.text.isEmpty) ||
          //         !(catController.text.isEmpty) ||
          //         result != null) {
          //       //showPopup();
          //     } else
          //       Navigator.pop(context);
          //   }),
          // ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                /*SizedBox(
                  height: 30,
                ),*/

                //// image /////
                // Stack(
                //   alignment: AlignmentDirectional.bottomEnd,
                //   children: [
                //     Container(
                //         width: w * 0.35,
                //         height: w * 0.35,
                //         child: CircleAvatar(
                //             backgroundColor: Color.fromARGB(255, 255, 255, 255),
                //             backgroundImage: profilePic == " "
                //                 ? null
                //                 : NetworkImage(profilePic),
                //             radius: 200.0),
                //         //  borderRadius: BorderRadius.circular(50),

                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Color.fromARGB(255, 255, 255, 255),
                //           borderRadius: BorderRadius.circular(500),
                //         )),
                //     GestureDetector(
                //       onTap: () {
                //         // pickUploadProfilePic();
                //       },
                //       child: Container(
                //           child: Icon(
                //             Icons.edit,
                //             color: Colors.white,
                //           ),
                //           width: w * 0.1,
                //           height: w * 0.1,
                //           decoration: BoxDecoration(
                //             color: Color.fromARGB(255, 18, 1, 96),
                //             borderRadius: BorderRadius.circular(500),
                //           )),
                //     )
                //   ],
                // ),

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
                            fontSize: 18,
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
                      "اسم الاختبار:",
                      style: GoogleFonts.tajawal(
                        fontSize: 18,
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
                SingleChildScrollView(
                    child:

                        ////description limit the charcter numbers
                        Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "التصنيف:",
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
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
                              return DropdownButton<dynamic>(
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
                                    // print(selectedCategory);
                                  });
                                },
                                value: selectedCategory,
                                isExpanded: true,
                                hint: Text(
                                    "اختر تصنيف ...                                                 ",
                                    style: GoogleFonts.tajawal(
                                        fontSize: 15,
                                        color: const Color.fromARGB(
                                            131, 18, 1, 96))),
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
                          fontSize: 18,
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
                        'نوع الاختبار :',
                        style: GoogleFonts.tajawal(
                          fontSize: 18,
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
                            title: const Text("مجدول  "),
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
                            title: const Text("مباشر "),
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "عدد المحاولات:",
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
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
                              List<DropdownMenuItem> attempts = [];
                              for (int i = 1; i <= 10; i++) {
                                attempts.add(DropdownMenuItem(
                                  value: i,
                                  child: Text(i.toString()),
                                ));
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<dynamic>(
                                    items: attempts,
                                    iconSize: 30,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 19, 1, 96),
                                    ),
                                    onChanged: (attemptsValue) {
                                      setState(() {
                                        selectedattempts = attemptsValue;
                                        attemController.text =
                                            attemptsValue.toString();
                                        // print(attemptsValue);
                                      });
                                    },
                                    value: selectedattempts,
                                    isExpanded: false,
                                    hint: Text(" اختر عدد",
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

                    //deadline
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          " موعد التسليم:",
                          style: GoogleFonts.tajawal(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 19, 1, 96),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLength: 20,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Maximum Deadline is required!';
                                } else {
                                  return null;
                                }
                              },
                              controller: dateController,
                              decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  counterText: "",
                                  icon: const Icon(Icons.calendar_today,
                                      color: Color.fromARGB(255, 19, 1, 96),
                                      size: 30.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Color.fromARGB(179, 252, 162,
                                              77), // header background color
                                          onSurface: Color.fromARGB(255, 19, 1,
                                              96), // header text color
                                          onPrimary: Color.fromARGB(255, 19, 1,
                                              96), // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: const Color.fromARGB(
                                                255,
                                                192,
                                                181,
                                                250), // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  // String formattedDate =
                                  //     DateFormat("yyyy-MM-dd")
                                  //         .format(pickedDate);

                                  setState(() {
                                    dateController.text =
                                        (pickedDate.toString())
                                            .substring(0, 10);
                                    //formattedDate.toString();
                                  });
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          // SizedBox(
                          //   height: 6,
                          // ),

                          Visibility(
                              visible: questions.isNotEmpty,
                              child: questions.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          Text(
                                            " الأسئلة:",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: const Color.fromARGB(
                                                  255, 19, 1, 96),
                                            ),
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: questions.length,
                                              itemBuilder: (context, index) {
                                                index++;
                                                title = questions['$index']
                                                    ['title'];
                                                time =
                                                    questions['$index']['time'];
                                                score = questions['$index']
                                                        ['score']
                                                    .toString();
                                                // print(index);
                                                // print(questions.length);

                                                int cLetters =
                                                    questions['$index']['title']
                                                        .toString()
                                                        .length;
                                                return GestureDetector(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    height: 40,
                                                    width: 30,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              blurRadius: 20,
                                                              offset:
                                                                  const Offset(
                                                                      1, 1),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.26))
                                                        ]),
                                                    //color: Colors.white,
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 6),
                                                        SizedBox(
                                                            width: 150,
                                                            child: Text(
                                                              '-$index$title',
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .tajawal(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    19,
                                                                    1,
                                                                    96),
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                            width: 25),
                                                        // Padding(
                                                        //     padding: EdgeInsets.only(
                                                        //         left: 5, right: 80),
                                                        //     child:
                                                        Text(
                                                          time,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255, 19, 1, 96),
                                                          ),
                                                          //)
                                                        ),
                                                        const Icon(
                                                          Icons.timer_sharp,
                                                          color:
                                                              Color(0xFF130160),
                                                          size: 18,
                                                        ),
                                                        const SizedBox(
                                                            width: 25),
                                                        Text(
                                                          score,
                                                          style: GoogleFonts
                                                              .tajawal(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255, 19, 1, 96),
                                                          ),
                                                        ),
                                                        const Icon(
                                                          IconData(0xe22c,
                                                              fontFamily:
                                                                  'MaterialIcons'),
                                                          color:
                                                              Color(0xFF130160),
                                                          size: 18,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    // print(questions);
                                                    if (index > 0) {
                                                      await Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CreateQuestion(
                                                                    //pin: PIN,
                                                                    id: index,
                                                                    questions:
                                                                        questions,
                                                                  )));
                                                    }
                                                    setState(() {
                                                      title =
                                                          questions['$index']
                                                              ['title'];
                                                      time = questions['$index']
                                                          ['time'];
                                                      score =
                                                          questions['$index']
                                                                  ['score']
                                                              .toString();
                                                    });
                                                  },
                                                );
                                              })
                                        ])
                                  : Container())
                        ])) //;
                    // }))
                    ,

                    Container(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        minWidth: 60,
                        height: 40,
                        onPressed: () async {
                          // if (catController.text.isEmpty ||
                          //     result == null ||
                          //     !(_formKey.currentState!.validate())) {
                          //   ShowAlert();
                          //   return;
                          // } else {
                          //   // await uploadFile();
                          //   bool Nunique = true;
                          //   while (Nunique && !created) {
                          //     int randomNumber = Random().nextInt(9999) + 1000;
                          //     PIN = '1${randomNumber}';
                          //     QuerySnapshot<Map<String, dynamic>> _pinstream =
                          //         await FirebaseFirestore.instance
                          //             .collection('quiz')
                          //             .where('pin', isEqualTo: PIN)
                          //             .get();

                          //     if (_pinstream.size == 0) {
                          //       Nunique = false;
                          //     }
                          //   }
                          //   Timestamp date = Timestamp.now();
                          //   if (!created) {
                          //     getCurrentUser();

                          //     final req = Request(
                          //         uid: uemail,
                          //         name: nameController.text,
                          //         accessLevel: val1,
                          //         category: catController.text,
                          //         attempts: attemController.text,
                          //         type: val2,
                          //         pin: PIN);

                          //     // RequestLabel(req);
                          //     // final _request = FirebaseFirestore.instance
                          //     //     .collection('quiz')
                          //     //     .doc();

                          //     final json = req.toJson();
                          //     await _request.set(json);
                          //     created = true;
                          //   }
                          //   // Navigator.push(
                          //   //     context,
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) => SuccessRequest()));

                          // }
                          // print(questions.length);
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateQuestion(
                                    //pin: PIN,
                                    id: questions.length + 1,
                                    questions: questions,
                                  )));
                          setState(() {
                            if (questions.isNotEmpty) {
                              int i = questions.length;
                              title = questions['$i']['title'];
                              time = questions['$i']['time'];
                              score = questions['$i']['score'].toString();
                            }
                          });
                        },
                        color: const Color.fromRGBO(255, 205, 77, 1),
                        elevation: 0,
                        shape: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 205, 77, 1),
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("إضافة سؤال ",
                            style: GoogleFonts.tajawal(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 19, 1, 96),
                                fontWeight: FontWeight.bold)),
                      ),
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
                              !(_formKey.currentState!.validate()) ||
                              questions.isEmpty) {
                            ShowAlert();
                            return;
                          } else {
                            // await uploadFile();
                            bool Nunique = true;
                            while (Nunique) {
                              int randomNumber = Random().nextInt(9999) + 1000;
                              PIN = '1$randomNumber';
                              QuerySnapshot<Map<String, dynamic>> pinstream =
                                  await FirebaseFirestore.instance
                                      .collection('quiz')
                                      .where('pin', isEqualTo: PIN)
                                      .get();

                              if (pinstream.size == 0) {
                                Nunique = false;
                              }
                            }
                            Timestamp date = Timestamp.now();

                            getCurrentUser();
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImages =
                                referenceRoot.child('Quiz images');

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
                              category: catController.text,
                              attempts: attemController.text,
                              type: val2,
                              pin: PIN,
                              questionsNum: questions.length,
                              img: imageUrl,
                              deadline: dateController.text,
                            );

                            RequestLabel(req);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SuccessRequest()));
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GenerateQR(PIN)
                              // AnswerQuestion(
                              //       pin: "110525",
                              //       id: 1,
                              //     )
                              ));
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
                ))
              ],
            )),
          ),
        ),
      ),
    );
  }

  Future RequestLabel(Request req) async {
    final request = FirebaseFirestore.instance.collection('quiz').doc(PIN);

    final json = req.toJson();
    await request.set(json);
    for (int i = 1; i <= questions.length; i++) {
      request.collection("questions").doc('$i').set(questions['$i']);
    }
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

  //            void pickUploadProfilePic() async{

  //     try {
  //     XFile?  image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image != null){
  //     var pickedfilename = image.name;
  //       if(image == null) return;
  //       print('ref');
  //       Reference ref = FirebaseStorage.instance.ref().child("files/$pickedfilename");
  //       print(ref);
  //       await ref.putFile(File(image.path));
  //        print(ref);
  //       ref.getDownloadURL().then((value){
  //       print(value);
  //       setState(() {
  //          profilePicLink = value;
  //          profilePic= profilePicLink;

  //     });

  //     });}

  //   } on PlatformException catch(e) {
  //     print('Failed to pick image: $e');

  //   }

  // }

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
  late String id;
  late String uid;
  late String name;
  late String category;
  late int accessLevel;
  late String attempts;
  late int type;
  late String pin;
  late int questionsNum;
  late String img;
  late String deadline;
  Request(
      {required this.uid,
      required this.name,
      required this.category,
      required this.accessLevel,
      required this.attempts,
      required this.type,
      required this.pin,
      required this.questionsNum,
      required this.img,
      required this.deadline});

  Map<String, dynamic> toJson() => {
        'ownerId': uid,
        'name': name,
        'category': category,
        'accessLevel': accessLevel,
        'numberOfAttempt': attempts,
        'type': type,
        'pin': pin,
        'questions number': questionsNum,
        'img': img,
        'deadline': deadline
      };
}
