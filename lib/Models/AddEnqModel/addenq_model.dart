class PatchExCus
{
  int? id;
  String?custcode;
  String? CardCode;
  String? CardName;
  String? CardType;
  String? U_Address1;
  String? U_Address2;
  String? U_Address3;
  String? U_City;
  String? U_Pincode;
  String? U_State;
  String? U_ShipAddress1;
  String? U_ShipAddress2;
  String? U_ShipAddress3;
  String? U_Shiparea;
  String? U_ShipCity;
  String? U_ShipPincode;
  String? U_ShipCountry;
  String? U_ShipState;
  String? U_Country;
  String? U_Facebook;
  String? U_EMail;
  String? U_Type;
  String? cantactName;
  String? altermobileNo;
  String? gst;
  double? potentialvalue;
  String? remarks;
  String? levelof;
  String? ordertype;
  String? couponcode;
  String? area;
  String? state;
  int? docent;
  int? ordernum;
  int? enqid;
  int? enqtype;
  
  
  // String? U;






  PatchExCus({
    this.remarks,
    this.levelof,
    this.ordertype,
    this.enqtype,
    this.enqid,
    this.docent,
    this.ordernum,
    this.U_ShipCountry,
    this.area,
    this.state,
    this.cantactName,
    this.custcode,
    this.id,
this.CardCode,
this.CardName,
this.CardType,
this.U_Address1,
this.U_Address2,
this.U_Address3,
this.couponcode,
this.U_City,
this.U_Country,
this.U_EMail,
this.U_Facebook,
this.U_Pincode,
this.U_State,
this.U_Type

  });

}
class couponmodel{
  String? customerCode;
  String? itemCode;
  String? storeCode;
  int? qty;
  double? totalBillValue;
  String? requestedBy_UserCode;

couponmodel({
 this.customerCode,
 this.itemCode,
 this.storeCode,
 this.qty,
 this.totalBillValue,
 this.requestedBy_UserCode
});

}
class addspecialprice{
  int? docentry;
  String? fromDate;
  String? toDate;
  String? customerCode;
  String? customerName;
  String? customerMobile;
  String? itemCode;
  String? itemName;
  double? quantity;
  String? storeCode;
  String? assignedTo;
  double? rp;
addspecialprice({
  this.docentry,
this.fromDate,
this.toDate,
this.customerCode,
this.customerName,
this.customerMobile,
this.itemCode,
this.itemName,
this.quantity,
this.storeCode,
this.assignedTo,
this.rp,
});
}

class PostEnq
{
  String? CardCode;
  String? Activity;
  String? ActivityType;
  String? U_Lookingfor;
  double? U_PotentialValue;
  String? U_AssignedTo;
  String? U_EnqStatus;
  String? U_EnqRefer;
  String? assignedtoslpCode;
  String? assignedtoManagerSlpCode;
  String? isvist;
  String? sitedate;
  String? remainderdate;




  PostEnq({
this.CardCode,
this.Activity,
this.ActivityType,
this.U_Lookingfor,
this.U_PotentialValue,
this.U_AssignedTo,
this.U_EnqStatus,
this.U_EnqRefer,
this.assignedtoslpCode,
this.isvist,
this.sitedate,
this.remainderdate,
  });

}