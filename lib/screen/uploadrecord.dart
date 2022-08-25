import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ps/classes/picList.dart';
import 'package:ps/screen/cameraPage.dart';
import 'package:ps/screen/newre.dart';
import 'package:ps/wiedgts/iamgesviwe.dart';

TextEditingController illness = TextEditingController();
TextEditingController hospital = TextEditingController();
TextEditingController diagnoses = TextEditingController();
TextEditingController medicine = TextEditingController();
TextEditingController comment = TextEditingController();
late List<String> diagnosesList = ['a'];
late List<String> medicineList = ['b'];
var id;

class uploadRecord extends StatefulWidget {
  // const uploadRecord({Key? key}) : super(key: key);

  uploadRecord(j) {
    id = int.parse(j);
    print(id);
  }
  @override
  State<uploadRecord> createState() => _uploadRecordState();
}
/* 
@override
void initState() {
  // super.initState();
  diagnosesList;
  medicineList;
} */

//CollectionReference users =  FirebaseFirestore.instance.collection('users/dnKK4bdwLbMlkJLZ6s75/record');
int ddd = 2;
Future<void> addUser() async {
  final query = await FirebaseFirestore.instance
      .collection('users')
      .where('idNumber', isEqualTo: id)
      .get();
  if (query.docs.length > 0) {
    final documentId = query.docs[0].id;
    print(documentId);

    CollectionReference u =
        FirebaseFirestore.instance.collection('users/$documentId/record');

    // Call the user's CollectionReference to add a new user record
    return u
        .add({
          'illnessName': illness.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class _uploadRecordState extends State<uploadRecord> {
  void showsnakbar(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a),
      duration: Duration(milliseconds: 500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("upload")),
        body: ListView(
          children: [
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'IllnessName',
                  labelText: "Illness",
                  //           icon: Icon(Icons.person)
                ),
                //   controller: illness,
                controller: illness,
                //  keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hospital Name',
                  labelText: "Hospital Name",
                  //           icon: Icon(Icons.person)
                ),
                controller: hospital,
                //   keyboardType: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.amber),
              ),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Diagnoses Name:',
                      labelText: "Diagnoses",
                    ),
                    controller: diagnoses,
                    //  keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (diagnoses.text.isEmpty) {
                        showsnakbar('write diagnoses');
                      } else {
                        setState(() {
                          diagnosesList.add(diagnoses.text);
                        });
                      }
                    },
                    icon: Icon(Icons.add)),

                //

                //   if (diagnosesList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    height: 150,
                    child: diagnosesList.isEmpty
                        ? Text('Empty')
                        : ListView.builder(
                            itemCount: diagnosesList.length,
                            itemBuilder: ((context, index) {
                              if (diagnosesList == null)
                                return Text("Empty List");
                              else if (index == 0)
                                return Text("");
                              else
                                return Card(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(diagnosesList[index]),
                                        IconButton(
                                            onPressed: () async {
                                              await availableCameras().then(
                                                (value) => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageUploads(),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.camera)),
                                        //      pictureList!.isEmpty?
                                        //    imgview(index)

                                        //   :Text('No photos')
                                      ]),
                                );
                              ;
                            })),
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Color.fromARGB(255, 179, 31, 12))),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Medicine Name',
                      labelText: "Medicines",
                      //           icon: Icon(Icons.person)
                    ),
                    controller: medicine,
                    //   keyboardType: TextInputType.number,
                  ),

                  IconButton(
                      onPressed: () {
                        if (medicine.text.isEmpty) {
                          showsnakbar('write medicine');
                        } else {
                          setState(() {
                            medicineList.add(medicine.text);
                          });
                        }
                      },
                      icon: Icon(Icons.add)),

                  //

                  //    if (diagnosesList.isNotEmpty)

                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Container(
                      height: 80,
                      child: medicineList.isEmpty
                          ? Text('Empty')
                          : ListView.builder(
                              itemCount: medicineList.length,
                              itemBuilder: ((context, index) {
                                if (medicineList.isEmpty)
                                  return Text('Empty');
                                else if (index == 0)
                                  return Text("");
                                else
                                  return ListTile(
                                      title: Text(medicineList[index]));
                              })),
                    ),
                  ),
                ],
              ),
            ),
            Card(
                color: Color.fromRGBO(255, 254, 229, 1),
                child: Row(
                  children: [
                    Text("Chronic :"),
                    Checkbox(value: false, onChanged: null),
                  ],
                )),
            Card(
                color: Color.fromRGBO(255, 254, 229, 1),
                child: Row(
                  children: [
                    Text("Surgery :"),
                    Checkbox(value: false, onChanged: null),
                  ],
                )),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Comment',
                  labelText: "Comment",
                  //           icon: Icon(Icons.person)
                ),
                controller: comment,
                //   keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (illness.text.isEmpty) {
              showsnakbar('illness Name is empty');
            } else if (hospital.text.isEmpty) {
              showsnakbar('hosptial Name is empty');
            } else {
              addUser();
            }
          },
          tooltip: 'add record',
          child: const Icon(Icons.add),
        ));
  }
}
