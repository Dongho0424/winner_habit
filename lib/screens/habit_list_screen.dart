import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/providers/main_provider.dart';

class HabitListScreen extends StatefulWidget {
  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  int id;

  @override
  void initState() {
    super.initState();
    id = getNowId();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MainProvider>(context, listen: false)
          .getAllHabitsFromDB(id),
      builder: (futureContext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              title: Text("Main Page"),
              centerTitle: true,
              backgroundColor: AppColor.backgroundColor,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              title: Text("Main Page"),
              centerTitle: true,
              backgroundColor: AppColor.backgroundColor,
            ),
            body: Consumer<MainProvider>(
              builder: (context, mainProvider, child) {
                return mainProvider.habitList.length <= 0
                    ? noHabitList(context)
                    : Container();
              },
            ),
          );
        } else {
          return Scaffold(body: Container());
        }
      },
    );
  }

  Widget noHabitList(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Center(child: Text("첫번째 챌린지를 등록하세요!", style: TextStyle(color: Colors.white),)),
          SizedBox(height: 100),
          RaisedButton(
            child: Center(child: Text("여기를 누르세요!!", style: TextStyle(color: Colors.white),)),
              onPressed: (){
                print("#asd");
              }
          )
        ],
      ),
    );
  }
}
