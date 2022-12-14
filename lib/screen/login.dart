import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/respationlogin.dart';
import 'package:ps/screen/viewprofile.dart';
import '/screen/newre.dart';
//import '/screen/ptabs.dart';
import 'doctorlogin.dart';

late bool c;
bool x = false;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
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
  return c;
}

class _loginState extends State<login> {
  TextEditingController id = TextEditingController();
  void showsnakbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter ID"),
      duration: Duration(milliseconds: 500),
    ));
  }

  void c() async {
    int i = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .where('idNumber', isEqualTo: int.parse(id.text))
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // return true;
        //  addUser();

        print('Id Not found');
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Data Error'),
              content: SingleChildScrollView(
                child: Text(' ID Not found !'),
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
            MaterialPageRoute(builder: (context) => viewprofile(id.text)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("PMS")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                //    padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: 300,

                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'ID',
                    labelText: "ID",
                    //      icon: Icon(Icons.person)
                    //
                  ),
                  controller: id,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () async {
                      x = true;
                      
                      if (id.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Enter ID"),
                          duration: Duration(milliseconds: 500),
                        ));
                      } else {
                        setState(() {
                          id.text;
                        });
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
                        //  id.clear();
                      }
                    },
                    child: Text("login")),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const newre()));
                    },
                    child: Text("New Registration?")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const doctorLogin()));
                    },
                    child: Text("Doctor")),
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const respationlogin()));
                },
                child: Text("respastion")),
          ],
        ),
      ),
    );
  }
}
