import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherAddCoursePage extends StatefulWidget {
  const TeacherAddCoursePage({Key? key}) : super(key: key);

  @override
  State<TeacherAddCoursePage> createState() => _TeacherAddCoursePageState();
}

class _TeacherAddCoursePageState extends State<TeacherAddCoursePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController courseDaysController = TextEditingController();
  TextEditingController courseTimesController = TextEditingController();
  TextEditingController courseSeatsController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();

  addcourse() async {
    CollectionReference _mainCollection = _firestore.collection('courses');
    DocumentReference documentReferencer = _mainCollection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "name": courseNameController.text,
      "description": courseDescriptionController.text,
      "days": courseDaysController.text,
      "times": courseTimesController.text,
      "seats": courseSeatsController.text,
      "price": coursePriceController.text,
      'teacher': FirebaseAuth.instance.currentUser!.uid
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Course data added to the database"))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back")),
              SizedBox(
                height: 30.0,
              ),
              Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: courseNameController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Name',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Name";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: courseDescriptionController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Description',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Description";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: courseDaysController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Days',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Days";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: courseTimesController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Times',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Times";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: courseSeatsController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Seats',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Seats";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: coursePriceController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Course Price',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Course Price";
                            }
                          }),
                      SizedBox(
                        height: mq.height * 0.15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addcourse();
                        },
                        child: Text(
                          'SUBMIT',
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
