// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

class GetOrderDetailsQTH {
  GetOrderDeatilsheaderData? OrderDeatilsheaderData;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetOrderDetailsQTH(
      {required this.OrderDeatilsheaderData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetOrderDetailsQTH.fromJson(Map<String,dynamic> jsons, int stcode) {
    if (jsons != null||jsons.isNotEmpty) {
   
    var list = json.decode(jsons["data"]) as Map<String,dynamic>;
    // List<GetOrderDeatilsQTHData> dataList =
    //     list.map((data) => GetOrderDeatilsQTHData.fromJson(data)).toList();
    return GetOrderDetailsQTH(
        OrderDeatilsheaderData: GetOrderDeatilsheaderData.fromJson(list),
        message: "Success",
        status: true,
        stcode: stcode,
        exception: null);
    } else {
      return GetOrderDetailsQTH(
          OrderDeatilsheaderData: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetOrderDetailsQTH.error(String jsons, int stcode) {
    return GetOrderDetailsQTH(
        OrderDeatilsheaderData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
   factory GetOrderDetailsQTH.issues(Map<String,dynamic> jsons, int stcode) {
    return GetOrderDetailsQTH(
        OrderDeatilsheaderData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons["respDesc"]);
  }
}

class GetOrderDeatilsheaderData{
 List<GetOrderDeatilsQTHData>? OrderDeatilsQTHData;
  List<GetOrderQTLData>? OrderDeatilsQTLData;
  GetOrderDeatilsheaderData({
    required this.OrderDeatilsQTHData,
    required this.OrderDeatilsQTLData
  });
 factory GetOrderDeatilsheaderData.fromJson(Map<String,dynamic> jsons) {
    if (jsons["Ordermaster"] != null && jsons["orederLine"] !=null) {
    log("INININ:" + jsons.toString());
    var list1 = jsons["Ordermaster"] as List;
    List<GetOrderDeatilsQTHData> dataList1 =
        list1.map((data) => GetOrderDeatilsQTHData.fromJson(data)).toList();
          var list2 = jsons["orederLine"] as List;
      
      List<GetOrderQTLData> dataList2 =
          list2.map((data) => GetOrderQTLData.fromJson(data)).toList();
    return GetOrderDeatilsheaderData(
      OrderDeatilsQTHData:dataList1,
      OrderDeatilsQTLData:dataList2,
        );
    } else {
      return GetOrderDeatilsheaderData(
        OrderDeatilsQTHData:null,
         OrderDeatilsQTLData:null,

         );
    }
  }

}

class GetOrderDeatilsQTHData {
  int? OrderDocEntry; //
  String? reasonType;
  String? ordersalesperson;
  // int? FollowupEntry;
  int? OrderNum; //
  String? OrderCreatedDate; //
  // String? LastFUPUpdate;
  String? CardCode; //
  String? CardName; //
  String? Address1; //
  String? Address2; //
  String? City; //
  String? Pincode; //
  double? DocTotal; //

  String? del_Address1;
  String? del_Address2;
  String? del_Area;
  String? del_City;
  String? del_State;
  String? del_Pincode;
  double? basetotal;
  double? subtotal;
  double? taxAmount;
  double? RoundOff;
  String? DeliveryDate;
  String? DeliveryNo;
    String? DeliveryURL1;
    String? DeliveryURL2;
     String? InvoiceDate;
  String? InvoiceNo;
    String? InvoiceURL1;
    String? InvoiceURL2;
    int? isDelivered;
    int? isInvoiced;
    String? area;
    String? state;
    String? gst;
    String? StoreCode;
    String? deliveryduedate;
    String? PaymentDueDate;
    double? GrossTotal;
    double? SubTotal;
    String? PaymentTerms;

    // double? RoundOff;
    // double? DocTotal;

  // double? DocTotal;
 
  // String? LastUpdateMessage;
  // String? LastUpdateTime;

  GetOrderDeatilsQTHData(

      {required this.PaymentTerms,
        required this. GrossTotal,
        required this. SubTotal,
        required this. deliveryduedate,
        // required this. deliveryduedate,
        // required this. deliveryduedate,
        required this. PaymentDueDate,
       required this. StoreCode,
      required this.  gst,
        required this.state,
        required this.area,
        required this.OrderDocEntry,
      required this.OrderNum,
      required this.OrderCreatedDate,
      // required this.LastFUPUpdate,

      required this.reasonType,
      required this.ordersalesperson,
      required this.CardCode,
      required this.CardName,
      required this.Address1,
      required this.Address2,
      required this.City,
      required this.Pincode,
      required this.DocTotal,
      required this.del_Address1,
      required this.del_Address2,
      required this.del_Area,
      required this.del_City,
      required this.del_Pincode,
      required this.del_State,
      required this.subtotal,
      required this.RoundOff,
      required this.basetotal,
      required this.taxAmount,
      required this.DeliveryDate,
      required this.DeliveryNo,
      required this.DeliveryURL1,
      required this.DeliveryURL2,
      required this.InvoiceDate,
      required this.InvoiceNo,
      required this.InvoiceURL1,
      required this.InvoiceURL2,
      required this.isDelivered,
      required this.isInvoiced
      
     
      });

  factory GetOrderDeatilsQTHData.fromJson(Map<String, dynamic> jsons) {
    
    
     

      return GetOrderDeatilsQTHData(
        PaymentTerms:jsons['PaymentTerms']??'',
        GrossTotal:jsons['GrossTotal'] ?? '',
        SubTotal:jsons['SubTotal'] ?? '',
        PaymentDueDate:jsons['PaymentDueDate'] ?? '',
        deliveryduedate:jsons['DeliveryDueDate'] ?? '',
        StoreCode:jsons['StoreCode'] ?? '',
        gst:jsons['GSTNo'] ?? '',
        state: jsons['Bil_State'] ?? '',
        area:jsons['Bil_Area'] ?? '',
        isDelivered:jsons['isDelivered'] ?? '',
         isInvoiced:jsons['isInvoiced'] ?? '',
        DeliveryDate:jsons['DeliveryDate'] ?? '',
        
        DeliveryNo:jsons['DeliveryNo'] ?? '',
        
        DeliveryURL1:jsons['DeliveryURL1'],
        
        DeliveryURL2:jsons['DeliveryURL2'] ,
        
        InvoiceDate:jsons['InvoiceDate'] ?? '',
        
        InvoiceNo:jsons['InvoiceNo'] ?? '',
        
        InvoiceURL1:jsons['InvoiceURL1'] ,
        
        InvoiceURL2:jsons['InvoiceURL2'] ,
       del_Address1:jsons['Del_Address1'] ?? '',
       del_Address2:jsons['Del_Address2'] ?? '',
       del_Area:jsons['Del_Area'] ?? '',
       del_City:jsons['Del_City'] ?? '',
       del_Pincode:jsons['Del_State'] ?? '',
       del_State:jsons['Del_Pincode'] ?? '',
subtotal:jsons['SubTotal'] ,
RoundOff:jsons['RoundOff'] ,
basetotal:jsons['GrossTotal'] ,
taxAmount:jsons['TaxAmount'] ,
        OrderDocEntry: jsons['DocEntry'] ?? -1,
        OrderNum: jsons['OrderNumber'] ?? -1,
        OrderCreatedDate: jsons['DocDate'] ?? '',
        // LastFUPUpdate: jsons['lastFUPUpdate'] ?? '',
        CardCode: jsons['CustomerCode'] ?? '',
        CardName: jsons['CustomerName'] ?? '',
        Address1: jsons['Bil_Address1'] ?? '',
        Address2: jsons['Bil_Address2'] ?? '',
        City: jsons['Bil_City'] ?? '',
        Pincode: jsons['Bil_Pincode'] ?? '',
        DocTotal: jsons['DocTotal'] ?? 0.00,
        reasonType: jsons['OrderStatus'] ?? '',
        ordersalesperson: jsons['AssignedTo'] ?? '',
        // LastUpdateMessage: json['LastUpdateMessage'] ?? '',
        // LastUpdateTime: json['LastUpdateTime'] ?? '',
        //FollowupEntry: json['FollowupEntry']
      );
    
   
  }
  
}

class GetOrderQTLData {
  String? ItemCode;
  String? ItemName;
  double? Quantity;
  double? Price;
  String? deliveryFrom;
  String? LocCode;
  int? LineNum;
  double? MRP;
  double? BasePrice;
  double? GrossLineTotal;
  double? TaxCode;
  double? Info_SP;
  double? Cost;
  double? StoreStock;
  double? WhseStock;
  bool? isFixedPrice;
  bool? AllowOrderBelowCost;
  bool? AllowNegativestock;
  
  GetOrderQTLData({
    required this.MRP,
     required this.Info_SP,
      required this.Cost,
       required this.StoreStock,
        required this.WhseStock,
         required this.isFixedPrice,
          required this.AllowOrderBelowCost,
          required this.AllowNegativestock,
            required this.TaxCode,
   
    required this.GrossLineTotal,
    required this.BasePrice,
    required this.LineNum,
    required this.deliveryFrom,
    required this.LocCode,
    required this.ItemCode,
    required this.ItemName,
    required this.Quantity,
    required this.Price,
  });
  factory GetOrderQTLData.fromJson(Map<String, dynamic> json) =>
      GetOrderQTLData(
        MRP:json['MRP']??0.00,
        Info_SP:json['Info_SP']??0.00,
        Cost:json['Cost']??0.00,
        StoreStock:json['StoreStock']??0.00,
        WhseStock:json['WhseStock']??0.00,
        isFixedPrice:json['isFixedPrice']??false,
        AllowNegativestock:json['AllowNegativeStock']==1?true:false,
        AllowOrderBelowCost:json['AllowOrderBelowCost']??false,
        TaxCode:json['TaxRate'] ?? 0.0,
        GrossLineTotal:json['GrossLineTotal'] ?? 0.0,
        BasePrice: json['BasePrice'] ?? 0.0,
        LineNum:json['LineNum'] ?? 0,
        deliveryFrom:json['DeliveryFrom'] ?? '',
        LocCode:json['LocCode'] ?? '',
        ItemCode: json['ItemCode'] ?? '',
        ItemName: json['ItemName'] ?? '',
        Quantity: json['Quantity'] ?? 0,
        Price: json['Price'] ?? 0.00,
      );
}
