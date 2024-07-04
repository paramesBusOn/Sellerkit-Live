// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

class OrderSavePostModal {
  OrderSavePostModheader? orderSavePostheader;
  String? exception;
  int? stcode;
  String? message;

  OrderSavePostModal(
      {this.exception,
      this.message,
      required this.stcode,
      required this.orderSavePostheader});
  factory OrderSavePostModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    // print("jsons['body']"+jsons['body'].toString());
    // print("quT2s"+jsons['docEntry'].toString());

    if (jsons != null && jsons.isNotEmpty) {
      // print("jsons['quT2s']"+jsons['quT2s'].toString());
      var list = json.decode(jsons['data']) as Map<String, dynamic>;
      // List<DocumentLines> dataList =
      //     list.map((enquiries) => DocumentLines.fromJson(enquiries)).toList();
      return OrderSavePostModal(
        orderSavePostheader: OrderSavePostModheader.fromJson(list),
        stcode: stcode,
        exception: null,

        // error: null
      );
    } else {
      print("wrong site");
      return OrderSavePostModal(
        orderSavePostheader: null,
        stcode: stcode,
        exception: "Failure",

        // error: null
      );
    }
  }

  factory OrderSavePostModal.error(String jsons, int stcode) {
    return OrderSavePostModal(
      orderSavePostheader: null,
      stcode: stcode,
      exception: jsons,

      // error: null
    );
  }

  factory OrderSavePostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return OrderSavePostModal(
        orderSavePostheader: null,
        stcode: stcode,
        exception: jsons["respDesc"],
        message: jsons['respCode']

        // error: jsons==null?null: Error.fromJson(jsons['error']),
        );
  }

  //json==null?null: Error.fromJson(json['error']),
}

class OrderSavePostModheader {
  // Error? error ;
  List<DocumentLines>? documentdata;
  List<ordermaster>? orderMasterdata;
  List<paymentorders>? orderpaydata;
  OrderSavePostModheader({this.documentdata, this.orderMasterdata,
  this.orderpaydata
      // this.U_sk_email,

      });

  factory OrderSavePostModheader.fromJson(Map<String, dynamic> jsons) {
    if (jsons['Ordermaster'] != null && jsons["orederLine"] != null && jsons["OrderPays"] != null) {
      var list = jsons['Ordermaster'] as List;
      var list2 = jsons['orederLine'] as List;
      var list3 = jsons['OrderPays'] as List;

      List<ordermaster> dataList =
          list.map((enquiries) => ordermaster.fromJson(enquiries)).toList();
      List<DocumentLines> dataList2 =
          list2.map((enquiries) => DocumentLines.fromJson(enquiries)).toList();
           List<paymentorders> dataList3 =
          list3.map((enquiries) => paymentorders.fromJson(enquiries)).toList();
      return OrderSavePostModheader(
        documentdata: dataList2,
        orderMasterdata: dataList,
        orderpaydata:dataList3
      );
    } else {
      return OrderSavePostModheader(
        documentdata: null,
        orderMasterdata: null,
        orderpaydata:null
      );
    }
  }
}
class paymentorders{
  int? DocEntry;
  String? Code;
  String? ModeName;
  double? Amount;
  paymentorders({
 required this.DocEntry,
 required this.Code,
 required this.ModeName,
 required this.Amount
  });
factory paymentorders.fromJson(Map<String, dynamic> jsons){
  
 return paymentorders(
  DocEntry: jsons['DocEntry']??0, 
  Code: jsons['Code']??'', 
  ModeName: jsons['ModeName']??'', 
  Amount: jsons['Amount']??0.0
  );
}

}
class ordermaster {
  String? CardCode;
  String? CardName;
  int? DocNo;
  // String? U_sk_email;
  String? U_sk_NextFollowDt;

  String? bil_Address1;
  String? bil_Address2;
  String? Bil_Area;
  String? Bil_City;
  String? Bil_State;
  String? Bil_Pincode;
  String? Del_Address1;
  String? Del_Address2;
  String? Del_Area;
  String? Del_City;
  String? Del_State;
  String? Del_Pincode;
  String? DocDate;
  double? DocTotal;
  double? TaxAmount;
  double? SubTotal;
  double? GrossTotal;
  double? roundoff;
  String? gstno;
  String? deliveryduedate;
  String? paymentduedate;
  String? StoreCode;
  String? PaymentTerms;

  ordermaster(
      {required this.PaymentTerms,
      required this.GrossTotal,
      required this.SubTotal,
      required this.TaxAmount,
      required this.DocTotal,
      required this.roundoff,
      this.CardName,
      this.CardCode,
      this.DocNo,

      // this.U_sk_email,
      this.U_sk_NextFollowDt,
      required this.Bil_Area,
      required this.Bil_City,
      required this.Bil_Pincode,
      required this.Bil_State,
      required this.Del_Address1,
      required this.Del_Address2,
      required this.Del_Area,
      required this.Del_City,
      required this.Del_Pincode,
      required this.Del_State,
      required this.DocDate,
      required this.bil_Address1,
      required this.bil_Address2,
      required this.gstno,
      required this.deliveryduedate,
      required this.paymentduedate,
      required this.StoreCode});
  factory ordermaster.fromJson(Map<String, dynamic> jsons) {
    return ordermaster(
      PaymentTerms: jsons["PaymentTerms"] ?? '',
      StoreCode: jsons["StoreCode"],
      paymentduedate: jsons["PaymentDueDate"] ?? '',
      deliveryduedate: jsons["DeliveryDueDate"] ?? '',
      gstno: jsons["GSTNo"] ?? '',
      roundoff: jsons["RoundOff"] ?? 0.0,
      GrossTotal: jsons["GrossTotal"] ?? 0.0,
      DocTotal: jsons["DocTotal"] ?? 0.0,
      TaxAmount: jsons["TaxAmount"] ?? 0.0,
      SubTotal: jsons["SubTotal"] ?? 0.0,
      CardCode: jsons["CustomerCode"] ?? '',
      CardName: jsons["CustomerName"] ?? '',

      DocNo: jsons["OrderNumber"],
      // U_sk_email: jsons["u_sk_email"] ?? '',
      U_sk_NextFollowDt: jsons["DeliveryDueDate"] ?? '',
      Bil_Area: jsons["Bil_Area"] ?? '',
      Bil_City: jsons["Bil_City"] ?? '',
      Bil_Pincode: jsons["Bil_Pincode"] ?? '',
      Bil_State: jsons["Bil_State"] ?? '',
      Del_Address1: jsons["Bil_Address1"] ?? '',
      Del_Address2: jsons["Bil_Address2"] ?? '',
      Del_Area: jsons["Del_Area"] ?? '',
      Del_City: jsons["Del_City"] ?? '',
      Del_Pincode: jsons["Del_Pincode"] ?? '',
      Del_State: jsons["Del_State"] ?? '',
      DocDate: jsons["DocDate"] ?? '',
      bil_Address1: jsons["Del_Address1"] ?? '',
      bil_Address2: jsons["Del_Address2"] ?? '',
    );
  }
}
// class Error{
//   int? code;
//   Message?message;
//  Error({
//    this.code,
//   this.message
//  });

//   factory Error.fromJson(dynamic jsons) {
//     return Error(
//       code: jsons['code']as int,
//      message: Message.fromJson(jsons['message']),
//        );
//  }
// }

//  class Message{
//   String ?lang;
//   String ? value;
//  Message({
//    this.lang,
//    this.value,
//  });

//   factory Message.fromJson(dynamic jsons) {
//     return Message(
//     //  groupCode: jsons['GroupCode'] as int,
//       lang: jsons['lang']as String,
//       value: jsons['value'] as String,

//        );
//  }
//  }
class paymenttermdata {
  String? paymodcode;
  String? paymodename;
  String? ref1;
  String? ref2;
  String? listtype;
  String? dateref;
  String? attachment1;
  double? amount;

  paymenttermdata({
    required this.paymodcode,
    required this.paymodename,
    required this.ref1,
    required this.ref2,
    required this.listtype,
    required this.dateref,
    required this.attachment1,
    required this.amount,
  });
  Map<String, dynamic> tojason2() {
    final Map<String, dynamic> map = {};
    void addNonNullEntry(String key, dynamic value) {
    if (value != null) {
      map[key] = value;
    }
  }
    addNonNullEntry("paymodecode", paymodcode);
  addNonNullEntry("paymodename", paymodename);
  addNonNullEntry("ref1", ref1);
  addNonNullEntry("ref2", ref2);
  addNonNullEntry("listvalcode", listtype);
  addNonNullEntry("dateref", dateref);
  addNonNullEntry("attachpath", attachment1);
  addNonNullEntry("amount", amount!.round());
    
    return map;
  }
   Map<String, dynamic> tojason3(){
     Map<String, dynamic> map ={

      "paymodecode": paymodcode!,
      "paymodename": paymodename!,
      "ref1": ref1!,
      "ref2": ref2!,
      "listvalcode": listtype!,
      "dateref": dateref!,
      "attachpath": attachment1!,
      "amount": amount!.round(),
    };
     return map;
   }
  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "paymodecode": paymodcode!,
      "paymodename": paymodename!,
      "ref1": ref1!,
      "ref2": ref2!,
      "listvalcode": listtype!,
      "dateref": dateref!,
      "attachpath": attachment1,
      "amount": amount,
    };
    return map;
  }
}

class PostOrder {
  int? docEntry;
  int? docnum;
  String? docstatus;
  // String? DocType;
  double? doctotal;
  String? DocDate;
  String? CardCode;
  String? DocDateold;
  //
  // String? U_sk_enqId;
  String? U_sk_leadId;
  String? paymentTerms;
  String? poReference;
  String? notes;
  String? deliveryDate;
  String? paymentDate;
  String? attachmenturl1;
  String? attachmenturl2;
  String? attachmenturl3;
  String? attachmenturl4;
  String? attachmenturl5;

  //
  String? CardName;
  // String? U_sk_gender;
  // String? U_sk_Agegroup;
  // String? U_sk_cameas;
  // String? U_sk_Referals;
  String? DeliveryDate;
  int? updateid;
  String? updateDate;
  String? slpCode;
  int? enqID;
  List<DocumentLines>? docLine;
  List<paymenttermdata>? paymentdata;

  PostOrder(
      {this.DocDateold,
      this.CardCode,
      //New
      this.updateDate,
      this.updateid,
      this.slpCode,
      this.U_sk_leadId,
      this.paymentTerms,
      this.poReference,
      this.notes,
      this.deliveryDate,
      this.attachmenturl1,
      this.attachmenturl2,
      this.attachmenturl3,
      this.attachmenturl4,
      this.attachmenturl5,
      this.paymentDate,
      //
      this.doctotal,
      this.docEntry,
      this.docnum,
      this.docstatus,
      this.paymentdata,
      this.DocDate,
      // this.DocType,
      // this.U_sk_Address1,
      // this.U_sk_Address2,
      // this.U_sk_Address3,
      // this.U_sk_Pincode,
      // this.U_sk_City,
      // this.U_sk_alternatemobile,
      // this.U_sk_budget,
      // this.U_sk_headcount,
      this.CardName,
      this.docLine,
      this.enqID});

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "docEntry": docEntry,
      "dOcNUm": docnum,
      "docstatus": docstatus,
      // "DocType": DocType,
      "doctotal": doctotal,
      "canceled": "N",
      "DocDate": DocDate,
      "CardCode": CardCode,
      "CardName": CardName,
      // "U_sk_Address1": U_sk_Address1,
      // "U_sk_Address2": U_sk_Address2,
      // "U_sk_Address3": U_sk_Address3,

      // "U_sk_Pincode": U_sk_Pincode,
      // "U_sk_City": U_sk_City,
      // "U_sk_alternatemobile": U_sk_alternatemobile,
      // "SalesPersonCode": slpCode,
      // "U_sk_enqid": enqID,
      // "U_sk_email": U_sk_email,
      // "U_sk_headcount": U_sk_headcount,
      // "U_sk_budget": U_sk_budget,
      "u_sk_enqid": U_sk_leadId,
      "paymentTerms": paymentTerms,
      "customer_Po_referance": poReference,
      "notes": notes,
      "deliveryDate": deliveryDate,
      "attachmenturl1": attachmenturl1,
      "attachmenturl2": attachmenturl2,
      "attachmenturl3": attachmenturl3,
      "attachmenturl4": attachmenturl4,
      "attachmenturl5": attachmenturl5,
      "slpCode": slpCode,
      "updatedby": updateid,
      "updateddate": updateDate,

      "quT1s": paymentdata!.map((e) => e.tojason()).toList(),
      "quT2s": docLine!.map((e) => e.tojason()).toList()
    };
    return map;
  }
}

class DocumentLines {
  int? id;
  int? docEntry;
  int? linenum;
  String? ItemCode;
  String? ItemDescription;
  double? Quantity;
  double? Price;
  double? TaxCode;
  String? TaxLiable;
  double? LineTotal;
  String? deliveryfrom;
  String? storecode;
  double? BasePrice;
  double? sp;
  double? MRP;
  double? slpprice;
  double? storestock;
  double? whsestock;
  bool? isfixedprice;
  bool? allownegativestock;
  bool? alloworderbelowcost;
  String? complementary;
  String? couponcode;
  String? partcode;
   String? partname;

  DocumentLines(
      {this.partcode,
      this.couponcode,
      this.complementary,
      this.MRP,
      this.alloworderbelowcost,
      this.allownegativestock,
      this.isfixedprice,
      this.whsestock,
      this.storestock,
      this.slpprice,
      this.sp,
      required this.id,
      this.storecode,
      this.deliveryfrom,
      required this.docEntry,
      required this.linenum,
      required this.ItemCode,
      required this.ItemDescription,
      required this.Quantity,
      required this.LineTotal,
      required this.Price,
      required this.TaxCode,
      this.partname,
      this.TaxLiable,
      this.BasePrice});

  factory DocumentLines.fromJson(Map<String, dynamic> jsons) {
    return DocumentLines(
      MRP: jsons['MRP'],
      BasePrice: jsons['BasePrice'],
      id: jsons['id'],
      docEntry: jsons['DocEntry'],
      linenum: jsons['LineNum'],
      ItemCode: jsons['ItemCode'],
      ItemDescription: jsons['ItemName'],
      LineTotal: jsons['GrossLineTotal'],
      Price: jsons['Price'] ?? 0.00,
      Quantity: jsons['Quantity'],
      TaxCode: jsons['TaxRate'],
      TaxLiable: jsons['taxLiable'],
    );
  }

  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "id": id,
      "docEntry": docEntry,
      "lineNum": linenum,
      "itemCode": ItemCode,
      "itemDescription": ItemDescription,
      "quantity": Quantity!,
      "lineTotal": LineTotal!,
      "price": Price,
      "taxCode": TaxCode,
      "taxLiable": TaxLiable,
    };
    return map;
  }

  Map<String, dynamic> tojason2() {
    Map<String, dynamic> map = {
      "itemcode": ItemCode!.replaceAll("'", "''"),
      "itemname": ItemDescription!.replaceAll("'", "''"),
      "quantity": Quantity!,
      "price": Price,
      "storecode": storecode,
      "deliveryfrom": deliveryfrom,
      "couponcode": couponcode,
      "partnercode": partcode
    };
    return map;
  }
}
