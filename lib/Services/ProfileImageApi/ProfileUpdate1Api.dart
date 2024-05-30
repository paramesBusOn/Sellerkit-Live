// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate1Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class ProfileUpdateApi1 {
  static Future<String> getData(String image,String? urlname) async {
    int resCode = 500;
    String image2 = '$image';
      String modifiedImage = image2.replaceAll('"', '');

  log("AAAA"+modifiedImage); 
    try {
      Config config = Config();

      // await config.getSetup();
      log("UURRR" +
          Url.queryApi +
          'SkClientPortal/UploadProfileMedia?filename=${image.split('/').last}');
      // final response = await http.post(
      //     Uri.parse(Url.queryApi +
      //         "SkClientPortal/UploadProfileMedia?filename=$urlname"),

          // Url.queryApi + 'SellerKit'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          // headers: {
          //   "content-type": "application/json",
          //   "Authorization": 'bearer ' + ConstantValues.token,
          //   "Location": '${ConstantValues.EncryptedSetup}'
          // },
          var url = Uri.parse(Url.queryApi +
          'SkClientPortal/UploadProfileMedia?filename=${image.split('/').last}');
      // print("url: ${url}");
      var request = http.MultipartRequest('POST', url);
        // request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      //   var file = await http.MultipartFile.fromPath(
      //   'image',
      //   "${filename}",
      //   filename: '${filename.split('/').last}',
      // );

      var file = await http.MultipartFile.fromPath(
        'formFile',
        "${image}",
        filename: '${image.split('/').last}',
      );
      request.files.add(file);
      var headers = {
        'Authorization': 'bearer ${ConstantValues.token}',
        "Location":'${ConstantValues.EncryptedSetup}',
        "content-type": "application/json",
      };
      request.headers.addAll(headers);
      var response = await request.send();
      // log("SSS"+response.statusCode.toString());
        var resposbody = await response.stream.bytesToString();
      //     body: jsonEncode({"formFile": image2.replaceAll('"', '')}));
      // log("llllll" + jsonEncode({"formFile": image2.replaceAll('"', '')}));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      print("SK_GET_STORAGE_FOLDER " + resposbody.toString());
      if (response.statusCode == 200) {
        return resposbody.toString();
      } else {
        // print("Error: ${json.decode(response.body)}");
        return "No Data Found";
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return "No Data Found";
    }
  }
}
