import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itech/screens/home/home_teacher.dart';

class TeaherCourseDetails extends StatefulWidget {
  const TeaherCourseDetails(
      {Key? key,
      required this.course,
      required this.isHome,
      required this.bookingId})
      : super(key: key);

  final Course course;
  final bool isHome;
  final String bookingId;

  @override
  State<TeaherCourseDetails> createState() => _TeaherCourseDetailsState();
}

class _TeaherCourseDetailsState extends State<TeaherCourseDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> changeBookingStatus(status) async {
    if (auth.currentUser != null) {
      CollectionReference _mainCollection = _firestore.collection('booking');
      DocumentReference documentReferencer =
          _mainCollection.doc(widget.bookingId);
      Map<String, dynamic> data = <String, dynamic>{
        'status': status ? 'accepted' : 'rejected',
      };
      await documentReferencer
          .update(data)
          .whenComplete(() => print("Booking data added to the database"))
          .catchError((e) => print(e));
    } else {
      print('user not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back")),
                Spacer(),
                Text(
                  widget.course.name!,
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("Course Description:"),
            SizedBox(
              height: 5.0,
            ),
            Text(widget.course.description!),
            SizedBox(
              height: 10.0,
            ),
            Text("Course Days:"),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Sunday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("0")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Monday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("1")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Tuesday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("2")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Wednesday",
                        style: TextStyle(fontSize: 5),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("3")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Thursday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("4")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Friday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("5")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
                  width: 5.0,
                ),
                Container(
                  height: 70,
                  width: 40,
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        "Sunday",
                        style: TextStyle(fontSize: 7),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 40,
                        decoration: BoxDecoration(
                          color: widget.course.days!.contains("6")
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
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
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Course Times:"),
            SizedBox(
              height: 5.0,
            ),
            Text(widget.course.times!),
            SizedBox(
              height: 10.0,
            ),
            Text("Available Seats:"),
            SizedBox(
              height: 5.0,
            ),
            Text(widget.course.seats! + " Seats"),
            SizedBox(
              height: 10.0,
            ),
            Text("Price:"),
            SizedBox(
              height: 5.0,
            ),
            Text(widget.course.price! + " JOD"),
            SizedBox(
              height: 10.0,
            ),
            !widget.isHome
                ? ElevatedButton(
                    onPressed: () {
                      changeBookingStatus(true);
                      print("Accept");
                    },
                    child: Text(
                      'ACCEPT',
                      style: const TextStyle(fontSize: 27),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      )),
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.width / 7.5)),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            !widget.isHome
                ? ElevatedButton(
                    onPressed: () {
                      changeBookingStatus(false);
                      print("Reject");
                    },
                    child: Text(
                      'REJECT',
                      style: const TextStyle(fontSize: 27),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      )),
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.width / 7.5)),
                    ),
                  )
                : Container()
          ]),
        ),
      ),
    );
  }
}
