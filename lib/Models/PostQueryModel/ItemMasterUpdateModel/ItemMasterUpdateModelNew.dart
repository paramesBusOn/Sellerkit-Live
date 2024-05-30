import 'dart:convert';

class ItemMasterNewUpdateModal {
List<ItemMasterNewUpdateData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ItemMasterNewUpdateModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ItemMasterNewUpdateModal.fromJson(List< dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty ) {
      var list = jsons as List;
      List<ItemMasterNewUpdateData> dataList =
          list.map((data) => ItemMasterNewUpdateData.fromJson(data)).toList();
      return ItemMasterNewUpdateModal(
        itemdata: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ItemMasterNewUpdateModal(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ItemMasterNewUpdateModal.error(String jsons,int stcode) {
    return ItemMasterNewUpdateModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class ItemMasterNewUpdateData {
  ItemMasterNewUpdateData({
    required this.MgrPrice,
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
    this.mrp,
    this.olp
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
  double? mrp;
  double? olp;


  factory ItemMasterNewUpdateData.fromJson(Map<String, dynamic> json) =>
   ItemMasterNewUpdateData(
     itemcode: json['itemCode'] ?? '',
     itemName: json['itemName'] ?? '',
     Segment: json['segment'] ?? '', 
     Favorite: json['Favorite'] ?? '', 
     Category: json['category'] ?? '',
     Brand: json['brand'] ?? '', 
     Division: json['division'] ?? '', 
     StoreStock: json['storeStock']?? 0.00,
     MgrPrice: json['mgrPrice'] ?? 0.00, 
     SlpPrice: json['slpPrice'] ?? 0.00,
     WhsStock:json['whsStock']?? 0.00,
     mrp: json['mrp']??0.00,
     olp: json['olp']??0.00
     );
}
