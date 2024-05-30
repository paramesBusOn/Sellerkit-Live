// ignore_for_file: unnecessary_null_comparison

class LeadSavePostModal {
  String? exception;
  int?stcode;
  int? DocEntry;
  String? CardCode;
  String? CardName;
  int? DocNo;
  String?U_sk_email;
  String?U_sk_NextFollowDt;
  // Error? error ;
  List<DocumentLines>? documentdata;

 LeadSavePostModal({
      this.exception,
      required this.stcode,
      required this.DocEntry,
      required this.CardCode,
      required this.CardName,
      // this.error,
       this.DocNo,
      this.documentdata,
      this.U_sk_email,
      this.U_sk_NextFollowDt
      });
  factory LeadSavePostModal.fromJson(Map<String, dynamic> jsons,int stcode) {
     if(jsons['quT1s'] != null){
     var list =  jsons['quT1s'] as List; 
      List<DocumentLines> dataList = list
          .map((enquiries) => DocumentLines.fromJson(enquiries))
          .toList();
      return LeadSavePostModal(
        stcode: stcode,
        exception:null,
        DocEntry:jsons["docEntry"]??'',
        CardCode:jsons["cardCode"]??'',
        CardName:jsons["cardName"]??'',
        documentdata:dataList,
        DocNo: jsons["dOcNUm"]??'',
        U_sk_email:jsons["u_sk_email"]??'',
        U_sk_NextFollowDt:jsons["u_sk_NextFollowDt"]??'',
        // error: null
      );
      }else{
 return LeadSavePostModal(
        stcode: stcode,
        exception:"$jsons",
        DocEntry:jsons["docEntry"]??'',
        CardCode:jsons["cardCode"]??'',
        CardName:jsons["cardName"]??'',
        documentdata:null,
        DocNo: jsons["dOcNUm"]??'',
        U_sk_email:jsons["u_sk_email"]??'',
        U_sk_NextFollowDt:jsons["u_sk_NextFollowDt"]??'',
        // error: null
      );
      }
  }

  factory LeadSavePostModal.error(String jsons,int stcode) {
    return LeadSavePostModal(
        stcode: stcode,
        exception:"$jsons",
        DocEntry:null,
        CardCode:null,
        CardName:null,
        // error: null
        );
  }

   factory LeadSavePostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return LeadSavePostModal(
        stcode: stcode,
        exception:null,
        DocEntry:null,
        CardCode:null,
        CardName:null,
        // error: jsons==null?null: Error.fromJson(jsons['error']),
        );
  }

  //json==null?null: Error.fromJson(json['error']),
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



class PostLead
{
  int? docEntry;
  int? docnum;
  String? docstatus;
  String?DocType;
  double? doctotal;
  String?DocDate;
  String? CardCode;
  String? U_sk_Address1;
  String? U_sk_Address2;
  String? U_sk_Pincode;
  String? U_sk_City;
  String? U_sk_alternatemobile;
  String? U_sk_headcount;
  String? U_sk_budget;
  String? CardName;
  String? U_sk_email;
  String? U_sk_gender;
  String? U_sk_Agegroup;
  String? U_sk_cameas;
  String? U_sk_Referals;
  String? U_sk_NextFollowDt;
  String? U_sk_planofpurchase;
  String? slpCode;
  int? enqID;
  List<DocumentLines>? docLine;

  PostLead({
    this.doctotal,
    this.docEntry,
    this.docnum,
    this.docstatus,
 this.CardCode,
 this.DocDate,
 this.DocType,
 this.U_sk_Address1,
 this.U_sk_Address2,
 this.U_sk_Pincode,
 this.U_sk_City,
 this.U_sk_alternatemobile,
 this.U_sk_budget,
 this.U_sk_headcount,
 this.CardName,
 this.U_sk_Agegroup,
 this.U_sk_NextFollowDt,
 this.U_sk_Referals,
 this.U_sk_cameas,
 this.U_sk_email,
 this.U_sk_gender,
 this.U_sk_planofpurchase,
 this.docLine,
 this.slpCode,
 this.enqID
  });

Map<String,dynamic> tojson(){
  Map<String,dynamic> map ={
    "docEntry":docEntry,
    "dOcNUm":docnum,
    "docstatus":docstatus,
     "DocType":DocType,
     "doctotal": doctotal,
     "canceled":"N",
     "DocDate":DocDate,
     "CardCode":CardCode,
     "CardName":CardName,
     "U_sk_Address1":U_sk_Address1,
     "U_sk_Address2":U_sk_Address2,
     "U_sk_Pincode":U_sk_Pincode,
     "U_sk_City":U_sk_City,
     "U_sk_alternatemobile":U_sk_alternatemobile,
     "SalesPersonCode":slpCode,
     "U_sk_enqid":enqID==null?"": enqID.toString(),
     "U_sk_email":U_sk_email,
     "U_sk_headcount":U_sk_headcount,
     "U_sk_budget":U_sk_budget,
     "U_sk_gender":U_sk_gender,
     "U_sk_Agegroup":U_sk_Agegroup,
     "U_sk_cameas":U_sk_cameas,
     "U_sk_Referals":U_sk_Referals,
     "U_sk_NextFollowDt":U_sk_NextFollowDt,
     "U_sk_planofpurchase":U_sk_planofpurchase,
     "quT1s": docLine!.map((e) => e.tojason()).toList()
  };
  return map;
}


}

class DocumentLines
{
  int? id;
  int? docEntry;
  int? linenum;
  String? ItemCode;
  String? ItemDescription;
  int? Quantity;
  double? Price;
  String? TaxCode;
  String? TaxLiable;
  double? LineTotal;
  bool? isfixedprice;

  DocumentLines({
     this.isfixedprice,
    required this.id,
    required this.docEntry,
    required this.linenum,
    required this.ItemCode,
    required this.ItemDescription,
    required this.Quantity,
    required this.LineTotal,
    required this.Price,
    required this.TaxCode,
    required this.TaxLiable
  });

    factory DocumentLines.fromJson(Map<String, dynamic> jsons) {
      return DocumentLines(
        id:jsons['id'],
        docEntry: jsons['docEntry'],
        linenum: jsons['lineNum'],

        ItemCode: jsons['itemCode'], 
        ItemDescription: jsons['itemDescription'], 
        LineTotal:  jsons['lineTotal'],
        Price:  jsons['price']??0.00,
        Quantity: jsons['quantity'],
        TaxCode:  jsons['taxCode'],
        TaxLiable:  jsons['taxLiable'],
      );
  }


  Map<String,dynamic> tojason(){
    Map<String,dynamic> map ={
      "id":id,
      "docEntry":docEntry,
      "lineNum":linenum,
       "itemCode":ItemCode,
       "itemDescription":ItemDescription,
       "quantity":Quantity!,
       "lineTotal":LineTotal!,
       "price":Price,
       "taxCode":TaxCode,
       "taxLiable":TaxLiable,
    };
    return map;
  }

  Map<String,dynamic> tojason2(){
    Map<String,dynamic> map ={
       "lineNum": linenum,
      "itemCode": ItemCode!.replaceAll("'", "''"),
      "itemName": ItemDescription!.replaceAll("'", "''"),
      "quantity": Quantity,
      "price": Price,
      "sp": 0,
      "ssP1": 0,
      "ssP2": 0,
      "ssP3": 0,
      "ssP4": 0,
      "ssP5": 0,
      "storeStock": 0,
      "whseStock": 0
    };
    return map;
  }
  
}