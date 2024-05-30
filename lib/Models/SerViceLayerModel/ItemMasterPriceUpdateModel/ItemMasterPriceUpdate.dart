
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class ItemMasterPriceUpdateModal{
  String ?odatametadata;
  int? stcode;
  Error? error ;
  String?exception;
  String? itemCode;
String ?itemName;
String ?brand;
String? category;
String? division;
String? segement;
String? properties1;
List<ItemPrices>? itemPrices;

  ItemMasterPriceUpdateModal({
   required this.odatametadata,
   this.stcode,
   this.error,
   this.exception,
   required  this.itemCode,
required  this.itemName,
required this.brand,
required  this.category,
required this.division,
required this.segement,
 required this.itemPrices,
 required this.properties1
  });
   factory ItemMasterPriceUpdateModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    // if (jsons['value'] != null) {
      var list =  jsons['ItemPrices'] as List; 
      List<ItemPrices> dataList = list
          .map((dynamic enquiries) => ItemPrices.fromJson(enquiries))
          .toList();
      return ItemMasterPriceUpdateModal(
        odatametadata: jsons['odata.metadata'].toString(),
        stcode: stcode,
        error:null,
        exception: null,   
        itemCode: jsons['ItemCode'].toString(), 
      itemName: jsons['ItemName'].toString(), 
      brand:jsons['U_Brand'].toString(), 
      segement: jsons['U_Segment'].toString(),
      category:jsons['U_Category'].toString(), 
      division: jsons['U_Division'].toString(), 
      properties1:  jsons['Properties1'].toString(),
      itemPrices: dataList, 
      );
    // } else {
    //   return ItemModal(
    //     odatametadata: null,
    //     itemValueValue:null,
    //     nextLink: null,
    //     error: null
    //       );
    // }
  }

   factory ItemMasterPriceUpdateModal.issue(Map<String, dynamic>? json,int? stcode) {
      return ItemMasterPriceUpdateModal(
       odatametadata: null,
       stcode:stcode,
       error:json==null?null: Error.fromJson(json['error']),
       exception: null,
        itemCode: null,
      itemName: null,
      brand:null,
      segement:null,
      category:null,
      division: null,
      properties1: null,
      itemPrices: null, 
          );
  }

     factory ItemMasterPriceUpdateModal.exception(String exp,int? stcode) {
      return ItemMasterPriceUpdateModal(
       odatametadata: null,
       stcode:stcode,
       error:null,
       exception: exp,
  itemCode: null,
      itemName: null,
      brand:null,
      segement:null,
      category:null,
      division: null,
      properties1: null,
      itemPrices: null, 
          );
  }
}


// class ItemValue{
// String? itemCode;
// String ?itemName;
// String ?brand;
// String? category;
// String? division;
// String? segement;
// String? properties1;
// List<ItemPrices>? itemPrices;
// ItemValue({
// required  this.itemCode,
// required  this.itemName,
// required this.brand,
// required  this.category,
// required this.division,
// required this.segement,
//  required this.itemPrices,
//  required this.properties1
// });

//  factory ItemValue.fromJson(dynamic jsons) {      
//     var list =  jsons['ItemPrices'] as List; 
//       List<ItemPrices> dataList = list
//           .map((dynamic enquiries) => ItemPrices.fromJson(enquiries))
//           .toList();
//     return ItemValue(
//       itemCode: jsons['ItemCode'].toString(), 
//       itemName: jsons['ItemName'].toString(), 
//       brand:jsons['U_Brand'].toString(), 
//       segement: jsons['U_Segment'].toString(),
//       category:jsons['U_Category'].toString(), 
//       division: jsons['U_Division'].toString(), 
//       properties1:  jsons['Properties1'].toString(),
//       itemPrices: dataList, 
 
//        );
//  }
// }

class ItemPrices{
  int? PriceList;
  double ? price;
  ItemPrices({
    required this.PriceList,
    required this.price
  });
  factory ItemPrices.fromJson(dynamic jsons) {      
    return ItemPrices(
      PriceList: jsons['PriceList']==null?0: jsons['PriceList']as int, 
      price: jsons['Price']==null?0.00: jsons['Price']as double,  
       );
 }
}

class Error{
  int? code;
  Message?message;
 Error({
   this.code,
  this.message
 });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code']as int,
     message: Message.fromJson(jsons['message']),
       );
 }
}

 class Message{
  String ?lang;
  String ? value; 
 Message({
   this.lang,
   this.value,
 });

  factory Message.fromJson(dynamic jsons) {
    return Message(
    //  groupCode: jsons['GroupCode'] as int, 
      lang: jsons['lang']as String,
      value: jsons['value'] as String,
   
       );
 }
 }

