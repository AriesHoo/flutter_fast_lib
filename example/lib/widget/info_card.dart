import 'package:flutter/material.dart';

///示例提示Card控件
class InfoCard extends StatelessWidget {
  final String info;

  const InfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(info),
      ),
      shadowColor: Colors.purpleAccent,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 0.2,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.075),
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
