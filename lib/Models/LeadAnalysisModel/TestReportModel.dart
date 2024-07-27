import '../../DBModel/ReportsModel/TestReportModelDB.dart';

class TestReportMod {
  String title;
  List<TestReportValues> testReportValList;
  TestReportMod({required this.testReportValList, required this.title});
}

class TestReportValues {
  int? lineid;
  String? titleVal;
  String? reportValues;
  TestReportValues({
    this.lineid,
    this.titleVal,
    this.reportValues,
  });
  Map<String, Object?> toMap() => {
        LeadTestReportDB.title: titleVal,
        LeadTestReportDB.testValues: reportValues,
      };
}
