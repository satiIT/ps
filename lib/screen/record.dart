import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                child: Text(data['illnessName']),
              );
            }).toList(),
          ),
        );
      },
    ));
  }
}
