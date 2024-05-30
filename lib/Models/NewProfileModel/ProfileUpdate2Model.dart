import 'dart:convert';

class ProfileUpdateModel2 {
  List<ProfileUpdateModel2Data>? setprofiledata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ProfileUpdateModel2(
      {required this.setprofiledata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ProfileUpdateModel2.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<ProfileUpdateModel2Data> dataList =
          list.map((data) => ProfileUpdateModel2Data.fromJson(data)).toList();
      return ProfileUpdateModel2(
          setprofiledata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return ProfileUpdateModel2(
          setprofiledata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory ProfileUpdateModel2.error(String jsons, int stcode) {
    return ProfileUpdateModel2(
        setprofiledata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ProfileUpdateModel2Data {
  String? actionResponse;
  String? actionResponseMessage;

  ProfileUpdateModel2Data({
    required this.actionResponse,
    required this.actionResponseMessage,
  });

  factory ProfileUpdateModel2Data.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateModel2Data(
        actionResponse: json['ActionResponse'],
        actionResponseMessage: json['ActionResponseMessage'],
      );
}
