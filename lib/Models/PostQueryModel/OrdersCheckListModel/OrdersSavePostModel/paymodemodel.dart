import 'dart:convert';

class PaymodeModal {
PaymodeModal2? paymode;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  PaymodeModal(
      {required this.paymode,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory PaymodeModal.fromJson(Map<String,dynamic> jsons,int stcode) {
    if (jsons['data'] != null ) {
      var list = json.decode(jsons['data'] as String) as Map<String,dynamic>;
      // List<PaymodeModalData> dataList =
      //     list.map((data) => PaymodeModalData.fromJson(data)).toList();
      return PaymodeModal(
        paymode: PaymodeModal2.fromJson(list),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return PaymodeModal(
        paymode: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory PaymodeModal.error(String jsons,int stcode) {
    return PaymodeModal(
        paymode: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class PaymodeModal2{
  List<PaymodeModalData>? paymodeModalData;
  List<PaymodeModalist>? paymodeModallist;

  PaymodeModal2({
required this.paymodeModalData,
required this.paymodeModallist
  });
factory PaymodeModal2.fromJson(Map<String, dynamic> jsons){
  if(jsons["PaymentMode"] != null || jsons["PaymentMode_List"] != null){
     var list1 = jsons["PaymentMode"] as List;
     var list2 = jsons["PaymentMode_List"] as List;
      List<PaymodeModalData> dataList =
        list1.map((data) => PaymodeModalData.fromJson(data)).toList();
         List<PaymodeModalist> dataList2 =
        list2.map((data) => PaymodeModalist.fromJson(data)).toList();

    return     PaymodeModal2(
      paymodeModalData: dataList, 
      paymodeModallist: dataList2
      );

  }else{
   return PaymodeModal2(
      paymodeModalData: null, 
      paymodeModallist: null
      );
  }
}
}
class PaymodeModalist{
  String? Code;
  String? ListCode;
  String? ListName;
  bool? Status;
  PaymodeModalist({
required this.Code,
required this.ListCode,
required this.ListName,
required this.Status
  });
factory PaymodeModalist.fromJson(Map<String, dynamic> json)=>
PaymodeModalist(
  Code: json['Code']??'', 
  ListCode: json['ListCode']??'', 
  ListName: json['ListName']??'', 
  Status: json['Status']??false
  );
}

class PaymodeModalData {
  PaymodeModalData({
    required this.Attach,
    required this.Code,
    required this.CreatedBy,
    required this.CreatedDatetime,
    required this.ListVal,
    required this.ModeName,
    required this.Ref1,
    required this.Ref2,
    required this.SortOrder,
    required this.Status,
    required this.TransDate,
    required this.isselected,
     this.amount

    // required this.CODE,
    // required this.color,
    // required this.createdBy,
    // required this.createdOn,
    // required this.description,
    // required this.id,
    // required this.mastertypeid,
    // required this.parentMasterId,
    // required this.status,
    // required this.updatedBy,
    // required this.updatedOn
  });

  String? Code;
  String? ModeName;
  int? SortOrder;
  bool? Ref1;
  bool? Ref2;
  bool? ListVal;
  bool? TransDate;
  bool? Attach;
  bool? Status;
    int? CreatedBy;
  String? CreatedDatetime;
  bool? isselected;
  String? amount;
 

  // String? CODE;
  // int? color;
  // int? id;
  // int? mastertypeid;
  // String? description;
  // int? parentMasterId;
  // int? status;
  // int? createdBy;
  // String? createdOn;
  // int? updatedBy;
  // String? updatedOn; 
  



  factory PaymodeModalData.fromJson(Map<String, dynamic> json) =>
   PaymodeModalData(
    Attach: json['Attach']??false, 
    Code: json['Code']??"", 
    CreatedBy: json['CreatedBy']??0, 
    CreatedDatetime: json['CreatedDatetime']??'', 
    ListVal: json['ListVal']??false, 
    ModeName: json['ModeName']??'',
    Ref1: json['Ref1']??false,
    Ref2: json['Ref2']??false, 
    SortOrder: json['SortOrder']??0, 
    Status:json['Status']??false, 
    TransDate: json['TransDate']??false,
    isselected:false,
    amount:''
    );
   
}
