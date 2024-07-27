// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names, camel_case_types, unnecessary_string_interpolations, unused_import

import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/SettlementModel/SettlementPostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;

// import 'package:sellerkit/main.dart';

class SettlementPostApi {
  static Future<SettlementPostDetails> getCollectionData(
      settlePostBody? settlepostlist) async {
    // int resCode = 500;
    try {
      log('settle Body:' + jsonEncode({
            "doctype": "${settlepostlist!.doctype}",
            "depoaccount": "${settlepostlist.depoaccount}",
            "remarks": "${settlepostlist.remarks}",
            "settlelines": settlepostlist.settlementLineList
                .map((e) => e.tojason())
                .toList()
          }));
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse("${Url.queryApi}Sellerkit_Flexi/v2/SetlleAdd"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "doctype": "${settlepostlist.doctype}",
            "depoaccount": "${settlepostlist.depoaccount}",
            "remarks": "${settlepostlist.remarks}",
            "settlelines": settlepostlist.settlementLineList
                .map((e) => e.tojason())
                .toList()
          }));
      response.statusCode;

      log('settle ResponceCode:' + response.statusCode.toString());

      log('settle Post Responce:' + response.body.toString());
      if (response.statusCode == 200) {
        return SettlementPostDetails.fromJson(
            json.decode(response.body.toString()), response.statusCode);
      } else {
        return SettlementPostDetails.issues(
            json.decode(response.body.toString()), response.statusCode);
      }
    } catch (e) {
      log("e::"+e.toString());
      return SettlementPostDetails.error("$e", 500);
    }
  }
}

class settlePostBody {
  //
  String doctype;
  String depoaccount;
  String remarks;

  List<Settlelines> settlementLineList = [];
  settlePostBody({
    //
    required this.doctype,
    required this.depoaccount,
    required this.remarks,
    required this.settlementLineList,
  });
}

class Settlelines {
  int? docentry;
  double? amount;
  int? ipayline;

  Settlelines({
    required this.docentry,
    required this.amount,
    required this.ipayline
  });

  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "docentry": docentry,
      "amount": amount,
      "ipaylinenum":ipayline
    };
    return map;
  }
}
