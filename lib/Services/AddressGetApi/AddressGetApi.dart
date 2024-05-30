import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/AddressApiModel/AddressMoasterModel.dart';
import 'package:sellerkit/main.dart';

// import '../../Models/AddressMoasterModel.dart';


class AddressMasterApi {
  static Future<AddressrModel> getData(String lan,String long) async {
    int resCode = 500;


    try {
    log("addapi::"+"https://maps.googleapis.com/maps/api/geocode/json?latlng=$lan,$long&key=AIzaSyAdvVumVzr7teF3UDRchglwonf_vjvXtZo");
      // await config.getSetup();
       final response = await http.get(
        Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lan,$long&key=AIzaSyAdvVumVzr7teF3UDRchglwonf_vjvXtZo'),
        headers: {
          "content-type": "application/json",
        },
      );
      resCode = response.statusCode;
      log("ADDRESS"+response.body.toString());
      // log("sk_Address_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AddressrModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        log("Error: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AddressrModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
       throw Exception(e.toString());
      // return AddressrModel.error(e.toString(), resCode);
    }
  }
}
