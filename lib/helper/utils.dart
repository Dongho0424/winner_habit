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