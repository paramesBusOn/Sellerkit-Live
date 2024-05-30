
import 'dart:developer';

import 'package:sellerkit/DBModel/TestDbmodel1.dart';
import 'package:sellerkit/DBModel/testdbmodel2.dart';

class ItemListheader{
  List<ItemlistPardata>? itemlispardara;
  String? Exception;
  int? stcode;
  String? message;
  ItemListheader({
    required this.itemlispardara,
    required this.Exception,
    required this.message,
    required this.stcode

  });

  factory ItemListheader.fromJson(Map<String,dynamic> json,int stcode){
    
    if(json['data'] !=null ){
      var list=json['data'] as List;
      
      if(list != null && list.isNotEmpty){
        // log("list1111::"+list.length.toString());
     
          List<ItemlistPardata> dataList =
          list.map((data) => ItemlistPardata.fromJson(data)).toList();
          
return ItemListheader(
      itemlispardara: dataList, 
      Exception: null, 
      message: "sucess", 
      stcode: stcode
      );
      }else{
        return ItemListheader(
      itemlispardara: null, 
      Exception: null, 
      message: "failed", 
      stcode: stcode
      );
      }
 
    }else{
      return ItemListheader(
      itemlispardara: null, 
      Exception: null, 
      message: "failed", 
      stcode: stcode
      );
    }
   
  }
    factory ItemListheader.issues(Map<String,dynamic> jsons,int stcode) {
    return ItemListheader(
        itemlispardara: null, message: jsons['respCode'],  stcode: stcode,
        Exception:jsons['respDesc']);
  }

  factory ItemListheader.error(String jsons,int stcode) {
    return ItemListheader(
        itemlispardara: null, message: 'Exception',  stcode: stcode,
        Exception:jsons);
  }

}


class ItemlistPardata{
  Itemlistdata1? itemlist1;
  Itemlistdata2? itemlist2;
  ItemlistPardata({
    required this.itemlist1,
    required this.itemlist2

  });
  factory ItemlistPardata.fromJson(Map<String,dynamic> json){
    int dd=0;
      //  log("list1111::${dd+1}");
 return ItemlistPardata(
    itemlist1: Itemlistdata1.fromJson(json['it']),
    itemlist2: Itemlistdata2.fromJson(json['ip']),
    
    );
  }
 
 
    

}


class Itemlistdata1{
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
  String? status;
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
  Itemlistdata1({
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
  factory Itemlistdata1.fromJson(Map<String,dynamic> json)=>
  Itemlistdata1(
    brand: json['brand'], 
    brandCode: json['brandCode'], 
    catalogueUrl1: json['catalogueUrl1'], 
    catalogueUrl2: json['catalogueUrl2'], 
    category: json['category'], 
    clasification: json['clasification'], 
    color: json['color'], 
    createdBy: json['createdBy'], 
    createdDateTime: json['createdDateTime'], 
    eol: json['eol'], 
    fast: json['fast'], 
    id: json['id'], 
    imageUrl1: json['imageUrl1'], 
    imageUrl2: json['imageUrl2'], 
    itemCode: json['itemCode']??'', 
    itemDescription: json['itemDescription'], 
    itemGroup: json['itemGroup'], 
    itemName: json['itemName'], 
    lastUpdatedIp: json['lastUpdatedIp'], 
    modelNo: json['modelNo'], 
    movingType: json['movingType'], 
    partCode: json['partCode'], 
    serialNumber: json['serialNumber'], 
    sizeCapacity: json['sizeCapacity'], 
    skucode: json['skucode'], 
    slow: json['slow'], 
    specification: json['specification'], 
    status: json['status'], 
    subCategory: json['subCategory'], 
    taxRate: json['taxRate'].toString(), 
    textNote: json['textNote'], 
    uoM: json['uoM'], 
    updateDateTime: json['updateDateTime'], 
    updatedBy: json['updatedBy'], 
    veryFast: json['veryFast'], 
    verySlow: json['verySlow']
    );

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

class Itemlistdata2{
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
  Itemlistdata2({
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
factory Itemlistdata2.fromJson(Map<String,dynamic> json)=>
Itemlistdata2(
  allowNegativeStock: json['allowNegativeStock'], 
  allowOrderBelowCost:  json['allowOrderBelowCost'], 
  cost:  json['cost'], 
  createdBy:  json['createdBy'], 
  createdDateTime:  json['createdDateTime'], 
  id:  json['id'], 
  isFixedPrice:  json['isFixedPrice'], 
  itemCode:  json['itemCode']??'', 
  mrp:  json['mrp'], 
  sp:  json['sp'], 
  spInc:  json['spInc'], 
  ssp1:  json['ssp1'], 
  ssp1Inc:  json['ssp1Inc'], 
  ssp2:  json['ssp2'], 
  ssp2Inc:  json['ssp2Inc'], 
  ssp3:  json['ssp3'], 
  ssp3Inc:  json['ssp3Inc'], 
  ssp4:  json['ssp4'], 
  ssp4Inc:  json['ssp4Inc'], 
  ssp5:  json['ssp5'], 
  ssp5Inc:  json['ssp5Inc'], 
  storeCode:  json['storeCode']??'', 
  storeStock:  json['storeStock'], 
  updatedBy:  json['updatedBy'], 
  updatedDateTime:  json['updatedDateTime'], 
  validTill:  json['validTill'], 
  whseCode:  json['whseCode'], 
  whseStock:  json['whseStock']
  );

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