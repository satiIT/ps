import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController fName = TextEditingController();
TextEditingController sName = TextEditingController();
TextEditingController tName = TextEditingController();
TextEditingController id = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController height = TextEditingController();
TextEditingController weight = TextEditingController();
TextEditingController bloodType = TextEditingController();
CollectionReference users = FirebaseFirestore.instance.collection('users');
final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').snapshots();
var dropdownValue = "Male";
var dropdownValueb = "O+";
DateTime? date = DateTime.now();
bool s = false;
late bool t;

class newre extends StatefulWidget {
  const newre({Key? key}) : super(key: key);

  @override
  State<newre> createState() => _newreState();
}

class _newreState extends State<newre> {
  void showsnakbar(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a),
      duration: Duration(milliseconds: 500),
    ));
  }

  void c() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('idNumber', isEqualTo: id.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        // return true;
        addUser();

        print('we have same id');
      } else {
        // return false;
        addUser();
      }
    });
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user

    return users.add({
      'firstName': fName.text,
      'secondName': sName.text,
      'thirdName': tName.text,
      'idNumber': int.parse(id.text),
      'height': int.parse(height.text),
      'weight': int.parse(weight.text),
      'blodType': dropdownValueb,
      'birthDate': date,
      'phone': int.parse(phone.text),
      'gender': dropdownValue,
      //   'dffgfg':false
    }).then((value) {
      print("User Added");
      
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Registartion")),
        body: ListView(
          children: [
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                  labelText: "First Name",
                  //           icon: Icon(Icons.person)
                ),
                controller: fName,
                //   keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'second Name',
                  labelText: "second Name",
                  //           icon: Icon(Icons.person)
                ),
                controller: sName,
                //   keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Third Name',
                  labelText: "Third Name",
                  //           icon: Icon(Icons.person)
                ),
                controller: tName,
                //   keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'ID',
                  labelText: "ID Number",
                  //           icon: Icon(Icons.person)
                ),
                controller: id,
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              width: 250,
              child: Row(
                children: [
                  Text('${date!.year}/${date!.month}/${date!.day}'),
                  RaisedButton(
                    color: Colors.amber,
                    onPressed: () async {
                      DateTime? newdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900, 1),
                          lastDate: DateTime.now());
                      if (newdate == null) return;
                      setState(() {
                        date = newdate;
                      });
                      //  print(date);
                    },
                    child: Text("Brith Date"),
                  ),
                ],
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'phone',
                  labelText: "phone Number",
                  //           icon: Icon(Icons.person)
                ),
                controller: phone,
                keyboardType: TextInputType.number,
              ),
            ),
            Card(
                color: Color.fromRGBO(255, 254, 229, 1),
                child: Row(
                  children: [
                    Text("gender :"),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                )),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'height',
                  labelText: "height",
                  //           icon: Icon(Icons.person)
                ),
                controller: height,
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
              //    padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              width: 300,

              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'weight',
                  labelText: "weight",
                  //           icon: Icon(Icons.person)
                ),
                controller: weight,
                keyboardType: TextInputType.number,
              ),
            ),
            Container(
                //    padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: 300,
                child: Row(
                  children: [
                    Text('Bolad Type : '),
                    DropdownButton<String>(
                      value: dropdownValueb,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueb = newValue!;
                        });
                      },
                      items: <String>[
                        'O+',
                        'O-',
                        'A+',
                        'A-',
                        'AB+',
                        'AB-',
                        'B+',
                        'B-'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (fName.text.isEmpty) {
              showsnakbar("Enter FirstName");
            } else if (sName.text.isEmpty) {
              showsnakbar("Enter Secound Name");
            } else if (tName.text.isEmpty) {
              showsnakbar("Enter Tharid Name");
            } else if (id.text.isEmpty) {
              showsnakbar("Enter id");
            } else if (phone.text.isEmpty) {
              showsnakbar("Enter phone Number ");
            } else if (height.text.isEmpty) {
              showsnakbar("Enter height");
            } else if (weight.text.isEmpty) {
              showsnakbar("Enter Weight");
            } else {
              c();
            }
          },
          tooltip: 'Add person',
          child: const Icon(Icons.add),
        ));
  }
}
