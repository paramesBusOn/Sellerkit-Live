import 'dart:convert';

class ItemMaster {
  String? message;
  bool? status;
  String? exception;
  List<DataItems>? Stockitem;
  int stcode;
  ItemMaster(
      {required this.message,
      required this.status,
      this.Stockitem,
      required this.exception,
      required this.stcode});
  factory ItemMaster.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons["data"] != "No Data Found ") {
      var list =jsonDecode(jsons["data"])as List; ;

      List<DataItems> lst_stocks =
          list.map((Stockitem) => DataItems.fromJson(Stockitem)).toList();

      return ItemMaster(
          status: jsons["status"] as bool,
          message: jsons["message"],
          Stockitem: lst_stocks,
          exception: null,
          stcode: stcode);
    } else {
      return ItemMaster(
          message: jsons['message'] as String,
          status: jsons['status'] as bool,
          Stockitem: null,
          exception: null,
          stcode:stcode);
    }
  }
  factory ItemMaster.exception(String jsons,int stcode) {
    return ItemMaster(message: null, status: null, exception: jsons,stcode:stcode);
  }
}

class DataItems {
  String itemcode;
  String itemname;
  // String serialnumber;
  // String warehouse;
  double onhand;
  // String salesorder;
  // String purchaseorder;
  // String pricelist;
  // String listname;
  // String price;

  DataItems({
    required this.itemcode,
    required this.itemname,
    // required this.serialnumber,
    // required this.warehouse,
    required this.onhand,
    // required this.salesorder,
    // required this.purchaseorder,
    // required this.pricelist,
    // required this.listname,
    // required this.price,
  });

  factory DataItems.fromJson(Map<String, dynamic> jsons) {
    return DataItems(
      itemcode: jsons["ItemCode"],
      itemname: jsons["ItemName"],
      // serialnumber: jsons["serialNumber"],
      // warehouse: jsons["warehouse"],
      onhand: jsons["OnHand"],
      // salesorder: jsons["salesOrder"],
      // purchaseorder: jsons["purchaseOrder"],
      // pricelist: jsons["priceList"],
      // listname: jsons["listName"],
      // price: jsons["price"].toString().isEmpty?0:jsons["price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ItemCode": itemcode,
        "ItemName": itemname,
        // "serialNumber": serialnumber,
        // "warehouse": warehouse,
        "OnHand": onhand,
        // "salesOrder": salesorder,
        // "purchaseOrder": purchaseorder,
        // "priceList": pricelist,
        // "listName": listname,
        // "price": price,
      };
}
