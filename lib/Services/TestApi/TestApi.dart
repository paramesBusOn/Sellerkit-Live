import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/main.dart';

class TestApi {
  static Future<void> getData() async {
    int resCode = 500;
    try {
            Config config = Config();

      await config.getSetup(); 
      final response = await http.post(Uri.parse('http://rajan.vzone.in:7615/api/KP/TargetVsAchive'),
           headers: {
            "content-type": "application/json",
          },
          body: jsonEncode(
           {
  "finclYear": "FY19-20",
  "monthName": "October"
}
          ));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode == 200) {
      } else {
        print("Error: ${json.decode(response.body)}");
      }
    } catch (e) {
      print("Exception: " + e.toString());
    }
  }
}
