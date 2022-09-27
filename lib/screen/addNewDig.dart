import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/classes/diganosesClass.dart';
import 'package:ps/screen/cameraPage.dart';

//late List<String> diagnosesList = ['a'];
late String path, docID;
TextEditingController diagnoses = TextEditingController();
CollectionReference dig = FirebaseFirestore.instance.collection(path);
late List digName, digimg;
late int li;

class addNewdiag extends StatefulWidget {
  // const addNewdiag({Key? key}) : super(key: key);
  addNewdiag(String p, String dID, List dn, List s) {
    path = p;
    docID = dID;
    digName = dn;
    digimg = s;
    //  print(digimg[1]);
    print(docID);
    li = digName.length;
  }

  @override
  State<addNewdiag> createState() => _addNewdiagState();
}

class _addNewdiagState extends State<addNewdiag> {
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

  void showsnakbar(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a),
      duration: Duration(milliseconds: 500),
    ));
  }

  Future<void> addi() async {
    // for (int i = 1; i < diagnosesList.length; i++) {
    //    digName.add(diagnosesList[i]);
    //  }

    // dignosesClass.pic.remove(dignosesClass.pic[0]);
    for (int j = 1; j < dignosesClass.pic.length; j++) {
      digimg.add(dignosesClass.pic[j]);
    }
    return dig.doc(docID).update({'digimg': digimg}).then((value) {
      dig.doc(docID).update({'diagnoses': digName}).then((value) {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Scusesfull opration'),
                content: SingleChildScrollView(
                  child: Text('User Added scusesfully !'),
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
            });
      }).catchError((e) => print('erorr img  ' + e.toString()));
    }).catchError((e) => print('errr   ' + e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Daignoses "),
        ),
        body: Container(
          height: 500,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              width: 500,
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
                onPressed: () async {
                  if (diagnoses.text.isEmpty) {
                    showsnakbar('write diagnoses');
                  } else {
                    setState(() {
                      digName.add(diagnoses.text);
                      li = digName.length;
                    });
                    await availableCameras().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageUploads(),
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.add)),

            //

            //   if (diagnosesList.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                height: 350,
                child: digName.isEmpty
                    ? Text('Empty')
                    : ListView.builder(
                        itemCount: digName.length,
                        itemBuilder: ((context, index) {
                          if (digName == null)
                            return Text("Empty List");
                          //   else if (index == 0)
                          //   return Text("");
                          else
                            return Card(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 40,
                                        child: Center(
                                            child: Text(digName[index]))),
                                    //  index<=li-1?

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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (diagnoses.text.isEmpty) {
              showsnakbar('diagnoses Name is empty');
            } else {
              bool s = await internet(context);
              if (s == true) {
                // internet(context);
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
                addi();
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
                        child: Text('cheak your Enternet connecation'),
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
            }
          },
          tooltip: 'add record',
          child: const Icon(Icons.add),
        ));
  }
}
