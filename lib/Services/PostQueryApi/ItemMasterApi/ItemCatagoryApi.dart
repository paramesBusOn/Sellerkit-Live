// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

import 'dart:convert';
import 'dart:developer';

import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/PostQueryModel/ItemMasterModelNew.dart/ItemCatagoryModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';

class ItemMasterCatagoryApiNew {
static  Future<ItemMasterCatNewModal> getData() async {
    int resCode = 500;
    log("Item Master Api::"+Url.queryApi + 'SkClientPortal/GetCatogeryList');
    log('token::'+ConstantValues.token);
 
    try {
         
          // await config.getSetup(); 
          final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetCatogeryList'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location":'${ConstantValues.EncryptedSetup}'
          
        },
      );
      log('location:: ${ConstantValues.EncryptedSetup}');
      // ignore: prefer_interpolation_to_compose_strings

      resCode = response.statusCode;
      // log(response.statusCode.toString());
      log("ItemMAsterCata New:"+response.body.toString());
      if (response.statusCode == 200) {
        
        return ItemMasterCatNewModal.fromJson(response.body.toString(), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ItemMasterCatNewModal.error('Error', resCode);
      }
    } catch (e) {

      log("Exception2222: "+e.toString());
      return ItemMasterCatNewModal.error(e.toString(), resCode);
    }
  }

 
}
