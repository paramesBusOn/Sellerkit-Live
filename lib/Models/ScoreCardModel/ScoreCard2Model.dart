import 'dart:convert';

class ScoreCard2Model {
  List<ScoreCard2Data>? scorecarddata2;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ScoreCard2Model(
      {required this.scorecarddata2,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ScoreCard2Model.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<ScoreCard2Data> dataList =
          list.map((data) => ScoreCard2Data.fromJson(data)).toList();
      return ScoreCard2Model(
          scorecarddata2: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ScoreCard2Model(
          scorecarddata2: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory ScoreCard2Model.error(String jsons, int stcode) {
    return ScoreCard2Model(
        scorecarddata2: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ScoreCard2Data {
  String? title;
  int? sortOrder;
  String? rank;
  String? name;
  String? profilePic;

  ScoreCard2Data({
    required this.title,
    required this.sortOrder,
    required this.rank,
    required this.name,
    required this.profilePic,
  });

  factory ScoreCard2Data.fromJson(Map<String, dynamic> json) => ScoreCard2Data(
        title: json['title'] ?? "",
        sortOrder: json['sortOrder'],
        rank: json['rank'] ?? "",
        name: json['name'] ?? "",
        profilePic: json['profilePic'] ?? "",
      );
}
