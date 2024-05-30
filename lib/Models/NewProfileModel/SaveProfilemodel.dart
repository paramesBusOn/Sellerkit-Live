class SaveProfileModel {
  int statuscode;
  String? errormsg;

  SaveProfileModel({required this.statuscode, required this.errormsg});

  factory SaveProfileModel.fromjson(int rescode) {
    return SaveProfileModel(statuscode: rescode, errormsg: null);
  }
  factory SaveProfileModel.issue(String jsons, int stcode) {
    return SaveProfileModel(statuscode: stcode, errormsg: jsons);
  }
}
