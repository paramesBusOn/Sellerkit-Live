class updatevisitmodel{
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
updatevisitmodel({
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

 factory updatevisitmodel.fromJson(Map<String, dynamic> jsons,int stcode) {      

    return updatevisitmodel(
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

   factory updatevisitmodel.issue(Map<String, dynamic> jsons,int? stcode) {
      return updatevisitmodel(
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

     factory updatevisitmodel.exception(String exp,int? stcode) {
      return updatevisitmodel(
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