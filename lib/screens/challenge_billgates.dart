import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/providers/main_provider.dart';

class ChallengeBillGates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("빌게이츠 챌린지 참여"),
          onPressed: () {
            Provider.of<MainProvider>(context, listen: false).CreateNewChallenge(Challenge.BILLGATES);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
