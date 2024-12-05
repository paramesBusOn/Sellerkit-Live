

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Models/ordergiftModel/ParticularpricelistModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class ParticularPriceListApi{
  static Future<ParticularpriceDetails> getData()async{
     int resCode = 500;
     try{
      log("::aaa::"+Url.queryApi + 'SkClientPortal/GetPricesLabs');
      final response=await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetPricesLabs'),
      headers: {
        "content-type": "application/json",
        "Authorization": 'bearer '+ ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
      }
      );
      resCode = response.statusCode;
      log("response.body"+response.body.toString());
      log("response.body"+response.statusCode.toString());
      if(response.statusCode ==200){
        return ParticularpriceDetails.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return ParticularpriceDetails.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return ParticularpriceDetails.error(e.toString(), resCode);
     }

  }
}