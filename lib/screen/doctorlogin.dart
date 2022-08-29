import 'package:flutter/material.dart';
import '/screen/dmain.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                hintText: 'Email',
                labelText: "Email",
                //           icon: Icon(Icons.person)
              ),
              controller: dID,
              keyboardType: TextInputType.emailAddress,
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
              obscureText: true,
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () async {
                  if (dID.text.isEmpty) {
                    showsnakbar("Enter ID");
                  } else if (password.text.isEmpty) {
                    showsnakbar("Enter password");
                  } else {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: dID.text, password: password.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const dMain()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
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
