// ignore_for_file: non_constant_identifier_names

class VisitPlanData {
  VisitPlanData({
    this.Mgr_UserName,
    this.EnqID,
    this.CardCode,
    this.Status,
    this.CardName,
    this.AssignedTo_User,
    this.EnqDate,
    this.Followup,
    this.Mgr_UserCode,
    this.AssignedTo_UserName,
    this.EnqType,
    this.Lookingfor,
    this.PotentialValue,
    this.Address_Line_1,
    this.Address_Line_2,
    this.Pincode,
    this.City,
    this.State,
    this.Country,
    this.Manager_Status_Tab,
    this.Slp_Status_Tab,
    //
    required this.customer,
    required this.datetime,
    required this.purpose,
    required this.area,
    required this.product,
    required this.type,
    required this.Mobile,
    required this.CantactName,
    required this.U_Address1,
    required this.U_Address2,
    required this.U_City,
    required this.U_State,
    required this.U_Pincode,

    // required this.customertag
  });

  int? EnqID;
  String? CardCode;
  String? CardName;
  String? EnqDate;
  String? Followup;
  String? Status;
  int? Mgr_UserCode;
  String? Mgr_UserName;
  int? AssignedTo_User;
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
  String? Slp_Status_Tab;
  // String? customertag;
  //
  String? U_Pincode;
  String? customer;
  String? datetime;
  String? purpose;
  String? area;
  String? product;
  String? type;
  String? U_Address1;
  String? U_Address2;
  String? U_City;
  String? U_State;
  String? Mobile;
  String? CantactName;

  // factory VisitPlanData.fromJson(Map<String, dynamic> json) =>
  //  VisitPlanData(
  //    EnqID: json['EnqID'] ?? 0,
  //    CardCode: json['CardCode'] ?? '',
  //    Status: json['Status'] ?? '',
  //    CardName: json['CardName'] ?? '',
  //    EnqDate: json['EnqDate'] ?? '',
  //    Followup: json['Followup'] ?? '',
  //    Mgr_UserCode: json['Mgr_UserCode'] ?? '',
  //    AssignedTo_UserName: json['AssignedTo_UserName']?? '',
  //    Mgr_UserName: json['Mgr_UserName'] ?? '',
  //    AssignedTo_User: json['AssignedTo_User'] ?? '',
  //    EnqType:json['EnqType']?? '',
  //    Lookingfor: json['Lookingfor'] ?? '',
  //    PotentialValue: json['PotentialValue'] ?? 0.00,
  //    Address_Line_1: json['Address_Line_1'] ?? '',
  //    Address_Line_2: json['Address_Line_2'] ?? '',
  //    Pincode: json['Pincode']?? '',
  //    City: json['City'] ??'',
  //    State: json['State'] ?? '',
  //    Country:json['Country']?? '',
  //     Manager_Status_Tab: json['Manager_Status_Tab'] ?? '',
  //    Slp_Status_Tab: json['Slp_Status_Tab'] ?? '',
  //   // customertag:json['customertag'] ?? '',
  //    );

}
