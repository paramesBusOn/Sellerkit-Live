const String tableopenLeadfilter = "openLeadfilter";

class OpenLeadfilterDBcolumns{
  static const String leadDocEntry = 'LeadDocEntry';
  static const String followupEntry = 'FollowupEntry';
  static const String leadNum = 'LeadNum';
  static const String mobile = 'Mobile';
  static const String customerName = 'CustomerName';
  static const String docDate = 'DocDate';
  static const String city = 'City';
  static const String nextFollowup = 'NextFollowup';
  static const String product = 'Product';
  static const String value = 'Value';
  static const String status = 'Status';
  static const String lastUpdateMessage = 'LastUpdateMessage';
  static const String lastUpdateTime = 'LastUpdateTime';
  static const String customermob = 'Customermob';
  static const String cusEmail = 'CusEmail';
  static const String companyname = 'Companyname';
  static const String cusgroup = 'Cusgroup';
  static const String storecode = 'Storecode';
  static const String add1 = 'Add1';
  static const String add2 = 'Add2';
  static const String area = 'Area';
  static const String district = 'District';
  static const String state = 'State';
  static const String country = 'Country';
  static const String pincode = 'Pincode';
  static const String gender = 'Gender';
  static const String agegroup = 'Agegroup';
  static const String cameAs = 'CameAs';
  static const String headcount = 'Headcount';
  static const String maxbudget = 'Maxbudget';
  static const String assignedTo = 'AssignedTo';
  static const String refferal = 'Refferal';
  static const String purchasePlan = 'PurchasePlan';
  static const String dealDescription = 'DealDescription';
  static const String lastFollowupDate = 'LastFollowupDate';
  static const String createdBy = 'CreatedBy';
  static const String createdDate = 'CreatedDate';
  static const String updatedBy = 'UpdatedBy';
  static const String updatedDate = 'UpdatedDate';
  static const String traceId = 'TraceId';
  static const String interestLevel = 'InterestLevel';
  static const String orderType = 'OrderType';
}

class OpenLeadfiltermodel{
   int? LeadDocEntry;
  int? FollowupEntry;
  int? LeadNum;
  String? Mobile;
  String? CustomerName;
  String? DocDate;
  String? City;
  String? NextFollowup;
  String? Product;
  double? Value;
  String? Status;
  String? LastUpdateMessage;
  String? LastUpdateTime;
  String? customermob;
  String? cusEmail;
  String? companyname;
  String? cusgroup;
  String? storecode;
  String? add1;
  String? add2;
  String? area;

  String? district;
  String? state;
  String? country;
  String? pincode;
  String? gender;
  String? agegroup;
  String? cameAs;
  int? headcount;
  double? maxbudget;
  String? assignedTo;
  String? refferal;
  String? purchasePlan;
  String? dealDescription;
  String? lastFollowupDate;

  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? traceId;
  
 String? InterestLevel;
  String? OrderType;
OpenLeadfiltermodel({
 required this.InterestLevel,
  required this.OrderType,
    
    required this.LeadDocEntry,
    required this.LeadNum,
    required this.Mobile,
    required this.CustomerName,
    required this.DocDate,
    required this.City,
    required this.NextFollowup,
    required this.Product,
    required this.Value,
    required this.Status,
    required this.LastUpdateMessage,
    required this.LastUpdateTime,
    required this.FollowupEntry,
    required this.customermob,
    required this.cusEmail,
    required this.companyname,
    required this.cusgroup,
    required this.storecode,
    required this.add1,
    required this.add2,
    required this.area,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.gender,
    required this.agegroup,
    required this.cameAs,
    required this.headcount,
    required this.maxbudget,
    required this.assignedTo,
    required this.refferal,
    required this.purchasePlan,
    required this.dealDescription,
    required this.lastFollowupDate,
   
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.traceId,
});
 Map<String, Object?> toMap() => {
    OpenLeadfilterDBcolumns.leadDocEntry:LeadDocEntry,
    OpenLeadfilterDBcolumns.followupEntry:FollowupEntry,
    OpenLeadfilterDBcolumns.leadNum:LeadNum,
    OpenLeadfilterDBcolumns.mobile:Mobile,
    OpenLeadfilterDBcolumns.customerName:CustomerName,
    OpenLeadfilterDBcolumns.docDate:DocDate,
    OpenLeadfilterDBcolumns.city:City,
    OpenLeadfilterDBcolumns.nextFollowup:NextFollowup,
    OpenLeadfilterDBcolumns.product:Product,
    OpenLeadfilterDBcolumns.value:Value,
    OpenLeadfilterDBcolumns.status:Status,
    OpenLeadfilterDBcolumns.lastUpdateMessage:LastUpdateMessage,
    OpenLeadfilterDBcolumns.lastUpdateTime:LastUpdateTime,
    OpenLeadfilterDBcolumns.customermob:customermob,
    OpenLeadfilterDBcolumns.cusEmail:cusEmail,
    OpenLeadfilterDBcolumns.companyname:companyname,
    OpenLeadfilterDBcolumns.cusgroup:cusgroup,
    OpenLeadfilterDBcolumns.storecode:storecode,
    OpenLeadfilterDBcolumns.add1:add1,
    OpenLeadfilterDBcolumns.add2:add2,
    OpenLeadfilterDBcolumns.area:area,
    OpenLeadfilterDBcolumns.district:district,
    OpenLeadfilterDBcolumns.state:state,
    OpenLeadfilterDBcolumns.country:country,
    OpenLeadfilterDBcolumns.pincode:pincode,
    OpenLeadfilterDBcolumns.gender:gender,
    OpenLeadfilterDBcolumns.agegroup:agegroup,
    OpenLeadfilterDBcolumns.cameAs:cameAs,
    OpenLeadfilterDBcolumns.headcount:headcount,
    OpenLeadfilterDBcolumns.maxbudget:maxbudget,
    OpenLeadfilterDBcolumns.assignedTo:assignedTo,
    OpenLeadfilterDBcolumns.refferal:refferal,
    OpenLeadfilterDBcolumns.purchasePlan:purchasePlan,
    OpenLeadfilterDBcolumns.dealDescription:dealDescription,
    OpenLeadfilterDBcolumns.lastFollowupDate:lastFollowupDate,
    OpenLeadfilterDBcolumns.createdBy:createdBy,
    OpenLeadfilterDBcolumns.createdDate:createdDate,
    OpenLeadfilterDBcolumns.updatedBy:updatedBy,
    OpenLeadfilterDBcolumns.updatedDate:updatedDate,
    OpenLeadfilterDBcolumns.traceId:traceId,
    
    OpenLeadfilterDBcolumns.interestLevel:InterestLevel,
    OpenLeadfilterDBcolumns.orderType:OrderType,
    
  };
}