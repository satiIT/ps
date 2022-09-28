import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/viewfullbook.dart';
import 'package:ps/screen/viewfullbookpai.dart';

late int ide;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('booking')
    .where('patienID', isEqualTo: ide)
    .snapshots();

class viewBookingForPatien extends StatefulWidget {
  //const viewBookingForPatien({Key? key}) : super(key: key);
  viewBookingForPatien(int i) {
    ide = i;
  }
  @override
  State<viewBookingForPatien> createState() => _viewBookingForPatienState();
}

class _viewBookingForPatienState extends State<viewBookingForPatien> {
  se() {
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('booking')
          .where('patienID', isEqualTo: ide)
        //  .where('date', isEqualTo: DateTime.now())
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
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      viewFullBookpai(document.id, ide))));
                        }),
                        child: Container(
                          height: 60,
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
                                  data['hospitalName'],
                                  style: TextStyle(color: Colors.black,fontSize: 20),
                                ),
                                Text(
                                  data['date'].toDate().toString(),
                                  style: TextStyle(color: Colors.black,fontSize: 20),
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
