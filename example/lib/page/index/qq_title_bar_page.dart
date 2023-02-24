import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fast_lib_example/main.dart';

///模拟QQ标题
class QQTitleBarPage extends StatelessWidget {
  const QQTitleBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.qqTitleBar),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: Theme.of(context)
            .appBarTheme
            .titleTextStyle
            ?.copyWith(color: Colors.white),
        iconTheme: Theme.of(context)
            .appBarTheme
            .iconTheme
            ?.copyWith(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.purpleAccent,
            gradient: LinearGradient(
              colors: [
                Color(0xFF33bafc),
                Color(0xFF34b0fc),
                Color(0xFF4e8cfc),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
      ),
    );
  }
}
