

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class GetoutstandingApi{
  static Future<outsatandingmodel> getData()async{
     int resCode = 500;
     try{
      log("aaa::"+Url.queryApi + 'Sellerkit_Flexi/v2/GetAllOutstandings');
      Config config=Config();
      final response=await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllOutstandings'),
      headers: {
        "content-type": "application/json",
        "Authorization": 'bearer '+ ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
      }
      );
      resCode = response.statusCode;
      log("response.body"+response.body.toString());
      if(response.statusCode ==200){
        return outsatandingmodel.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return outsatandingmodel.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return outsatandingmodel.error(e.toString(), resCode);
     }

  }
}