
// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types
class EnqPatchModal{
  String ?odatametadata;
  List<EnqPatchValue>? itemValueValue;
  int? stcode;
  String? nextLink;
  Error? error ;
  String?exception;
  EnqPatchModal({
   required this.odatametadata,
   this.itemValueValue,
   this.stcode,
   this.nextLink,
   this.error,
   this.exception
  });
   factory EnqPatchModal.fromJson(Map<String, dynamic> jsons,int stcode) {
    // if (jsons['value'] != null) {
      var list =  jsons['value'] as List; 
      List<EnqPatchValue> dataList = list
          .map((dynamic enquiries) => EnqPatchValue.fromJson(enquiries))
          .toList();
      return EnqPatchModal(
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

   factory EnqPatchModal.issue(Map<String, dynamic>? json,int? stcode) {
      return EnqPatchModal(
       odatametadata: null,
       itemValueValue:null,
       nextLink:null,
       stcode:stcode,
       error:json==null?null: Error.fromJson(json['error']),
       exception: null
          );
  }

     factory EnqPatchModal.exception(String exp,int? stcode) {
      return EnqPatchModal(
       odatametadata: null,
       itemValueValue:null,
       nextLink:null,
       stcode:stcode,
       error:null,
       exception: exp
          );
  }
}


class EnqPatchValue{
String? itemCode;
String ?itemName;
String ?brand;

EnqPatchValue({
required  this.itemCode,
required  this.itemName,
required this.brand,

});

 factory EnqPatchValue.fromJson(dynamic jsons) {      

    return EnqPatchValue(
      itemCode: jsons['ItemCode'].toString(), 
      itemName: jsons['ItemName'].toString(), 
      brand:jsons['U_Brand'].toString(),  
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

