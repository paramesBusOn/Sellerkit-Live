// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class FollowUPListModel {
List<FollowUPListData>? followUPListData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  FollowUPListModel(
      {required this.followUPListData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory FollowUPListModel.fromJson(List< dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<FollowUPListData> dataList =
          list.map((data) => FollowUPListData.fromJson(data)).toList();
      return FollowUPListModel(
        followUPListData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return FollowUPListModel(
        followUPListData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory FollowUPListModel.error(String jsons,int stcode) {
    return FollowUPListModel(
        followUPListData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}

class FollowUPListData {
  FollowUPListData({
    required this.FollowupDate,
    required this.LeadDocEntry,
    required this.LeadDocNum,
    required this.FollowupEntry,
    required this.Phone,
    required this.Customer,
    required this.CretedDate,
    required this.LastFollowupDate,
    required this.DocTotal,
     this.Quantity,
    required this.Product,
    required this.LastFollowupStatus,
     this.LastFollowup_Feedback,
     this.CustomerInitialIcon,
    this.Followup_Due_Type,
     this.add1,
     this.add2,
     this.area,
     this.city,
     this.cusEmail,
     this.cusgroup,
     this.pincode,
     this.state
    
  });

  String? FollowupDate;
  int? LeadDocEntry;
  int? LeadDocNum;
  int? FollowupEntry;
  String? Phone;
  String? Customer;
  String? CretedDate;
  String? LastFollowupDate;
  double? DocTotal;
  String? Quantity;
  String? Product;
  String? LastFollowupStatus;
  String? LastFollowup_Feedback;
  String? CustomerInitialIcon;
  String? Followup_Due_Type;
  String? add1;
  String? add2;
  String? pincode;
  String? city;
  String? cusEmail;
  String? state;
  String? cusgroup;
   String? area;



  factory FollowUPListData.fromJson(Map<String, dynamic> json) =>
   FollowUPListData(
     FollowupDate: json['followupDate'] ?? '',
     LeadDocEntry: json['leadDocEntry'] ?? 0,
     LeadDocNum: json['leadDocNum'] ?? 0,
     FollowupEntry: json['followupEntry'] ?? 0,
     Phone: json['phone'] ?? '',
     Customer: json['customer'] ?? '',
     CretedDate: json['createDate'] ?? '',
     LastFollowupDate: json['createDate'] ?? '',
     DocTotal: json['docTotal'] ?? 0,
     Quantity: json['quantity'] ?? '',
     Product: json['product']!=null?
     ( json['product'].toString().length>26?
     json['product'].toString().substring(0,26)
     :json['product'].toString()): '',
     LastFollowupStatus: json['lastFollowupStatus'] ?? '',
     LastFollowup_Feedback: json['lastFollowup_Feedback'] ?? '',
     CustomerInitialIcon: json['customerInitialIcon'] ?? '',
     Followup_Due_Type: json['followup_Due_Type'] ?? '',

     );


    Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "FollwUPDate": FollowupDate,
      "LeadDocEntry": LeadDocEntry,
      "LeadDocNum":LeadDocNum,
      "FollowupEntry": FollowupEntry,
      "Phone": Phone,
      "Customer":Customer,
      "CretedDate": CretedDate,
      "LastFollowupDate": LastFollowupDate,
      "DocTotal":DocTotal,
      "Quantity": Quantity,
      "Product": Product,
      "LastFollowupStatus":LastFollowupStatus,
      "LastFollowup_Feedback":LastFollowup_Feedback,
      "CustomerInitialIcon": CustomerInitialIcon,
    };
    return map;
  }
}
