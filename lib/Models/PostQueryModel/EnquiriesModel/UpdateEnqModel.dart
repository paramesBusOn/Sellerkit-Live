// import 'dart:convert';
// import 'dart:developer';

// class UpdateEnqModal {
// UpdateEnqData? userLtData;
//   String message;
//   bool? status;
//   String? exception;
//   int?stcode;
//   UpdateEnqModal(
//       {required this.userLtData,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode
//       });
//   factory UpdateEnqModal.fromJson(Map<String, dynamic> jsons,int stcode) {
//     log("update"+jsons.toString());
//     if (jsons != null && jsons.isNotEmpty) {
//       // var list = json.decode(jsons) as List;
//       // List<UpdateEnqData> dataList =
//       //     list.map((data) => UpdateEnqData.fromJson(data)).toList();
//       return UpdateEnqModal(
//         userLtData:UpdateEnqData.fromJson(jsons) ,
//         message: "Success",
//         status: true,
//         stcode: stcode,
//         exception:null
//       );
//     } else {
//       return UpdateEnqModal(
//         userLtData: null,
//         message: "Failure",
//         status: false,
//         stcode: stcode,
//         exception:null
//       );
//     }
//   }

//   factory UpdateEnqModal.error(String jsons,int stcode) {
//     return UpdateEnqModal(
//         userLtData: null, message: 'Exception', status: null,   stcode: stcode,
//         exception:jsons);
//   }
// }

// class UpdateEnqData {
//   UpdateEnqData({
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
// // int? id;

// // String?    customerCode;
// //  String?   customerName;
// //   String?  mobileNo;
// //  String?   alternateMobileNo;
// // String?    contactName;
// //   String?  facebook;
// //  String?   cardtype;
// // String?    email;
// //  String?   gstNo;
// // String?    codeId;
// // int?    createdBy;
// //  String?   createdOn;
// //  int?   updatedBy;
// //  String?   updatedOn;
// //  String?   address1;
// //  String?   address2;
// // String?    address3;
// //  String?   city;
// //  String?   state;
// //  String?   country;
// //  String?   pinCode;
// //  String?   shippingAddress1;
// // String?    shippingAddress2;
// //  String?   shippingAddress3;
// // String?    shippingCity;
// //  String?   shippingState;
// //  String?   shippingCountry;
// //  String?   shippingPinCode;
// //  String?   tag;
// //  bool?   status;
//   // String? actionResponce;
//   // String? actionResponseMessage;


//   factory UpdateEnqData.fromJson(Map<String, dynamic> json) =>
//    UpdateEnqData(
//     activity: json['activity'], 
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
//     updateddate: json['updateddate']);
   
// }
