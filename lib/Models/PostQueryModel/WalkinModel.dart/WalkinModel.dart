import 'dart:convert';

class WalkinModal {
WalkinModalData? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  WalkinModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory WalkinModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = json.decode(jsons["data"]) as List;
      // List<WalkinModalData> dataList =
      //     list.map((data) => WalkinModalData.fromJson(data)).toList();
      return WalkinModal(
        userLtData: WalkinModalData.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return WalkinModal(
        userLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory WalkinModal.error(String jsons,int stcode) {
    return WalkinModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class WalkinModalData {
  WalkinModalData({
   required this.division,
   required this.headcount,
   required this.id,
   required this.purposeofvisit,
   required this.slpcode,
   required this.u_branch,
   required this.visittime

    // required this.actionResponce,
    // required this.actionResponseMessage,
  });
int? id;
String? slpcode;
String? purposeofvisit;
String? division;
int? headcount;
String? u_branch;
String? visittime;

  // String? actionResponce;
  // String? actionResponseMessage;


  factory WalkinModalData.fromJson(Map<String, dynamic> json) =>
   WalkinModalData(
    division: json['division'], 
    headcount: json['headCount'], 
    id: json['id'], 
    purposeofvisit: json['purposeofvisit'], 
    slpcode: json['slpCode'], 
    u_branch: json['u_branch'], 
    visittime: json['visitTime']
    );
   
}
