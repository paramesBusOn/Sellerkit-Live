// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';

class ItemMasterNewModal {
  List<ItemMasterNewData>? itemdata;
// List<ItemMasterNewData>? itempriceStock;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  ItemMasterNewModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ItemMasterNewModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // print("object::" + jsons.toString());
      var list = jsons['data'] as List;
      List<ItemMasterNewData> dataList =
          list.map((data) => ItemMasterNewData.fromJson(data)).toList();
      return ItemMasterNewModal(
          itemdata: dataList,
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return ItemMasterNewModal(
          itemdata: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory ItemMasterNewModal.issues(Map<String, dynamic> jsons, int stcode) {
    return ItemMasterNewModal(
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory ItemMasterNewModal.error(String jsons, int stcode) {
    return ItemMasterNewModal(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ItemMasterNewData {
  ItemMasterNewData(
      {required this.MgrPrice,
      required this.itemcode,
      required this.itemName,
      required this.Segment,
      required this.Favorite,
      required this.SlpPrice,
      required this.Category,
      required this.Brand,
      required this.Division,
      required this.StoreStock,
      required this.WhsStock,
      required this.id,
      required this.allowNegativeStock,
      required this.allowOrderBelowCost,
      required this.brandCode,
      required this.catalogueUrl1,
      required this.catalogueUrl2,
      required this.clasification,
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
      required this.veryFast,
      required this.verySlow,
      required this.whseCode,
      required this.color,
      required this.validTill,
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

  String? itemcode;
  String? itemName;
  String? Favorite;
  String? Category;
  String? Brand;
  String? Segment;
  String? Division;
  double? MgrPrice;
  double? SlpPrice;
  double? StoreStock;
  double? WhsStock;
  int? id;
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




  factory ItemMasterNewData.fromJson(Map<String, dynamic> json) {
    // print("!-----------------------------2--------");
    return ItemMasterNewData(
        MgrPrice: json['mrp'] ?? 0,
        itemcode: json['itemCode'] ?? '',
        itemName: json['itemName'] ?? '',
        Segment: json['subCategory'] ?? '',
        Favorite: json['favourite'] ?? '', //
        SlpPrice: json['cost'] ?? 00,
        Category: json['category'] ?? '',
        Brand: json['brand'] ?? '',
        Division: json['division'] ?? '', //
        StoreStock: json['storeStock'] ?? 00,
        WhsStock: json['whseStock'] ?? 00,
        id: json['id']??0,
        color: json['color']??'',
        allowNegativeStock: json['allowNegativeStock']??false,
        allowOrderBelowCost: json['allowOrderBelowCost']??false,
        brandCode: json['brandCode']??'',
        catalogueUrl1: json['catalogueUrl1']??'',
        catalogueUrl2: json['catalogueUrl2']??'',
        clasification: json['clasification']??'',
        eol: json['eol']??false,
        fast: json['fast']??false,
        imageUrl1: json['imageUrl1']??'',
        imageUrl2: json['imageUrl2']??'',
        isFixedPrice: json['isFixedPrice']??false,
        itemDescription: json['itemDescription']??'',
        itemGroup: json['itemGroup']??'',
        modelNo: json['modelNo']??'',
        movingType: json['movingType']??'',
        partCode: json['partCode']??'',
        priceStockId: json['priceStockId']??0,
        serialNumber: json['serialNumber']??false,
        sizeCapacity: json['sizeCapacity']??'',
        skucode: json['skucode']??'',
        slow: json['slow']??false,
        sp: json['sp']??0.0,
        specification: json['specification']??'',
        ssp1: json['ssp1']??0.0,
        ssp1Inc: json['ssp1Inc']??0.0,
        ssp2: json['ssp2']??0.0,
        ssp2Inc: json['ssp2Inc']??0.0,
        ssp3: json['ssp3']??0.0,
        ssp3Inc: json['ssp3Inc']??0.0,
        ssp4: json['ssp4']??0.0,
        ssp4Inc: json['ssp4Inc']??0.0,
        ssp5: json['ssp5']??0.0,
        ssp5Inc: json['ssp5Inc']??0.0,
        status: json['status']??'',
        storeCode: json['storeCode']??'',
        taxRate: json['taxRate']??0,
        textNote: json['textNote']??'',
        uoM: json['uoM']??'',
        validTill: json['validTill']??'',
        veryFast: json['veryFast']??false,
        verySlow: json['verySlow']??false,
        whseCode: json['whseCode']??'',
        calcType: json['calcType']??'',
   payOn: json['payOn']??'',
     storeAgeSlab1: json['store_Age_Slab_1']??0.0,
   storeAgeSlab2: json['store_Age_Slab_2']??0.0,
   storeAgeSlab3: json['store_Age_Slab_3']??0.0,
   storeAgeSlab4: json['store_Age_Slab_4']??0.0,
   storeAgeSlab5: json['store_Age_Slab_5']??0.0,
   whsAgeSlab1: json['whs_Age_Slab_1']??0.0,
   whsAgeSlab2: json['whs_Age_Slab_2']??0.0,
   whsAgeSlab3: json['whs_Age_Slab_3']??0.0,
   whsAgeSlab4: json['whs_Age_Slab_4']??0.0,
   whsAgeSlab5: json['whs_Age_Slab_4']??0.0,
        );
  }
 
}


// itemMasterold
// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:convert';
// import 'dart:math';

// class ItemMasterNewModal {
// List<ItemMasterNewData>? itemdata;
// // List<ItemMasterNewData>? itempriceStock;
//   String message;
//   bool? status;
//   String? exception;
//   int?stcode;
//   ItemMasterNewModal(
//       {required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode
//       });
//   factory ItemMasterNewModal.fromJson(List<dynamic> jsons,int stcode) {
//     if (jsons != null && jsons.isNotEmpty) {
//       print("object::"+jsons.toString());
//       var list = jsons as List;
//       List<ItemMasterNewData> dataList =
//           list.map((data) => ItemMasterNewData.fromJson(data)).toList();
//       return ItemMasterNewModal(
//         itemdata:dataList,
//         message: "sucess",
//         status: true,
//         stcode: stcode,
//         exception:null
//       );
//     } else {
//       return ItemMasterNewModal(
//         itemdata: null,
//         message: "failed",
//         status: false,
//         stcode: stcode,
//         exception:null
//       );
//     }
//   }
//    factory ItemMasterNewModal.issues(Map<String,dynamic> jsons,int stcode) {
//     return ItemMasterNewModal(
//         itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
//         exception:jsons['respDesc']);
//   }

//   factory ItemMasterNewModal.error(String jsons,int stcode) {
//     return ItemMasterNewModal(
//         itemdata: null, message: 'Exception', status: null,   stcode: stcode,
//         exception:jsons);
//   }
// }

// // class ItemMasterNewHeader {
// //   ItemMasterNewHeader({
    
// //     required this.itemdata
// //   });
// // ItemMasterNewData? itemdata;
// // ItemMasterPriceStock? itemdataprice;
  


// //   factory ItemMasterNewHeader.fromJson(Map<String, dynamic> jsons) {
// //    if(jsons['itemmaster'] !=null && jsons['itemPriceStock'] !=null){
// // return ItemMasterNewHeader(
// //     itemdata:ItemMasterNewData.fromJson(jsons['itemmaster']),
// //      );
// //    }else{
// //    return ItemMasterNewHeader(
// //     itemdata:null,
// //      ); 
// //    }
  
// //      }
// // }


// class ItemMasterNewData {
//   ItemMasterNewData({
//     required this.MgrPrice,
//     required this.itemcode,
//     required this.itemName,
//     required this.Segment,
//     required this.Favorite,
//     required this.SlpPrice,
//     required this.Category,
//     required this.Brand,
//     required this.Division,
//     required this.StoreStock,
//     required this.WhsStock,
//     required this.id
//   });

//   String? itemcode;
//   String? itemName;
//   String? Favorite;
//   String? Category;
//   String? Brand;
//   String? Segment;
//   String? Division;
//   double? MgrPrice;
//   double? SlpPrice;
//   int? StoreStock;
//   int? WhsStock;
//   int? id;


//   factory ItemMasterNewData.fromJson(Map<String, dynamic> json) {
//     // print("!-----------------------------2--------");
//   return ItemMasterNewData(
//     id: json['id'],
//      itemcode: json['itemCode'] ?? '',
//      itemName: json['itemName'] ?? '',
//      Segment: json['subCategory'] ?? '', 
//      Favorite: json['favourite'] ?? '', //
//      Category: json['category'] ?? '',
//      Brand: json['brand'] ?? '', 
//      Division: json['division'] ?? '', 
//      StoreStock: json['storeStock']?? 00,
//      MgrPrice: json['mrgPrice'] ?? 0, 
//      SlpPrice: json['slpPrice'] ?? 00,
//      WhsStock:json['whsStock']?? 00 );
//      }
// }

// // class ItemMasterPriceStock{
// //   int id;
// // }
