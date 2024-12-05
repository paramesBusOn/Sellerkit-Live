

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Models/ordergiftModel/LiknkedItemsModel.dart';
import 'package:sellerkit/Models/ordergiftModel/ordergiftModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class LinkeditemsApi{
  static Future<LinkeditemsDetails> getData(String? itemcode)async{
     int resCode = 500;
     try{
      log("::aaa::"+Url.queryApi + 'Sellerkit_Flexi/v3/GetLinkedItems/PrimaryItemcode?PrimaryItemcode=${Uri.encodeComponent(itemcode!)}');
      final response=await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v3/GetLinkedItems/PrimaryItemcode?PrimaryItemcode=${Uri.encodeComponent(itemcode!)}'),
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
        return LinkeditemsDetails.fromJson(json.decode(response.body.toString()),response.statusCode);
      }else{
        return LinkeditemsDetails.issues(json.decode(response.body),response.statusCode);
    
      }
     }catch (e){
      log("message"+e.toString());
       return LinkeditemsDetails.error(e.toString(), resCode);
     }

  }
}