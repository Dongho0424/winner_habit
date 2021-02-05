import 'package:flutter/material.dart';
import 'package:winner_habit/helper/theme.dart';

class ChallengeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("ChallengeSearchScreen"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
      ),
    );
  }
}
