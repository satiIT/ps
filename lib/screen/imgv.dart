import 'package:flutter/material.dart';
import 'package:ps/screen/newre.dart';
  var sa;

class imgv extends StatefulWidget {
  //const imgv({Key? key}) : super(key: key);
  imgv( v) {
    sa = v;
  }

  @override
  State<imgv> createState() => _imgvState();
}

class _imgvState extends State<imgv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("image view")),
      body: Image.network(sa),
    );
  }
}
