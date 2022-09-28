import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:ps/screen/doctorBooking.dart';

late String id, name;
final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('hospital')
    //    .where('idNumber', isEqualTo: int.parse(id))
    .snapshots();

class booking extends StatefulWidget {
  //const booking({Key? key}) : super(key: key);

  booking(i, n) {
    id = i;
    name = n;
    //   print(name);
  }
  @override
  State<booking> createState() => _bookingState();
}

class _bookingState extends State<booking> {
  //var dropdownValueb = "sati Elsadig";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hospital List")),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
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
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {
                        print(document.id);
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => doctorBooking(
                                        document.id.toString(),
                                        data['name'].toString(),
                                        id,
                                        name,
                                        data['id']), fullscreenDialog: true,))
                            .then((value) => setState(() => {}));
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 45,
                            width: 350,
                            //color: Colors.amber,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                data['name'],
                                style: TextStyle(color: Colors.black,fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }
}
