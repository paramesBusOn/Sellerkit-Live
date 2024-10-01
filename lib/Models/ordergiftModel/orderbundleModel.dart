import 'dart:convert';
import 'dart:developer';

class OrderbundleHeader {
  OrderbundleHeader(
      {required this.respCode,
      required this.itemdata,
      required this.respDesc,
      required this.respType,
      this.stcode,
      this.exception,
      this.message,
      this.status

      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  OrderbundleHeadertwo? itemdata;
  int? stcode;
  String? message;
  bool? status;
  String? exception;
//   int? stcode;

  factory OrderbundleHeader.fromJson(Map<String, dynamic> jsons,int stcode) {
   
    if (jsons['data'] != null) {
      var list = json.decode(jsons['data'] as String ) as Map<String,dynamic>;
    //   if(list.isNotEmpty ||list != null){
      //  List<GetCustomerData> dataList =
      //   list.map((data) => GetCustomerData.fromJson(data)).toList();
      return OrderbundleHeader(
          respCode: jsons['respCode']??'',
          itemdata: OrderbundleHeadertwo.fromJson(list),
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
           message: "Success",
          status: true,
          stcode: stcode,
          exception: null
          
          );

      // }else{
      //    return GetCustomerDataHeader(
      // respCode: jsons['respCode'],
      //   datadetail: null,
      //   respDesc: jsons['respDesc'],
      //   respType: jsons['respType']
      //   );
      // }
    } else {
      return OrderbundleHeader(
          respCode: jsons['respCode'],
          itemdata: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
           message: "Failure",
          status: false,
          stcode: stcode,
          exception: null
          
          );
    }
  }
    factory OrderbundleHeader.error(String jsons, int stcode) {
    return OrderbundleHeader(
      respCode: null,
          
          respDesc: null,
          respType: null,
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
   factory OrderbundleHeader.issues(
      Map<String, dynamic> jsons, int stcode) {
    return OrderbundleHeader(
      respCode: null,
          
          respDesc: null,
          respType: null,
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
}

class OrderbundleHeadertwo {
  OrderbundleHeadertwo(
      {required this.Bundleheaddetails,
      required this.BundleItemdetails,
      required this.Bundlestoredetails,
      // required this.quotationdetails,
      // required this.orderdetails
      });

  List<Bundleheadlist>? Bundleheaddetails;
  List<BundleItemlist>? BundleItemdetails;
  List<Bundlestorelist>? Bundlestoredetails;
  
  // List<GetleadData>? leaddetails;
  // List<GetQuotationData>? quotationdetails;
  // List<GetorderData>? orderdetails;

  factory OrderbundleHeadertwo.fromJson(Map<String, dynamic> jsons) {
    // var list6=jsons[""];\
   
    if (jsons["BundleHead"] != null || jsons["BundleItem"] != null ||jsons["BundleStore"] != null) {
      var list1 = jsons["BundleHead"] as List;
     var list2 = jsons["BundleItem"] as List;
      var list3 = jsons["BundleStore"] as List;
     List<Bundleheadlist> dataList =
        list1.map((data) => Bundleheadlist.fromJson(data)).toList();
      log("list1::"+list1.toString());
      
      if(list2.isNotEmpty){
 List<BundleItemlist> dataList2 =
        list2.map((data) => BundleItemlist.fromJson(data)).toList();
        if(list3.isNotEmpty){
        
 List<Bundlestorelist> dataList3 =
        list3.map((data) => Bundlestorelist.fromJson(data)).toList();
        return OrderbundleHeadertwo(
          Bundleheaddetails: dataList, 
          BundleItemdetails: dataList2,
          Bundlestoredetails: dataList3
          );
      }else{
return OrderbundleHeadertwo(
          Bundleheaddetails: dataList, 
          BundleItemdetails: dataList2,
          Bundlestoredetails: null
          );
      }
        

      }else{
         return OrderbundleHeadertwo(
          Bundleheaddetails: dataList, 
          BundleItemdetails: null,
           Bundlestoredetails: null
          );
      }
     
    } else {
      return OrderbundleHeadertwo(
          Bundleheaddetails: null,
          BundleItemdetails: null,
           Bundlestoredetails: null
          );
    }
  }
}

class Bundleheadlist {
  int? ID; //
  String? BundleCode;
  String? BundleName;
  String? EffectFrom;
  String? EffectTo;
  int? Status;
  String? AttachURL1;
  String? AttachURL2;
  String? AttachURL3;
  int? OtherOffer;
  double? TotalAmount;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? traceid;



  Bundleheadlist({
    required this.AttachURL1,
    required this.AttachURL2,
    required this.AttachURL3,
    required this.BundleCode,
    required this.BundleName,
    required this.CreatedBy,
    required this.CreatedDateTime,
    required this.EffectFrom,
    required this.EffectTo,
    required this.ID,
    required this.OtherOffer,
    required this.Status,
    required this.TotalAmount,
    required this.UpdatedBy,
    required this.UpdatedDateTime,
    required this.traceid
  });
  factory Bundleheadlist.fromJson(Map<String, dynamic> json) =>
      Bundleheadlist(
        AttachURL1: json['AttachURL1']??'', 
        AttachURL2: json['AttachURL2']??'', 
        AttachURL3: json['AttachURL3']??'', 
        BundleCode: json['BundleCode']??'', 
        BundleName: json['BundleName']??'', 
        CreatedBy: json['CreatedBy']??0, 
        CreatedDateTime: json['CreatedDateTime']??'', 
        EffectFrom: json['EffectFrom']??'', 
        EffectTo: json['EffectTo']??'', 
        ID: json['ID']??0, 
        OtherOffer: json['OtherOffer']??0, 
        Status: json['Status']??0, 
        TotalAmount: json['TotalAmount']??0.0, 
        UpdatedBy: json['UpdatedBy']??0, 
        UpdatedDateTime: json['UpdatedDateTime']??'', 
        traceid: json['traceid']??''
        );
}
class BundleItemlist{
  int? Id;
  int? BundleSetup_Id;
  int? LineNum;
  String? ItemCode;
  String? ItemName;
  double? Quantity;
  double? Price;
  double? LineTotal;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  String? UpdatedDateTime;
  String? TraceId;

  BundleItemlist({
required this.BundleSetup_Id,
required this.CreatedBy,
required this.CreatedDateTime,
required this.Id,
required this.ItemCode,
required this.ItemName,
required this.LineNum,
required this.LineTotal,
required this.Price,
required this.Quantity,
required this.TraceId,
required this.UpdatedBy,
required this.UpdatedDateTime
  });
   factory BundleItemlist.fromJson(Map<String, dynamic> json) =>
   BundleItemlist(
    BundleSetup_Id: json['BundleSetup_Id']??0, 
    CreatedBy: json['CreatedBy']??0, 
    CreatedDateTime: json['CreatedDateTime']??'', 
    Id: json['Id']??0, 
    ItemCode: json['ItemCode']??'', 
    ItemName: json['ItemName']??'', 
    LineNum: json['LineNum']??0, 
    LineTotal: json['LineTotal']??0.0, 
    Price: json['Price']??0.0, 
    Quantity: json['Quantity']??0.0, 
    TraceId: json['TraceId']??'', 
    UpdatedBy: json['UpdatedBy']??0, 
    UpdatedDateTime: json['UpdatedDateTime']??''
    );
}


class Bundlestorelist{
  int? Id;
  int? BundleSetup_Id;
  String? StoreCode;
  String? TraceID;
  

  Bundlestorelist({
required this.BundleSetup_Id,

required this.Id,
required this.StoreCode,
required this.TraceID,
  });
   factory Bundlestorelist.fromJson(Map<String, dynamic> json) =>
   Bundlestorelist(
    BundleSetup_Id: json['BundleSetup_Id']??0, 
    TraceID: json['TraceID']??'', 
    StoreCode: json['StoreCode']??'', 
    Id: json['Id']??0, 
    
    );
}