// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:math';

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';

class ItemviewNewModal {
  ItemMasterNewDataheader? itemdatahead;
// List<ItemMasterNewData>? itempriceStock;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  ItemviewNewModal(
      {required this.itemdatahead,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ItemviewNewModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
    // print("object::" + jsons.toString());
    // var list = json.decode (jsons['data']) as List;
    // List<ItemMasterNewData> dataList =
    //     list.map((data) => ItemMasterNewData.fromJson(data)).toList();
    return ItemviewNewModal(
        itemdatahead: ItemMasterNewDataheader.fromJson(jsons),
        message: "sucess",
        status: true,
        stcode: stcode,
        exception: null);
    } else {
      return ItemviewNewModal(
          itemdatahead: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory ItemviewNewModal.issues(Map<String, dynamic> jsons, int stcode) {
    return ItemviewNewModal(
        itemdatahead: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory ItemviewNewModal.error(String jsons, int stcode) {
    return ItemviewNewModal(
        itemdatahead: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ItemMasterNewDataheader {
  List<ItemViewNewData>? itemdata;
  ItemMasterNewDataheader({required this.itemdata});
  factory ItemMasterNewDataheader.fromJson(
    Map<String, dynamic> jsons,
  ) {
    if (jsons['data'] != null) {
      var list = json.decode(jsons['data']) as List;
      List<ItemViewNewData> dataList =
          list.map((data) => ItemViewNewData.fromJson(data)).toList();
      return ItemMasterNewDataheader(itemdata: dataList);
    } else {
      return ItemMasterNewDataheader(itemdata: null);
    }
  }
}

class ItemViewNewData {
  ItemViewNewData(
      {required this.itemcode,
      required this.StoreStock,
      required this.WhsStock,
      required this.id,
      required this.allowNegativeStock,
      required this.allowOrderBelowCost,
      required this.isFixedPrice,
      required this.sp,
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
      required this.MgrPrice,
      required this.Cost,
      required this.storeCode,
      required this.CreatedBy,
      required this.IncEligibleBelowCost,
      required this.whseCode,
      required this.color,
       required this.spinc,
      required this.validTill,
      required this.calcType,
      required this.payOn});
  int? id;
  String? itemcode;
  String? storeCode;
  String? whseCode;
  double? StoreStock;
  double? WhsStock;
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
  bool? IncEligibleBelowCost;
  bool? isFixedPrice;
  String? validTill;
  String? color;
  String? calcType;
  String? payOn;
  int? CreatedBy;
  double? MgrPrice;
  double? Cost;
  double? spinc;

  factory ItemViewNewData.fromJson(Map<String, dynamic> json) {
    // print("!-----------------------------2--------");
    return ItemViewNewData(
        MgrPrice: json['MRP'] ?? 0,
        itemcode: json['ItemCode'] ?? '',
        StoreStock: json['StoreStock'] ?? 00,
        WhsStock: json['WhseStock'] ?? 00,
        id: json['Id'] ?? 0,
        color: json['color'] ?? '',
        allowNegativeStock: json['AllowNegativeStock'] ?? false,
        allowOrderBelowCost: json['AllowOrderBelowCost'] ?? false,
        isFixedPrice: json['isFixedPrice'] ?? false,
        IncEligibleBelowCost: json['IncEligibleBelowCost'] ?? false,
        sp: json['SP'] ?? 0.0,
        spinc: json['SP_Inc'] ?? 0.0,
        ssp1: json['SSP1'] ?? 0.0,
        ssp1Inc: json['SSP1_Inc'] ?? 0.0,
        ssp2: json['SSP2'] ?? 0.0,
        ssp2Inc: json['SSP2_Inc'] ?? 0.0,
        ssp3: json['SSP3'] ?? 0.0,
        ssp3Inc: json['SSP3_Inc'] ?? 0.0,
        ssp4: json['SSP4'] ?? 0.0,
        ssp4Inc: json['SSP4_Inc'] ?? 0.0,
        ssp5: json['SSP5'] ?? 0.0,
        ssp5Inc: json['SSP5_Inc'] ?? 0.0,
        storeCode: json['StoreCode'] ?? '',
        validTill: json['ValidTill'] ?? '',
        whseCode: json['WhseCode'] ?? '',
        calcType: json['CalcType'] ?? '',
        Cost: json['Cost'] ?? 0.0,
        CreatedBy:json['CreatedBy'] ?? 0, 
        payOn: json['PayOn'] ?? '');
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
