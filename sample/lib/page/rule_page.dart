import 'package:flutter/material.dart';
import 'package:flutter_blood_belfry/main.dart';

///游戏规则
class RulePage extends StatelessWidget {
  const RulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appString.gameRule),
      ),
      body: Text(appString.gameRule),
    );
  }
}
