
const String tableitemlist1 = "tablelist1";
class ItemlistdbColumns1{
  static const String id = "Id";
 static const String itemName = "ItemName";
 static const String itemCode = "ItemCode";
 static const String brand = "Brand";
 static const String category = "Category";
 static const String subCategory = "SubCategory";
 static const String itemDescription = "ItemDescription";
 static const String modelNo = "ModelNo";
 static const String partCode = "PartCode";
 static const String skucode = "Skucode";
 static const String brandCode = "BrandCode";
 static const String itemGroup = "ItemGroup";
 static const String specification = "Specification";
 static const String sizeCapacity = "SizeCapacity";
 static const String color = "Color";
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
 static const String createdBy = "CreatedBy";
 static const String updatedBy = "UpdatedBy";
 static const String createdDateTime = "CreatedDateTime";
 static const String updateDateTime = "UpdateDateTime";
 static const String lastUpdatedIp = "LastUpdatedIp";
 static const String veryFast = "VeryFast";
 static const String fast = "Fast";
 static const String slow = "Slow";
 static const String verySlow = "VerySlow";
 static const String serialNumber = "SerialNumber";

}


class ItemlistDBdata1{
  int? id;
  String? itemName;
  String? itemCode;
  String? brand;
  String? category;
  String? subCategory;
  String? itemDescription;
  String? modelNo;
  String? partCode;
  String? skucode;
  String? brandCode;
  String? itemGroup;
  String? specification;
  String? sizeCapacity;
  String? color;
  String? clasification;
  String? uoM;
  String? taxRate;
  String? catalogueUrl1;
  String? catalogueUrl2;
  String? imageUrl1;
  String? imageUrl2;
  String? textNote;
  int? status;
  String? movingType;
  bool? eol;
  String? createdBy;
  String? updatedBy;
  String? createdDateTime;
  String? updateDateTime;
  String? lastUpdatedIp;
  bool? veryFast;
  bool? fast;
  bool? slow;
  bool? verySlow;
  bool? serialNumber;
  ItemlistDBdata1({
    required this.brand,
    required this.brandCode,
    required this.catalogueUrl1,
    required this.catalogueUrl2,
    required this.category,
    required this.clasification,
    required this.color,
    required this.createdBy,
    required this.createdDateTime,
    required this.eol,
    required this.fast,
    required this.id,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.itemCode,
    required this.itemDescription,
    required this.itemGroup,
    required this.itemName,
    required this.lastUpdatedIp,
    required this.modelNo,
    required this.movingType,
    required this.partCode,
    required this.serialNumber,
    required this.sizeCapacity,
    required this.skucode,
    required this.slow,
    required this.specification,
    required this.status,
    required this.subCategory,
    required this.taxRate,
    required this.textNote,
    required this.uoM,
    required this.updateDateTime,
    required this.updatedBy,
    required this.veryFast,
    required this.verySlow

  });
  Map<String , Object?> toMap()=>
  {
    ItemlistdbColumns1.id:id,
    ItemlistdbColumns1.itemName:itemName,
    ItemlistdbColumns1.itemCode:itemCode,
    ItemlistdbColumns1.brand:brand,
    ItemlistdbColumns1.category:category,
    ItemlistdbColumns1.subCategory:subCategory,
    ItemlistdbColumns1.itemDescription:itemDescription,
    ItemlistdbColumns1.modelNo:modelNo,
    ItemlistdbColumns1.partCode:partCode,
    ItemlistdbColumns1.skucode:skucode,
    ItemlistdbColumns1.brandCode:brandCode,
    ItemlistdbColumns1.itemGroup:itemGroup,
    ItemlistdbColumns1.specification:specification,
    ItemlistdbColumns1.sizeCapacity:sizeCapacity,
    ItemlistdbColumns1.color:color,
    ItemlistdbColumns1.clasification:clasification,
    ItemlistdbColumns1.uoM:uoM,
    ItemlistdbColumns1.taxRate:taxRate,
    ItemlistdbColumns1.catalogueUrl1:catalogueUrl1,
    ItemlistdbColumns1.catalogueUrl2:catalogueUrl2,
    ItemlistdbColumns1.imageUrl1:imageUrl1,
    ItemlistdbColumns1.imageUrl2:imageUrl2,
    ItemlistdbColumns1.textNote:textNote,
    ItemlistdbColumns1.status:status,
    ItemlistdbColumns1.movingType:movingType,
    ItemlistdbColumns1.eol:eol,
    ItemlistdbColumns1.createdBy:createdBy,
    ItemlistdbColumns1.updatedBy:updatedBy,
    ItemlistdbColumns1.createdDateTime:createdDateTime,
    ItemlistdbColumns1.updateDateTime:updateDateTime,
    ItemlistdbColumns1.lastUpdatedIp:lastUpdatedIp,
    ItemlistdbColumns1.veryFast:veryFast,
    ItemlistdbColumns1.fast:fast,
    ItemlistdbColumns1.slow:slow,
    ItemlistdbColumns1.verySlow:verySlow,
     ItemlistdbColumns1.serialNumber:serialNumber,
  };

}