import 'package:flutter/cupertino.dart';

///
class WebModel {
  String name;
  String url;
  Widget? icon;
  Color? color;

  WebModel(
    this.name,
    this.url, {
    this.icon,
    this.color,
  });
}
