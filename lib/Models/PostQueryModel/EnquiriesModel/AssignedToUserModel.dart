// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

class AssignedToUserModal {
AssignedToUserData? userLtData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  AssignedToUserModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AssignedToUserModal.fromJson(Map<String, dynamic> jsons,int stcode) {
  //  log("update"+jsons.toString());
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<AssignedToUserData> dataList =
      //     list.map((data) => AssignedToUserData.fromJson(data)).toList();
      return AssignedToUserModal(
       userLtData:AssignedToUserData.fromJson(jsons) ,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return AssignedToUserModal(
       userLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
factory AssignedToUserModal.issues(Map<String,dynamic> jsons,int stcode) {
    return AssignedToUserModal(
        userLtData: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory AssignedToUserModal.error(String jsons,int stcode) {
    return AssignedToUserModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class AssignedToUserData {
  AssignedToUserData({


  required this.respCode,
   required this.datadetail,
   required this.respDesc,
   required this.respType
  });

 String? respType;
    String? respCode;
    String? respDesc;
    List<assignData>? datadetail;


  factory AssignedToUserData.fromJson(Map<String, dynamic> jsons) {
     var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return AssignedToUserData(
      respCode: jsons['respCode'], 
        datadetail: null, 
        respDesc: jsons['respDesc'], 
        respType: jsons['respType']
        );

      }
       else {
      List<assignData> dataList =
          list.map((data) => assignData.fromJson(data)).toList();
      return AssignedToUserData(
        respCode: jsons['respCode'], 
        datadetail: dataList, 
        respDesc: jsons['respDesc'], 
        respType: jsons['respType']
        );
   
   
      
    }
  }
   
   
}

class assignData{
   int? EnqID;//
 String? EnquiredOn;
  String? CardCode;//
  String? CardName;//
  String? EnqDate;//
  String? Followup;//
  String? Status;//
  String? Mgr_UserCode;//
  String? Mgr_UserName;//
  String? AssignedTo_User;//
  String? AssignedTo_UserName;//
  String? EnqType;
  String? Lookingfor;//
  double? PotentialValue;//
  String? Address_Line_1;//
  String? Address_Line_2;//
  String? Pincode;//
  String? City;//
  String? State;//
  String? Country;//
  String? Manager_Status_Tab;//
  String? Slp_Status_Tab;//
  String? email;//
  String? referal;//
 // String? customertag;
 String? contactName;
 String? altermobileNo;
 String? customerGroup;  
 String? customermobile;
 String? comapanyname;
 String? storecode;
 String? area;
 String? district;
 String? itemCode;
 String? itemname;
 String? enquirydscription;
 double? quantity;
 String? isVisitRequired;
 String? visitTime;
 String? remindOn;  
 String? isClosed;
 bool? leadConverted;
  int?  createdBy;
  String?  createdDateTime;
  int?  updatedBy;
  String?  updatedDateTime;
  String? traceid;


assignData({
required this.contactName,
required this.altermobileNo,
required this.customerGroup,
required this.Mgr_UserName,
required this.comapanyname,
required this.visitTime,
required this.remindOn,
required this.isClosed,
required this.isVisitRequired,
required this.storecode,
required this.area,
required this.district,
required this.itemCode,
required this.itemname,
required this.leadConverted,
required this.createdBy,
required this.createdDateTime,
required this.updatedBy,
required this.updatedDateTime,
required this.enquirydscription,
required this.quantity,
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
     required this.email,
    required this.referal,
    required this.customermobile,
    required this.traceid,
});
 factory assignData.fromJson(Map<String, dynamic> json) =>
   assignData(
     EnqID: json['EnquiryID'] ?? 0,//
     CardCode: json['CustomerCode'] ?? '',//
     Status: json['CurrentStatus'] ?? '', 
     CardName: json['CustomerName'] ?? '', //
     EnqDate: json['EnquiredOn'] ?? '',//
     Followup: json['FollowupOn'] ?? '', 
     Mgr_UserCode: json['mgr_UserCode'] ?? '', 
     AssignedTo_UserName: json['AssignedTo']?? '',//
     Mgr_UserName: json['mgr_UserName'] ?? '',
     AssignedTo_User: json['assignedTo_User'] ?? '',
     EnqType:json['EnquiryType']?? '',
     Lookingfor: json['Lookingfor'] ?? '', 
     PotentialValue: json['Potentialvalue'] ?? 0.00,
     Address_Line_1: json['Address1'] ?? '', //
     Address_Line_2: json['Address2'] ?? '', 
     Pincode: json['PinCode'].toString()?? '',//
     City: json['City'] ??'',//
     State: json['State'] ?? '',//
     Country:json['Country']?? '',
      Manager_Status_Tab: json['manager_Status_Tab'] ?? '', 
     Slp_Status_Tab: json['EnquiryStatus'] ?? '',
      email: json['CustomerEmail'] ??'',//
    referal: json['Refferal'] ??'',
    contactName: json['ContactName'],//
    customerGroup: json['CustomerGroup'],//
    altermobileNo:json['AlternateMobileNo'],//
    customermobile: json["CustomerMobile"],//
    comapanyname: json['CompanyName'],//
    storecode: json['StoreCode'],//
    area: json['BilArea'],//
    district: json['District'],//
    itemCode: json['ItemCode'],
    itemname: json['ItemName'],
    enquirydscription: json['Enquirydscription'],
    quantity: json['Quantity'],
    isVisitRequired: json["IsVisitRequired"],
    visitTime: json['VisitTime'],
    remindOn: json['RemindOn'],
    isClosed: json['isClosed'],
    leadConverted:json['LeadConverted'],
    createdBy: json["CreatedBy"],
    createdDateTime: json['CreatedDateTime'],
    updatedBy: json['UpdatedBy'],
    updatedDateTime: json['UpdatedDateTime'],
    traceid: json['traceid'] ??''

    
     );

}

//old code

// import 'dart:convert';
// import 'dart:developer';

// class AssignedToUserModal {
// AssignedToUserData? userLtData;
//   String message;
//   bool? status;
//   String? exception;
//   int? stcode;
//   AssignedToUserModal(
//       {required this.userLtData,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode
//       });
//   factory AssignedToUserModal.fromJson(Map<String, dynamic> jsons,int stcode) {
//    log("update"+jsons.toString());
//     if (jsons != null && jsons.isNotEmpty) {
//       // var list = jsons as List;
//       // List<AssignedToUserData> dataList =
//       //     list.map((data) => AssignedToUserData.fromJson(data)).toList();
//       return AssignedToUserModal(
//        userLtData:AssignedToUserData.fromJson(jsons) ,
//         message: "Success",
//         status: true,
//         stcode: stcode,
//         exception:null
//       );
//     } else {
//       return AssignedToUserModal(
//        userLtData: null,
//         message: "Failure",
//         status: false,
//         stcode: stcode,
//         exception:null
//       );
//     }
//   }

//   factory AssignedToUserModal.error(String jsons,int stcode) {
//     return AssignedToUserModal(
//         userLtData: null, message: 'Exception', status: null,   stcode: stcode,
//         exception:jsons);
//   }
// }

// class AssignedToUserData {
//   AssignedToUserData({
//    required this.activity,
//    required this.activityType,
//    required this.closed,
//    required this.createdDate,
//    required this.createdby,
//    required this.customerCode,
//    required this.id,
//    required this.potentialvalue,
//    required this.u_AssignedTo,
//    required this.u_EnqRefer,
//    required this.u_EnqStatus,
//    required this.u_Followupdate,
//    required this.u_Lookingfor,
//    required this.u_ManagerSlp,
//    required this.updatedby,
//    required this.updateddate
//   });

//    int? id;
//   String?  customerCode;
//   String?  activity;
//    String? activityType;
//   double?  potentialvalue;
//   String?  u_Lookingfor;
//    String? u_AssignedTo;
//   String?  u_ManagerSlp;
//   String?  u_EnqStatus;
//  String?   u_EnqRefer;
//    int? createdby;
//      String?  createdDate;
//   int?  updatedby;
//    String? updateddate;
//   String?  u_Followupdate;
//   String?  closed;


//   factory AssignedToUserData.fromJson(Map<String, dynamic> json) =>
//    AssignedToUserData(
//       activity: json['activity'], 
//     activityType: json['activityType'], 
//     closed: json['closed'], 
//     createdDate: json['createdDate'], 
//     createdby: json['createdby'], 
//     customerCode: json['customerCode'], 
//     id: json['id'], 
//     potentialvalue: json['potentialvalue'], 
//     u_AssignedTo: json['u_AssignedTo'], 
//     u_EnqRefer: json['u_EnqRefer'], 
//     u_EnqStatus: json['u_EnqStatus'], 
//     u_Followupdate: json['u_Followupdate'], 
//     u_Lookingfor: json['u_Lookingfor'], 
//     u_ManagerSlp: json['u_ManagerSlp'], 
//     updatedby: json['updatedby'], 
//     updateddate: json['updateddate']
//      );
   
// }

