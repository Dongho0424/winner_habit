import 'package:winner_habit/models/challenge.dart';

int getNowId(){
  String year = DateTime.now().year.toString();
  String month = DateTime.now().month.toString();
  String day = DateTime.now().day.toString();
  int id;
  if(int.parse(month) < 10)
    id = int.parse("${year}0$month$day");
  else
    id = int.parse("$year$month$day");

  // return ex) 20210128
  return id;
}

String toChallengeKorString(Challenge challenge){
  switch (challenge){
    case Challenge.BILLGATES:
      return '빌게이츠';
    case Challenge.STEVEJOBS:
      return '스티브잡스';
    default:
      print("toChallengeKorString error");
      return ' ';
  }
}

String toChallengeString(Challenge challenge){
  switch (challenge){
    case Challenge.BILLGATES:
      return 'BillGates';
    case Challenge.STEVEJOBS:
      return 'SteveJobs';
    default:
      print("toChallengeString error");
      return ' ';
  }
}

Challenge toChallenge(String challenge){
  switch (challenge){
    case "BillGates":
      return Challenge.BILLGATES;
    case "SteveJobs":
      return Challenge.STEVEJOBS;
    default:
      print("toChallenge error");
      return null;
  }
}


