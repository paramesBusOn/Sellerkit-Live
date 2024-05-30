import 'dart:convert';

class ProfileUpdateModel1 {
  List<ProfileUpdateModel1Data>? profiledata;
  String? attachpath;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ProfileUpdateModel1(
      {required this.profiledata,
      required this.message,
      required this.attachpath,
      required this.status,
      this.exception,
      required this.stcode});
  factory ProfileUpdateModel1.fromJson(String jsons, int stcode) {
    if (jsons != null) {
      // var list = json.decode(jsons["data"]) as List;
      // List<ProfileUpdateModel1Data> dataList =
      //     list.map((data) => ProfileUpdateModel1Data.fromJson(data)).toList();
      return ProfileUpdateModel1(
          profiledata: null,
          message: "Success",
          status: true,
          stcode: stcode,
          attachpath:jsons,
          exception: null);
    } else {
      return ProfileUpdateModel1(
          profiledata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          attachpath:null,
          exception: null);
    }
  }

  factory ProfileUpdateModel1.error(String jsons, int stcode) {
    return ProfileUpdateModel1(
        profiledata: null,
        message: null,
        status: null,
        stcode: stcode,
        attachpath:null,
        exception: jsons);
  }
}

class ProfileUpdateModel1Data {
  String? attachpath;

  ProfileUpdateModel1Data({
    required this.attachpath,
  });

  factory ProfileUpdateModel1Data.fromJson(String json) =>
      ProfileUpdateModel1Data(
        attachpath: json,
      );
}
