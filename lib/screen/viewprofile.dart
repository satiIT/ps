//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/booking.dart';
import 'package:ps/screen/recordList.dart';
import 'package:ps/screen/viewrecord.dart';
import 'package:ps/screen/viewvBookingPaiten.dart';

var id;

class viewprofile extends StatefulWidget {
  //const viewprofile({Key? key}) : super(key: key);
  viewprofile(t) {
    id = t;
    print(id);
  }

  @override
  State<viewprofile> createState() => _viewprofileState();
}

class _viewprofileState extends State<viewprofile> {
  s() {
    setState(() {
      id;
    });
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('idNumber', isEqualTo: int.parse(id))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("profile")),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                    'Something went wrong   ' + snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.data == null) {
                return Text("No Data");
              }
              return Container(
                child: Center(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      String s = document.id;
                      // ignore: avoid_print
                      print(s);
                      return Container(
                          width: 10,
                          //       height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          //  color: Colors.blue,

                            // color: Color.fromARGB(255, 169, 170, 171)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 50),
                                Container(
                                  height: 45,
                                  width: 500,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      data['firstName'] +
                                          ' ' +
                                          data['secondName'] +
                                          ' ' +
                                          data['thirdName'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 500,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'Brith Date : ' +
                                          data['birthDate'].toDate().toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    height: 45,
                                    width: 500,
                                    //color: Colors.amber,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Center(
                                        child: Text(
                                      data['gender'],
                                      style: TextStyle(fontSize: 20),
                                    ))),
                                SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 500,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'Height : ' + data['height'].toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 500,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'Weight : ' + data['weight'].toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 500,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      'blod Type : ' + data['blodType'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 200),
                                Container(
                                  height: 45,
                                  width: 300,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  viewRecord(s)));
                                    },
                                    child: Text("View Record Lis",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 300,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<String>(
                                              builder: (context) => booking(data['idNumber'].toString(), data['firstName'] +
                                          ' ' +
                                          data['secondName'] +
                                          ' ' +
                                          data['thirdName'])));
                                    },
                                    child: Text("booking",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                  SizedBox(height: 10),
                                Container(
                                  height: 45,
                                  width: 300,
                                  //color: Colors.amber,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<String>(
                                              builder: (context) =>viewBookingForPatien(data['idNumber']) ));},
                                    
                                    child: Text("View Booking",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
//nam5 (us-central)