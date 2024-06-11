


import 'dart:convert';

class useidModal {
useridData? ageLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  useidModal(
      {required this.ageLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory useidModal.fromJson(Map<String,dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<AgeData> dataList =
      //     list.map((data) => AgeData.fromJson(data)).toList();
      return useidModal(
        ageLtData: useridData.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return useidModal(
        ageLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory useidModal.error(String jsons,int stcode) {
    return useidModal(
        ageLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class useridData {
  useridData({
    required this.mobile,
    
  });

  String? mobile;
  



  factory useridData.fromJson(Map<String, dynamic> json) =>
   useridData(
    mobile: json['mobile'], 
    
    );
   
}
