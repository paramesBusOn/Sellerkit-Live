

class NewCustomerschedule{
// String? customercode;
// String ?purposeofvisit;
// String? meetingtime;
// int? userid;
// String? assignslpcode;
// int? createdby;
// String? visitstatus;
// String? closed;
String? message;

 int? stcode;
 
String?exception;
// String ?odatametadata;
NewCustomerschedule({
  this.message,
//  required this.assignslpcode,
//  required this.closed,
//  required this.createdby,
//  required this.customercode,
//  required this.meetingtime,
//  required this.purposeofvisit,
//  required this.userid,
//  required this.visitstatus,

required this.stcode,
this.exception,
});

 factory NewCustomerschedule.fromJson(Map<String, dynamic> jsons,int stcode) {      

    return NewCustomerschedule(
      // assignslpcode: jsons["assignedSlpCode"], 
      // closed: jsons["closed"], 
      // createdby: jsons["createdy"], 
      // customercode: jsons["customerCode"], 
      // meetingtime: jsons["meetingTime"], 
      
      // purposeofvisit: jsons["purposeofVisit"], 
      // userid: jsons["userId"], 
      // visitstatus: jsons["visitStatus"], 
      message: jsons['respDesc'],
      stcode: stcode,
      exception: null
      );
 }

   factory NewCustomerschedule.issue(Map<String, dynamic> jsons,int? stcode) {
      return NewCustomerschedule(
      //  assignslpcode: null, 
      // closed: null, 
      // createdby: null, 
      // customercode: null, 
      // meetingtime: null, 
      
      // purposeofvisit: null, 
      // userid: null, 
      // visitstatus: null, 
      stcode: stcode,
      message:jsons['respCode'] ,
      exception: jsons['respDesc']
          );
  }

     factory NewCustomerschedule.exception(String exp,int? stcode) {
      return NewCustomerschedule(
      //   assignslpcode: null, 
      // closed: null, 
      // createdby: null, 
      // customercode: null, 
      // meetingtime: null, 
     
      // purposeofvisit: null, 
      // userid: null, 
      // visitstatus: null, 
      message: '',
      stcode: stcode,
      exception: exp
          );
  }
}


class postscheduledata{
  String? customername;
  String? email;
  String? altermobile;
   String? lookingfor;
  String? add1;
  String? add2;
  String? add3;
  String? area;
  String? city;
  String? district;
  String? state;
  String? country;
  int? pincode;
  String? contactname;
  
String? customercode;
String ?purposeofvisit;
String? meetingtime;
int? userid;
String? assignslpcode;
int? createdby;
String? visitstatus;
String? closed;
int? visitid2;
int? baseid;
int? basetype;
double? potential;
postscheduledata({
  this.potential,
  this.baseid,
  this.basetype,
  this.contactname,
  this.lookingfor,
  this.altermobile,
  this.customername,
  this.email,
  this.add1,
  this.add2,
  this.add3,
  this.area,
  this.city,
  this.district,
  this.pincode,
  this.state,
  this.country,
  this.visitid2,


 this.assignslpcode,
 this.closed,
 this.createdby,
 this.customercode,
 this.meetingtime,
 this.purposeofvisit,
 this.userid,
 this.visitstatus
});
}

class siteinpatch{
  int? visitid;
  String? time;
  String? customername;
  String? email;
  String? altermobile;
   String? lookingfor;
  String? add1;
  String? add2;
  String? add3;
  String? area;
  String? city;
  String? district;
  String? state;
  String? country;
  int? pincode;
  String? contactname;
  String? checkinaddress;
  
String? customercode;
String ?purposeofvisit;
String? meetingtime;
int? userid;
String? assignslpcode;
int? createdby;
String? visitstatus;
String? closed;
int? visitid2;
double? potential;
int? basetype;
int? baseid;
  siteinpatch({this.checkinaddress,
    this.potential,
    this.basetype,
    this.baseid,
    this.time,
    this.visitid,
    this.contactname,
  this.lookingfor,
  this.altermobile,
  this.customername,
  this.email,
  this.add1,
  this.add2,
  this.add3,
  this.area,
  this.city,
  this.district,
  this.pincode,
  this.state,
  this.country,
  this.visitid2,


 this.assignslpcode,
 this.closed,
 this.createdby,
 this.customercode,
 this.meetingtime,
 this.purposeofvisit,
 this.userid,
 this.visitstatus
  });
}
class siteoutpatc{
  int? visitid;
  String? time;
  String? customername;
  String? email;
  String? altermobile;
   String? lookingfor;
  String? add1;
  String? add2;
  String? add3;
  String? area;
  String? city;
  String? district;
  String? state;
  String? country;
  int? pincode;
  String? contactname;
  
String? customercode;
String ?purposeofvisit;
String? meetingtime;
int? userid;
String? assignslpcode;
int? createdby;
String? visitstatus;
String? closed;
int? visitid2;
double? potential;
int? basetype;
int? baseid;
  siteoutpatc({
    this.potential,
    this.basetype,
    this.baseid,
    this.time,
    this.visitid,
    this.contactname,
  this.lookingfor,
  this.altermobile,
  this.customername,
  this.email,
  this.add1,
  this.add2,
  this.add3,
  this.area,
  this.city,
  this.district,
  this.pincode,
  this.state,
  this.country,
  this.visitid2,


 this.assignslpcode,
 this.closed,
 this.createdby,
 this.customercode,
 this.meetingtime,
 this.purposeofvisit,
 this.userid,
 this.visitstatus
  });
}
class leavereq{
  int? id;
  String? slpcode;
  String? reportto;
  String? leavereqtype;
  String? leavetype;
  String? startdate;
  String? enddate;
  String? halfDay;
  int? noofleavereq;
  String? reason;
  int? status;
leavereq({
   this.enddate,
   this.halfDay,
   this.id,
   this.leavereqtype,
   this.leavetype,
   this.noofleavereq,
   this.reason,
   this.reportto,
   this.slpcode,
   this.startdate,
   this.status

});
  
}
class siteout{
  int? visitid;
  String? siteChekOutTime;
  String? lookingFor;
  String? visitOutComes;
  String? nextVisit;
  int? convertToEnquiry;
  String? u_AssignedTo;
  String? nextFollowupDate;
  String? attachmenturl1;
  String? attachmenturl2;
  String? attachmenturl3;
  String? attachmenturl4;
  String? visitdate;
  String? revisitby;
  String? siteoutaddress;
    
  siteout({
    this.siteoutaddress,
    this.visitdate,
    this.revisitby,
    this.attachmenturl2,
    this.attachmenturl3,
    this.attachmenturl4,
    this.visitid,
     this.convertToEnquiry,
     this.lookingFor,
     this.nextFollowupDate,
     this.nextVisit,
     this.siteChekOutTime,
     this.u_AssignedTo,
     this.visitOutComes,
this.attachmenturl1,

  });
}


