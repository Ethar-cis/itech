import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itech/screens/auth/login_teacher.dart';
import 'package:itech/screens/auth/register.dart';
import 'package:itech/screens/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> login() async {
    try {
      final User? user = (await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RichText(
                      text: TextSpan(
                          text: "Teachers Login",
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginTeacherPage()),
                                  (route) => false);
                            }),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/logo.png',
                width: mq.width * 0.6,
              ),
              Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: emailController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 22),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: RichText(
                              text: TextSpan(
                                  text: "Forget Password?",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Forget Password Clicked!');
                                    }),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: mq.height * 0.15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          login().then((value) {
                            if (value == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            }
                          });
                        },
                        child: Text(
                          'SIGN IN',
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
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                        child: RichText(
                          text: TextSpan(
                              text: "New User? SIGN UP NOW",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()),
                                  );
                                }),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
