// import 'dart:convert';
// import 'dart:developer';
// import '../../Models/LoginModel/LoginModel.dart';
// import 'package:http/http.dart' as http;

// class LoginAPiOld {
//   static Future<LoginModel> getData(PostLoginData postLoginData) async {
//     int resCode = -1;
//     try {
//       final response = await http.post(
//         Uri.parse("http://216.48.186.108:19978/api/SellerKit/Auth"),// 164.52.214.147:47183
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//   "deviceCode":"39f4127ba2cfb165",//"${postLoginData.deviceCode}",
//   "ip": "100.168.1.2",
//   "userName": "${postLoginData.username}",
//   "passward": "${postLoginData.password}",
//   "licenseKey": "ab12EDw87e4"
//         })
//       );
//       log(jsonEncode({
        
//    "deviceCode":"${postLoginData.deviceCode}",
//   "ip": "100.168.1.2",
//   "userName": "${postLoginData.username}",
//   "passward": "${postLoginData.password}",
//   "licenseKey": "ab12EDw87e4"
        
//         }));
//       resCode = response.statusCode;
//       if (response.statusCode == 200) {

//         print(json.decode(response.body));
//         Map data = json.decode(response.body);
//         if(data["responce"]!= null){
//           print(data["responce"])
// ;   
// print( json.decode(data["responce"]));
//      }
//         return LoginModel.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: error");
//         return LoginModel.issue(resCode,"Something went wrong..!!");
//       }
//     } catch (e) {
//       //
//       print(e.toString());
//       return LoginModel.issue(resCode,"$e");
//     }
//   }


// }
