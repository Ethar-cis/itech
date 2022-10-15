import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itech/screens/home/home_teacher.dart';

class RegisterTeacherPage extends StatefulWidget {
  const RegisterTeacherPage({Key? key}) : super(key: key);

  @override
  State<RegisterTeacherPage> createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> registerTeacherFormKey = GlobalKey<FormState>();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<bool> registerTeacher() async {
    final User? user = (await auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      CollectionReference _mainCollection = _firestore.collection('teachers');
      DocumentReference documentReferencer =
          _mainCollection.doc(user.uid).collection('info').doc();
      Map<String, dynamic> data = <String, dynamic>{
        "fullname": fullnameController.text,
        "email": emailController.text,
        "location": locationController.text,
        "phoneNumber": phoneNumberController.text,
        "image":
            "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
      };
      await documentReferencer
          .set(data)
          .whenComplete(() => print("Teaacher data added to the database"))
          .catchError((e) => print(e));
      user.updateDisplayName(fullnameController.text);
      user.updatePhotoURL(
          "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png");

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                      text: TextSpan(
                          text: "Back",
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            }),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png")),
                  Positioned(
                    child: InkWell(
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(1, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.blue,
                            size: 23,
                          )),
                      onTap: () {},
                    ),
                    left: 65.0,
                    top: 65.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                  key: registerTeacherFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          controller: fullnameController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Fullname',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: emailController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            var pattern =
                                r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern);
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            } else if (!regex.hasMatch(value)) {
                              return "Not Valid Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          controller: locationController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.start,
                          controller: phoneNumberController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          controller: confirmPasswordController,
                          obscureText: true,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 22),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty || value == null) {
                              return "Please Enter You\'r Email";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.1,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          registerTeacher().then((value) {
                            if (value == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeTeacherPage()),
                                  (route) => false);
                            }
                          });
                        },
                        child: Text(
                          'SIGN UP',
                          style: const TextStyle(fontSize: 27),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          )),
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.width / 7.5)),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
