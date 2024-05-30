class cancelModel {
  String message;
  bool? status;
  String? exception;
  int?stcode;
  cancelModel(
      {
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory cancelModel.fromJson(int stcode) {
    // if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<EnquiriesData> dataList =
      //     list.map((data) => EnquiriesData.fromJson(data)).toList();
      return cancelModel(
        // itemdata: stateHeader.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    // } else {
    //   return cancelModel(
    //     // itemdata: null,
    //     message:"Failure",
    //     status: false,
    //     stcode: stcode,
    //     exception:null
    //   );
    // }
  }
factory cancelModel.issues(Map<String,dynamic> jsons,int stcode) {
    return cancelModel(
        message: jsons['respType'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory cancelModel.error(String jsons,int stcode) {
    return cancelModel(
         message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}