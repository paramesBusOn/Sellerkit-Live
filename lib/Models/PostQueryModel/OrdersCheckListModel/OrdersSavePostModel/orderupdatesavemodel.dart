// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:math';

class OrderupdatePostModal {
  OrderSavePostModheader? orderSavePostheader;
  String? exception;
  int? stcode;
  

  OrderupdatePostModal(
      {this.exception,
      required this.stcode,
      required this.orderSavePostheader
     
      });
  factory OrderupdatePostModal.fromJson(Map<String, dynamic> jsons, int stcode) {
      // print("jsons['body']"+jsons['body'].toString());
      // print("quT2s"+jsons['docEntry'].toString());

    if (jsons != null&&jsons.isNotEmpty) {
      // print("jsons['quT2s']"+jsons['quT2s'].toString());
      var list =json.decode(jsons['data'])  as Map<String,dynamic>;
      // List<DocumentLines> dataList =
      //     list.map((enquiries) => DocumentLines.fromJson(enquiries)).toList();
      return OrderupdatePostModal(
        orderSavePostheader:OrderSavePostModheader.fromJson(list),
        stcode: stcode,
        exception: null,
       
        // error: null
      );
    } else {
      print("wrong site");
      return OrderupdatePostModal(
        orderSavePostheader:null,
        stcode: stcode,
        exception: "Failure",
       
        // error: null
      );
    }
  }

  factory OrderupdatePostModal.error(String jsons, int stcode) {
    return OrderupdatePostModal(
       orderSavePostheader:null,
      stcode: stcode,
      exception: jsons,
      
      // error: null
    );
  }

  

  factory OrderupdatePostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return OrderupdatePostModal(
       orderSavePostheader:null,
      stcode: stcode,
      exception: jsons["respDesc"],
     
      // error: jsons==null?null: Error.fromJson(jsons['error']),
    );
  }

  //json==null?null: Error.fromJson(json['error']),
}
class OrderSavePostModheader{
  
  // Error? error ;
  List<DocumentLines>? documentdata;
  List<ordermaster>? orderMasterdata;
  OrderSavePostModheader({

      this.documentdata,
      this.orderMasterdata
      // this.U_sk_email,
     
  });

   factory OrderSavePostModheader.fromJson(Map<String, dynamic> jsons){
    if(jsons['Ordermaster'] !=null && jsons["orederLine"] !=null){
var list =jsons['Ordermaster']  as List;
var list2 =jsons['orederLine']  as List;

      List<ordermaster> dataList =
          list.map((enquiries) => ordermaster.fromJson(enquiries)).toList();
             List<DocumentLines> dataList2 =
          list2.map((enquiries) => DocumentLines.fromJson(enquiries)).toList();
          return OrderSavePostModheader(
        
        documentdata: dataList2,
        orderMasterdata:dataList,
       
            );
    }else{
        return OrderSavePostModheader(
          documentdata: null,
           orderMasterdata:null,
       
            );
    }

   }
     

  }


  class ordermaster{
 
        String? CardCode;
  String? CardName;
  int? DocNo;
  // String? U_sk_email;
  String? U_sk_NextFollowDt;
   ordermaster({
  this.CardName,
      this.CardCode,
      this.DocNo,
     
      // this.U_sk_email,
      this.U_sk_NextFollowDt,
   });
   factory ordermaster.fromJson(Map<String, dynamic> jsons){

   
    return ordermaster(
 CardCode: jsons["CustomerCode"] ?? '',
        CardName: jsons["CustomerName"] ?? '',
     
       DocNo: jsons["OrderNumber"] ,
        // U_sk_email: jsons["u_sk_email"] ?? '',
        U_sk_NextFollowDt: jsons["DeliveryDueDate"] ?? '',
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

// class PostOrder {
//   int? docEntry;
//   int? docnum;
//   String? docstatus;
//   // String? DocType;
//   double? doctotal;
//   String? DocDate;
//   String? CardCode;
//   //
//   // String? U_sk_enqId;
//   String? U_sk_leadId;
//   String? paymentTerms;
//   String? poReference;
//   String? notes;
//   String? deliveryDate;
//   String? paymentDate;
//   String? attachmenturl1;
//   String? attachmenturl2;
//   String? attachmenturl3;
//   String? attachmenturl4;
//   String? attachmenturl5;

//   //
//   String? CardName;
//   // String? U_sk_gender;
//   // String? U_sk_Agegroup;
//   // String? U_sk_cameas;
//   // String? U_sk_Referals;
//   String? DeliveryDate;
//   int? updateid;
//   String? updateDate;
//   String? slpCode;
//   int? enqID;
//   List<DocumentLines>? docLine;

//   PostOrder(
//       {
//         this.CardCode,
//       //New
//       this.updateDate,
//       this.updateid,
//       this.slpCode,
//       this.U_sk_leadId,
//       this.paymentTerms,
//       this.poReference,
//       this.notes,
//       this.deliveryDate,
//       this.attachmenturl1,
//       this.attachmenturl2,
//       this.attachmenturl3,
//       this.attachmenturl4,
//       this.attachmenturl5,
//       this.paymentDate,
//       //
//       this.doctotal,
//       this.docEntry,
//       this.docnum,
//       this.docstatus,
      
//       this.DocDate,
//       // this.DocType,
//       // this.U_sk_Address1,
//       // this.U_sk_Address2,
//       // this.U_sk_Address3,
//       // this.U_sk_Pincode,
//       // this.U_sk_City,
//       // this.U_sk_alternatemobile,
//       // this.U_sk_budget,
//       // this.U_sk_headcount,
//       this.CardName,
//       this.docLine,
//       this.enqID});

//   Map<String, dynamic> tojson() {
//     Map<String, dynamic> map = {
//       "docEntry": docEntry,
//       "dOcNUm": docnum,
//       "docstatus": docstatus,
//       // "DocType": DocType,
//       "doctotal": doctotal,
//       "canceled": "N",
//       "DocDate": DocDate,
//       "CardCode": CardCode,
//       "CardName": CardName,
//       // "U_sk_Address1": U_sk_Address1,
//       // "U_sk_Address2": U_sk_Address2,
//       // "U_sk_Address3": U_sk_Address3,

//       // "U_sk_Pincode": U_sk_Pincode,
//       // "U_sk_City": U_sk_City,
//       // "U_sk_alternatemobile": U_sk_alternatemobile,
//       // "SalesPersonCode": slpCode,
//       // "U_sk_enqid": enqID,
//       // "U_sk_email": U_sk_email,
//       // "U_sk_headcount": U_sk_headcount,
//       // "U_sk_budget": U_sk_budget,
//       "u_sk_enqid":U_sk_leadId,
//       "paymentTerms":paymentTerms,
//       "customer_Po_referance":poReference,
//       "notes":notes,
//       "deliveryDate":deliveryDate,
//       "attachmenturl1":attachmenturl1,
//       "attachmenturl2":attachmenturl2,
//       "attachmenturl3":attachmenturl3,
//       "attachmenturl4":attachmenturl4,
//       "attachmenturl5":attachmenturl5,
//       "slpCode":slpCode,
//       "updatedby":updateid,
//       "updateddate":updateDate,

      
//       "quT2s": docLine!.map((e) => e.tojason()).toList()
//     };
//     return map;
//   }
// }

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

  DocumentLines(
      {
       
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
      required this.TaxLiable});

  factory DocumentLines.fromJson(Map<String, dynamic> jsons) {
    return DocumentLines(
      id: jsons['id'],
      docEntry: jsons['DocEntry'],
      linenum: jsons['LineNum'],
      ItemCode: jsons['ItemCode'],
      ItemDescription: jsons['ItemName'],
      LineTotal: jsons['lineTotal'],
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
      "itemcode": ItemCode,
      "itemname": ItemDescription,
      "quantity": Quantity!,
      "price": Price,
      "storecode": storecode,
      "deliveryfrom": deliveryfrom
     
    };
    return map;
  }
}
