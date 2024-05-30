const String tableopenlead = 'tableopenlead';

class openleadT {
  static String leadDocEntry = 'LeadDocEntry';
  static String followupEntry = 'FollowupEntry';
  static String leadNum = 'LeadNum';
  static String mobile = 'Mobile';
  static String customerName = 'CustomerName';
  static String docDate = 'DocDate';
  static String city = 'City';
  static String nextFollowup = 'NextFollowup';
  static String product = 'Product';
  static String value = 'Value';
  static String status = 'Status';
  static String lastUpdateMessage = 'LastUpdateMessage';
  static String lastUpdateTime = 'LastUpdateTime';
  static String customermob = 'Customermob';
  static String cusEmail = 'CusEmail';
  static String companyname = 'Companyname';
  static String cusgroup = 'Cusgroup';
  static String storecode = 'Storecode';
  static String add1 = 'Add1';
  static String add2 = 'Add2';
  static String area = 'Area';
  static String district = 'District';
  static String state = 'State';
  static String country = 'Country';
  static String pincode = 'Pincode';
  static String gender = 'Gender';
  static String agegroup = 'Agegroup';
  static String cameAs = 'CameAs';
  static String headcount = 'Headcount';
  static String maxbudget = 'Maxbudget';
  static String assignedTo = 'AssignedTo';
  static String refferal = 'Refferal';
  static String purchasePlan = 'PurchasePlan';
  static String dealDescription = 'DealDescription';
  static String lastFollowupDate = 'LastFollowupDate';
  static String createdBy = 'CreatedBy';
  static String createdDate = 'CreatedDate';
  static String updatedBy = 'UpdatedBy';
  static String updatedDate = 'UpdatedDate';
  static String traceId = 'TraceId';
}

class leadopenDBmodel {
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

  leadopenDBmodel(
      {required this.City,
      required this.CustomerName,
      required this.DocDate,
      required this.FollowupEntry,
      required this.LastUpdateMessage,
      required this.LastUpdateTime,
      required this.LeadDocEntry,
      required this.LeadNum,
      required this.Mobile,
      required this.NextFollowup,
      required this.Product,
      required this.Status,
      required this.Value,
      required this.add1,
      required this.add2,
      required this.agegroup,
      required this.area,
      required this.assignedTo,
      required this.cameAs,
      required this.companyname,
      required this.country,
      required this.createdBy,
      required this.createdDate,
      required this.cusEmail,
      required this.cusgroup,
      required this.customermob,
      required this.dealDescription,
      required this.district,
      required this.gender,
      required this.headcount,
      required this.lastFollowupDate,
      required this.maxbudget,
      required this.pincode,
      required this.purchasePlan,
      required this.refferal,
      required this.state,
      required this.storecode,
      required this.traceId,
      required this.updatedBy,
      required this.updatedDate});

  Map<String, Object?> toMap() => {
        openleadT.add1: add1!,
        openleadT.agegroup: agegroup!,
        openleadT.leadDocEntry: LeadDocEntry!,
        openleadT.followupEntry: FollowupEntry!,
        openleadT.leadNum: LeadNum!,
        openleadT.mobile: Mobile!,
        openleadT.customerName: CustomerName!,
        openleadT.docDate: DocDate!,
        openleadT.city: City!,
        openleadT.product: Product!,
        openleadT.value: Value!,
        openleadT.status: Status!,
        openleadT.nextFollowup: NextFollowup!,
        openleadT.lastUpdateMessage: LastUpdateMessage!,
        openleadT.lastUpdateTime: LastUpdateTime!,
        openleadT.customermob: customermob!,
        openleadT.cusEmail: cusEmail!,
        openleadT.companyname: companyname!,
        openleadT.cusgroup: cusgroup!,
        openleadT.storecode: storecode!,
        openleadT.add2: add2!,
        openleadT.area: area!,
        openleadT.district: district!,
        openleadT.state: state!,
        openleadT.country: country!,
        openleadT.pincode: pincode!,
        openleadT.gender: gender!,
        openleadT.agegroup: agegroup!,
        openleadT.cameAs: cameAs!,
        openleadT.headcount: headcount!,
        openleadT.maxbudget: maxbudget!,
        openleadT.assignedTo: assignedTo!,
        openleadT.refferal: refferal!,
        openleadT.purchasePlan: purchasePlan!,
        openleadT.dealDescription: dealDescription!,
        openleadT.lastFollowupDate: lastFollowupDate!,
        openleadT.createdBy: createdBy!,
        openleadT.createdDate: createdDate!,
        openleadT.updatedBy: updatedBy!,
        openleadT.updatedDate: updatedDate!,
        openleadT.traceId: traceId!,
        
      };
}
