
import 'dart:convert';
import 'dart:developer';

class AccountsEnqDetailsNew{
  List<AccountsEnqdetailData>? detaildataEnq;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AccountsEnqDetailsNew(
      {required this.detaildataEnq,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AccountsEnqDetailsNew.fromJson(List< dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      // log("listsL:"+list.toString());
      List<AccountsEnqdetailData> dataList =
          list.map((data) => AccountsEnqdetailData.fromJson(data)).toList();
      return AccountsEnqDetailsNew(
        detaildataEnq: dataList,
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return AccountsEnqDetailsNew(
        detaildataEnq: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory AccountsEnqDetailsNew.error(String jsons,int stcode) {
    return AccountsEnqDetailsNew(
        detaildataEnq: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class AccountsEnqdetailData {
  AccountsEnqdetailData({
  required this.assignedTo_User,
  required this.assignedTo_UserName,
  required this.cardcode,
  required this.enqDate,
  required this.enqid,
  required this.followup,
  required this.lookingfor,
  required this.manager_Status_Tab,
  required this.mgr_UserCode,
  required this.mgr_UserName,
  required this.potentialValue,
  required this.slp_Status_Tab,
  required this.status
  });
int? enqid;
String? cardcode;
String? status;
String? enqDate;
String? followup;
String? mgr_UserCode;
String? mgr_UserName;
String? assignedTo_User;
String? assignedTo_UserName;
String? lookingfor;
double? potentialValue;
String? manager_Status_Tab;
String? slp_Status_Tab;
  // String? cardcode;
  // String? cardname;
  // String? street;
  // String? block;
  // String? zipcode;
  // String? city;
  // String? state;
  // String? country;
  // String? tag;


  factory AccountsEnqdetailData.fromJson(Map<String, dynamic> json) =>
   AccountsEnqdetailData(
    assignedTo_User: json['assignedTo_User'], 
    assignedTo_UserName: json['assignedTo_UserName'], 
    cardcode: json['cardCode'], 
    enqDate: json['enqDate'], 
    enqid: json['enqID'], 
    followup: json['followup'], 
    lookingfor: json['lookingfor'], 
    manager_Status_Tab: json['manager_Status_Tab'], 
    mgr_UserCode: json['mgr_UserCode'], 
    mgr_UserName: json['mgr_UserName'], 
    potentialValue: json['potentialValue'], 
    slp_Status_Tab: json['slp_Status_Tab'], 
    status: json['status']
    );
    
}


class AccountsLeadDetailsNew{
  List<AccountsLeaddetailData>? detaildataLead;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AccountsLeadDetailsNew(
      {required this.detaildataLead,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AccountsLeadDetailsNew.fromJson(List< dynamic> jsons,int stcode) {
    if (jsons != null) {
      var list = jsons as List;
      // log("listsL:"+list.toString());
      List<AccountsLeaddetailData> dataList =
          list.map((data) => AccountsLeaddetailData.fromJson(data)).toList();
      return AccountsLeadDetailsNew(
        detaildataLead: dataList,
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return AccountsLeadDetailsNew(
        detaildataLead: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory AccountsLeadDetailsNew.error(String jsons,int stcode) {
    return AccountsLeadDetailsNew(
        detaildataLead: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class AccountsLeaddetailData {
  AccountsLeaddetailData({
  required this.city,
  required this.customerName,
  required this.docDate,
  required this.followupEntry,
  required this.lastUpdateMessage,
  required this.lastUpdateTime,
  required this.leadDocEntry,
  required this.leadNum,
  required this.mobile,
  required this.nextFollowup,
  required this.product,
  required this.status,
  required this.value
  });

int? leadDocEntry;
int? leadNum;
String? mobile;
String? customerName;
String? docDate;
String? city;
String? nextFollowup;
String? product;
double? value;
String? status;
String? lastUpdateMessage;
String? lastUpdateTime;
int? followupEntry;





  factory AccountsLeaddetailData.fromJson(Map<String, dynamic> json) =>
  AccountsLeaddetailData(
    city: json["city"]??"", 
    customerName: json["customerName"], 
    docDate: json["docDate"], 
    followupEntry: json["followupEntry"], 
    lastUpdateMessage: json["lastUpdateMessage"], 
    lastUpdateTime: json["lastUpdateTime"], 
    leadDocEntry: json["leadDocEntry"], 
    leadNum: json["leadNum"], 
    mobile: json["mobile"], 
    nextFollowup: json["nextFollowup"], 
    product: json["product"], 
    status: json["status"], 
    value: json["value"]);
}
