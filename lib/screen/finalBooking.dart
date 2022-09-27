import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/booking.dart';
import 'package:ps/screen/viewprofile.dart';

CollectionReference booking = FirebaseFirestore.instance.collection('booking');

late String hosptial, doctor, pid, pname, email;
late int hid;

class finalBooking extends StatefulWidget {
  // const finalBooking({Key? key}) : super(key: key);

  finalBooking(String h, String d, String p, String n, String e, int hd) {
    hosptial = h;
    doctor = d;
    print(doctor);
    pid = p;
    pname = n;
    email = e;
    hid = hd;
  }

  @override
  State<finalBooking> createState() => _finalBookingState();
}

class _finalBookingState extends State<finalBooking> {
  Future<bool> internet(BuildContext context) async {
    late bool v;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        v = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      v = false;
    }
    return v;
  }

  void c() async {
    await FirebaseFirestore.instance
        .collection('booking')
        .where('patienID', isEqualTo: int.parse(pid))
        .where('doctorName', isEqualTo: doctor)
        .where('hospitalName', isEqualTo: hosptial)
        .where('hospitalID', isEqualTo: hid)
        // .where('date',isGreaterThanOrEqualTo: DateTime.now())
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        // return true;
        //  addUser();

        print('we have same id');
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Data Error'),
              content: SingleChildScrollView(
                child: Text('Same booking was found !'),
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
      } else if (value.docs.isEmpty) {
        // return false;
        b(context);
      }
    });
  }

  Future<void> b(BuildContext context) {
    // Call the user's CollectionReference to add a new user

    return booking.add({
      'hospitalID': hid,
      'hospitalName': hosptial,
      'doctorEmail': email,
      'doctorName': doctor,
      'patienID': int.parse(pid),
      'patientName': pname,
      'date': DateTime.now()
      //   'dffgfg':false
    }).then((value) {
      print("User Added");
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Scusesfull opration'),
              content: SingleChildScrollView(
                child: Text('booking Added scusesfully !'),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('ok'),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewprofile(pid)));
                  },
                ),
              ],
            );
          });
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Booking")),
        body: Column(
          children: [
            SizedBox(height: 10),
            Center(
              child: Container(
                  height: 45,
                  width: 350,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    'Hospital  :  ' + hosptial,
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  height: 45,
                  width: 350,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    'Doctor  :  ' + doctor,
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  height: 45,
                  width: 350,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    'Patient ID  :  ' + pid,
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  height: 45,
                  width: 350,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    'Patient Name  :  ' + pname,
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                  height: 45,
                  width: 350,
                  //color: Colors.amber,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text(
                    DateTime.now().toString(),
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool q = await internet(context);
            if (q == true) {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(''),
                    content: SingleChildScrollView(
                      child: Center(child: CircularProgressIndicator()),
                      //   Text('Would you like to approve of this message?'),
                    ),
                    actions: <Widget>[],
                  );
                },
              );
              c();
            }
            else{
           return   showDialog<void>(
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
          child: const Icon(Icons.add),
        ));
  }
}
