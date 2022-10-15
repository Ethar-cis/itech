import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itech/screens/home/course_details_students.dart';
import 'package:itech/screens/home/home_teacher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readCourses() {
    CollectionReference _mainCollection = _firestore.collection('courses');
    CollectionReference _bookingCollection = _firestore.collection('booking');

    _bookingCollection.snapshots().forEach((book) {
      book.docs.forEach((val2) {
        _mainCollection.snapshots().forEach((element) {
          element.docs.forEach((val) {
            print("Element => ${val.id}");
            setState(() {
              if (user != null &&
                  val2['studentId'] == user!.uid &&
                  val2['courseId'] == val.id) {
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
              }
            });
          });
        });
      });
    });

    return _mainCollection.snapshots();
  }

  User? user;
  QueryDocumentSnapshot<Object?>? userInfo;
  List<Course> coursesList = [];

  Stream<QuerySnapshot> readTeacherInfo() {
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
    readTeacherInfo();
    readCourses();
    if (user == null) {
      print('NO USER!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Back")),
                    Spacer(),
                    Text("Profile"),
                    Spacer(),
                  ],
                ),
                Text("Contact Informatio"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Email: " +
                              (userInfo != null
                                  ? "${userInfo!.get('email')}"
                                  : "-")),
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Courses:"),
                SizedBox(
                  height: 20,
                ),
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
                                        isHome: false,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}
