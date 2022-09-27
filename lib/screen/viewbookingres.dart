import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/viewfullbook.dart';

late String doctorEmail, hospitalID;
late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('booking')
    .where('doctorEmail', isEqualTo: doctorEmail)
    .where('hospitalID', isEqualTo: int.parse(hospitalID))
    .snapshots();

class viewBookingRes extends StatefulWidget {
  // const viewBookingRes({Key? key}) : super(key: key);

  viewBookingRes(String deml, String hid) {
    hospitalID = hid;
    doctorEmail = deml;
  }

  @override
  State<viewBookingRes> createState() => _viewBookingResState();
}

class _viewBookingResState extends State<viewBookingRes> {
  se() {
    setState(() {
      if (doctorEmail.isEmpty) {
        _usersStream = FirebaseFirestore.instance
            .collection('booking')
            //   .where('doctorEmail', isEqualTo: doctorEmail)
            .where('hospitalID', isEqualTo: int.parse(hospitalID))
            .snapshots();
      } else {
        _usersStream = FirebaseFirestore.instance
            .collection('booking')
            .where('doctorEmail', isEqualTo: doctorEmail)
            .where('hospitalID', isEqualTo: int.parse(hospitalID))
       //     .where('date', isEqualTo: DateTime.now())
            .snapshots();
      }
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
              return Text("NO Booking");
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
                        onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        viewfullbook(document.id))))
                            .then((value) => setState(() => {})),
                        child: Container(
                          height: 45,
                          width: 350,
                          //color: Colors.amber,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              data['patientName'],
                              style: TextStyle(color: Colors.black),
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
