

const String tableitemlist2 = "tablelist2";

class ItemlistdbColumns2{
  static const String id = "Id";
 static const String itemCode = "ItemCode";
 static const String storeCode = "StoreCode";
 static const String whseCode = "WhseCode";
 static const String storeStock = "StoreStock";
 static const String whseStock = "WhseStock";
 static const String mrp = "Mrp";
 static const String cost = "Cost";
 static const String sp = "Sp";
 static const String ssp1 = "Ssp1";
 static const String ssp2 = "Ssp2";
 static const String ssp3 = "Ssp3";
 static const String ssp4 = "Ssp4";
 static const String ssp5 = "Ssp5";
 static const String spInc = "SpInc";
 static const String ssp1Inc = "Ssp1Inc";
 static const String ssp2Inc = "Ssp2Inc";
 static const String ssp3Inc = "Ssp3Inc";
 static const String ssp4Inc = "Ssp4Inc";
 static const String ssp5Inc = "Ssp5Inc";
 static const String allowNegativeStock = "AllowNegativeStock";
 static const String allowOrderBelowCost = "AllowOrderBelowCost";
 static const String isFixedPrice = "IsFixedPrice";
 static const String validTill = "ValidTill";
 static const String createdBy = "CreatedBy";
 static const String createdDateTime = "CreatedDateTime";
 static const String updatedBy = "UpdatedBy";
 static const String updatedDateTime = "UpdatedDateTime";
 
}
class ItemlistDBdata2{
  int? id;
  String? itemCode;
  String? storeCode;
  String? whseCode;
  double? storeStock;
  double? whseStock;
  double? mrp;
  double? cost;
  double? sp;
  double? ssp1;
  double? ssp2;
  double? ssp3;
  String? ssp4;
  String? ssp5;
  String? spInc;
  String? ssp1Inc;
  String? ssp2Inc;
  String? ssp3Inc;
  String? ssp4Inc;
  String? ssp5Inc;
  bool? allowNegativeStock;
  bool? allowOrderBelowCost;
  bool? isFixedPrice;
  String? validTill;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  ItemlistDBdata2({
    required this.allowNegativeStock,
    required this.allowOrderBelowCost,
    required this.cost,
    required this.createdBy,
    required this.createdDateTime,
    required this.id,
    required this.isFixedPrice,
    required this.itemCode,
    required this.mrp,
    required this.sp,
    required this.spInc,
    required this.ssp1,
    required this.ssp1Inc,
    required this.ssp2,
    required this.ssp2Inc,
    required this.ssp3,
    required this.ssp3Inc,
    required this.ssp4,
    required this.ssp4Inc,
    required this.ssp5,
    required this.ssp5Inc,
    required this.storeCode,
    required this.storeStock,
    required this.updatedBy,
    required this.updatedDateTime,
    required this.validTill,
    required this.whseCode,
    required this.whseStock

  });

   Map<String , Object?> toMap()=>{
ItemlistdbColumns2.id:id,
ItemlistdbColumns2.itemCode:itemCode,
ItemlistdbColumns2.storeCode:storeCode,
ItemlistdbColumns2.whseCode:whseCode,
ItemlistdbColumns2.storeStock:storeStock,
ItemlistdbColumns2.whseStock:whseStock,
ItemlistdbColumns2.mrp:mrp,
ItemlistdbColumns2.cost:cost,
ItemlistdbColumns2.sp:sp,
ItemlistdbColumns2.ssp1:ssp1,
ItemlistdbColumns2.ssp2:ssp2,
ItemlistdbColumns2.ssp3:ssp3,
ItemlistdbColumns2.ssp4:ssp4,
ItemlistdbColumns2.ssp5:ssp5,
ItemlistdbColumns2.spInc:spInc,
ItemlistdbColumns2.ssp1Inc:ssp1Inc,
ItemlistdbColumns2.ssp2Inc:ssp2Inc,
ItemlistdbColumns2.ssp3Inc:ssp3Inc,
ItemlistdbColumns2.ssp4Inc:ssp4Inc,
ItemlistdbColumns2.ssp5Inc:ssp5Inc,
ItemlistdbColumns2.allowNegativeStock:allowNegativeStock,
ItemlistdbColumns2.allowOrderBelowCost:allowOrderBelowCost,
ItemlistdbColumns2.isFixedPrice:isFixedPrice,
ItemlistdbColumns2.validTill:validTill,
ItemlistdbColumns2.createdBy:createdBy,
ItemlistdbColumns2.createdDateTime:createdDateTime,
ItemlistdbColumns2.updatedBy:updatedBy,
ItemlistdbColumns2.updatedDateTime:updatedDateTime,
   };
}