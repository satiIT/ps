import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/addNewDig.dart';
import 'package:ps/screen/imgv.dart';
import 'package:ps/screen/updaterecord.dart';

var id, oid;

class record extends StatefulWidget {
  //const record({ Key? key }) : super(key: key);
  record(d, s) {
    id = d;
    oid = s;
    print(id);
  }

  @override
  State<record> createState() => _recordState();
}

class _recordState extends State<record> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users/$oid/record')
      .where('__name__', isEqualTo: id)
      //   .doc(id)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Record View ')),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return Center(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          child: Card(
                            //   color: Color.fromRGBO(255, 254, 229, 1),
                            child: Center(
                                child: Text(' Name OF Illness : ' +
                                    data['illnessName'],style: TextStyle(fontSize: 20))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          child: Card(
                            //    color: Color.fromRGBO(255, 254, 229, 1),
                            child: Center(
                                child: data['hospital'] == null
                                    ? Text('no Data')
                                    : Text('hospital  : ' + data['hospital'],style: TextStyle(fontSize: 20))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          child: Card(
                            //     color: Color.fromRGBO(255, 254, 229, 1),

                            child: Container(
                              height: 40,
                              child: Center(
                                  child: data['date'] == null
                                      ? Text('no Data')
                                      : Text('Date  : ' +
                                          data['date'].toDate().toString(),style: TextStyle(fontSize: 20))),
                            ),
                          ),
                        ),
                        data['digimg'] == null
                            ? Text("No Imges ")
                            : Container(
                                height: 300,
                                width: 200,
                                child: ListView.builder(
                                  itemCount: data['diagnoses'].length,
                                  itemBuilder: (context, index) {
                                    List s = data['digimg'];
                                    List n = data['diagnoses'];
                                    List m = data['medicine'];
                                    //  print(s[0]);
                                    return Column(
                                      children: [
                                        Container(
                                            height: 40,
                                            child: Card(
                                                child: Center(
                                                    child: Text(
                                              'Name Of Diagnoses : ' + n[index],
                                              style: TextStyle(fontSize: 20),
                                            )))),
                                        index >= s.length
                                            ? Text('No Images')
                                            : InkWell(
                                                child: Image.network(s[index]),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              imgv(s[index])));
                                                },
                                              ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Color.fromRGBO(255, 254, 229, 1),
                                      ],
                                    );
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Card(
                            child: Center(
                              ///     color: Color.fromRGBO(255, 254, 229, 1),
                              child: data['medicine'] == null
                                  ? Text('No Data',style: TextStyle(fontSize: 20),)
                                  : Text('Medicine : ' +
                                      data['medicine'].toString(),style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Card(
                            child: Center(
                                child: data['chronic'] == true
                                    ? Text('Chonic',style: TextStyle(fontSize: 20))
                                    : Text('')),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: data['surgery'] == true
                                  ? Text('Need surgery ',style: TextStyle(fontSize: 20))
                                  : Text(''),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => addNewdiag(
                                            'users/$oid/record',
                                            document.id,
                                            data['diagnoses'],
                                            data['digimg'])));
                              },
                              child: Text("add diagnoses")),
                        )
                        /*  ListView.builder(
                            itemCount: data['medicine'].length,
                            itemBuilder: (context, index) {
                              List c = data['medicine'];
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Card(
                                      color: Color.fromRGBO(255, 254, 229, 1),
                                      child: Center(
                                          child: c.isEmpty
                                              ? Text('no Data')
                                              : Text('Medicine : ' + c[index])),
                                    ),
                                  ),
                                ],
                              );
                            })*/
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
