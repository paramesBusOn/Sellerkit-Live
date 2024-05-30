import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/NewProfileModel/SaveProfilemodel.dart';
import 'package:sellerkit/main.dart';

class SaveProfileApi {
  static int resCode = 500;
  static Future<SaveProfileModel> getSaveProfileData(
      String? filesPath, String? imageBytes) async {
    try {
      await config.getSetup(); final response = await http.post(
          Uri.parse('http://216.48.186.108:19979/api/SellerKit/savefile'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "files": [
              {
                "imageBytes": "$imageBytes",
                "filePath": "$filesPath${ConstantValues.slpcode}.png"
              }
            ]
          }));

      log(jsonEncode({
        "files": [
          {
            "filePath": "$filesPath${ConstantValues.slpcode}.png",
            "imageBytes": "$imageBytes",
          }
        ]
      }));
      if (response.statusCode == 200) {
        return SaveProfileModel.fromjson(response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return SaveProfileModel.issue("Error", resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return SaveProfileModel.issue(e.toString(), resCode);
    }
  }
}
