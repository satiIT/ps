import 'dart:io';

import 'package:flutter/material.dart';
import '/screen/dmain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class doctorLogin extends StatefulWidget {
  const doctorLogin();

  @override
  State<doctorLogin> createState() => _doctorLoginState();
}

class _doctorLoginState extends State<doctorLogin> {
  late bool c;
  TextEditingController dID = TextEditingController();
  TextEditingController password = TextEditingController();
  void showsnakbar(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a),
      duration: Duration(milliseconds: 500),
    ));
  }

  Future<bool> internet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        c = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      c = false;
    }
    print(c);
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Login")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //    padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            width: 300,

            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                labelText: "Email",
                //           icon: Icon(Icons.person)
              ),
              controller: dID,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            //    padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            width: 300,

            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'password',
                labelText: "password",
                //  icon: Icon(Icons.password)
              ),
              controller: password,
              obscureText: true,
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () async {
                  if (dID.text.isEmpty) {
                    showsnakbar("Enter ID");
                  } else if (password.text.isEmpty) {
                    showsnakbar("Enter password");
                  } else {
                    bool s = await internet(context);
                    print(s);
                    if (s == true) {
                      print('dataaaaa');
                      try {
                        CircularProgressIndicator();
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: dID.text, password: password.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  dMain(dID.text)));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password' ||
                            e.code == 'user-not-found') {
                          // print('Wrong password provided for that user.');
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('varification Error'),
                                content: SingleChildScrollView(
                                  child: Text('wrong username or password'),
                                  //   Text('Would you like to approve of this message?'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      //       dID.clear();
                      password.clear();
                    } else if (s == false) {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Network Error'),
                            content: SingleChildScrollView(
                              child: Text('cheak your Enternet connecation'),
                              //   Text('Would you like to approve of this message?'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text("login")),
          ),
        ],
      )),
    );
  }
}
