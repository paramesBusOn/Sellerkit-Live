import 'dart:convert';
import 'dart:developer';

import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
import 'package:sellerkit/DBModel/outstandinglinechild.dart';
class outsatandingmodel {
  outstandingheader? outstandhead;
  String? exception;
  int? stcode;
  String? message;
  outsatandingmodel(
      { this.outstandhead,
       this.exception,
       this.message,
       this.stcode});
  factory outsatandingmodel.fromJson(Map<String,dynamic> jsons, int stcode) {
    if (jsons['data'] != null ) {
      var list =json.decode(jsons['data'])  as Map<String,dynamic>;
      // log("message"+list.toString());
      // List<outstandingData> datalist =
      //     list.map((data) => outstandingData.fromJson(data)).toList();
      return outsatandingmodel(
          outstandhead: outstandingheader.fromJson(list),
          exception: null,
          message: "Succuess",
          stcode: stcode);
    } else {
      return outsatandingmodel(
          outstandhead: null, exception: null, message: "Fail", stcode: stcode);
    }
  }
  factory outsatandingmodel.issues(Map<String, dynamic> jsons, int stcode) {
    return outsatandingmodel(
        outstandhead: null,
        exception: jsons['respDesc'],
        message: jsons['respCode'],
        stcode: stcode);
  }
  factory outsatandingmodel.error(String jsons, int stcode) {
    return outsatandingmodel(
        outstandhead: null, exception: jsons, message: "fail", stcode: stcode);
  }
}

class outstandingheader{
 List< outstandingData>? outstanddata;
 List< outstandingLine>? outstandline;
outstandingheader({
 this.outstanddata,
 this.outstandline,
});
factory outstandingheader.fromJson(Map<String,dynamic> jsons){
  if(jsons['OutstandingMaster'] !=null && jsons['OutstandingLine'] !=null){
    var list1= jsons['OutstandingMaster'] as List;
    log("list1::"+list1.length.toString());
    var list2= jsons['OutstandingLine'] as List;
    log("list2::"+list2.length.toString());
     List<outstandingData> datalist1 =
          list1.map((data) => outstandingData.fromJson(data)).toList();
          List<outstandingLine> datalist2 =
          list2.map((data) => outstandingLine.fromJson(data)).toList();
          return outstandingheader(
            outstanddata: datalist1, 
            outstandline: datalist2
            );


  }else{
    return outstandingheader(
      outstanddata: null, 
      outstandline: null);
  }
}
}

class outstandingData {
  
  String? customerCode;//
  String? customerName;//
  String? customerMobile;//
  String? alternateMobileNo;//
  String? contactName;//
  String? customerEmail;//
  String? companyName;//
  String? customerGroup;//
  String? gstNo;//
 
  String? storeCode;//
  String? assignedTo;//
  
  double? transAmount;//
  double? penaltyAfterDue;//
  double? collectionInc;//
  double? amountPaid;//
  double? balanceToPay;//
  

  outstandingData(
      { this.alternateMobileNo,
       this.amountPaid,
       this.assignedTo,
       this.balanceToPay,
      
       this.collectionInc,
      
       this.companyName,
       this.contactName,
      
       this.customerCode,
       this.customerEmail,
       this.customerGroup,
       this.customerMobile,
       this.customerName,
      
       this.gstNo,
      
       this.penaltyAfterDue,
      
       this.storeCode,
      
       this.transAmount,
      });

  factory outstandingData.fromJson(Map<String, dynamic> jsons) {
    // log("jsons::::"+jsons.toString());
    return outstandingData(
        alternateMobileNo: jsons['AlternateMobileNo']??'',//
        amountPaid: jsons['AmountPaid']??'',//
        assignedTo: jsons['AssignedTo']??'',//
        balanceToPay: jsons['BalanceToPay']??'',//
       
        collectionInc: jsons['CollectionInc']??'',//
       
        companyName: jsons['CompanyName']??'',//
        contactName: jsons['ContactName']??'',//  
       
        customerCode: jsons['CustomerCode']??'',//
        customerEmail: jsons['CustomerEmail']??'',//
        customerGroup: jsons['CustomerGroup']??'',//
        customerMobile: jsons['CustomerMobile']??'',//
        customerName: jsons['CustomerName']??'',//
       
        gstNo: jsons['GSTNo']??'',//
       
        penaltyAfterDue: jsons['PenaltyAfterDue']??'',//
        
        storeCode: jsons['StoreCode']??'',//
        
        transAmount: jsons['TransAmount']??'',//
       );
  }
   Map<String , Object?> toMap()=>{
 outsatandingDBcolumns.alternateMobileNo:alternateMobileNo,
 outsatandingDBcolumns.amountPaid:amountPaid,
 outsatandingDBcolumns.assignedTo:assignedTo,
 
 outsatandingDBcolumns.customerCode:customerCode,
 outsatandingDBcolumns.customerName:customerName,
 outsatandingDBcolumns.customerMobile:customerMobile,
 outsatandingDBcolumns.contactName:contactName,
 outsatandingDBcolumns.customerEmail:customerEmail,
 outsatandingDBcolumns.companyName:companyName,
 outsatandingDBcolumns.customerGroup:customerGroup,
 outsatandingDBcolumns.gstNo:gstNo,

 outsatandingDBcolumns.storeCode:storeCode,
 
 outsatandingDBcolumns.transAmount:transAmount,
 outsatandingDBcolumns.penaltyAfterDue:penaltyAfterDue,
 outsatandingDBcolumns.collectionInc:collectionInc,
 outsatandingDBcolumns.balanceToPay:balanceToPay,

};
}

class outstandingLine{
int? docentry;
String? customerCode;//
  String? customerName;//
  String? customerMobile;//
  String? alternateMobileNo;//
  String? contactName;//
  String? customerEmail;//
  String? companyName;//
  String? customerGroup;//
  String? gstNo;//
  String? customerPORef;
   String? bil_Address1;
  String? bil_Address2;
  String? bil_Address3;
  String? bil_Area;
  String? bil_City;
  String? bil_District;
  String? bil_State;
  String? bil_Country;
  String? bil_Pincode;
  String? storeCode;//
  String? assignedTo;//
  String? transNum;
  String? transDate;
  String? transDueDate;
  String? transType;
  String? transRef1;
  String? loanRef;
  String? collectionType;
  double? transAmount;//
  double? penaltyAfterDue;//
  double? collectionInc;//
  double? amountPaid;//
  double? balanceToPay;//
  String? status;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  String? traceid;
  outstandingLine({
 this.bil_Address1,
       this.bil_Address2,
       this.bil_Address3,
       this.bil_Area,
       this.bil_City,
       this.bil_Country,
       this.bil_District,
       this.bil_Pincode,
       this.bil_State,
       this.collectionType,
       this.createdBy,
       this.createdOn,
       this.customerPORef,
       this.docentry,
       this.transDate,
       this.transDueDate,
       this.transNum,
       this.transRef1,
       this.transType,
       this.updatedBy,
       this.updatedOn,
       this.loanRef,
       this.status,
       this.traceid,
       this.alternateMobileNo,
       this.amountPaid,
       this.assignedTo,
       this.balanceToPay,
       this.collectionInc,
       this.companyName,
       this.contactName,
       this.customerCode,
       this.customerEmail,
       this.customerGroup,
       this.customerMobile,
       this.customerName,
       this.gstNo,
       this.penaltyAfterDue,
       this.storeCode,
       this.transAmount

  });
  factory outstandingLine.fromJson(Map<String, dynamic> jsons)=>
  outstandingLine(
    customerCode: jsons['CustomerCode'],
    customerName: jsons['CustomerName'],
    customerMobile: jsons['CustomerMobile'],
    alternateMobileNo: jsons['AlternateMobileNo']??'',
    contactName: jsons['ContactName'],
    customerEmail: jsons['CustomerEmail'],
    companyName: jsons['CompanyName'],
    customerGroup: jsons['CustomerGroup'],
    gstNo: jsons['GSTNo'],
    storeCode: jsons['StoreCode'],
    assignedTo: jsons['AssignedTo'],
    transAmount: jsons['TransAmount'],
    penaltyAfterDue: jsons['PenaltyAfterDue'],
    collectionInc: jsons['CollectionInc'],
    amountPaid: jsons['AmountPaid'],
    balanceToPay: jsons['BalanceToPay'],

    bil_Address1: jsons['Bil_Address1']??'',
     bil_Address2: jsons['Bil_Address2']??'', 
     bil_Address3: jsons['Bil_Address3']??'', 
     bil_Area: jsons['Bil_Area']??'', 
     bil_City: jsons['Bil_City'], 
     bil_Country: jsons['Bil_Country'], 
     bil_District: jsons['Bil_District'], 
     bil_Pincode: jsons['Bil_Pincode'], 
     bil_State: jsons['Bil_State'], 
     collectionType: jsons['CollectionType'], 
     createdBy: jsons['CreatedBy'], 
     createdOn: jsons['CreatedOn'], 
     customerPORef: jsons['CustomerPORef']??'',
     docentry: jsons['DocEntry'], 
     transDate: jsons['TransDate'], 
     transDueDate: jsons['TransDueDate'], 
     transNum: jsons['TransNum'], 
     transRef1: jsons['TransRef1'], 
     transType: jsons['TransType'], 
     updatedBy: jsons['UpdatedBy'], 
     updatedOn: jsons['UpdatedOn'], 
     loanRef: jsons['LoanRef'], 
     status: jsons['Status'], 
     traceid: jsons['traceid'] 
     );

     Map<String , Object?> toMap()=>{
      
outsatandinglineDBcolumns.docentry:docentry,
outsatandinglineDBcolumns.customerCode:customerCode,
outsatandinglineDBcolumns.customerName:customerName,
outsatandinglineDBcolumns.customerMobile:customerMobile,
outsatandinglineDBcolumns.alternateMobileNo:alternateMobileNo,
outsatandinglineDBcolumns.contactName:contactName,
outsatandinglineDBcolumns.customerEmail:customerEmail,
outsatandinglineDBcolumns.companyName:companyName,
outsatandinglineDBcolumns.customerGroup:customerGroup,
outsatandinglineDBcolumns.gstNo:gstNo,
outsatandinglineDBcolumns.customerPORef:customerPORef,
outsatandinglineDBcolumns.bil_Address1:bil_Address1,
outsatandinglineDBcolumns.bil_Address2:bil_Address2,
outsatandinglineDBcolumns.bil_Address3:bil_Address3,
outsatandinglineDBcolumns.bil_Area:bil_Area,
outsatandinglineDBcolumns.bil_City:bil_City,
outsatandinglineDBcolumns.bil_District:bil_District,
outsatandinglineDBcolumns.bil_State:bil_State,
outsatandinglineDBcolumns.bil_Country:bil_Country,
outsatandinglineDBcolumns.bil_Pincode:bil_Pincode,
outsatandinglineDBcolumns.storeCode:storeCode,
outsatandinglineDBcolumns.assignedTo:assignedTo,
outsatandinglineDBcolumns.transNum:transNum,
outsatandinglineDBcolumns.transDate:transDate,
outsatandinglineDBcolumns.transDueDate:transDueDate,
outsatandinglineDBcolumns.transType:transType,
outsatandinglineDBcolumns.transRef1:transRef1,
outsatandinglineDBcolumns.loanRef:loanRef,
outsatandinglineDBcolumns.collectionType:collectionType,
outsatandinglineDBcolumns.transAmount:transAmount,
outsatandinglineDBcolumns.penaltyAfterDue:penaltyAfterDue,
outsatandinglineDBcolumns.collectionInc:collectionInc,
outsatandinglineDBcolumns.amountPaid:amountPaid,
outsatandinglineDBcolumns.balanceToPay:balanceToPay,
outsatandinglineDBcolumns.status:status,
outsatandinglineDBcolumns.createdBy:createdBy,
outsatandinglineDBcolumns.createdOn:createdOn,
outsatandinglineDBcolumns.updatedBy:updatedBy,
outsatandinglineDBcolumns.updatedOn:updatedOn,
outsatandinglineDBcolumns.traceid:traceid,


  }; 
}
class OutPDFLines {
  int? id;
  String? transNum;
  String? transDate;
  String? transDueDate;
  String? transType;
  double? transAmt;
  double? balanceTopay;

  OutPDFLines({
     this.id,
    this.transNum,
    this.transAmt,
    this.transDueDate,
     this.transDate,
     this.transType,
     this.balanceTopay,
  });

  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "id": id,
      "transNum": transNum,
      "transAmt": transAmt,
      "transDueDate": transDueDate,
      "transType": transType,
      "balanceTopay": balanceTopay,
      "transDate": transDate!,
    };
    return map;
  }

  Map<String, dynamic> tojason2() {
    Map<String, dynamic> map = {
      "id": id,
      "transNum": transNum,
      "transAmt": transAmt,
      "transDueDate": transDueDate,
      "transType": transType,
      "balanceTopay": balanceTopay,
      "transDate": transDate!,
    };
    return map;
  }
}