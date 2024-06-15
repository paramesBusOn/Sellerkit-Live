

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class refpartnerApi{

  static Future<refdetModal> getData()async{
int resCode =500;
try {
 
      log("URLLLLL"+Url.queryApi + 'Sellerkit_Flexi/v2/AllPartnerList?UserId=${ConstantValues.UserId}');
      // await config.getSetup(); 
      final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/AllPartnerList?UserId=${ConstantValues.UserId}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          
          );

          // log(jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.sapUserID}'"
          // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("refparner11: "+response.body.toString());
      if (response.statusCode == 200) {
        return refdetModal.fromJson(
           json.decode(response.body)  , response.statusCode);
      } else {
      //  print("ErrorExceptionFEED: ${json.decode(response.body)}");
        return refdetModal.error('Error', response.statusCode);
        //throw Exception();
      }
    } catch (e) {
     log("ExceptionFEED: " + e.toString());
      return refdetModal.error(e.toString(), resCode);
     // throw Exception(e.toString());
    }
  }
}

class refdetModal {
refdetModalheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  refdetModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory refdetModal.fromJson(Map<String,dynamic> jsons,int stcode) {
    // log("jsons:::::"+jsons.toString());
    
    // if (jsons['data'] != null ) {
      // var list =jsons["data"]  as List;
      // List<refdetModalData> dataList =
      //     list.map((data) => refdetModalData.fromJson(data)).toList();
      return refdetModal(
        itemdata: refdetModalheader.fromJson(jsons),
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    // } else {
    //   return refdetModal(
    //     itemdata: null,
    //     message: "failed",
    //     status: false,
    //     stcode: stcode,
    //     exception:null
    //   );
    // }
  }

  factory refdetModal.issues(Map<String,dynamic> jsons,int stcode) {
    return refdetModal(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory refdetModal.error(String jsons,int stcode) {
    return refdetModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}
class refdetModalheader{
   List<refdetModalData>? itemdata;
   refdetModalheader({
    required this.itemdata
   });
factory refdetModalheader.fromJson(Map<String,dynamic> jsons,){
//  print("jsonsjsons::"+jsons.toString());
  if(jsons['data'] != null){
    
var list = json.decode(jsons['data']) as List;
 
      List<refdetModalData> dataList =
          list.map((data) => refdetModalData.fromJson(data)).toList();
  return refdetModalheader(
    itemdata: dataList
    );
  }else{
     return refdetModalheader(
    itemdata: null
    );
  }

}
}
class refdetModalData {
  refdetModalData({
    required this.Code,
    required this.Name,


  });

  String? Code;
  String? Name;


  factory refdetModalData.fromJson(Map<String, dynamic> json) =>
   refdetModalData(
     Code: json['code'] ?? 00,
     Name: json['description'] ?? '',
     );
   
  
}
