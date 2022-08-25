import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../classes/picList.dart';

late int index;

class imgview extends StatefulWidget {
  // const imgview({Key? key}) : super(key: key);
  imgview(int x) {
    index = x;
  }
  @override
  State<imgview> createState() => _imgviewState();
}

class _imgviewState extends State<imgview> {
  @override
  Widget build(BuildContext context) {
    return Image.network(pictureList![index]) ;
  }
}
