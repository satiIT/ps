import 'dart:ui';

import 'package:camera/camera.dart';

class dignosesClass {
  String? url;
  static  List<String> pic=['a'];
  dignosesClass({required this.url}) {
    pic.add(url!);
    print(pic[1]);
  }
  static re() {
    return pic;
  }
}
