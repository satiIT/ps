import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ps/screen/booking.dart';
import 'package:ps/screen/ptabs.dart';
import 'package:ps/screen/recordList.dart';
import 'package:ps/screen/updaterecord.dart';
import 'package:ps/screen/uploadrecord.dart';
import 'package:ps/screen/viewbooking.dart';
import 'package:ps/screen/viewprofile.dart';

late String email;


class dMain extends StatefulWidget {
  //const dMain({Key? key}) : super(key: key);
  dMain(String e) {
    email = e;
    print(email);
  }

  @override
  State<dMain> createState() => _dMainState();
}

class _dMainState extends State<dMain> {
  TextEditingController id = TextEditingController();

  void showsnakbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter ID"),
      duration: Duration(milliseconds: 500),
    ));
  }
  booking() async {
  await FirebaseFirestore.instance
      .collection('booking')
      .where('doctorEmail', isEqualTo: email)
      .get()
      .then((value) {
    if (value.docs.isEmpty) {
      // return true;
      //  addUser();

      print('we have same id');
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Data Error'),
            content: SingleChildScrollView(
              child: Text('Data not found !'),
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
    } else if (value.docs.isNotEmpty) {
      // return false;
      return navi();
    }
  });
}


  navi() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => viewbooking(email)))
        .then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              //   width: 300,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'ID',
                    labelText: "ID",
                    icon: Icon(Icons.person)),
                controller: id,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  if (id.text.isEmpty) {
                    showsnakbar();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewprofile(id.text)));
                    //  id.clear();
                  }
                },
                child: Text("view record")),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  if (id.text.isEmpty) {
                    showsnakbar();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                uploadRecord(int.parse(id.text))));
                    //     id.clear();
                  }
                },
                child: Text("upload record")),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  booking();
                  //  id.clear();
                },
                child: Text("view bookings")),
          ),
        ],
      )),
    );
  }
}
