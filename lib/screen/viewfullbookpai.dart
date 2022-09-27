import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/viewvBookingPaiten.dart';

late int ide;
late String docID;
late bool v;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('booking')
    .where('__name__', isEqualTo: docID)
    .snapshots();

class viewFullBookpai extends StatefulWidget {
  //const viewFullBookpai({Key? key}) : super(key: key);
  viewFullBookpai(String i, int id) {
    docID = i;
    ide = id;
    print(docID);
  }

  @override
  State<viewFullBookpai> createState() => _viewFullBookpaiState();
}

class _viewFullBookpaiState extends State<viewFullBookpai> {
  CollectionReference boo = FirebaseFirestore.instance.collection('booking');

  c() {
    boo.doc(docID).delete().then((value) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('sucsesfull opration'),
            content: SingleChildScrollView(
              child: Text('booking deleted !'),
              //   Text('Would you like to approve of this message?'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  viewBookingForPatien(ide))))
                      .then((value) => setState(() => {}));
                },
              ),
            ],
          );
        },
      );
    }).catchError((error) => print(error.toString()));
  }

  Future<bool> internet(BuildContext context) async {
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

  se() {
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('booking')
          .where('__name__', isEqualTo: docID)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    se();
    return Scaffold(
      appBar: AppBar(title: Text('booking view')),
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
            if (snapshot.hasData == null) {
              return Text('No Data');
            }

            return Center(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return

                      //   SizedBox(height: 15,),
                      Column(
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'hospital Name : ' + data['hospitalName'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        width: 350,
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Doctor Name  :  ' + data['doctorName'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        width: 350,
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'patien Name  :  ' + data['patientName'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        width: 350,
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Date  :  ' + data['date'].toDate().toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),

                      Container(
                          child: Center(
                        child: TextButton(
                            child: Icon(Icons.delete),
                            onPressed: (() async {
                              bool s = await internet(context);
                              if (s == true) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(''),
                                      content: SingleChildScrollView(
                                        child: Text(
                                            'are you sure to delete the booking '),
                                        //   Text('Would you like to approve of this message?'),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('ok'),
                                          onPressed: () {
                                            c();
                                            Navigator.of(context).pop();

                                          },
                                        ),
                                        TextButton(
                                          child: const Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              
                              } else if (s == false) {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Network Error'),
                                      content: SingleChildScrollView(
                                        child: Text(
                                            'cheak your Enternet connecation'),
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
                            })),
                      ))
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
