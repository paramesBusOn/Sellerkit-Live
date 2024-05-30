// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/onboardModel/onboardmodel.dart';

class onBoardApi {
  static Future<onBoardModal> getData(
) async {

    int resCode = 500;
    try {
      print('Get Url Api::http://164.52.217.188:81/api/PortalAuthenticate/GetInitialContent');
    final response = await http.get(Uri.parse('http://164.52.217.188:81/api/PortalAuthenticate/GetInitialContent'),

        headers: {"Content-Type": "application/json"},

    );
print("get url body::"+response.body.toString());
      print("Status Code::" +response.statusCode.toString());
      resCode = response.statusCode;
      
      if (response.statusCode == 200) {
        // print("Error: ${response.body}");
        return onBoardModal.fromJson(json.decode(response.body) , response.statusCode);
      } else {
        // print("Error: ${response.body}");
        return onBoardModal.error("no Data",response.statusCode );
      }
    } catch (e) {
      log("Exception: " + e.toString());
      return onBoardModal.error(e.toString(), resCode);
    }
  }
}
