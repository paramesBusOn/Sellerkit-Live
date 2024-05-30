import 'dart:convert';
import 'dart:math';

class getApproverModal {
  List<GetApproverheader>? getApproverheader;
  String? exception;
  int? stcode;
  String? message;
  

  getApproverModal(
      {this.exception,
      this.message,
      required this.stcode,
      required this.getApproverheader
     
      });
  factory getApproverModal.fromJson(Map<String, dynamic> jsons, int stcode) {
      // print("jsons['body']"+jsons['body'].toString());
      // print("quT2s"+jsons['docEntry'].toString());

    if (jsons != null&&jsons.isNotEmpty) {
      // print("jsons['quT2s']"+jsons['quT2s'].toString());
      var list =json.decode(jsons['data'])  as List;
      List<GetApproverheader> dataList =
          list.map((enquiries) => GetApproverheader.fromJson(enquiries)).toList();
      return getApproverModal(
        getApproverheader:dataList,
        stcode: stcode,
        exception: null,
        message: jsons['respCode']
       
        // error: null
      );
    } else {
      print("wrong site");
      return getApproverModal(
        getApproverheader:null,
        stcode: stcode,
        exception: "Failure",
        message: jsons['respCode']
       
        // error: null
      );
    }
  }

   factory getApproverModal.error(String jsons, int stcode) {
    return getApproverModal(
       getApproverheader:null,
      stcode: stcode,
      exception: jsons,
      
      // error: null
    );
  }

  

  factory getApproverModal.issue(Map<String, dynamic> jsons, int stcode) {
    return getApproverModal(
       getApproverheader:null,
      stcode: stcode,
      exception: jsons["respDesc"],
      message: jsons['respCode']
      
     
      // error: jsons==null?null: Error.fromJson(jsons['error']),
    );
  }
}

class GetApproverheader{
  String? Slab;
  String? Authoriser_Code;
  String? Authoriser_Name;
  String? Authoriser_Mobile;
GetApproverheader({
required this.Slab,
required this.Authoriser_Code,
required this.Authoriser_Name,
required this.Authoriser_Mobile,
});
factory GetApproverheader.fromJson(Map<String,dynamic> json)=>
GetApproverheader(
  Slab: json['Slab']??'', 
  Authoriser_Code: json['Authoriser_Code']??'', 
  Authoriser_Name: json['Authoriser_Name']??'', 
  Authoriser_Mobile: json['Authoriser_Mobile']??''
  );
}