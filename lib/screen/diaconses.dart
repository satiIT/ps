import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

var id, oid;

class diagnoses extends StatefulWidget {
  //const diagnoses({Key? key}) : super(key: key);
  record(d, s) {
    id = d;
    oid = s;
    print(id);
  }

  @override
  State<diagnoses> createState() => _diagnosesState();
}

class _diagnosesState extends State<diagnoses> {
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
              return Text("Loading");
            }

            return Center(
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Center(
                    child: Column(
                      children: [
                        Text(data['illnessName']),
                        data['digimg'] == null
                            ? Text("No Imges ")
                            : Container(
                                height: 300,
                                width: 200,
                                child: ListView.builder(
                                  itemCount: data['digimg'].length,
                                  itemBuilder: (context, index) {
                                    List s = data['digimg'];
                                    //  print(s[0]);
                                    return Image.network(s[index]);
                                  },
                                ),
                              )
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
