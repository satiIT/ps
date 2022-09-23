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
  Future<void> b(BuildContext context) {
    // Call the user's CollectionReference to add a new user

    return booking.add({
      'hospitalID': hid,
      'hospitalName': hosptial,
      'doctorEmail': email,
      'doctorName':doctor,
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
          onPressed: () {
            b(context);
          },
          child: const Icon(Icons.add),
        ));
  }
}
