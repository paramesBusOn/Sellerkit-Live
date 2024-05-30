class ProfileupdateModel {
String? profileData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ProfileupdateModel(
      {required this.profileData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ProfileupdateModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons !=null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // log("jsonS"+jsons.toString());
      // List<ProfileData> dataList =
      //     list.map((data) => ProfileData.fromJson(data)).toList();
      return ProfileupdateModel(
        profileData: null,
        message: jsons['respCode'],
        status: true,
        stcode: stcode,
        exception:jsons['respDesc']
      );
    } else {
      return ProfileupdateModel(
        profileData: null,
        message: jsons['respCode'],
        status: false,
        stcode: stcode,
        exception:jsons['respDesc']
      );
    }
  }
  factory ProfileupdateModel.issues(Map<String,dynamic> jsons,int stcode) {
    return ProfileupdateModel(
        profileData: null, 
        message: jsons['respCode'], 
        status: null,   
        stcode: stcode,
        exception:jsons['respDesc']);
  }

 

  factory ProfileupdateModel.error(String jsons,int stcode) {
    return ProfileupdateModel(
        profileData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}