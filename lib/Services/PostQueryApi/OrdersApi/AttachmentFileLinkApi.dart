import 'package:http/http.dart' as http;
// ignore_for_file: unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:developer';
// import 'package:dio/dio.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';


import 'package:sellerkit/Constant/Configuration.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Controller/OrderController/OrderNewController.dart';

class OrderAttachmentApiApi {
  static Future<String> getData(String filename) async {
    int resCode = 500;
    // Responce respon=new Responce();
    // var dio = Dio();
    // var dio = Dio();

    try {
      
Config config = Config();
// await config.getSetup(); 
      // Response response = await dio.post(
      //   // "http://192.168.0.162:81/api/SkClientPortal/UploadOrderMedia?filename=Screenshot_2023-09-05-12-06-20-77_ae2c0829d08fc004d4ae97ce5b311048.jpg",
      //   Url.queryApi + 'SkClientPortal/UploadOrderMedia?filename=$filename',
      //   options: Options(
      //     headers: {
      //       "content-type": "application/json",
      //       "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
      //     },
      //   ),
      //   data: FormData.fromMap({
      //     'formFile': '$filename',
      //   }),
      //   queryParameters: {
      //   'filename': '$filename',
      //   // 'param2': 'value2',
      //   // Add other query parameters here
      // },
      // );

      // var request = http.MultipartRequest(
      //     'POST',
      //     Uri.parse(Url.queryApi +
      //         'SkClientPortal/UploadOrderMedia?filename=$filename'));
      // request.fields.addAll({'formFile': '$filename'});
      // request.fields['filename'] = '$filename';
      // request.headers['Authorization'] = 'bearer ' + ConstantValues.token;
      // request.headers['content-type'] = 'application/json';
      var url = Uri.parse(Url.queryApi +
          'SkClientPortal/UploadOrderMedia?filename=${filename.split('/').last}');
      print("url: ${url}");
      var request = http.MultipartRequest('POST', url);
        // request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      //   var file = await http.MultipartFile.fromPath(
      //   'image',
      //   "${filename}",
      //   filename: '${filename.split('/').last}',
      // );

      var file = await http.MultipartFile.fromPath(
        'formFile',
        "${filename}",
        filename: '${filename.split('/').last}',
      );
      log("aaa::"+filename.toString());
      request.files.add(file);
      var headers = {
        'Authorization': 'bearer ${ConstantValues.token}',
        "Location":'${ConstantValues.EncryptedSetup}',
        "content-type": "application/json",
      };
      request.headers.addAll(headers);
      var response = await request.send();
      log("SSS"+response.statusCode.toString());
      
        var resposbody = await response.stream.bytesToString();
         log("file ${resposbody.toString()} parames::" +
            response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // log("palss");
       

        return resposbody.toString();
      } else {
        return "No Data Found..!!";
      }
    } catch (e) {
      log("eerrorattachments::"+e.toString());
      return "No Data Found..!!";
    }
  }
}
