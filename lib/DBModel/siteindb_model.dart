const String tablesiteinfilter="tablesitein";

class tablesiteinCulumns{
  static const String visitplan ='Visitplan';
  static const String customercode ='Customercode';
  static const String purposeofvisit ='Purposeofvisit';
  static const String meetingtime ='Meetingtime';
  static const String userid ='Userid';
  static const String createdby ='Createdby';
  static const String closed ='Closed';
  static const String customername ='Customername';
  static const String address1 ='Address1';
  static const String address2 ='Address2';
  static const String address3 ='Address3';
  static const String city ='City';
  static const String product ='Product';
  static const String visitstatus ='Visitstatus';
  static const String pincode ='Pincode';
  static const String state ='State';
  static const String cusmobile ='Cusmobile';
  static const String cusemail ='Cusemail';
  static const String contactname ='Contactname';
  static const String area ='Area';
  static const String district ='District';
  static const String country ='Country';
  static const String storecode ='Storecode';
  static const String plannedDate ='PlannedDate';
  static const String checkinDateTime ='CheckinDateTime';
  static const String checkinLat ='CheckinLat';
  static const String checkinLong ='CheckinLong';
  static const String checkoutDateTime ='CheckoutDateTime';
  static const String checkoutLat ='CheckoutLat';
  static const String checkoutLong ='CheckoutLong';
  static const String lookingFor ='LookingFor';
  static const String assignedTo ='AssignedTo';
  static const String visitOutcome ='VisitOutcome';
  static const String potentialBusinessValue ='PotentialBusinessValue';
  static const String visitStatus ='VisitStatus';
  static const String isClosed ='IsClosed';
  static const String baseType ='BaseType';
  static const String baseId ='BaseId';
  static const String targetType ='TargetType';
  static const String targetId ='TargetId';
  static const String att1 ='Att1';
  static const String att2 ='Att2';
  static const String att3 ='Att3';
  static const String att4 ='Att4';
  static const String createdBy ='CreatedBy';
  static const String createdDateTime ='CreatedDateTime';
  static const String updatedBy ='UpdatedBy';
  static const String updatedDateTime ='UpdatedDateTime';
  static const String traceid ='Traceid';

}

class siteindbfilterModel{
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

  siteindbfilterModel({
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
    required this.address1,
    required this.address2,
    required this.address3,
    required this.area,
    required this.city,
    required this.closed,
    required this.contactname,
    required this.country,
    required this.createdby,
    required this.cusemail,
    required this.cusmobile,
    required this.customercode,
    required this.customername,
    required this.district,
    required this.meetingtime,
    required this.pincode,
    required this.plannedDate,
    required this.product,
    required this.purposeofvisit,
    required this.state,
    required this.storecode,
    required this.traceid,
    required this.userid,
    required this.visitplan,
    required this.visitstatus,
    

  });

 

}