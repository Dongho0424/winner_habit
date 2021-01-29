import 'package:flutter/material.dart';
import 'package:winner_habit/helper/theme.dart';

class WorkOutViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("WorkOutViewScreen"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/WorkOutEdit'),
          child: Text("go to workout edit screen"),
        ),
      ),
    );
  }
}
