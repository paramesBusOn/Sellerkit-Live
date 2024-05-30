import 'dart:convert';

class ScoreCard4Model {
  List<ScoreCard4Data>? scorecarddata4;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ScoreCard4Model(
      {required this.scorecarddata4,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ScoreCard4Model.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<ScoreCard4Data> dataList =
          list.map((data) => ScoreCard4Data.fromJson(data)).toList();
      return ScoreCard4Model(
          scorecarddata4: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ScoreCard4Model(
          scorecarddata4: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory ScoreCard4Model.error(String jsons, int stcode) {
    return ScoreCard4Model(
        scorecarddata4: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ScoreCard4Data {
  String? title;
  String? kpi;
  String? rank;
  String? name;
  String? date;

  ScoreCard4Data({
    required this.title,
    required this.date,
    required this.rank,
    required this.name,
    required this.kpi,
  });

  factory ScoreCard4Data.fromJson(Map<String, dynamic> json) => ScoreCard4Data(
        title: json['title'] ?? "",
        date: json['date'] ?? "",
        rank: json['rank'] ?? "",
        name: json['name'] ?? "",
        kpi: json['kpi'] ?? "",
      );
}
