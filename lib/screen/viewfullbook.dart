import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late String docID;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('booking')
    .where('__name__', isEqualTo: docID)
    .snapshots();

class viewfullbook extends StatefulWidget {
  //const viewfullbook({Key? key}) : super(key: key);
  viewfullbook(id) {
    docID = id;
  }
  @override
  State<viewfullbook> createState() => _viewfullbookState();
}

class _viewfullbookState extends State<viewfullbook> {
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
