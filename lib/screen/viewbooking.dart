import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/viewfullbook.dart';

late String email;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('booking')
    .where('doctorEmail', isEqualTo: email)
    .snapshots();

class viewbooking extends StatefulWidget {
  // const viewbooking({Key? key}) : super(key: key);
  viewbooking(String e) {
    email = e;
  }

  @override
  State<viewbooking> createState() => _viewbookingState();
}

class _viewbookingState extends State<viewbooking> {
  se() {
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('booking')
          .where('doctorEmail', isEqualTo: email)
       //   .where('date', isEqualTo: DateTime.now())
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      viewfullbook(document.id)));
                        },
                        child: Container(
                          //height: 45,
                          width: 350,
                          //color: Colors.amber,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'pateint Name  :  ' + data['patientName'],
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'hospital  :  ' + data['hospitalName'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
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
