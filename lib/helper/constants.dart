enum Week { MON, TUE, WED, THUR, FRI, SAT, SUN }

List<Week> everyDay() {
  return [
    Week.MON,
    Week.TUE,
    Week.WED,
    Week.THUR,
    Week.FRI,
    Week.SAT,
    Week.SUN
  ];
}

List<Week> everyWeek() {
  return [
    Week.MON,
    Week.TUE,
    Week.WED,
    Week.THUR,
    Week.FRI,
  ];
}

List<Week> everyWeekend() {
  return [
    Week.SAT,
    Week.SUN
  ];
}
