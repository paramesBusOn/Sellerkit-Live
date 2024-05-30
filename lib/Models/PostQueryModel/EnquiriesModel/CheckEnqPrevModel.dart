import 'dart:convert';

class CheckEnqPrevDetailsModel {
List<CheckEnqPrevDetailsData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  CheckEnqPrevDetailsModel(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory CheckEnqPrevDetailsModel.fromJson(List< dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<CheckEnqPrevDetailsData> dataList =
          list.map((data) => CheckEnqPrevDetailsData.fromJson(data)).toList();
      return CheckEnqPrevDetailsModel(
        itemdata: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return CheckEnqPrevDetailsModel(
        itemdata: null,
        message:"Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory CheckEnqPrevDetailsModel.error(String jsons,int stcode) {
    return CheckEnqPrevDetailsModel(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class CheckEnqPrevDetailsData {
  CheckEnqPrevDetailsData({
    required this.Mgr_UserName,
    required this.EnqID,
    required this.CardCode,
    required this.Status,
    required this.CardName,
    required this.AssignedTo_User,
    required this.EnqDate,
    required this.Followup,
    required this.Mgr_UserCode,
    required this.AssignedTo_UserName,
    required this.EnqType,
     required this.Lookingfor,
    required this.PotentialValue,
    required this.Address_Line_1,
    required this.Address_Line_2,
    required this.Pincode,
    required this.City,
    required this.State,
    required this.Country,
    required this.Manager_Status_Tab,
    required this.Slp_Status_Tab,
    required this.Current_Branch,
    required this.User_Branch,
     required this.email,
    required this.referal,
   
  });

  int? EnqID;
  String? CardCode;
  String? CardName;
  String? EnqDate;
  String? Followup;
  String? Status;
  String? Mgr_UserCode;
  String? Mgr_UserName;
  String? AssignedTo_User;
  String? AssignedTo_UserName;
  String? EnqType;
  String? Lookingfor;
  double? PotentialValue;
  String? Address_Line_1;
  String? Address_Line_2;
  String? Pincode;
  String? City;
  String? State;
  String? Country;
  String? Manager_Status_Tab;
  String? Slp_Status_Tab;  //Current_Branch,User_Branch
  String? Current_Branch;
  String? User_Branch;
    String? email;
  String? referal;

  factory CheckEnqPrevDetailsData.fromJson(Map<String, dynamic> json) =>
   CheckEnqPrevDetailsData(
     EnqID: json['enqID'] ?? 0,
     CardCode: json['cardCode'] ?? '',
     Status: json['status'] ?? '', 
     CardName: json['cardName'] ?? '', 
     EnqDate: json['enqDate'] ?? '',
     Followup: json['followup'] ?? '', 
     Mgr_UserCode: json['mgr_UserCode'] ?? '', 
     AssignedTo_UserName: json['assignedTo_UserName']?? '',
     Mgr_UserName: json['mgr_UserName'] ?? '',
     AssignedTo_User: json['assignedTo_User'] ?? '',
     EnqType:json['slp_Status_Tab']?? '',
     Lookingfor: json['lookingfor'] ?? '', 
     PotentialValue: json['potentialValue'] ?? 0.00,
     Address_Line_1: json['Address_Line_1'] ?? '', 
     Address_Line_2: json['Address_Line_2'] ?? '', 
     Pincode: json['Pincode']?? '',
     City: json['City'] ??'',
     State: json['State'] ?? '',
     Country:json['Country']?? '',
     Manager_Status_Tab: json['manager_Status_Tab'] ?? '', 
     Slp_Status_Tab: json['slp_Status_Tab'] ?? '',
     Current_Branch:json['current_Branch'] ?? '',
     User_Branch: json['user_Branch'] ?? '',
     email: json['email'] ??'',
     referal: json['u_EnqRefer'] ?? '',
    
     );
}
