const String tableoutstanding = "Outstanding";

class outsatandingDBcolumns {
  
  static const String customerCode = 'CustomerCode';//
  static const String customerName = 'CustomerName';//
  static const String customerMobile = 'CustomerMobile';//
  static const String alternateMobileNo = 'AlternateMobileNo';//
  static const String contactName = 'ContactName';//
  static const String customerEmail = 'CustomerEmail';//
  static const String companyName = 'CompanyName';//
  static const String customerGroup = 'CustomerGroup';//
  static const String gstNo = 'GstNo';//
  
  static const String storeCode = 'StoreCode';//
  static const String assignedTo = 'AssignedTo';//
  
  static const String transAmount = 'TransAmount';//
  static const String penaltyAfterDue = 'PenaltyAfterDue';//
  static const String collectionInc = 'CollectionInc';//
  static const String amountPaid = 'AmountPaid';//
  static const String balanceToPay = 'BalanceToPay';//
  
  
}

class outstandingDBModel{
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
  outstandingDBModel({
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
     
      required this.transAmount,
      
  });

 
 
}

