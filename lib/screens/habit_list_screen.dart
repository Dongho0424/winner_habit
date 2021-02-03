import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/providers/main_provider.dart';
import 'package:winner_habit/screens/challenge_billgates.dart';
import 'package:winner_habit/widgets/habit_list_item.dart';

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
    Provider.of<MainProvider>(this.context, listen: false).setCurrentDate(id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: Provider.of<MainProvider>(context, listen: false)
          .getAllHabitsFromDB(id),
      builder: (futureContext, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              title: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      print("now: ${DateTime.now()}");
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   setState(() {
                      //     id--;
                      //   });
                      // });
                      Provider.of<MainProvider>(context, listen: false)
                          .setCurrentDate(id);
                    },
                  ),
                  Text("$id"), // using id
                  if (id < getNowId())
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        // WidgetsBinding.instance.addPostFrameCallback((_) {
                        //   setState(() {
                        //     id++;
                        //   });
                        // });
                        Provider.of<MainProvider>(context, listen: false)
                            .setCurrentDate(id);
                      },
                    ),
                ],
              ),
              centerTitle: true,
              backgroundColor: AppColor.backgroundColor,
            ),
            body: Consumer<MainProvider>(
              builder: (context, mainProvider, child) {
                return mainProvider.habitList.length <= 0
                  ? noHabitList(context)
                  : ListView.builder(
                      itemCount: mainProvider.habitList.length + 1,
                      itemBuilder: (builderContext, index) {

                        print("mainProvider.habitList.length: ${mainProvider.habitList.length}");

                        if (index == 0) {
                          return challengeHeader(size, mainProvider.currentChallenge);
                        } else {
                          final i = index - 1;
                          BaseHabit habit = mainProvider.habitList[i];
                          print("ListView.builder, habit.title: ${habit.title}");
                          print("ListView.builder, habit.type: ${habit.type}");
                          print("ListView.builder, habit.isDone: ${habit.isDone}");
                          print("ListView.builder, habit.whichChallenge: ${habit.whichChallenge}");
                          return HabitListItem(habit);
                        }
                      },
                    );
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
          Center(
              child: Text(
            "첫번째 챌린지를 등록하세요!",
            style: TextStyle(color: Colors.white),
          )),
          SizedBox(height: 100),
          // 임시로 해놓은 것
          RaisedButton(
              child: Center(
                  child: Text(
                "여기를 누르세요!!!",
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                // 임시로 해놓은 것
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChallengeBillGates()));
              })
        ],
      ),
    );
  }

  Widget challengeHeader(Size size, Challenge challenge) {
    return GestureDetector(
      onTap: () {
        print("challengeHeader");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        height: 150,
        width: double.infinity,
        color: Colors.black87,
        child: Row(
          children: [
            Image(image: AssetImage(BillGates.illust), width: 100, height: 150, color: Colors.white),
//               Container(color: Colors.red, width: 100, height: 150),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3),
                    Text("D-35",
                        style: TextStyle(color: Colors.red, fontSize: 15)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: toChallengeKorString(challenge),
                            style:
                            TextStyle(color: Colors.white, fontSize: 38),
                          ),
                          TextSpan(
                            text: ' 챌린지',
                            style:
                            TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("전체 달성률",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    SizedBox(height: 7),
                    Text("일일 달성률",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    SizedBox(height: 2),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
