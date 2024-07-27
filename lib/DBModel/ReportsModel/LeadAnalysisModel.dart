const String leadAnalysisTable = "LeadAnalysisTable";

class LeadAnalysisDB {
  static const String leadId = 'LeadId';
  static const String leadDate = 'LeadDate';
  static const String customerCode = 'CustomerCode';
  static const String customerName = 'CustomerName';
  static const String customerMobile = 'CustomerMobile';
  static const String customerEmail = 'CustomerEmail';
  static const String companyName = 'CompanyName';
  static const String customerGroup = 'CustomerGroup';
  static const String storeCode = 'StoreCode';
  static const String storeName = 'StoreName';
  static const String address1 = 'Address1';
  static const String address2 = 'Address2';
  static const String area = 'Area';
  static const String city = 'City';
  static const String district = 'District';
  static const String state = 'State';
  static const String country = 'Country';
  static const String pincode = 'Pincode';
  static const String gender = 'Gender';
  static const String ageGroup = 'AgeGroup';
  static const String cameAs = 'CameAs';
  static const String headcount = 'Headcount';
  static const String maxbudget = 'Maxbudget';
  static const String assignedTo = 'AssignedTo';
  static const String refferal = 'Refferal';
  static const String interestLevel = 'InterestLevel';
  static const String orderType = 'OrderType';
  static const String purchasePlan = 'PurchasePlan';
  static const String nextFollowupDate = 'NextFollowupDate';
  static const String dealDescription = 'DealDescription';
  static const String status = 'Status';
  static const String lastFollowupStatus = 'LastFollowupStatus';
  static const String lastFollowupDate = 'LastFollowupDate';
  static const String itemCode = 'ItemCode';
  static const String itemName = 'ItemName';
  static const String brand = 'Brand';
  static const String category = 'Category';
  static const String subCategory = 'SubCategory';
  static const String leadValue = 'LeadValue';
  static const String createdBy = 'CreatedBy';
  static const String createdDate = 'CreatedDate';
  static const String updatedBy = 'UpdatedBy';
  static const String updatedDate = 'UpdatedDate';
  static const String traceId = 'TraceId';
  static const String customerCreatedOn = 'CustomerCreatedOn';
}

// class LeadAnalysisDBData {
//   int leadId; //
//   String leadDate; //
//   String customerCode; //
//   String customerName; //
//   String customerMobile; //
//   String customerEmail; //
//   String companyName; //
//   String customerGroup; //
//   String storeCode;
//   String storeName;
//   String address1;
//   String address2;
//   String area;
//   String city;
//   String district;
//   String state; //
//   String country; //
//   int pincode;
//   String gender;
//   String ageGroup;
//   String cameAs;
//   int headcount;
//   double maxbudget; //
//   String assignedTo;
//   String refferal; //
//   String interestLevel; //
//   String orderType; //
//   String purchasePlan; //
//   String nextFollowupDate; //
//   String dealDescription; //
//   String status; //
//   String lastFollowupStatus; //
//   String lastFollowupDate; //
//   String itemCode;
//   String itemName;
//   String brand;
//   String category;
//   String subCategory;
//   double leadValue;
//   int createdBy; //
//   String createdDate;
//   int updatedBy;
//   String updatedDate;
//   String traceId;
//   String customerCreatedOn;

//   LeadAnalysisDBData({
//     required this.leadId,
//     required this.leadDate,
//     required this.customerCode,
//     required this.customerName,
//     required this.customerMobile,
//     required this.customerEmail,
//     required this.companyName,
//     required this.customerGroup,
//     required this.storeCode,
//     required this.storeName,
//     required this.address1,
//     required this.address2,
//     required this.area,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.country,
//     required this.pincode,
//     required this.gender,
//     required this.ageGroup,
//     required this.cameAs,
//     required this.headcount,
//     required this.maxbudget,
//     required this.assignedTo,
//     required this.refferal,
//     required this.interestLevel,
//     required this.orderType,
//     required this.purchasePlan,
//     required this.nextFollowupDate,
//     required this.dealDescription,
//     required this.status,
//     required this.lastFollowupStatus,
//     required this.lastFollowupDate,
//     required this.itemCode,
//     required this.itemName,
//     required this.brand,
//     required this.category,
//     required this.subCategory,
//     required this.leadValue,
//     required this.createdBy,
//     required this.createdDate,
//     required this.updatedBy,
//     required this.updatedDate,
//     required this.traceId,
//     required this.customerCreatedOn,
//   });

//   Map<String, Object?> toMap() => {
//         LeadAnalysisDB.leadId: leadId,
//         LeadAnalysisDB.leadDate: leadDate,
//         LeadAnalysisDB.customerCode: customerCode,
//         LeadAnalysisDB.customerName: customerName,
//         LeadAnalysisDB.customerMobile: customerMobile,
//         LeadAnalysisDB.customerEmail: customerEmail,
//         LeadAnalysisDB.companyName: companyName,
//         LeadAnalysisDB.customerGroup: customerGroup,
//         LeadAnalysisDB.storeCode: storeCode,
//         LeadAnalysisDB.storeName: storeName,
//         LeadAnalysisDB.address1: address1,
//         LeadAnalysisDB.address2: address2,
//         LeadAnalysisDB.area: area,
//         LeadAnalysisDB.city: city,
//         LeadAnalysisDB.district: district,
//         LeadAnalysisDB.state: state,
//         LeadAnalysisDB.country: country,
//         LeadAnalysisDB.pincode: pincode,
//         LeadAnalysisDB.gender: gender,
//         LeadAnalysisDB.ageGroup: ageGroup,
//         LeadAnalysisDB.cameAs: cameAs,
//         LeadAnalysisDB.headcount: headcount,
//         LeadAnalysisDB.maxbudget: maxbudget,
//         LeadAnalysisDB.assignedTo: assignedTo,
//         LeadAnalysisDB.refferal: refferal,
//         LeadAnalysisDB.interestLevel: interestLevel,
//         LeadAnalysisDB.orderType: orderType,
//         LeadAnalysisDB.purchasePlan: purchasePlan,
//         LeadAnalysisDB.nextFollowupDate: nextFollowupDate,
//         LeadAnalysisDB.dealDescription: dealDescription,
//         LeadAnalysisDB.status: status,
//         LeadAnalysisDB.lastFollowupStatus: lastFollowupStatus,
//         LeadAnalysisDB.lastFollowupDate: lastFollowupDate,
//         LeadAnalysisDB.itemCode: itemCode,
//         LeadAnalysisDB.itemName: itemName,
//         LeadAnalysisDB.brand: brand,
//         LeadAnalysisDB.category: category,
//         LeadAnalysisDB.subCategory: subCategory,
//         LeadAnalysisDB.leadValue: leadValue,
//         LeadAnalysisDB.createdBy: createdBy,
//         LeadAnalysisDB.createdDate: createdDate,
//         LeadAnalysisDB.updatedBy: updatedBy,
//         LeadAnalysisDB.updatedDate: updatedDate,
//         LeadAnalysisDB.traceId: traceId,
//         LeadAnalysisDB.customerCreatedOn: customerCreatedOn,
//       };
// }
