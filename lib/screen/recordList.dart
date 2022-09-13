import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/screen/updaterecord.dart';

final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('users/6xBMihdjEoPVuNFrnLNS/record')
    .snapshots();

class recordList extends StatefulWidget {
  const recordList({Key? key}) : super(key: key);

  @override
  State<recordList> createState() => _recordListState();
}

class _recordListState extends State<recordList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("record List")),
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
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: InkWell(
                          child: Container(
                              height: 45,
                              width: 500,
                              //color: Colors.amber,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 147, 95, 237),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(data['illnessName'])),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const updateRecord()));
                          }),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }
}
