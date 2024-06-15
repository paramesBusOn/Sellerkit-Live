// // ignore_for_file: empty_catches, unused_local_variable, unnecessary_new, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, avoid_print, prefer_const_constructors, sort_child_properties_last

// import 'dart:developer';
// import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:html/dom.dart';
// import 'package:get_ip_address/get_ip_address.dart';
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Constant/Encripted.dart';
// import 'package:sellerkit/Constant/LocationTrack.dart';
// import 'package:sellerkit/Constant/LocationTrackIos.dart';
// import 'package:sellerkit/Constant/methodchannel.dart';
// import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
// import 'package:upgrader/upgrader.dart';
// import '../../Constant/ConstantRoutes.dart';
// import '../../Constant/ConstantSapValues.dart';
// import '../../Constant/Helper.dart';
// import '../../Models/LoginModel/LoginModel.dart';
// import '../../Services/LoginApi/LoginApi.dart';
// import '../../Services/URL/LocalUrl.dart';

// import 'package:package_info_plus/package_info_plus.dart';

// class ConfigurationContoller extends ChangeNotifier {
//   Config config = Config();
//   PostLoginData postLoginData = new PostLoginData();
//   //fcm
//   String token = '';
//   final firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> fetss() async {}

//   // setURL() async {
//   //          dynamic deviceID = await Config.getdeviceId();
//   //          log("Device Id::"+deviceID);

//   //   String? getUrl = await HelperFunctions.getHostDSP();
//   //   ConstantValues.userNamePM = await HelperFunctions.getUserName();
//   //   log("getUrl $getUrl");
//   //   // log("userNamePM ${ConstantValues.userNamePM}");

//   //   Url.queryApi = "http://$getUrl:81/api/";
//   // }

//   Future<void> checkPlatFrom() async {
//     if (Platform.isAndroid) {
//       FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     } else if (Platform.isIOS) {
//       FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//   }
//   Future<String?> getStoreVersion(String myAppBundleId) async {
//       String? storeVersion;
//       if (Platform.isAndroid) {
//         PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
//         Document? result =
//             await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
//         if (result != null) storeVersion = playStoreSearchAPI.version(result);
//         log('PlayStore version: $storeVersion}');
//       } else if (Platform.isIOS) {
//         ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
//         Map<dynamic, dynamic>? result =
//             await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
//         if (result != null) storeVersion = iTunesSearchAPI.version(result);
//         log('AppStore version: $storeVersion}');
//       } else {
//         storeVersion = null;
//       }
//       return storeVersion;
//     }

//   Future<void> showVersion() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     log("packageInfo.version::" + packageInfo.version.toString());
//     ConstantValues.appversion = packageInfo.version;
//     log("packageInfo.versionConstant::" + ConstantValues.appversion.toString());
//     notifyListeners();
//   }

//   Future<String?> getToken() async {
//     return await firebaseMessaging.getToken();
//   }

//   checkStartingPage(String? pageName, int? docEntry) async {
//     //  print(await HelperFunctions.getOnBoardSharedPreference());
//     //  await DBOperation.createDB();
//     await HelperFunctions.getOnBoardSharedPreference().then((value) {});
//     if (await HelperFunctions.getOnBoardSharedPreference() == true) {
//       Get.offAllNamed(ConstantRoutes.splash);
//     } else {
//       Get.offAllNamed(ConstantRoutes.onBoard);
//     }
//   }

//   Future<void> checkBeforeLoginApi(BuildContext context) async {
//     // await setURL();
//     await checkPlatFrom();

//     String? getUrl = await HelperFunctions.getHostDSP();
//     ConstantValues.userNamePM = await HelperFunctions.getUserName();
//     log("getUrl $getUrl");
//     // log("userNamePM ${ConstantValues.userNamePM}");
// // Url.queryApi = 'http://91.203.133.224:81/api/';
//     Url.queryApi = 'http://${getUrl.toString()}/api/';
//     String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
//     String? licenseKey = await HelperFunctions.getLicenseKeySharedPreference();
//     String? userCode =
//         await HelperFunctions.getLogginUserCodeSharedPreference();
//     String? passsword = await HelperFunctions.getPasswordSharedPreference();
//     ConstantValues.tenetID =
//         (await HelperFunctions.getTenetIDSharedPreference()).toString();

//     bool? isLoggedIn = await HelperFunctions.getUserLoggedInSharedPreference();
//     token = (await getToken())!;
//     log("FCM Token: $token");
//     await HelperFunctions.saveFCMTokenSharedPreference(token);
//     log("licenseKey:::" + deviceID.toString());
//     //  String? fcmToken = await HelperFunctions.getFCMTokenSharedPreference();
//     //   log("Token:::" + fcmToken.toString());
//     postLoginData.deviceCode = deviceID;
//     postLoginData.licenseKey = licenseKey;
//     postLoginData.username = userCode;
//     postLoginData.fcmToken = token;
//     postLoginData.password = passsword;
//     String? model=await  Config.getdeviceModel() ;
//     String? brand=await  Config.getdeviceBrand() ;
// postLoginData. devicename='${brand} ${model}';
//     // print("isLoggedIn111: "+isLoggedIn.toString());
//     if (deviceID == null) {
//       // if (Platform.isAndroid) {
//       // deviceID = await PlatformDeviceId.getDeviceId;
//       deviceID = await Config.getdeviceId();
//       // } else if (Platform.isIOS) {
//       // deviceID = await PlatformDeviceId.getDeviceId;
//       // }
//       HelperFunctions.saveDeviceIDSharedPreference(deviceID!);

//       checkLicenseKey(getUrl, isLoggedIn);
//     } else {
//       checkLicenseKey(getUrl, isLoggedIn);
//     }
//   }

//   checkLicenseKey(String? URL, bool? isLoggedIn) async {
//     print("URL: " + URL.toString());
//     if (URL == null) {
//       //&& licenseKey == null
//       Get.offAllNamed(ConstantRoutes.login);
//     } else if (URL != null) {
//       //&& licenseKey != null
//       log("already login");
//       var connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult == ConnectivityResult.none) {
//         isLoading = false;
//         exceptionOnApiCall = 'Please Check Internet Connection..!!';
//       } else {
//         callLoginApi();
//       }
//       // await config.getSetup();
//     }
//   }

//   checkLoc() async {
//     if (Platform.isAndroid) {
//       await LocationTrack.determinePosition();
//     } else {
//       await LocationTrack2.determinePosition();
//     }
//     // await LocationTrack.determinePosition();
//     await Future.delayed(Duration(seconds: 3));
//     Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) async {
//       log("result:::" + result.name.toString());
//       // Got a new connectivity status!

//       if (result.name == 'none') {
//         ConstantValues.ipaddress = '';
//         ConstantValues.ipname = '';
//       } else if (result.name == 'mobile') {
//         if (Platform.isAndroid) {
//           final MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
//           final String? name = await Config.getipaddress();

//           // List<String>? wifiiInfo = await config.setNetwork();
//           //
//           // var ipAddress = IpAddress(type: RequestType.text);
//           // String data = await ipAddress.getIpAddress();
//            final String? data = await mobileNetworkInfo.getMobileNetworkName();
//           //
//           ConstantValues.ipaddress = name == null ? 'null' : name;
//           ConstantValues.ipname = data == null ? 'null' : data;
//         } else if (Platform.isIOS) {
//            List<String>? wifiiInfo = await config.getIosNetworkInfo();
//         ConstantValues.ipaddress =  wifiiInfo[1];
//         ConstantValues.ipname =  wifiiInfo[0];
//         }
//       } else if (result.name == 'wifi') {

//         String? name= await Config.getipaddress();
//         List<String>? wifiiInfo = await config.setNetwork();
//         ConstantValues.ipaddress = name == null ? 'null' : name;
//         ConstantValues.ipname = wifiiInfo[0];
//       }
//       // print("LocationTrack.Lat::" + LocationTrack.Lat.toString());
//       // print("LocationTrack.Long::" + LocationTrack.Long.toString());
//       // print("ConstantValues.lat::" + ConstantValues.latitude.toString());
//       // print("ConstantValues.lang::" + ConstantValues.langtitude.toString());
//       ConstantValues.latitude = LocationTrack.Lat.isEmpty
//           ? "${ConstantValues.latitude}"
//           : '${LocationTrack.Lat}';
//       ConstantValues.langtitude = LocationTrack.Long.isEmpty
//           ? "${ConstantValues.langtitude}"
//           : '${LocationTrack.Long}';
//       //
//       if (ConstantValues.langtitude!.isEmpty ||
//           ConstantValues.langtitude == '') {
//         ConstantValues.langtitude = '0.000';
//       }
//       if (ConstantValues.latitude!.isEmpty || ConstantValues.latitude == '') {
//         ConstantValues.latitude = '0.000';
//       }
//       ConstantValues.headerSetup =
//           "${ConstantValues.latitude};${ConstantValues.langtitude};${ConstantValues.ipname};${ConstantValues.ipaddress}";
//       //
//       print("Location Header::" + ConstantValues.headerSetup.toString());
//       EncryptData enc = new EncryptData();
//       String? encryValue = enc.encryptAES("${ConstantValues.headerSetup}");
//       log("Encryped Location Header:::" + encryValue.toString());
//       ConstantValues.EncryptedSetup = encryValue;
//       log("ConstantValues.EncryptedSetup::" +
//           ConstantValues.EncryptedSetup.toString());
//       //  await config.getSetup();
//     });

//     // await LocationTrack.checkcamlocation();
//   }

//   String exceptionOnApiCall = '';
//   String get getexceptionOnApiCall => exceptionOnApiCall;
//   bool isLoading = true;
//   bool get getisLoading => isLoading;

//   callLoginApi([String? pageName, int? docEntry]) async {
//     await checkLoc();

//     await LoginAPi.getData(postLoginData).then((value) async {
//       if (value.resCode! >= 200 && value.resCode! <= 210) {
//         if (value.loginstatus!.toLowerCase().contains('success') &&
//             value.data != null) {
//           DashBoardController.isLogout = false;
//           await HelperFunctions.saveLicenseKeySharedPreference(
//               value.data!.licenseKey);
//           // await HelperFunctions.saveSapUrlSharedPreference(
//           //     value.data!.endPointUrl);
//           await HelperFunctions.saveTenetIDSharedPreference(
//               value.data!.tenantId);
//               // await HelperFunctions.saveTokenSharedPreference(value!);
//           await HelperFunctions.saveUserIDSharedPreference(value.data!.UserID);
//           ConstantValues.UserId = value.data!.UserID;
//           ConstantValues.Usercode = value.data!.userCode;
//           ConstantValues.storeid = int.parse(value.data!.storeid.toString());
//           ConstantValues.Storecode = value.data!.storecode.toString();
//           await HelperFunctions.saveUserLoggedInSharedPreference(true);
//           await HelperFunctions.getFSTNameSharedPreference().then((value) {
//             if (value != null) {
//               ConstantValues.firstName = value;

//               notifyListeners();
//             }
//           });

//           // await HelperFunctions.saveuserDB(value.data!.userDB);
//           await HelperFunctions.savedbUserName(value.data!.UserID);
//           //   await HelperFunctions.savedbPassword(value.data!.dbPassword);

//           await HelperFunctions.saveUserType(value.data!.userType);
//           await HelperFunctions.saveSlpCode(value.data!.slpcode);

//           Get.offAllNamed(ConstantRoutes.download);
//         } else if (value.loginstatus!.toLowerCase().contains("failed") &&
//             value.data == null) {
//           isLoading = false;
//           exceptionOnApiCall = value.loginMsg!;
//           notifyListeners();
//         }
//       } else if (value.resCode! >= 400 && value.resCode! <= 410) {
//         isLoading = false;
//         exceptionOnApiCall = value.excep!;
//         notifyListeners();
//       } else {
//         if (value.excep == 'No route to host') {
//           isLoading = false;
//           isLoading = false;
//           exceptionOnApiCall = "Check your internet connectivity..!!";
//         } else {
//           isLoading = false;
//           isLoading = false;
//           exceptionOnApiCall = "${value.resCode!}..!!Network Issue..\nTry again Later..!!";
//         }
//         notifyListeners();
//       }
//     });
//   }
//   //
// }

// //  checkStartingPage()async{
// //   //  print(await HelperFunctions.getOnBoardSharedPreference());
// //   //  print(await HelperFunctions.getUserLoggedInSharedPreference());
// //     if( await HelperFunctions.getOnBoardSharedPreference()==true &&
// //      await HelperFunctions.getUserLoggedInSharedPreference()== true &&
// //  (await HelperFunctions.getDownloadedSharedPreference()== null ||
// //  await HelperFunctions.getDownloadedSharedPreference()== false)
// //      ){

// //       Get.offAllNamed(ConstantRoutes.download);
// //     }
// //     else if(await HelperFunctions.getOnBoardSharedPreference()==true &&
// //       await HelperFunctions.getUserLoggedInSharedPreference()== true &&
// //     await HelperFunctions.getDownloadedSharedPreference()== true ){
// //       Get.offAllNamed(ConstantRoutes.dashboard);
// //     }
// //     else if(await HelperFunctions.getOnBoardSharedPreference()==true &&
// //     (await HelperFunctions.getUserLoggedInSharedPreference()== null ||
// //     await HelperFunctions.getUserLoggedInSharedPreference()== false) ){
// //       Get.offAllNamed(ConstantRoutes.login);
// //     }else {
// //        Get.offAllNamed(ConstantRoutes.onBoard);
// //     }
// //   }
