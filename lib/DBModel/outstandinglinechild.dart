const String tableoutstandingline = "Outstandingline";

class outsatandinglineDBcolumns{
   static const String docentry = 'Docentry';
   static const String customerCode = 'CustomerCode';
   static const String customerName = 'CustomerName';
   static const String customerMobile = 'CustomerMobile';
   static const String alternateMobileNo = 'AlternateMobileNo';
   static const String contactName = 'ContactName';
   static const String customerEmail = 'CustomerEmail';
   static const String companyName = 'CompanyName';
   static const String customerGroup = 'CustomerGroup';
   static const String gstNo = 'GstNo';
   static const String customerPORef = 'CustomerPORef';
   static const String bil_Address1 = 'Bil_Address1';
   static const String bil_Address2 = 'Bil_Address2';
   static const String bil_Address3 = 'Bil_Address3';
   static const String bil_Area = 'Bil_Area';
   static const String bil_City = 'Bil_City';
   static const String bil_District = 'Bil_District';
   static const String bil_State = 'Bil_State';
   static const String bil_Country = 'Bil_Country';
   static const String bil_Pincode = 'Bil_Pincode';
   static const String storeCode = 'StoreCode';
   static const String assignedTo = 'AssignedTo';
   static const String transNum = 'TransNum';
   static const String transDate = 'TransDate';
   static const String transDueDate = 'TransDueDate';
   static const String transType = 'TransType';
   static const String transRef1 = 'TransRef1';
   static const String loanRef = 'LoanRef';
   static const String collectionType = 'CollectionType';
   static const String transAmount = 'TransAmount';
   static const String penaltyAfterDue = 'PenaltyAfterDue';
   static const String collectionInc = 'CollectionInc';
   static const String amountPaid = 'AmountPaid';
   static const String balanceToPay = 'BalanceToPay';
   static const String status = 'Status';
   static const String createdBy = 'CreatedBy';
   static const String createdOn = 'CreatedOn';
   static const String updatedBy = 'UpdatedBy';
   static const String updatedOn = 'UpdatedOn';
   static const String traceid = 'Traceid';

}



class outstandinglineDBModel{
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

  outstandinglineDBModel({
required this.bil_Address1,
      required this.bil_Address2,
      required this.bil_Address3,
      required this.bil_Area,
      required this.bil_City,
      required this.bil_Country,
      required this.bil_District,
      required this.bil_Pincode,
      required this.bil_State,
      required this.collectionType,
      required this.createdBy,
      required this.createdOn,
      required this.customerPORef,
      required this.docentry,
      required this.transDate,
      required this.transDueDate,
      required this.transNum,
      required this.transRef1,
      required this.transType,
      required this.updatedBy,
      required this.updatedOn,
      required this.loanRef,
      required this.status,
      required this.traceid,
      required this.alternateMobileNo,
      required this.amountPaid,
      required this.assignedTo,
      required this.balanceToPay,
      required this.collectionInc,
      required this.companyName,
      required this.contactName,
      required this.customerCode,
      required this.customerEmail,
      required this.customerGroup,
      required this.customerMobile,
      required this.customerName,
      required this.gstNo,
      required this.penaltyAfterDue,
      required this.storeCode,
      required this.transAmount
  });

 
}

const String tableoutstandingkpi = "OutstandingKPI";
class outstandingKPIcolumn{

}
