import 'dart:convert';
import 'dart:developer';

// class GetCustomerDetailsModal {
//  GetCustomerDataHeader itemdata;
//   String message;
//   bool? status;
//   String? exception;
//   int? stcode;
//   GetCustomerDetailsModal(
//       {
//         required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode});
//   factory GetCustomerDetailsModal.fromJson(
//       Map<String, dynamic> jsons, int stcode) {
//     if (jsons != null && jsons.isNotEmpty) {
//       // var list = jsons as Map<String,dynamic>;
//       // log("list::"+list.toString());
//       // List<EnquiriesData> dataList =
//       //     list.map((data) => EnquiriesData.fromJson(data)).toList();
//       return GetCustomerDetailsModal(
//           itemdata: GetCustomerDataHeader.fromJson(jsons),
//           message: "Success",
//           status: true,
//           stcode: stcode,
//           exception: null);
//     } else {
//       return GetCustomerDetailsModal(
//           itemdata: null,
//           message: "Failure",
//           status: false,
//           stcode: stcode,
//           exception: null);
//     }
//   }
//   factory GetCustomerDetailsModal.issues(
//       Map<String, dynamic> jsons, int stcode) {
//     return GetCustomerDetailsModal(
//         itemdata: null,
//         message: jsons['respType'],
//         status: null,
//         stcode: stcode,
//         exception: jsons['respDesc']);
//   }
//   factory GetCustomerDetailsModal.error(String jsons, int stcode) {
//     return GetCustomerDetailsModal(
//         itemdata: null,
//         message: 'Exception',
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

class GetCustomerDataHeader {
  GetCustomerDataHeader(
      {required this.respCode,
      required this.itemdata,
      required this.respDesc,
      required this.respType,
      this.stcode,
      this.exception,
      this.message,
      this.status

      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  GetCustomerDataHeadertwo? itemdata;
  int? stcode;
  String? message;
  bool? status;
  String? exception;
//   int? stcode;

  factory GetCustomerDataHeader.fromJson(Map<String, dynamic> jsons,int stcode) {
   
    if (jsons['data'] != null) {
      var list = json.decode(jsons['data'] as String ) as Map<String,dynamic>;
    //   if(list.isNotEmpty ||list != null){
      //  List<GetCustomerData> dataList =
      //   list.map((data) => GetCustomerData.fromJson(data)).toList();
      return GetCustomerDataHeader(
          respCode: jsons['respCode']??'',
          itemdata: GetCustomerDataHeadertwo.fromJson(list),
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
           message: "Success",
          status: true,
          stcode: stcode,
          exception: null
          
          );

      // }else{
      //    return GetCustomerDataHeader(
      // respCode: jsons['respCode'],
      //   datadetail: null,
      //   respDesc: jsons['respDesc'],
      //   respType: jsons['respType']
      //   );
      // }
    } else {
      return GetCustomerDataHeader(
          respCode: jsons['respCode'],
          itemdata: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
           message: "Failure",
          status: false,
          stcode: stcode,
          exception: null
          
          );
    }
  }
    factory GetCustomerDataHeader.error(String jsons, int stcode) {
    return GetCustomerDataHeader(
      respCode: null,
          
          respDesc: null,
          respType: null,
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
   factory GetCustomerDataHeader.issues(
      Map<String, dynamic> jsons, int stcode) {
    return GetCustomerDataHeader(
      respCode: null,
          
          respDesc: null,
          respType: null,
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
}

class GetCustomerDataHeadertwo {
  GetCustomerDataHeadertwo(
      {required this.customerdetails,
      required this.enquirydetails,
      // required this.leaddetails,
      // required this.quotationdetails,
      // required this.orderdetails
      });

  List<GetCustomerData>? customerdetails;
  List<GetenquiryData>? enquirydetails;
  // List<GetleadData>? leaddetails;
  // List<GetQuotationData>? quotationdetails;
  // List<GetorderData>? orderdetails;

  factory GetCustomerDataHeadertwo.fromJson(Map<String, dynamic> jsons) {
    // var list6=jsons[""];\
   
    if (jsons["customers"] != null || jsons["Trans"] != null) {
      var list1 = jsons["customers"] as List;
     var list2 = jsons["Trans"] as List;
     List<GetCustomerData> dataList =
        list1.map((data) => GetCustomerData.fromJson(data)).toList();
      log("list1::"+list1.toString());
      if(list2.isNotEmpty){
 List<GetenquiryData> dataList2 =
        list2.map((data) => GetenquiryData.fromJson(data)).toList();
        return GetCustomerDataHeadertwo(
          customerdetails: dataList, 
          enquirydetails: dataList2
          );

      }else{
         return GetCustomerDataHeadertwo(
          customerdetails: dataList, 
          enquirydetails: null
          );
      }
     
    } else {
      return GetCustomerDataHeadertwo(
          customerdetails: null,
          enquirydetails: null,
          );
    }
  }
}

class GetCustomerData {
  int? ID; //
  String? EnquiredOn;
  String? customerCode; //
  String? customerName; //
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
  String? mobileNo;
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
  String? createdBy;
  String? createdDateTime;
  String? updatedBy;
  String? updatedDateTime;
  String? gst;
  String? codeid;
  String? address3;
  String? del_Address1;
  String? del_Address2;
  String? del_Address3;
  String? del_Area;
  String? del_city;
  String? del_district;
  String? del_state;
  String? del_country;
  String? del_pincode;
  String? pan;
  String? website;
  String? facebook;
  String? cardtype;

  String? status;

  GetCustomerData({
    required this.del_Address1,
    required this.del_Address2,
    required this.del_Address3,
    required this.del_Area,
    required this.del_city,
    required this.del_country,
    required this.del_district,
    required this.del_pincode,
    required this.del_state,
    required this.pan,
    required this.website,
    required this.facebook,
    required this.cardtype,
    required this.status,
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
    required this.ID,
    required this.customerCode,
    required this.Status,
    required this.customerName,
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
    required this.gst,
    required this.mobileNo,
    required this.codeid,
    required this.address3,
  });
  factory GetCustomerData.fromJson(Map<String, dynamic> json) =>
      GetCustomerData(
          ID: json['Id'] ?? 0, //
          customerCode: json['CustomerCode'] ?? '', //
          Status: json['CurrentStatus'] ?? '',
          customerName: json['CustomerName'] ?? '', //
          EnqDate: json['EnquiredOn'] ?? '',
          Followup: json['FollowupOn'] ?? '',
          Mgr_UserCode: json['mgr_UserCode'] ?? '',
          AssignedTo_UserName: json['AssignedTo'] ?? '',
          Mgr_UserName: json['mgr_UserName'] ?? '',
          AssignedTo_User: json['assignedTo_User'] ?? '',
          EnqType: json['EnquiryType'] ?? '',
          Lookingfor: json['Lookingfor'] ?? '',
          PotentialValue: json['Potentialvalue'] ?? 0.00,
          Address_Line_1: json['Bil_Address1'] ?? '', //
          Address_Line_2: json['Bil_Address2'] ?? '', //
          Pincode: json['Bil_Pincode'] .toString(), //
          City: json['Bil_City'] ?? '', //
          State: json['Bil_State'] ?? '', //
          codeid: json["CodeId"], //
          Country: json['Country'] ?? '',
          Manager_Status_Tab: json['manager_Status_Tab'] ?? '',
          Slp_Status_Tab: json['EnquiryStatus'] ?? '',
          email: json['CustomerEmail'] ?? '', //
          referal: json['Refferal'] ?? '',
          contactName: json['ContactName'], //
          customerGroup: json['CustomerGroup'], //
          altermobileNo: json['AlternateMobileNo'], //
          mobileNo: json["CustomerMobile"], //
          comapanyname: json['CompanyName'], //
          storecode: json['StoreCode'], //
          area: json['Bil_Area'], //
          gst: json["GSTNo"], //
          address3: json["Bil_Address3"], //
          district: json['Bil_District'], //
          itemCode: json['ItemCode'],
          itemname: json['ItemName'],
          enquirydscription: json['Enquirydscription'],
          quantity: json['Quantity'],
          isVisitRequired: json["IsVisitRequired"],
          visitTime: json['VisitTime'],
          remindOn: json['RemindOn'],
          isClosed: json['isClosed'],
          leadConverted: json['LeadConverted'],
          createdBy: json["CreatedBy"],
          createdDateTime: json['CreatedOn'],
          updatedBy: json['UpdatedBy'],
          updatedDateTime: json['UpdatedOn'],
          del_Address1: json['Del_Address1'], //
          del_Address2: json["Del_Address2"], //
          del_Address3: json['Del_Address3'], //
          del_Area: json['Del_Area'], //
          del_city: json['Del_City'], //
          del_country: json['Del_Country'], //
          del_district: json["Del_District"], //
          del_pincode: json['Del_Pincode'], //
          del_state: json['Del_State'], //
          pan: json['PAN'], //
          facebook: json['Facebook'], //
          website: json['Website'], //
          cardtype: json['cardtype'], //
          status: json['Status'] //

          );
}
class GetenquiryData{
  String? DocType;
  int? DocNum;
  String? DocDate;
  String? Store;
  double? BusinessValue;
  String? AssignedTo;
  String? CurrentStatus;
  String? Status;
  GetenquiryData({
required this.DocType,
required this.AssignedTo,
required this.BusinessValue,
required this.CurrentStatus,
required this.DocDate,
required this.DocNum,
required this.Status,
required this.Store
  });
   factory GetenquiryData.fromJson(Map<String, dynamic> json) =>GetenquiryData(
    DocType: json['DocType']??'', 
    AssignedTo: json['AssignedTo']??'', 
    BusinessValue: json['BusinessValue']??0.0, 
    CurrentStatus: json['CurrentStatus']??'', 
    DocDate: json['DocDate'], 
    DocNum: json['DocNum']??'', 
    Status: json['Status']??'', 
    Store: json['Store']
    );
}
// class GetenquiryData {
//   int? enquiryID;
//   String? enquiredOn;
//   String? customerCode;
//   String? customerName;
//   String? contactName;
//   String? customerMobile;
//   String? alternateMobileNo;
//   String? companyName;
//   String? customerEmail;
//   String? customerGroup;
//   String? storeCode;
//   String? address1;
//   String? address2;
//   String? pinCode;
//   String? bilArea;
//   String? city;
//   String? district;
//   String? state;
//   String? country;
//   double? potentialvalue;
//   String? itemCode;
//   String? itemName;
//   String? assignedTo;
//   String? refferal;
//   String? enquiryType;
//   String? lookingfor;
//   String? enquirydscription;
//   double? quantity;
//   String? followupOn;
//   String? isVisitRequired;
//   String? visitTime;
//   String? remindOn;
//   String? currentStatus;
//   String? enquiryStatus;
//   String? isClosed;
//   bool? leadConverted;
//   int? createdBy;
//   String? createdDateTime;
//   int? updatedBy;
//   String? updatedDateTime;
//   GetenquiryData(
//       {required this.address1,
//       required this.address2,
//       required this.alternateMobileNo,
//       required this.assignedTo,
//       required this.bilArea,
//       required this.city,
//       required this.companyName,
//       required this.contactName,
//       required this.country,
//       required this.createdBy,
//       required this.createdDateTime,
//       required this.currentStatus,
//       required this.customerCode,
//       required this.customerEmail,
//       required this.customerGroup,
//       required this.customerMobile,
//       required this.customerName,
//       required this.district,
//       required this.enquiredOn,
//       required this.enquiryID,
//       required this.enquiryStatus,
//       required this.enquiryType,
//       required this.enquirydscription,
//       required this.followupOn,
//       required this.isClosed,
//       required this.isVisitRequired,
//       required this.itemCode,
//       required this.itemName,
//       required this.leadConverted,
//       required this.lookingfor,
//       required this.pinCode,
//       required this.potentialvalue,
//       required this.quantity,
//       required this.refferal,
//       required this.remindOn,
//       required this.state,
//       required this.storeCode,
//       required this.updatedBy,
//       required this.updatedDateTime,
//       required this.visitTime});
//   factory GetenquiryData.fromJson(Map<String, dynamic> json) => GetenquiryData(
//       address1: json['Address1'],
//       address2: json['Address2'],
//       alternateMobileNo: json['AlternateMobileNo'],
//       assignedTo: json['AssignedTo'],
//       bilArea: json['BilArea'],
//       city: json['City'],
//       companyName: json['CompanyName'],
//       contactName: json['ContactName'],
//       country: json['Country'],
//       createdBy: json['CreatedBy'],
//       createdDateTime: json['CreatedDateTime'],
//       currentStatus: json['CurrentStatus'],
//       customerCode: json['CustomerCode'],
//       customerEmail: json['CustomerEmail'],
//       customerGroup: json['CustomerGroup'],
//       customerMobile: json['CustomerMobile'],
//       customerName: json['CustomerName'],
//       district: json['District'],
//       enquiredOn: json['EnquiredOn'],
//       enquiryID: json['EnquiryID'],
//       enquiryStatus: json['EnquiryStatus'],
//       enquiryType: json['EnquiryType'],
//       enquirydscription: json['Enquirydscription'],
//       followupOn: json['FollowupOn'],
//       isClosed: json['isClosed'],
//       isVisitRequired: json['IsVisitRequired'],
//       itemCode: json['ItemCode'],
//       itemName: json['ItemName'],
//       leadConverted: json['LeadConverted'],
//       lookingfor: json['Lookingfor'],
//       pinCode: json['PinCode'].toString(),
//       potentialvalue: json['Potentialvalue'],
//       quantity: json['Quantity'],
//       refferal: json['Refferal'],
//       remindOn: json['RemindOn'],
//       state: json['State'],
//       storeCode: json['StoreCode'],
//       updatedBy: json['UpdatedBy'],
//       updatedDateTime: json['UpdatedDateTime'],
//       visitTime: json['VisitTime']);
// }

//Lead

class GetleadData {
  int? enquiryID;
  String? enquiredOn;
  String? customerCode;
  String? customerName;
  String? contactName;
  String? customerMobile;
  String? alternateMobileNo;
  String? companyName;
  String? customerEmail;
  String? customerGroup;
  String? storeCode;
  String? address1;
  String? address2;
  String? pinCode;
  String? bilArea;
  String? city;
  String? district;
  String? state;
  String? country;
  double? potentialvalue;
  String? itemCode;
  String? itemName;
  String? assignedTo;
  String? refferal;
  String? enquiryType;
  String? lookingfor;
  String? enquirydscription;
  double? quantity;
  String? followupOn;
  String? isVisitRequired;
  String? visitTime;
  String? remindOn;
  String? currentStatus;
  String? enquiryStatus;
  String? isClosed;
  bool? leadConverted;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  GetleadData(
      {required this.address1,
      required this.address2,
      required this.alternateMobileNo,
      required this.assignedTo,
      required this.bilArea,
      required this.city,
      required this.companyName,
      required this.contactName,
      required this.country,
      required this.createdBy,
      required this.createdDateTime,
      required this.currentStatus,
      required this.customerCode,
      required this.customerEmail,
      required this.customerGroup,
      required this.customerMobile,
      required this.customerName,
      required this.district,
      required this.enquiredOn,
      required this.enquiryID,
      required this.enquiryStatus,
      required this.enquiryType,
      required this.enquirydscription,
      required this.followupOn,
      required this.isClosed,
      required this.isVisitRequired,
      required this.itemCode,
      required this.itemName,
      required this.leadConverted,
      required this.lookingfor,
      required this.pinCode,
      required this.potentialvalue,
      required this.quantity,
      required this.refferal,
      required this.remindOn,
      required this.state,
      required this.storeCode,
      required this.updatedBy,
      required this.updatedDateTime,
      required this.visitTime});
  factory GetleadData.fromJson(Map<String, dynamic> json) => GetleadData(
      address1: json['Address1'],
      address2: json['Address2'],
      alternateMobileNo: json['AlternateMobileNo'],
      assignedTo: json['AssignedTo'],
      bilArea: json['BilArea'],
      city: json['City'],
      companyName: json['CompanyName'],
      contactName: json['ContactName'],
      country: json['Country'],
      createdBy: json['CreatedBy'],
      createdDateTime: json['CreatedDateTime'],
      currentStatus: json['CurrentStatus'],
      customerCode: json['CustomerCode'],
      customerEmail: json['CustomerEmail'],
      customerGroup: json['CustomerGroup'],
      customerMobile: json['CustomerMobile'],
      customerName: json['CustomerName'],
      district: json['District'],
      enquiredOn: json['EnquiredOn'],
      enquiryID: json['EnquiryID'],
      enquiryStatus: json['EnquiryStatus'],
      enquiryType: json['EnquiryType'],
      enquirydscription: json['Enquirydscription'],
      followupOn: json['FollowupOn'],
      isClosed: json['isClosed'],
      isVisitRequired: json['IsVisitRequired'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      leadConverted: json['LeadConverted'],
      lookingfor: json['Lookingfor'],
      pinCode: json['PinCode'].toString(),
      potentialvalue: json['Potentialvalue'],
      quantity: json['Quantity'],
      refferal: json['Refferal'],
      remindOn: json['RemindOn'],
      state: json['State'],
      storeCode: json['StoreCode'],
      updatedBy: json['UpdatedBy'],
      updatedDateTime: json['UpdatedDateTime'],
      visitTime: json['VisitTime']);
}

//Quotation
class GetQuotationData {
  int? enquiryID;
  String? enquiredOn;
  String? customerCode;
  String? customerName;
  String? contactName;
  String? customerMobile;
  String? alternateMobileNo;
  String? companyName;
  String? customerEmail;
  String? customerGroup;
  String? storeCode;
  String? address1;
  String? address2;
  String? pinCode;
  String? bilArea;
  String? city;
  String? district;
  String? state;
  String? country;
  double? potentialvalue;
  String? itemCode;
  String? itemName;
  String? assignedTo;
  String? refferal;
  String? enquiryType;
  String? lookingfor;
  String? enquirydscription;
  double? quantity;
  String? followupOn;
  String? isVisitRequired;
  String? visitTime;
  String? remindOn;
  String? currentStatus;
  String? enquiryStatus;
  String? isClosed;
  bool? leadConverted;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  GetQuotationData(
      {required this.address1,
      required this.address2,
      required this.alternateMobileNo,
      required this.assignedTo,
      required this.bilArea,
      required this.city,
      required this.companyName,
      required this.contactName,
      required this.country,
      required this.createdBy,
      required this.createdDateTime,
      required this.currentStatus,
      required this.customerCode,
      required this.customerEmail,
      required this.customerGroup,
      required this.customerMobile,
      required this.customerName,
      required this.district,
      required this.enquiredOn,
      required this.enquiryID,
      required this.enquiryStatus,
      required this.enquiryType,
      required this.enquirydscription,
      required this.followupOn,
      required this.isClosed,
      required this.isVisitRequired,
      required this.itemCode,
      required this.itemName,
      required this.leadConverted,
      required this.lookingfor,
      required this.pinCode,
      required this.potentialvalue,
      required this.quantity,
      required this.refferal,
      required this.remindOn,
      required this.state,
      required this.storeCode,
      required this.updatedBy,
      required this.updatedDateTime,
      required this.visitTime});
  factory GetQuotationData.fromJson(Map<String, dynamic> json) =>
      GetQuotationData(
          address1: json['Address1'],
          address2: json['Address2'],
          alternateMobileNo: json['AlternateMobileNo'],
          assignedTo: json['AssignedTo'],
          bilArea: json['BilArea'],
          city: json['City'],
          companyName: json['CompanyName'],
          contactName: json['ContactName'],
          country: json['Country'],
          createdBy: json['CreatedBy'],
          createdDateTime: json['CreatedDateTime'],
          currentStatus: json['CurrentStatus'],
          customerCode: json['CustomerCode'],
          customerEmail: json['CustomerEmail'],
          customerGroup: json['CustomerGroup'],
          customerMobile: json['CustomerMobile'],
          customerName: json['CustomerName'],
          district: json['District'],
          enquiredOn: json['EnquiredOn'],
          enquiryID: json['EnquiryID'],
          enquiryStatus: json['EnquiryStatus'],
          enquiryType: json['EnquiryType'],
          enquirydscription: json['Enquirydscription'],
          followupOn: json['FollowupOn'],
          isClosed: json['isClosed'],
          isVisitRequired: json['IsVisitRequired'],
          itemCode: json['ItemCode'],
          itemName: json['ItemName'],
          leadConverted: json['LeadConverted'],
          lookingfor: json['Lookingfor'],
          pinCode: json['PinCode'].toString(),
          potentialvalue: json['Potentialvalue'],
          quantity: json['Quantity'],
          refferal: json['Refferal'],
          remindOn: json['RemindOn'],
          state: json['State'],
          storeCode: json['StoreCode'],
          updatedBy: json['UpdatedBy'],
          updatedDateTime: json['UpdatedDateTime'],
          visitTime: json['VisitTime']);
}
//Orders

class GetorderData {
  int? enquiryID;
  String? enquiredOn;
  String? customerCode;
  String? customerName;
  String? contactName;
  String? customerMobile;
  String? alternateMobileNo;
  String? companyName;
  String? customerEmail;
  String? customerGroup;
  String? storeCode;
  String? address1;
  String? address2;
  String? pinCode;
  String? bilArea;
  String? city;
  String? district;
  String? state;
  String? country;
  double? potentialvalue;
  String? itemCode;
  String? itemName;
  String? assignedTo;
  String? refferal;
  String? enquiryType;
  String? lookingfor;
  String? enquirydscription;
  double? quantity;
  String? followupOn;
  String? isVisitRequired;
  String? visitTime;
  String? remindOn;
  String? currentStatus;
  String? enquiryStatus;
  String? isClosed;
  bool? leadConverted;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  GetorderData(
      {required this.address1,
      required this.address2,
      required this.alternateMobileNo,
      required this.assignedTo,
      required this.bilArea,
      required this.city,
      required this.companyName,
      required this.contactName,
      required this.country,
      required this.createdBy,
      required this.createdDateTime,
      required this.currentStatus,
      required this.customerCode,
      required this.customerEmail,
      required this.customerGroup,
      required this.customerMobile,
      required this.customerName,
      required this.district,
      required this.enquiredOn,
      required this.enquiryID,
      required this.enquiryStatus,
      required this.enquiryType,
      required this.enquirydscription,
      required this.followupOn,
      required this.isClosed,
      required this.isVisitRequired,
      required this.itemCode,
      required this.itemName,
      required this.leadConverted,
      required this.lookingfor,
      required this.pinCode,
      required this.potentialvalue,
      required this.quantity,
      required this.refferal,
      required this.remindOn,
      required this.state,
      required this.storeCode,
      required this.updatedBy,
      required this.updatedDateTime,
      required this.visitTime});
  factory GetorderData.fromJson(Map<String, dynamic> json) => GetorderData(
      address1: json['Address1'],
      address2: json['Address2'],
      alternateMobileNo: json['AlternateMobileNo'],
      assignedTo: json['AssignedTo'],
      bilArea: json['BilArea'],
      city: json['City'],
      companyName: json['CompanyName'],
      contactName: json['ContactName'],
      country: json['Country'],
      createdBy: json['CreatedBy'],
      createdDateTime: json['CreatedDateTime'],
      currentStatus: json['CurrentStatus'],
      customerCode: json['CustomerCode'],
      customerEmail: json['CustomerEmail'],
      customerGroup: json['CustomerGroup'],
      customerMobile: json['CustomerMobile'],
      customerName: json['CustomerName'],
      district: json['District'],
      enquiredOn: json['EnquiredOn'],
      enquiryID: json['EnquiryID'],
      enquiryStatus: json['EnquiryStatus'],
      enquiryType: json['EnquiryType'],
      enquirydscription: json['Enquirydscription'],
      followupOn: json['FollowupOn'],
      isClosed: json['isClosed'],
      isVisitRequired: json['IsVisitRequired'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      leadConverted: json['LeadConverted'],
      lookingfor: json['Lookingfor'],
      pinCode: json['PinCode'].toString(),
      potentialvalue: json['Potentialvalue'],
      quantity: json['Quantity'],
      refferal: json['Refferal'],
      remindOn: json['RemindOn'],
      state: json['State'],
      storeCode: json['StoreCode'],
      updatedBy: json['UpdatedBy'],
      updatedDateTime: json['UpdatedDateTime'],
      visitTime: json['VisitTime']);
}

//old code
// import 'dart:convert';
// import 'dart:developer';

// class GetCustomerDetailsModal {
//   GetCustomerData? itemdata;
//   String message;
//   bool? status;
//   String? exception;
//   int? stcode;
//   GetCustomerDetailsModal(
//       {required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode});
//   factory GetCustomerDetailsModal.fromJson(
//       Map<String, dynamic> jsons, int stcode) {
//     log("json:" + jsons.toString());
//     if (jsons['data'] != null) {
//       // var list = jsons as List;
//       // List<GetCustomerData> dataList =
//       //     list.map((data) => GetCustomerData.fromJson(data)).toList();
//       return GetCustomerDetailsModal(
//           itemdata: GetCustomerData.fromJson(jsons['data']),
//           message: jsons['msg'],
//           status: jsons['status'],
//           stcode: stcode,
//           exception: null);
//     } else {
//       return GetCustomerDetailsModal(
//           itemdata: null,
//           message: jsons['msg'],
//           status: jsons['status'],
//           stcode: stcode,
//           exception: null);
//     }
//   }

//   factory GetCustomerDetailsModal.error(String jsons, int stcode) {
//     return GetCustomerDetailsModal(
//         itemdata: null,
//         message: 'Exception',
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }
// class GetCustomerData {
//   GetCustomerData({
//     required this.ZipCode,
//     required this.CardCode,
//     required this.CardName,
//     required this.Street,
//     required this.Block,
//     required this.City,
//     required this.State,
//     required this.Country,
//     required this.tags,

//   });

//   String? CardCode;
//   String? CardName;
//   String? Street;
//   String? Block;
//   String? ZipCode;
//   String? City;
//   String? State;
//   String? Country;
//   String? tags;

//   factory GetCustomerData.fromJson(Map<String, dynamic> json) =>
//    GetCustomerData(
//      CardCode: json['CardCode'] ?? '',
//      CardName: json['CardName'] ?? '',
//      Street: json['Street'] ?? '',
//      Block: json['Block'] ?? '',
//      ZipCode: json['ZipCode'] ?? '',
//      City: json['City'] ??'',
//      State: json['State'] ?? '',
//      Country:json['Country']?? '',
//      tags:json['Tag']?? '',

//      );
// }
// class GetCustomerData {
//   GetCustomerData({
//     this.address1,
//     this.address2,
//     this.address_3,
//     this.alternateMobileNo,
//     this.cardtype,
//     this.city,
//     this.codeId,
//     this.contactName,
//     this.country,
//     this.createdBy,
//     this.createdOn,
//     this.customerCode,
//     this.customerName,
//     this.email,
//     this.facebook,
//     this.gstNo,
//     this.id,
//     this.mobileNo,
//     this.pinCode,
//     this.shippingAddress1,
//     this.shippingAddress2,
//     this.shippingAddress_3,
//     this.shippingCity,
//     this.shippingCountry,
//     this.shippingPinCode,
//     this.shippingState,
//     this.state,
//     this.status,
//     this.area,
//     this.customerGroup,
//     this.updatedBy,
//     this.updatedOn,
//     //New
//     this.companyName, //
//     this.district, //
//     this.shippingArea, //
//     this.shippingDistrict, //Not Given
//     this.pan, //
//     this.website, //
//     this.storeCode, //
//   });
//   int? id; //
//   String? customerCode; //
//   String? customerName; //
//   String? mobileNo; //
//   String? alternateMobileNo; //
//   String? contactName; //
//   String? facebook; //
//   String? cardtype; //
//   String? email; //
//   String? gstNo; //
//   String? codeId; //
//   int? createdBy; //
//   String? createdOn; //
//   int? updatedBy; //
//   String? updatedOn; //
//   String? address1; //
//   String? address2; //
//   String? address_3; //
//   String? area; //
//   String? city; //
//   String? state; //
//   String? country; //
//   String? pinCode; //
//   String? shippingAddress1; //
//   String? shippingAddress2; //
//   String? shippingAddress_3; //
//   String? shippingCity; //
//   String? shippingState; //
//   String? shippingCountry; //
//   String? shippingPinCode; //
//   String? customerGroup; //
//   String? status; //
//   //New
//   String? companyName; //
//   String? district; //
//   String? shippingArea; //
//   String? shippingDistrict; //Not Given
//   String? pan; //
//   String? website; //
//   String? storeCode; //

//   factory GetCustomerData.fromJson(Map<String, dynamic> json) =>
//       GetCustomerData(
//         id: json['id'] ?? 0,//
//         customerCode: json['customerCode'] ?? '',//
//         customerName: json['customerName'] ?? '',//
//         mobileNo: json['customerMobile'] ?? '',//
//         alternateMobileNo: json['alternateMobileNo'] ?? '',//
//         contactName: json['contactName'] ?? '',//
//         facebook: json['facebook'] ?? '',//
//         cardtype: json['cardtype'] ?? '',//
//         email: json['customerEmail'] ?? '',//
//         gstNo: json['gstno'] ?? '',//
//         codeId: json['codeId'] ?? '',//
//         createdBy: json['createdBy']??0,//
//         createdOn: json['createdOn'] ?? '',//
//         updatedBy: json['updatedBy']??0,//
//         updatedOn: json['updatedOn'] ?? '',//
//         address1: json['bilAddress1'] ?? '',//
//         address2: json['bilAddress2'] ?? '',//
//         address_3: json['bilAddress3'] ?? '',//
//         area: json['bilArea']??'',//
//         city: json['bilCity'] ?? '',//
//         state: json['bilState'] ?? '',//
//         country: json['country'] ?? '',//
//         pinCode: json['bilPincode'] ?? '',//
//         shippingAddress1: json['delAddress1'] ?? '',//
//         shippingAddress2: json['delAddress2'] ?? '',//
//         shippingAddress_3: json['delAddress3'] ?? '',//
//         shippingCity: json['delCity'] ?? '',//
//         shippingState: json['delState'] ?? '',//
//         shippingCountry: json['delCountry'] ?? '',//
//         shippingPinCode: json['delPincode'] ?? '',//
//         customerGroup: json['customerGroup'] ?? '',//
//         status: json['status'] ?? '',//
//         //New
//         companyName: json['companyName'] ?? '',//
//         district: json['bilDistrict'] ?? '',//
//         shippingArea: json['delArea'] ?? '',
//         shippingDistrict: json[''] ?? '', //Not Giv
//         pan: json['pan'] ?? '',//
//         website: json['website'] ?? '',//
//         storeCode: json['storeCode'] ?? '',//
//       );
// }

// // Json
// // {
// //     "data": {
// //         "id": 82,
// //         "customerCode": "9087227638",
// //         "customerName": "VIGNESH",
// //         "customerMobile": "9087227638",
// //         "alternateMobileNo": null,
// //         "contactName": null,
// //         "customerEmail": "BUSON@GMAIL.COM",
// //         "companyName": "BUSON",
// //         "gstno": null,
// //         "codeId": null,
// //         "createdBy": 0,
// //         "createdOn": "2023-11-07T17:52:00.04",
// //         "updatedBy": 0,
// //         "updatedOn": "2023-11-07T17:52:00.04",
// //         "bilAddress1": null,
// //         "bilAddress2": null,
// //         "bilAddress3": null,
// //         "bilArea": null,
// //         "bilCity": null,
// //         "bilDistrict": null,
// //         "bilState": null,
// //         "country": "INDIA",
// //         "bilPincode": null,
// //         "delAddress1": null,
// //         "delAddress2": null,
// //         "delAddress3": null,
// //         "delArea": null,
// //         "delCity": null,
// //         "delState": null,
// //         "delCountry": null,
// //         "delPincode": null,
// //         "customerGroup": "RETAILER",
// //         "pan": null,
// //         "website": null,
// //         "status": null,
// //         "facebook": null,
// //         "cardtype": null,
// //         "storeCode": "CUD1"
// //     },
// //     "msg": "Success",
// //     "status": true
// // }
