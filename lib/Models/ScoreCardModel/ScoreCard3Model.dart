import 'dart:convert';

class ScoreCard3Model {
  List<ScoreCard3Data>? scorecarddata3;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ScoreCard3Model(
      {required this.scorecarddata3,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ScoreCard3Model.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list =jsons as List;
      List<ScoreCard3Data> dataList =
          list.map((data) => ScoreCard3Data.fromJson(data)).toList();
      return ScoreCard3Model(
          scorecarddata3: dataList,
          message:"Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ScoreCard3Model(
          scorecarddata3: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory ScoreCard3Model.error(String jsons, int stcode) {
    return ScoreCard3Model(
        scorecarddata3: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ScoreCard3Data {
  String? title;
  int? sortOrder;
  String? rank;
  String? name;
  String? profilePic;

  ScoreCard3Data({
    required this.title,
    required this.sortOrder,
    required this.rank,
    required this.name,
    required this.profilePic,
  });

  factory ScoreCard3Data.fromJson(Map<String, dynamic> json) => ScoreCard3Data(
        title: json['title'] ?? "",
        sortOrder: json['sortOrder'],
        rank: json['rank'] ?? "",
        name: json['name'] ?? "",
        profilePic: json['profilePic'] ?? "",
      );
}
