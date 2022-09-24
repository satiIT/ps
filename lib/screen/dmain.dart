import 'package:flutter/material.dart';
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
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewbooking(email))).then((value) =>setState(() => {}));
                  id.clear();
                },
                child: Text("view bookings")),
          ),
        ],
      )),
    );
  }
}
