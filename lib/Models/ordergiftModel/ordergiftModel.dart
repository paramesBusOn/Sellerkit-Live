
import 'dart:convert';
import 'dart:developer';

class OrdergiftDetails{
 Ordergiftheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  OrdergiftDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory OrdergiftDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return OrdergiftDetails(
        itemdata: Ordergiftheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return OrdergiftDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory OrdergiftDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return OrdergiftDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory OrdergiftDetails.error(String jsons,int stcode) {
    return OrdergiftDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class Ordergiftheader{
  
  List<OrdergiftData>? childdata;
  Ordergiftheader({
    required this.childdata

  });
  factory Ordergiftheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return Ordergiftheader(
       childdata: null, 
        );

      }
       else {
      List<OrdergiftData> dataList =
          list.map((data) => OrdergiftData.fromJson(data)).toList();
      return Ordergiftheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class OrdergiftData {
  OrdergiftData({
   required this.OfferSetup_Id,
    required this.ItemCode,
    required this.Attach_Qty,
    required this.BasicPrice,
    required this.ItemName,
    required this.MRP,
    required this.Price,
    required this.SP,
    required this.TaxAmt_PerUnit,
    required this.TaxRate,
   required this. quantity,
   required this. GiftQty,
   required this. MinQty,
   required this. UptoPriceSlab,
   required this. MinimumPrice,
  required this. allowpartialgift
    
  });
int? OfferSetup_Id;
String? ItemCode;
String? ItemName;
int? Attach_Qty;
String? UptoPriceSlab;
int? MinQty;
double? Price;
double? SP;
double? MRP;
double? TaxRate;
double? BasicPrice;
double? TaxAmt_PerUnit;
int? quantity;
double? GiftQty;
int? allowpartialgift;
double? MinimumPrice;

  factory OrdergiftData.fromJson(Map<String, dynamic> json) =>
   OrdergiftData(
    allowpartialgift:json['allowpartialgift']??0, 
    MinimumPrice:json['MinimumPrice']??0.0, 
    UptoPriceSlab:json['UptoPriceSlab']??'',
    MinQty:json['MinQty']??0,
    GiftQty:json['GiftQty']??0.0, 
    OfferSetup_Id: json['OfferSetup_Id']??0, 
    ItemCode: json['ItemCode']??'', 
    Attach_Qty: json['Attach_Qty']??0, 
    BasicPrice: json['BasicPrice']??0.0, 
    ItemName: json['ItemName']??'', 
    MRP: json['MRP']??0.0, 
    Price: json['Price']??0.0, 
    SP: json['SP']??0.0, 
    TaxAmt_PerUnit: json['TaxAmt_PerUnit']??0.0, 
    TaxRate: json['TaxRate']??0.0,
    quantity:json['MinQty']??0
    );
    
}
