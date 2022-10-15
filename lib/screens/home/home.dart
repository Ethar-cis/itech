import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itech/screens/auth/login.dart';
import 'package:itech/screens/home/course_details_students.dart';
import 'package:itech/screens/home/home_teacher.dart';
import 'package:itech/screens/home/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  QueryDocumentSnapshot<Object?>? userInfo;
  List<Course> coursesList = [];

  Stream<QuerySnapshot> readCourses() {
    CollectionReference _mainCollection = _firestore.collection('courses');

    _mainCollection.snapshots().forEach((element) {
      element.docs.forEach((val) {
        print("Element => ${val.id}");
        setState(() {
          coursesList.add(Course(
            name: val['name'],
            description: val['description'],
            days: val['days'],
            times: val['times'],
            seats: val['seats'],
            price: val['price'],
            teacherId: val['teacher'],
            courseId: val.id,
          ));
        });
      });
    });

    return _mainCollection.snapshots();
  }

  Stream<QuerySnapshot> readStudentInfo() {
    CollectionReference _mainCollection = _firestore.collection('students');
    CollectionReference notesItemCollection =
        _mainCollection.doc(user!.uid).collection('info');

    notesItemCollection.snapshots().forEach((element) {
      print(element.docs.first.get("fullname"));
      setState(() {
        userInfo = element.docs.first;
      });
    });

    return notesItemCollection.snapshots();
  }

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    readCourses();
    readStudentInfo();
    if (user == null) {
      print('NO USER!');
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
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userInfo != null
                            ? userInfo!.get("image")
                            : "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png")),
                  ),
                  SizedBox(width: 5.0),
                  Text(userInfo != null
                      ? userInfo!.get("fullname")
                      : "fullname"),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                      text: TextSpan(
                          text: "SIGN OUT",
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              auth.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Courses"),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: coursesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentCourseDetails(
                                      course: coursesList[index],
                                      isHome: true,
                                    )),
                          );
                          print(coursesList[index].name);
                        },
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                      "Course Name: ${coursesList[index].name}"),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Course Description: \n${coursesList[index].description}",
                                  )
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
