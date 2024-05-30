import 'dart:convert';

import 'package:sellerkit/DBModel/enquiry_filterdbmodel.dart';

class EnquiriesModal {
  EnquiriesHeader? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  EnquiriesModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory EnquiriesModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = json.decode(jsons) as Map<>;
      // List<EnquiriesData> dataList =
      //     list.map((data) => EnquiriesData.fromJson(data)).toList();
      return EnquiriesModal(
          itemdata: EnquiriesHeader.fromJson(jsons),
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return EnquiriesModal(
          itemdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory EnquiriesModal.issues(Map<String, dynamic> jsons, int stcode) {
    return EnquiriesModal(
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory EnquiriesModal.error(String jsons, int stcode) {
    return EnquiriesModal(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class EnquiriesHeader {
  EnquiriesHeader({
    //  required this.respCode,
    required this.datadetail,
    //  required this.respDesc,
    //  required this.respType

    // required this.customertag
  });

  // String? respType;
  //   String? respCode;
  //   String? respDesc;
  List<EnquiriesData>? datadetail;

  factory EnquiriesHeader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;
    if (list.isEmpty) {
      return EnquiriesHeader(
        // respCode: jsons['respCode'],
        datadetail: null,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    } else {
      List<EnquiriesData> dataList =
          list.map((data) => EnquiriesData.fromJson(data)).toList();
      return EnquiriesHeader(
        // respCode: jsons['respCode'],
        datadetail: dataList,
        // respDesc: jsons['respDesc'],
        // respType: jsons['respType']
      );
    }
  }
}

class EnquiriesData {
  int? EnqID; //
  String? EnquiredOn;
  String? CardCode; //
  String? CardName; //
  String? EnqDate; //
  String? Followup; //
  String? Status; //
  String? Mgr_UserCode; //
  String? Mgr_UserName; //
  String? AssignedTo_User; //
  String? AssignedTo_UserName; //
  String? EnqType;
  String? Lookingfor; //
  double? PotentialValue; //
  String? Address_Line_1; //
  String? Address_Line_2; //
  String? Pincode; //
  String? City; //
  String? State; //
  String? Country; //
  String? Manager_Status_Tab; //
  String? Slp_Status_Tab; //
  String? email; //
  String? referal; //
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
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  String? InterestLevel;
  String? OrderType;

  EnquiriesData({
    required this.InterestLevel,
    required this.OrderType,
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
  });
  factory EnquiriesData.fromJson(Map<String, dynamic> json) => EnquiriesData(
      InterestLevel: json['InterestLevel'] ?? '',
      OrderType: json['OrderType'] ?? '',
      EnqID: json['EnquiryID'] ?? 0, //
      CardCode: json['CustomerCode'] ?? '', //
      Status: json['CurrentStatus'] ?? '', //
      CardName: json['CustomerName'] ?? '', //
      EnqDate: json['EnquiredOn'] ?? '', //
      Followup: json['FollowupOn'] ?? '', //
      Mgr_UserCode: json['mgr_UserCode'] ?? '',
      AssignedTo_UserName: json['AssignedTo'] ?? '', //
      Mgr_UserName: json['mgr_UserName'] ?? '',
      AssignedTo_User: json['assignedTo_User'] ?? '',
      EnqType: json['EnquiryType'] ?? '', //
      Lookingfor: json['Lookingfor'] ?? '', //
      PotentialValue: json['Potentialvalue'] ?? 0.00, //
      Address_Line_1: json['Address1'] ?? '', //
      Address_Line_2: json['Address2'] ?? '', //
      Pincode: json['PinCode'].toString() ?? '', //
      City: json['City'] ?? '', //
      State: json['State'] ?? '', //
      Country: json['Country'] ?? '', //
      Manager_Status_Tab: json['manager_Status_Tab'] ?? '',
      Slp_Status_Tab: json['EnquiryStatus'] ?? '', //
      email: json['CustomerEmail'] ?? '', //
      referal: json['Refferal'] ?? '', //
      contactName: json['ContactName'] ?? '', //
      customerGroup: json['CustomerGroup'] ?? '', //
      altermobileNo: json['AlternateMobileNo'] ?? '',
      customermobile: json["CustomerMobile"] ?? '', //
      comapanyname: json['CompanyName'] ?? '', //
      storecode: json['StoreCode'] ?? '', //
      area: json['BilArea'] ?? '', //
      district: json['District'] ?? '', //
      itemCode: json['ItemCode'] ?? '', //
      itemname: json['ItemName'] ?? '', //
      enquirydscription: json['Enquirydscription'] ?? '', //
      quantity: json['Quantity'], //
      isVisitRequired: json["IsVisitRequired"] ?? '', //
      visitTime: json['VisitTime'] ?? '', //
      remindOn: json['RemindOn'] ?? '', //
      isClosed: json['isClosed'] ?? '', //
      leadConverted: json['LeadConverted'],
      createdBy: json["CreatedBy"],
      createdDateTime: json['CreatedDateTime'],
      updatedBy: json['UpdatedBy'],
      updatedDateTime: json['UpdatedDateTime']);

  Map<String, Object?> toMap() => {
        EnquiryfilterDBcolumns.enqID: EnqID,
        EnquiryfilterDBcolumns.enquiredOn: EnquiredOn,
        EnquiryfilterDBcolumns.cardCode: CardCode,
        EnquiryfilterDBcolumns.cardName: CardName,
        EnquiryfilterDBcolumns.enqDate: EnqDate,
        EnquiryfilterDBcolumns.followup: Followup,
        EnquiryfilterDBcolumns.status: Status,
        EnquiryfilterDBcolumns.mgrUserCode: Mgr_UserCode,
        EnquiryfilterDBcolumns.mgrUserName: Mgr_UserName,
        EnquiryfilterDBcolumns.assignedToUser: AssignedTo_User,
        EnquiryfilterDBcolumns.assignedToUserName: AssignedTo_UserName,
        EnquiryfilterDBcolumns.enqType: EnqType,
        EnquiryfilterDBcolumns.lookingfor: Lookingfor,
        EnquiryfilterDBcolumns.potentialValue: PotentialValue,
        EnquiryfilterDBcolumns.addressLine1: Address_Line_1,
        EnquiryfilterDBcolumns.addressLine2: Address_Line_2,
        EnquiryfilterDBcolumns.pincode: Pincode,
        EnquiryfilterDBcolumns.city: City,
        EnquiryfilterDBcolumns.state: State,
        EnquiryfilterDBcolumns.country: Country,
        EnquiryfilterDBcolumns.managerStatusTab: Manager_Status_Tab,
        EnquiryfilterDBcolumns.slpStatusTab: Slp_Status_Tab,
        EnquiryfilterDBcolumns.email: email,
        EnquiryfilterDBcolumns.referal: referal,
        EnquiryfilterDBcolumns.contactName: contactName,
        EnquiryfilterDBcolumns.altermobileNo: altermobileNo,
        EnquiryfilterDBcolumns.customerGroup: customerGroup,
        EnquiryfilterDBcolumns.customermobile: customermobile,
        EnquiryfilterDBcolumns.comapanyname: comapanyname,
        EnquiryfilterDBcolumns.storecode: storecode,
        EnquiryfilterDBcolumns.area: area,
        EnquiryfilterDBcolumns.district: district,
        EnquiryfilterDBcolumns.itemCode: itemCode,
        EnquiryfilterDBcolumns.itemname: itemname,
        EnquiryfilterDBcolumns.enquirydscription: enquirydscription,
        EnquiryfilterDBcolumns.quantity: quantity,
        EnquiryfilterDBcolumns.isVisitRequired: isVisitRequired,
        EnquiryfilterDBcolumns.visitTime: visitTime,
        EnquiryfilterDBcolumns.remindOn: remindOn,
        EnquiryfilterDBcolumns.isClosed: isClosed,
        EnquiryfilterDBcolumns.leadConverted: leadConverted,
        EnquiryfilterDBcolumns.createdBy: createdBy,
        EnquiryfilterDBcolumns.createdDateTime: createdDateTime,
        EnquiryfilterDBcolumns.updatedBy: updatedBy,
        EnquiryfilterDBcolumns.updatedDateTime: updatedDateTime,
        EnquiryfilterDBcolumns.interestLevel: InterestLevel,
        EnquiryfilterDBcolumns.orderType: OrderType,
      };
}

///older code
// import 'dart:convert';

// class EnquiriesModal {
// List<EnquiriesData>? itemdata;
//   String message;
//   bool? status;
//   String? exception;
//   int?stcode;
//   EnquiriesModal(
//       {required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode
//       });
//   factory EnquiriesModal.fromJson(List< dynamic> jsons,int stcode) {
//     if (jsons != null && jsons.isNotEmpty) {
//       var list = jsons as List;
//       List<EnquiriesData> dataList =
//           list.map((data) => EnquiriesData.fromJson(data)).toList();
//       return EnquiriesModal(
//         itemdata: dataList,
//         message: "Success",
//         status: true,
//         stcode: stcode,
//         exception:null
//       );
//     } else {
//       return EnquiriesModal(
//         itemdata: null,
//         message:"Failure",
//         status: false,
//         stcode: stcode,
//         exception:null
//       );
//     }
//   }

//   factory EnquiriesModal.error(String jsons,int stcode) {
//     return EnquiriesModal(
//         itemdata: null, message: 'Exception', status: null,   stcode: stcode,
//         exception:jsons);
//   }
// }

// class EnquiriesData {
//   EnquiriesData({
//     required this.Mgr_UserName,
//     required this.EnqID,
//     required this.CardCode,
//     required this.Status,
//     required this.CardName,
//     required this.AssignedTo_User,
//     required this.EnqDate,
//     required this.Followup,
//     required this.Mgr_UserCode,
//     required this.AssignedTo_UserName,
//     required this.EnqType,
//      required this.Lookingfor,
//     required this.PotentialValue,
//     required this.Address_Line_1,
//     required this.Address_Line_2,
//     required this.Pincode,
//     required this.City,
//     required this.State,
//     required this.Country,
//     required this.Manager_Status_Tab,
//     required this.Slp_Status_Tab,
//      required this.email,
//     required this.referal,
//    // required this.customertag
//   });

//   int? EnqID;//
//   String? CardCode;//
//   String? CardName;//
//   String? EnqDate;//
//   String? Followup;//
//   String? Status;//
//   String? Mgr_UserCode;//
//   String? Mgr_UserName;//
//   String? AssignedTo_User;//
//   String? AssignedTo_UserName;//
//   String? EnqType;
//   String? Lookingfor;//
//   double? PotentialValue;//
//   String? Address_Line_1;//
//   String? Address_Line_2;//
//   String? Pincode;//
//   String? City;//
//   String? State;//
//   String? Country;//
//   String? Manager_Status_Tab;//
//   String? Slp_Status_Tab;//
//   String? email;//
//   String? referal;//
//  // String? customertag;
//  String? contactName;
//  String? altermobileNo;
//  String? customerGroup;

//   factory EnquiriesData.fromJson(Map<String, dynamic> json) =>
//    EnquiriesData(
//      EnqID: json['enqID'] ?? 0,
//      CardCode: json['cardCode'] ?? '',
//      Status: json['status'] ?? '',
//      CardName: json['cardName'] ?? '',
//      EnqDate: json['enqDate'] ?? '',
//      Followup: json['followup'] ?? '',
//      Mgr_UserCode: json['mgr_UserCode'] ?? '',
//      AssignedTo_UserName: json['assignedTo_UserName']?? '',
//      Mgr_UserName: json['mgr_UserName'] ?? '',
//      AssignedTo_User: json['assignedTo_User'] ?? '',
//      EnqType:json['EnqType']?? '',
//      Lookingfor: json['lookingfor'] ?? '',
//      PotentialValue: json['potentialValue'] ?? 0.00,
//      Address_Line_1: json['address_Line_1'] ?? '',
//      Address_Line_2: json['address_Line_2'] ?? '',
//      Pincode: json['pincode']?? '',
//      City: json['city'] ??'',
//      State: json['state'] ?? '',
//      Country:json['country']?? '',
//       Manager_Status_Tab: json['manager_Status_Tab'] ?? '',
//      Slp_Status_Tab: json['slp_Status_Tab'] ?? '',
//       email: json['email'] ??'',
//     referal: json['u_EnqRefer'] ??'',
//     // customertag:json['customertag'] ?? '',
//      );

// }

// //json
// //  {
// //         "enqID": 49,
// //         "cardCode": "9566580463",
// //         "status": "NEW ENQUIRY",
// //         "cardName": "anbu",
// //         "enqDate": "2023-11-10T15:59:39.7",
// //         "followup": null,
// //         "mgr_UserCode": "SLP001",
// //         "mgr_UserName": "Administrator",
// //         "assignedTo_User": "684",
// //         "assignedTo_UserName": "VELMURUGAN T",
// //         "lookingfor": "SA",
// //         "potentialValue": 0.00,
// //         "address_Line_1": null,
// //         "address_Line_2": null,
// //         "pincode": null,
// //         "city": null,
// //         "state": null,
// //         "country": null,
// //         "manager_Status_Tab": "Assigned",
// //         "slp_Status_Tab": "Open",
// //         "email": "annbu@gmail.com",
// //         "u_EnqRefer": "FACEBOOK AD"
// //     }
