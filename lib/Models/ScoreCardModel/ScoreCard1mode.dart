import 'dart:convert';

class ScoreCard1Model {
  List<ScoreCard1Data>? scorecarddata1;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ScoreCard1Model(
      {required this.scorecarddata1,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ScoreCard1Model.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<ScoreCard1Data> dataList =
          list.map((data) => ScoreCard1Data.fromJson(data)).toList();
      return ScoreCard1Model(
          scorecarddata1: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ScoreCard1Model(
          scorecarddata1: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory ScoreCard1Model.error(String jsons, int stcode) {
    return ScoreCard1Model(
        scorecarddata1: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ScoreCard1Data {
  String? title;
  int? sortOrder;
  String? rank;
  String? name;
  String? profilePic;

  ScoreCard1Data({
    required this.title,
    required this.sortOrder,
    required this.rank,
    required this.name,
    required this.profilePic,
  });

  factory ScoreCard1Data.fromJson(Map<String, dynamic> json) => ScoreCard1Data(
        title: json['title'] ?? "",
        sortOrder: json['sortOrder'],
        rank: json['rank'] ?? "",
        name: json['name'] ?? "",
        profilePic: json['profilePic'] ?? "",
      );
}
