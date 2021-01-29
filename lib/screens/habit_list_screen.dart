import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winner_habit/helper/theme.dart';
import 'package:winner_habit/helper/utils.dart';
import 'package:winner_habit/models/challenge.dart';
import 'package:winner_habit/models/habits/base_habit.dart';
import 'package:winner_habit/providers/main_provider.dart';
import 'package:winner_habit/widgets/habit_list.dart';

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
            // appBar: AppBar(
            //   title: Text("Main Page"),
            //   centerTitle: true,
            //   backgroundColor: AppColor.backgroundColor,
            // ),
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
                      setState(() {id--;});
                      Provider.of<MainProvider>(context, listen: false).setCurrentDate(id);
                    },
                  ),
                  Text("$id"), // using id
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      setState(() {id++;});
                      Provider.of<MainProvider>(context, listen: false).setCurrentDate(id);
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
                          if (index == 0) {
                            return challengeHeader(size);
                          } else {
                            final i = index - 1;
                            BaseHabit habit = mainProvider.habitList[i];
                            return HabitList(habit);
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
          RaisedButton(
              child: Center(
                  child: Text(
                "여기를 누르세요!!",
                style: TextStyle(color: Colors.white),
              )),
              onPressed: () {
                print("#asd");
              })
        ],
      ),
    );
  }

  Widget challengeHeader(Size size) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 40.0),
      child: GestureDetector(
        onTap: () {
          print("challengeHeader");
        },
        child: Container(
          height: 150,
          width: double.infinity,
          color: AppColor.backgroundColor,
          child: Row(
            children: [
              Image(image: AssetImage(BillGates.illust)),
              SizedBox(width: 10),
              Column(
                children: [
                  Text("D-35", style: TextStyle(color: AppColor.dDayColor)),
                  Text("빌게이츠 챌린지"),
                  Text("전체 달성률"),
                  Text("일일 달성률"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
