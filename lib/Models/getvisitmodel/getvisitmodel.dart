import 'dart:convert';

import 'package:sellerkit/DBModel/siteindb_model.dart';
import 'package:sellerkit/DBModel/visitplandb_model.dart';

class getvisitmodel{
  getvisithead? getvisitheaddata;
  // List<getvisitdetails>? getvisitdetailsdata;
  String? exception;
  int? stcode;
  String? message;
  bool? status;

  getvisitmodel({
     this.exception,
    required this.getvisitheaddata,
    required this.message,
    required this.status,
    required this.stcode
  });
 factory getvisitmodel.fromJson(Map<String,dynamic> jsons,int stcode){
       

    if(jsons !=null && jsons.isNotEmpty){
    //  var list=jsons as List;
    //  List<getvisitdetails> datalist=list.map((data)=>getvisitdetails.fromJson(data)).toList();
    //   print("inside api method::"+datalist.toString());

      return getvisitmodel(
        exception: null, 
        getvisitheaddata: getvisithead.fromJson(jsons), 
        message: "Success", 
        status: true, 
        stcode: stcode
        );
    }else{
     return getvisitmodel(
        getvisitheaddata: null, 
        message: "Failure", 
        status: false, 
        stcode: stcode
        );

    }
  }
  factory getvisitmodel.issues(Map<String,dynamic> jsons,int stcode){
  return getvisitmodel(
    getvisitheaddata: null, 
    message: jsons['respCode'], 
    status: null, 
    stcode: stcode,
    exception: jsons['respDesc']
    );
}
factory getvisitmodel.error(String jsons,int stcode){
  return getvisitmodel(
    getvisitheaddata: null, 
    message: null, 
    status: null, 
    stcode: stcode,
    exception: jsons
    );
}
}
class getvisithead{
  List<getvisitdetails>? getvisitdetailsdata;
  getvisithead({
    required this.getvisitdetailsdata,

  });
  factory getvisithead.fromJson(Map<String,dynamic> jsons){
    var list = json.decode(jsons["data"]) as List;
    if(list.isEmpty){
        return getvisithead(
     
        getvisitdetailsdata: null, 
       
        );

      }else{
         List<getvisitdetails> dataList =
          list.map((data) => getvisitdetails.fromJson(data)).toList();
          return getvisithead(
     
        getvisitdetailsdata: dataList, 
       
        );
      }
  }
}

class getvisitdetails{

  int? visitplan;
  String? customercode;
  String? purposeofvisit;
  String? meetingtime;
  int? userid;
  int? createdby;
  String? closed;
  String? customername;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? product;
  String? visitstatus;
  String? pincode;
  String? state;
  String? cusmobile;
  String? cusemail;
  String? contactname;
  String? area;
  String? district;
  String? country;
  String? storecode;
  String? plannedDate;
  String? CheckinDateTime;
  double? CheckinLat;
  double? CheckinLong;
  String? CheckoutDateTime;
  double? CheckoutLat;
  double? CheckoutLong;
  String? LookingFor;
  String? AssignedTo;
  String? VisitOutcome;
  double? PotentialBusinessValue;
  String? VisitStatus;
  String? IsClosed;
  int? BaseType;
  int? BaseId;
  String? TargetType;
  String? TargetId;
  String? Att1;
  String? Att2;
  String? Att3;
  String? Att4;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? traceid;




getvisitdetails({
required this.address1,
required this.address2,
required this.address3,
required this.city,
required this.closed,
required this.createdby,
required this.customercode,
required this.customername,
required this.meetingtime,
required this.product,
required this.purposeofvisit,
required this.userid,
required this.visitplan,
required this.visitstatus,
required this.pincode,
required this.state,
required this.cusmobile,
required this.cusemail,
required this.contactname,
required this.AssignedTo,
required this.Att1,
required this.Att2,
required this.Att3,
required this.Att4,
required this.BaseId,
required this.BaseType,
required this.CheckinDateTime,
required this.CheckinLat,
required this.CheckinLong,
required this.CheckoutDateTime,
required this.CheckoutLat,
required this.CheckoutLong,
required this.CreatedBy,
required this.CreatedDateTime,
required this.IsClosed,
required this.LookingFor,
required this.PotentialBusinessValue,
required this.TargetId,
required this.TargetType,
required this.UpdatedBy,
required this.UpdatedDateTime,
required this.VisitOutcome,
required this.VisitStatus,
required this.area,
required this.country,
required this.district,
required this.plannedDate,
required this.storecode,
required this.traceid


});

factory getvisitdetails.fromJson(Map<String,dynamic> jsons){
  return getvisitdetails(
    address1: jsons['Address1']??'', 
    address2: jsons['Address2']??'', 
    address3: jsons['Address3'], 
    city: jsons['City']??'', 
    closed: jsons['']??'', 
    createdby: jsons['CreatedBy'], 
    customercode: jsons['CustomerCode'], 
    customername: jsons['CustomerName'], 
    meetingtime: jsons['PlannedDate'], 
    product: jsons['']??'', 
    purposeofvisit: jsons['PurposeofVisit']??'', 
    userid: jsons[''], 
    visitplan: jsons['VisitID'], 
    visitstatus: jsons['VisitStatus'], 
    pincode: jsons['Pincode'].toString(), 
    state: jsons['State'], 
    cusmobile: jsons['CustomerMobile'], 
    cusemail: jsons['CustomerEmail']??'', 
    contactname: jsons['ContactPerson']??'', 
    AssignedTo: jsons['AssignedTo'], 
    Att1: jsons['Att1'], 
    Att2: jsons['Att2'], 
    Att3: jsons['Att3'], 
    Att4: jsons['Att4'], 
    BaseId: jsons['BaseId'], 
    BaseType: jsons['BaseType'], 
    CheckinDateTime: jsons['CheckinDateTime'], 
    CheckinLat: jsons['CheckinLat']??0.0, 
    CheckinLong: jsons['CheckinLong']??0.0, 
    CheckoutDateTime: jsons['CheckoutDateTime'], 
    CheckoutLat: jsons['CheckoutLat']??0.0, 
    CheckoutLong: jsons['CheckoutLong']??0.0, 
    CreatedBy: jsons['CreatedBy'], 
    CreatedDateTime: jsons['CreatedDateTime'], 
    IsClosed: jsons['IsClosed'], 
    LookingFor: jsons['LookingFor']??'', 
    PotentialBusinessValue: jsons['PotentialBusinessValue']??0.0, 
    TargetId: jsons['TargetId'], 
    TargetType: jsons['TargetType'], 
    UpdatedBy: jsons['UpdatedBy'], 
    UpdatedDateTime: jsons['UpdatedDateTime'], 
    VisitOutcome: jsons['VisitOutcome'], 
    VisitStatus: jsons['VisitStatus'], 
    area: jsons['Area']??'', 
    country: jsons['Country'], 
    district: jsons['District']??'', 
    plannedDate: jsons['PlannedDate'], 
    storecode: jsons['StoreCode'], 
    traceid: jsons['traceid']);

}

 Map<String, Object?> toMap()=>{
  tableVisitplanCulumns.visitplan:visitplan,
  tableVisitplanCulumns.customercode:customercode,
  tableVisitplanCulumns.purposeofvisit:purposeofvisit,
  tableVisitplanCulumns.meetingtime:meetingtime,
  tableVisitplanCulumns.userid:userid,
  tableVisitplanCulumns.createdby:createdby,
  tableVisitplanCulumns.closed:closed,
  tableVisitplanCulumns.customername:customername,
  tableVisitplanCulumns.address1:address1,
  tableVisitplanCulumns.address2:address2,
  tableVisitplanCulumns.address3:address3,
  tableVisitplanCulumns.city:city,
  tableVisitplanCulumns.product:product,
  tableVisitplanCulumns.visitstatus:visitstatus,
  tableVisitplanCulumns.pincode:pincode,
  tableVisitplanCulumns.state:state,
  tableVisitplanCulumns.cusmobile:cusmobile,
  tableVisitplanCulumns.cusemail:cusemail,
  tableVisitplanCulumns.contactname:contactname,
  tableVisitplanCulumns.area:area,
  tableVisitplanCulumns.district:district,
  tableVisitplanCulumns.country:country,
  tableVisitplanCulumns.storecode:storecode,
  tableVisitplanCulumns.plannedDate:plannedDate,
  tableVisitplanCulumns.checkinDateTime:CheckinDateTime,
  tableVisitplanCulumns.checkinLat:CheckinLat,
  tableVisitplanCulumns.checkinLong:CheckinLong,
  tableVisitplanCulumns.checkoutDateTime:CheckoutDateTime,
  tableVisitplanCulumns.checkoutLat:CheckoutLat,
  tableVisitplanCulumns.checkoutLong:CheckoutLong,
  tableVisitplanCulumns.lookingFor:LookingFor,
  tableVisitplanCulumns.assignedTo:AssignedTo,
  tableVisitplanCulumns.visitOutcome:VisitOutcome,
  tableVisitplanCulumns.potentialBusinessValue:PotentialBusinessValue,
  tableVisitplanCulumns.visitStatus:VisitStatus,
  tableVisitplanCulumns.isClosed:IsClosed,
  tableVisitplanCulumns.baseType:BaseType,
  tableVisitplanCulumns.baseId:BaseId,
  tableVisitplanCulumns.targetType:TargetType,
  tableVisitplanCulumns.targetId:TargetId,
  tableVisitplanCulumns.att1:Att1,
  tableVisitplanCulumns.att2:Att2,
  tableVisitplanCulumns.att3:Att3,
  tableVisitplanCulumns.att4:Att4,
  tableVisitplanCulumns.createdBy:CreatedBy,
  tableVisitplanCulumns.createdDateTime:CreatedDateTime,
  tableVisitplanCulumns.updatedBy:UpdatedBy,
  tableVisitplanCulumns.updatedDateTime:UpdatedDateTime,
  tableVisitplanCulumns.traceid:traceid,
  
 };

  Map<String, Object?> toMap2() => {
    tablesiteinCulumns.visitplan:visitplan,
    tablesiteinCulumns.customercode:customercode,
    tablesiteinCulumns.purposeofvisit:purposeofvisit,
    tablesiteinCulumns.meetingtime:meetingtime,
    tablesiteinCulumns.userid:userid,
    tablesiteinCulumns.createdby:createdby,
    tablesiteinCulumns.closed:closed,
    tablesiteinCulumns.customername:customername,
    tablesiteinCulumns.address1:address1,
    tablesiteinCulumns.address2:address2,
    tablesiteinCulumns.address3:address3,
    tablesiteinCulumns.city:city,
    tablesiteinCulumns.product:product,
    tablesiteinCulumns.visitstatus:visitstatus,
    tablesiteinCulumns.pincode:pincode,
    tablesiteinCulumns.state:state,
    tablesiteinCulumns.cusmobile:cusmobile,
    tablesiteinCulumns.cusemail:cusemail,
    tablesiteinCulumns.contactname:contactname,
    tablesiteinCulumns.area:area,
    tablesiteinCulumns.district:district,
    tablesiteinCulumns.country:country,
    tablesiteinCulumns.storecode:storecode,
    tablesiteinCulumns.plannedDate:plannedDate,
    tablesiteinCulumns.checkinDateTime:CheckinDateTime,
    tablesiteinCulumns.checkinLat:CheckinLat,
    tablesiteinCulumns.checkinLong:CheckinLong,
    tablesiteinCulumns.checkoutDateTime:CheckoutDateTime,
    tablesiteinCulumns.checkoutLat:CheckoutLat,
    tablesiteinCulumns.checkoutLong:CheckoutLong,
    tablesiteinCulumns.lookingFor:LookingFor,
    tablesiteinCulumns.assignedTo:AssignedTo,
    tablesiteinCulumns.visitOutcome:VisitOutcome,
    tablesiteinCulumns.potentialBusinessValue:PotentialBusinessValue,
    tablesiteinCulumns.visitStatus:VisitStatus,
    tablesiteinCulumns.isClosed:IsClosed,
    tablesiteinCulumns.baseType:BaseType,
    tablesiteinCulumns.baseId:BaseId,
    tablesiteinCulumns.targetType:TargetType,
    tablesiteinCulumns.targetId:TargetId,
    tablesiteinCulumns.att1:Att1,
    tablesiteinCulumns.att2:Att2,
    tablesiteinCulumns.att3:Att3,
    tablesiteinCulumns.att4:Att4,
    tablesiteinCulumns.createdBy:CreatedBy,
    tablesiteinCulumns.createdDateTime:CreatedDateTime,
    tablesiteinCulumns.updatedBy:UpdatedBy,
    tablesiteinCulumns.updatedDateTime:UpdatedDateTime,
    tablesiteinCulumns.traceid:traceid,
    


  };
}

//{visitPlan: 2, customerCode: 7339104600, purposeofVisit: 79,
// meetingTime: 2023-11-12T12:19:46.943, userId: 14, createdy: 14, 
//closed: N, customerName: RAMESH, address: 4/44 , bilAddress2: RAMNAGAR, 
//bilAddress3: null, bilCity: COVAI, bilPincode: 87559, bilState: TAMILNADU, product: null, visitStatus: Missed},