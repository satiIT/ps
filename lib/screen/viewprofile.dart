//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/recordList.dart';
import 'package:ps/screen/viewrecord.dart';

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
              return Center(
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
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.amber),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Name : ' +
                                      data['firstName'] +
                                      ' ' +
                                      data['secondName'] +
                                      ' ' +
                                      data['thirdName'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Brith Date : ' + data['birthDate'].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                data['gender'] == true
                                    ? Text(
                                        'gender : ' + 'Male',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    : Text(
                                        'gender : ' + 'Female',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                Text(
                                  'Height : ' + data['height'].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Weight : ' + data['weight'].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'blod Type : ' + data['blodType'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                viewRecord(s)));
                                  },
                                  child: Text("View Record Lis"),
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