// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/finalBooking.dart';
import 'package:ps/screen/login.dart';

late String id, hospital, pid, pname;
late int hid;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('hospital/$id/doctors')
    //  .where('__name__', isEqualTo: id)
    .snapshots();

class doctorBooking extends StatefulWidget {
  // const doctorBooking({Key? key}) : super(key: key);
  doctorBooking(String d, String c, String p, String n, int hd) {
    hospital = c;
    print(hospital);
    pid = p;
    print(pid);
    pname = n;
    id = d;
    // print();
    hid = hd;
    print(hid);
    print(pname);
  }

  @override
  void initState() {
    //  super.initState();
    _usersStream;
  }

  @override
  State<doctorBooking> createState() => _doctorBookingState();
}

class _doctorBookingState extends State<doctorBooking> {
  se() {
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('hospital/$id/doctors')
          //  .where('__name__', isEqualTo: id)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    se();
    return Scaffold(
        appBar: AppBar(title: Text("Doctors List")),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Center(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    return

                        //   SizedBox(height: 15,),
                        InkWell(
                      onTap: () {
                        setState(() {
                          _usersStream;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => finalBooking(
                                    hospital,
                                    data['name'],
                                    pid,
                                    pname,
                                    data['email'] == null ? ' ' : data['email'],
                                    hid))).then((value) => setState(() => {}));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 45,
                            width: 350,
                            //color: Colors.amber,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                data['name'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }
}
