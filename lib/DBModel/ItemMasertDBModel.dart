// ignore_for_file: file_names
const String tableItemMaster = "ItemMaster";

class ItemMasterColumns {
  static const String id = "Id";
  static const String itemCode = "ItemCode";
  static const String itemName = "ItemName";
  static const String category = "Category";
  static const String brand = "Brand";
  static const String division = "Division";
  static const String segment = "Segment";
  static const String favorite = "Favorite";
  static const String isselected = "IsSelected";
  static const String slpPrice = "SlpPrice";
  static const String mgrPrice = "MgrPrice";
  static const String storeStock = "StoreStock";
  static const String whsStock = "WhsStock";
  static const String refreshedRecordDate = "RefreshedRecordDate";
  static const String itemDescription = "ItemDescription";
  static const String modelNo = "ModelNo";
  static const String partCode = "PartCode";
  static const String skucode = "Skucode";
  static const String brandCode = "BrandCode";
  static const String itemGroup = "ItemGroup";
  static const String specification = "Specification";
  static const String sizeCapacity = "SizeCapacity";
  static const String clasification = "Clasification";
  static const String uoM = "UoM";
  static const String taxRate = "TaxRate";
  static const String catalogueUrl1 = "CatalogueUrl1";
  static const String catalogueUrl2 = "CatalogueUrl2";
  static const String imageUrl1 = "ImageUrl1";
  static const String imageUrl2 = "ImageUrl2";
  static const String textNote = "TextNote";
  static const String status = "Status";
  static const String movingType = "MovingType";
  static const String eol = "Eol";
  static const String veryFast = "VeryFast";
  static const String fast = "Fast";
  static const String slow = "Slow";
  static const String verySlow = "VerySlow";
  static const String serialNumber = "SerialNumber";
  static const String priceStockId = "PriceStockId";
  static const String storeCode = "StoreCode";
  static const String whseCode = "WhseCode";
  static const String sp = "Sp";
  static const String ssp1 = "Ssp1";
  static const String ssp2 = "Ssp2";
  static const String ssp3 = "Ssp3";
  static const String ssp4 = "Ssp4";
  static const String ssp5 = "Ssp5";
  static const String ssp1Inc = "Ssp1Inc";
  static const String ssp2Inc = "Ssp2Inc";
  static const String ssp3Inc = "Ssp3Inc";
  static const String ssp4Inc = "Ssp4Inc";
  static const String ssp5Inc = "Ssp5Inc";
  static const String allowNegativeStock = "AllowNegativeStock";
  static const String allowOrderBelowCost = "AllowOrderBelowCost";
  static const String isFixedPrice = "IsFixedPrice";
  static const String validTill = "ValidTill";
  static const String color = "color";
  static const String calcType = "calcType";
  static const String payOn = "payOn";
  static const String storeAgeSlab1 = "storeAgeSlab1";
  static const String storeAgeSlab2 = "storeAgeSlab2";
  static const String storeAgeSlab3 = "storeAgeSlab3";
  static const String storeAgeSlab4 = "storeAgeSlab4";
  static const String storeAgeSlab5 = "storeAgeSlab5";
  static const String whsAgeSlab1 = "whsAgeSlab1";
  static const String whsAgeSlab2 = "whsAgeSlab2";
  static const String whsAgeSlab3 = "whsAgeSlab3";
  static const String whsAgeSlab4 = "whsAgeSlab4";
  static const String whsAgeSlab5 = "whsAgeSlab5";
  
}

class ItemMasterDBModel {
  int? id;
  int? IMId;
  String? itemCode;
  String itemName;
  String category;
  String brand;
  String division;
  String segment;
  String favorite;
  int isselected;
  double? slpPrice;
  double? mgrPrice;
  double? storeStock;
  double? whsStock;
  String? refreshedRecordDate;
  String? itemDescription;
  String? modelNo;
  String? partCode;
  String? skucode;
  String? brandCode;
  String? itemGroup;
  String? specification;
  String? sizeCapacity;
  String? clasification;
  String? uoM;
  int? taxRate;
  String? catalogueUrl1;
  String? catalogueUrl2;
  String? imageUrl1;
  String? imageUrl2;
  String? textNote;
  String? status;
  String? movingType;
  bool? eol;
  bool? veryFast;

  bool? fast;
  bool? slow;
  bool? verySlow;
  bool? serialNumber;
  int? priceStockId;
  String? storeCode;
  String? whseCode;
  double? sp;
  double? ssp1;
  double? ssp2;
  double? ssp3;
  double? ssp4;
  double? ssp5;
  double? ssp1Inc;
  double? ssp2Inc;
  double? ssp3Inc;
  double? ssp4Inc;
  double? ssp5Inc;
  bool? allowNegativeStock;
  bool? allowOrderBelowCost;
  bool? isFixedPrice;
  String? validTill;
  String? color;
   String? calcType;
  String? payOn;
  double? storeAgeSlab1;
  double? storeAgeSlab2;
  double? storeAgeSlab3;
  double? storeAgeSlab4;
  double? storeAgeSlab5;
  double? whsAgeSlab1;
  double? whsAgeSlab2;
  double? whsAgeSlab3;
  double? whsAgeSlab4;
  double? whsAgeSlab5;

  ItemMasterDBModel(
      {this.id,
      required this.itemCode,
      required this.brand,
      required this.division,
      required this.category,
      required this.itemName,
      required this.segment,
      required this.isselected,
      required this.favorite,
      required this.mgrPrice,
      required this.slpPrice,
      this.IMId,
      required this.storeStock,
      required this.whsStock,
      this.refreshedRecordDate,
      required this.allowNegativeStock,
      required this.allowOrderBelowCost,
      required this.brandCode,
      required this.catalogueUrl1,
      required this.catalogueUrl2,
      required this.clasification,
      required this.color,
      required this.eol,
      required this.fast,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.isFixedPrice,
      required this.itemDescription,
      required this.itemGroup,
      required this.modelNo,
      required this.movingType,
      required this.partCode,
      required this.priceStockId,
      required this.serialNumber,
      required this.sizeCapacity,
      required this.skucode,
      required this.slow,
      required this.sp,
      required this.specification,
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
      required this.status,
      required this.storeCode,
      required this.taxRate,
      required this.textNote,
      required this.uoM,
      required this.validTill,
      required this.veryFast,
      required this.verySlow,
      required this.whseCode,
      required this.calcType,
      required this.payOn,
       required this. storeAgeSlab1,
 required this. storeAgeSlab2,
  required this. storeAgeSlab3,
  required this. storeAgeSlab4,
  required this. storeAgeSlab5,
  required this. whsAgeSlab1,
  required this. whsAgeSlab2,
  required this. whsAgeSlab3,
  required this. whsAgeSlab4,
  required this. whsAgeSlab5,
      });

  Map<String, Object?> toMap() => {
        ItemMasterColumns.id: id,
        ItemMasterColumns.itemCode: itemCode,
        ItemMasterColumns.itemName: itemName,
        ItemMasterColumns.category: category,
        ItemMasterColumns.brand: brand,
        ItemMasterColumns.division: division,
        ItemMasterColumns.segment: segment,
        ItemMasterColumns.isselected: isselected,
        ItemMasterColumns.favorite: favorite,
        ItemMasterColumns.mgrPrice: mgrPrice,
        ItemMasterColumns.slpPrice: slpPrice,
        ItemMasterColumns.whsStock: whsStock,
        ItemMasterColumns.storeStock: storeStock,
        ItemMasterColumns.refreshedRecordDate: refreshedRecordDate,
        ItemMasterColumns.itemDescription: itemDescription,
        ItemMasterColumns.modelNo: modelNo,
        ItemMasterColumns.partCode: partCode,
        ItemMasterColumns.skucode: skucode,
        ItemMasterColumns.brandCode: brandCode,
        ItemMasterColumns.itemGroup: itemGroup,
        ItemMasterColumns.specification: specification,
        ItemMasterColumns.sizeCapacity: sizeCapacity,
        ItemMasterColumns.clasification: clasification,
        ItemMasterColumns.uoM: uoM,
        ItemMasterColumns.taxRate: taxRate,
        ItemMasterColumns.catalogueUrl1: catalogueUrl1,
        ItemMasterColumns.catalogueUrl2: catalogueUrl2,
        ItemMasterColumns.imageUrl1: imageUrl1,
        ItemMasterColumns.imageUrl2: imageUrl2,
        ItemMasterColumns.textNote: textNote,
        ItemMasterColumns.status: status,
        ItemMasterColumns.movingType: movingType,
        ItemMasterColumns.eol: eol.toString(),
        ItemMasterColumns.veryFast: veryFast.toString(),
        ItemMasterColumns.fast: fast.toString(),
        ItemMasterColumns.slow: slow.toString(),
        ItemMasterColumns.verySlow: verySlow.toString(),
        ItemMasterColumns.serialNumber: serialNumber.toString(),
        ItemMasterColumns.priceStockId: priceStockId,
        ItemMasterColumns.storeCode: storeCode,
        ItemMasterColumns.whseCode: whseCode,
        ItemMasterColumns.sp: sp,
        ItemMasterColumns.ssp1: ssp1,
        ItemMasterColumns.ssp2: ssp2,
        ItemMasterColumns.ssp3: ssp3,
        ItemMasterColumns.ssp4: ssp4,
        ItemMasterColumns.ssp5: ssp5,
        ItemMasterColumns.ssp1Inc: ssp1Inc,
        ItemMasterColumns.ssp2Inc: ssp2Inc,
        ItemMasterColumns.ssp3Inc: ssp3Inc,
        ItemMasterColumns.ssp4Inc: ssp4Inc,
        ItemMasterColumns.ssp5Inc: ssp5Inc,
        ItemMasterColumns.allowNegativeStock: allowNegativeStock.toString(),
        ItemMasterColumns.allowOrderBelowCost: allowOrderBelowCost.toString(),
        ItemMasterColumns.isFixedPrice: isFixedPrice.toString(),
        ItemMasterColumns.validTill: validTill,
        ItemMasterColumns.color: color,
        ItemMasterColumns.calcType: calcType,
        ItemMasterColumns.payOn: payOn,
        ItemMasterColumns.storeAgeSlab1: storeAgeSlab1,
        ItemMasterColumns.storeAgeSlab2: storeAgeSlab2,
        ItemMasterColumns.storeAgeSlab3: storeAgeSlab3,
        ItemMasterColumns.storeAgeSlab4: storeAgeSlab4,
        ItemMasterColumns.storeAgeSlab5: storeAgeSlab5,
        ItemMasterColumns.whsAgeSlab1: whsAgeSlab1,
        ItemMasterColumns.whsAgeSlab2: whsAgeSlab2,
        ItemMasterColumns.whsAgeSlab3: whsAgeSlab3,
        ItemMasterColumns.whsAgeSlab4: whsAgeSlab4,
        ItemMasterColumns.whsAgeSlab5: whsAgeSlab5,
        
      };
}
