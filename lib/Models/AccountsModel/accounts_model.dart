
import 'dart:convert';
import 'dart:developer';

class AccountsDetails{
 Accountsheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AccountsDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AccountsDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return AccountsDetails(
        itemdata: Accountsheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return AccountsDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory AccountsDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return AccountsDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory AccountsDetails.error(String jsons,int stcode) {
    return AccountsDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class Accountsheader{
  
  List<AccountsNewData>? childdata;
  Accountsheader({
    required this.childdata

  });
  factory Accountsheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return Accountsheader(
       childdata: null, 
        );

      }
       else {
      List<AccountsNewData> dataList =
          list.map((data) => AccountsNewData.fromJson(data)).toList();
      return Accountsheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class AccountsNewData {
  AccountsNewData({
   required this.AlternateMobileNo,
   required this.AssignedTo,
   required this.Bil_Address1,
   required this.Bil_Address2,
   required this.Bil_Address3,
   required this.Bil_Area,
   required this.Bil_City,
   required this.Bil_Country,
   required this.Bil_District,
   required this.Bil_Pincode,
   required this.Bil_State,
   required this.CompanyName,
   required this.ContactName,
   required this.CreatedBy,
   required this.CreatedOn,
   required this.CustomerCode,
   required this.CustomerEmail,
   required this.CustomerGroup,
   required this.CustomerMobile,
   required this.CustomerName,
   required this.Del_Address1,
   required this.Del_Address2,
   required this.Del_Address3,
   required this.Del_Area,
   required this.Del_City,
   required this.Del_Country,
   required this.Del_District,
   required this.Del_Pincode,
   required this.Del_State,
   required this.GSTNo,
   required this.PAN,
   required this.Status,
   required this.StoreCode,
   required this.UpdatedBy,
   required this.UpdatedOn,
   required this.traceid
  });

 String? CustomerCode;
 String? CustomerName ;
 String? CustomerMobile ;
 String? AlternateMobileNo ;
 String? ContactName ;
 String? CustomerEmail ;
 String? CompanyName ;
 String? CustomerGroup ;
 String? PAN ;
 String? GSTNo ;
 String? Bil_Address1 ;
 String? Bil_Address2 ;
 String? Bil_Address3 ;
 String? Bil_Area ;
 String? Bil_City  ;
 String? Bil_District  ;
 String? Bil_State  ;
 String? Bil_Country  ;
 String? Bil_Pincode  ;
 String? Del_Address1  ;
 String? Del_Address2  ;
 String? Del_Address3  ;
 String? Del_Area  ;
 String? Del_City  ;
 String? Del_District  ;
 String? Del_State  ;
 String? Del_Country  ;
 String? Del_Pincode  ;
 String? StoreCode  ;
 String? AssignedTo  ;
 String? Status  ;
 int? CreatedBy  ;
 String? CreatedOn  ;
 int? UpdatedBy  ;
 String? UpdatedOn  ;
String? traceid ;














  factory AccountsNewData.fromJson(Map<String, dynamic> json) =>
   AccountsNewData(
    AlternateMobileNo: json['AlternateMobileNo']??'', 
    AssignedTo: json['AssignedTo']??'', 
    Bil_Address1: json['Bil_Address1']??'', 
    Bil_Address2: json['Bil_Address2']??'', 
    Bil_Address3: json['Bil_Address3']??'', 
    Bil_Area: json['Bil_Area']??'', 
    Bil_City: json['Bil_City']??'', 
    Bil_Country: json['Bil_Country']??'', 
    Bil_District: json['Bil_District']??'', 
    Bil_Pincode: json['Bil_Pincode']??'', 
    Bil_State: json['Bil_State']??'', 
    CompanyName: json['CompanyName']??'', 
    ContactName: json['ContactName']??'', 
    CreatedBy: json['CreatedBy']??0, 
    CreatedOn: json['CreatedOn']??'', 
    CustomerCode: json['CustomerCode']??'', 
    CustomerEmail: json['CustomerEmail']??'', 
    CustomerGroup: json['CustomerGroup']??'', 
    CustomerMobile: json['CustomerMobile']??'', 
    CustomerName: json['CustomerName']??'', 
    Del_Address1: json['Del_Address1']??'', 
    Del_Address2: json['Del_Address2']??'', 
    Del_Address3: json['Del_Address3']??'', 
    Del_Area: json['Del_Area']??'', 
    Del_City: json['Del_City']??'', 
    Del_Country: json['Del_Country']??'', 
    Del_District: json['Del_District']??'', 
    Del_Pincode: json['Del_Pincode']??'', 
    Del_State: json['Del_State']??'', 
    GSTNo: json['GSTNo']??'', 
    PAN: json['PAN']??'', 
    Status: json['Status']??'', 
    StoreCode: json['StoreCode']??'', 
    UpdatedBy: json['UpdatedBy']??0, 
    UpdatedOn: json['UpdatedOn']??'', 
    traceid: json['traceid']??''
    );
    
}
