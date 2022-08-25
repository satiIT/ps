import 'package:flutter/material.dart';
import '/screen/dmain.dart';

class doctorLogin extends StatefulWidget {
  const doctorLogin();

  @override
  State<doctorLogin> createState() => _doctorLoginState();
}

class _doctorLoginState extends State<doctorLogin> {
  TextEditingController dID = TextEditingController();
  TextEditingController password = TextEditingController();
  void showsnakbar(String a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a),
      duration: Duration(milliseconds: 500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Login")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //    padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            width: 300,

            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ID',
                labelText: "ID",
                //           icon: Icon(Icons.person)
              ),
              controller: dID,
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
                hintText: 'password',
                labelText: "password",
                //  icon: Icon(Icons.password)
              ),
              controller: password,
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  if (dID.text.isEmpty) {
                    showsnakbar("Enter ID");
                  } else if (password.text.isEmpty) {
                    showsnakbar("Enter password");
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const dMain()));
                    //       dID.clear();
                    password.clear();
                  }
                },
                child: Text("login")),
          ),
        ],
      )),
    );
  }
}
