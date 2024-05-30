
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class ItemModal{
  String ?odatametadata;
  List<ItemValue>? itemValueValue;
  int? stcode;
  String? nextLink;
  Error? error ;
  String?exception;
  ItemModal({
   required this.odatametadata,
   this.itemValueValue,
   this.stcode,
   this.nextLink,
   this.error,
   this.exception
  });
   factory ItemModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    // if (jsons['value'] != null) {
      var list =  jsons['value'] as List; 
      List<ItemValue> dataList = list
          .map((dynamic enquiries) => ItemValue.fromJson(enquiries))
          .toList();
      return ItemModal(
        itemValueValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        stcode: stcode,
        nextLink:  jsons['odata.nextLink'].toString(),
        error:null,
        exception: null
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

   factory ItemModal.issue(Map<String, dynamic>? json,int? stcode) {
      return ItemModal(
       odatametadata: null,
       itemValueValue:null,
       nextLink:null,
       stcode:stcode,
       error:json==null?null: Error.fromJson(json['error']),
       exception: null
          );
  }

     factory ItemModal.exception(String exp,int? stcode) {
      return ItemModal(
       odatametadata: null,
       itemValueValue:null,
       nextLink:null,
       stcode:stcode,
       error:null,
       exception: exp
          );
  }
}


class ItemValue{
String? itemCode;
String ?itemName;
String ?brand;
String? category;
String? division;
String? segement;
String? properties1;
List<ItemPrices>? itemPrices;
ItemValue({
required  this.itemCode,
required  this.itemName,
required this.brand,
required  this.category,
required this.division,
required this.segement,
 required this.itemPrices,
 required this.properties1
});

 factory ItemValue.fromJson(dynamic jsons) {      
    var list =  jsons['ItemPrices'] as List; 
      List<ItemPrices> dataList = list
          .map((dynamic enquiries) => ItemPrices.fromJson(enquiries))
          .toList();
    return ItemValue(
      itemCode: jsons['ItemCode'].toString(), 
      itemName: jsons['ItemName'].toString(), 
      brand:jsons['U_Brand'].toString(), 
      segement: jsons['U_Segment'].toString(),
      category:jsons['U_Category'].toString(), 
      division: jsons['U_Division'].toString(), 
      properties1:  jsons['Properties1'].toString(),
      itemPrices: dataList, 
 
       );
 }
}

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

