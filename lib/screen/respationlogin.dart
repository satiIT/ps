import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/viewbookingres.dart';

TextEditingController doctorEmail = TextEditingController();
TextEditingController hospitalID = TextEditingController();

Future<bool> internet(BuildContext context) async {
  late bool c;

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
  return c;
}

class respationlogin extends StatefulWidget {
  const respationlogin({Key? key}) : super(key: key);

  @override
  State<respationlogin> createState() => _respationloginState();
}

class _respationloginState extends State<respationlogin> {
  void c() async {
    int i = 0;

    await FirebaseFirestore.instance
        .collection('booking')
        .where('hospitalID', isEqualTo: int.parse(hospitalID.text))
        .where('doctorEmail', isEqualTo: doctorEmail.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // return true;
        //  addUser();
      
        print(' Not found');
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Data Error'),
              content: SingleChildScrollView(
                child: Text(' Data Not found !'),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (value.docs.isNotEmpty) {
        // return false;
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => viewBookingRes(doctorEmail.text,hospitalID.text)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Respation login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Doctor Email',
                  labelText: "Doctor Email",
                  //      icon: Icon(Icons.person)
                  //
                ),
                controller: doctorEmail,
                //   keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hospital ID',
                  labelText: "Hospital ID",
                  //      icon: Icon(Icons.person)
                  //
                ),
                controller: hospitalID,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            TextButton(
                onPressed: () async {
                  bool s = await internet(context);
                  if (s == true) {
                      showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(''),
                                content: SingleChildScrollView(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                  //   Text('Would you like to approve of this message?'),
                                ),
                                actions: <Widget>[],
                              );
                            },
                          );
                    c();
                  }
                     if (s == false) {
                          print('show dig');
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Network Error'),
                                content: SingleChildScrollView(
                                  child:
                                      Text('cheak your Enternet connecation'),
                                  //   Text('Would you like to approve of this message?'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
