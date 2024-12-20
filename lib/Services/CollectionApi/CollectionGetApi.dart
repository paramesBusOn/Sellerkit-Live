// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/CollectionModel/collection_model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;


import 'package:sellerkit/Constant/constant_sapvalues.dart';
// import 'package:sellerkit/main.dart';

class CollectionGetApi {
  static Future<CollectionGetDetails> getCollectionData() async {
    int resCode = 500;
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse("${Url.queryApi}Sellerkit_Flexi/v2/IpayGet"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
          },
          body: jsonEncode({
            "listtype": "summary",
            "valuetype": "name",
            "fromperiod": null,
            "toperiod": null,
            "status": null,
            "userid": int.parse(ConstantValues.UserId)
          }));
      resCode = response.statusCode;
log("collection Get:"+response.body.toString());
      if (response.statusCode == 200) {
        return CollectionGetDetails.fromJson(
            json.decode(response.body.toString()), resCode);
      } else {
        return CollectionGetDetails.issues(
            json.decode(response.body.toString()), resCode);
      }
    } catch (e) {
      log("collection exception:"+e.toString());

      return CollectionGetDetails.error("$e", resCode);
    }
  }
}

class getCollectBody {
  String? listtype;
  String? valuetype;
  String? fromperiod;
  String? toperiod;
  String? status;
  String? userid;

  getCollectBody(
      {required this.listtype,
      required this.valuetype,
      required this.fromperiod,
      required this.toperiod,
      required this.status,
      required this.userid});
}
