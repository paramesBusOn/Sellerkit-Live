// ignore_for_file: empty_catches, unused_local_variable, unnecessary_new, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, avoid_print, prefer_const_constructors, sort_child_properties_last

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Encripted.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Constant/methodchannel.dart';
import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upgrader/upgrader.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Helper.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/AuthorizationDB.dart';
import '../../Models/LoginModel/LoginModel.dart';
import '../../Services/LoginApi/LoginApi.dart';
import '../../Services/URL/LocalUrl.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../Widgets/RestrictedPage.dart';

class ConfigurationContoller extends ChangeNotifier {
  Config config = Config();
  PostLoginData postLoginData = new PostLoginData();
  //fcm
  String token = '';
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> fetss() async {}

  // setURL() async {
  //          dynamic deviceID = await Config.getdeviceId();
  //          log("Device Id::"+deviceID);

  //   String? getUrl = await HelperFunctions.getHostDSP();
  //   ConstantValues.userNamePM = await HelperFunctions.getUserName();
  //   log("getUrl $getUrl");
  //   // log("userNamePM ${ConstantValues.userNamePM}");

  //   Url.queryApi = "http://$getUrl:81/api/";
  // }

  Future<void> checkPlatFrom() async {
    if (Platform.isAndroid) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } else if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

 Future<String?> getStoreVersion(String myAppBundleId) async {
    String? storeVersion;
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      Document? result2 =
          await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
      if (result2 != null) storeVersion = playStoreSearchAPI.version(result2);
      // log('PlayStore version: $storeVersion}');
      // } else if (Platform.isIOS) {
     
      // log('AppStore version: $storeVersion}');
    }else if(Platform.isIOS){
       ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result =
          await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
      if (result != null) storeVersion = iTunesSearchAPI.version(result);
    } else {
      storeVersion = null;
    }
    return storeVersion;
  }

  Future<void> showVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // log("packageInfo.version::" + packageInfo.version.toString());
    ConstantValues.appversion = packageInfo.version;
    // log("packageInfo.versionConstant::" + ConstantValues.appversion.toString());
    notifyListeners();
  }

  Future<String?> getToken() async {
    return await firebaseMessaging.getToken();
  }

  checkStartingPage(String? pageName, int? docEntry) async {
    //  print(await HelperFunctions.getOnBoardSharedPreference());
    //  await DBOperation.createDB();
    await HelperFunctions.getOnBoardSharedPreference().then((value) {});
    if (await HelperFunctions.getOnBoardSharedPreference() == true) {
      Get.offAllNamed(ConstantRoutes.splash);
    } else {
      Get.offAllNamed(ConstantRoutes.onBoard);
    }
  }

  double calculateDistance2(lat1, lon1, lat2, lon2) {
    print('process lat' + lat1.toString());
    print('process long' + lon1.toString());

    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742000 * asin(sqrt(a));
  }

Future<List<String>> getLocation(String restricdata) async {
  String split1 = restricdata;
  List<String>? clist = split1.split(",");

  return clist;
}
  checkLoginVerification() async {
    bool isuserfixed=false;
    final Database db = (await DBHelper.getInstance())!;
    // Timer.periodic(const Duration(minutes: 1), (timer) async {
      bool verifibool = false;

      String? getUrl = await HelperFunctions.getHostDSP();
      print("URL1:" + getUrl.toString());
      if (getUrl != null && getUrl != 'null' && getUrl != '') {
        List<Map<String, Object?>> VerificationDataDBData =
            await DBOperation.getLoginVerifiDBData(db);
        print("VerificationDataDBData bool:" +
            VerificationDataDBData.length.toString());
  //           if(VerificationDataDBData.isNotEmpty){
  //             for (int i = 0; i < VerificationDataDBData.length; i++) {
  //               if (VerificationDataDBData[i]['RestrictionType'].toString() ==
  //               '1'){
  //                 print("aaa"+VerificationDataDBData[i]['RestrictionType'].toString());
  //               }else if(VerificationDataDBData[i]['RestrictionType'].toString() ==
  //               '2'){
  // print("bbb"+VerificationDataDBData[i]['RestrictionType'].toString());
               
  //               }else{
                
  // print("ccc"+VerificationDataDBData[i]['RestrictionType'].toString());  
  //               }
  //             }
  //           }

//         if (VerificationDataDBData.isNotEmpty) {
//           for (int i = 0; i < VerificationDataDBData.length; i++) {
//             print("VerificationDataDBData[i]['RestrictionType'].toString()::"+VerificationDataDBData[i]['RestrictionType'].toString());
//             if (VerificationDataDBData[i]['RestrictionType'].toString() ==
//                 '1') {
//               if (VerificationDataDBData[i]['RestrictionData'].toString() ==
//                   ConstantValues.ipaddress) {
//                 verifibool = true;
//                 break;
//               }
//             }
//              else if (VerificationDataDBData[i]['RestrictionType'].toString() ==
//                 '2') {
//               if (Platform.isAndroid) {
//                 await LocationTrack.determinePosition();
//               } else {
//                 await LocationTrack2.determinePosition();
//               }
//               List<String>? locatoindetals = await getLocation(
//                   VerificationDataDBData[i]['RestrictionData'].toString());
//               String? lat = locatoindetals[0];
//               String? long = locatoindetals[1];
//               String? dis = locatoindetals[2];
//               double totaldis = calculateDistance2(
//                   double.parse(locatoindetals[0]),
//                   double.parse(locatoindetals[1]),
//                   double.parse(ConstantValues.latitude.toString()),
//                   double.parse(ConstantValues.langtitude.toString()));
//               print("Total Dis:" + totaldis.toString());
//               int apiDis = int.parse(locatoindetals[2].toString());
//               if (totaldis < apiDis.toDouble()) {
//                 verifibool = true;
//                 break;
//               }
//               //
//             }
//             else if (VerificationDataDBData[i]['RestrictionType'].toString() ==
//                 '3'){
//               String ipname = ConstantValues.ipname.replaceAll('"', '');
//               print("ipname:::"+ipname.toString());
//               if (VerificationDataDBData[i]['RestrictionData'].toString() ==
//                   ipname) {
//                 verifibool = true;
//                 isuserfixed=true;
//                 break;
//               }
//             }
//           }
// if(!isuserfixed){

// }
if (VerificationDataDBData.isNotEmpty) {
  bool anyConditionSatisfied = false; 

  for (int i = 0; i < VerificationDataDBData.length; i++) {
    print("VerificationDataDBData[i]['RestrictionType'].toString()::"+VerificationDataDBData[i]['RestrictionType'].toString());

    if (VerificationDataDBData[i]['RestrictionType'].toString() == '1') {
      if (VerificationDataDBData[i]['RestrictionData'].toString() == ConstantValues.ipaddress) {
        verifibool = true;
        anyConditionSatisfied = true; 
        break;
      }
    } else if (VerificationDataDBData[i]['RestrictionType'].toString() == '2') {
           if (Platform.isAndroid) {
                await LocationTrack.determinePosition();
              } else {
                await LocationTrack2.determinePosition();
              }
              List<String>? locatoindetals = await getLocation(
                  VerificationDataDBData[i]['RestrictionData'].toString());
              String? lat = locatoindetals[0];
              String? long = locatoindetals[1];
              String? dis = locatoindetals[2];
              double totaldis = calculateDistance2(
                  double.parse(locatoindetals[0]),
                  double.parse(locatoindetals[1]),
                  double.parse(ConstantValues.latitude.toString()),
                  double.parse(ConstantValues.langtitude.toString()));
              print("Total Dis:" + totaldis.toString());
              int apiDis = int.parse(locatoindetals[2].toString());
              if (totaldis < apiDis.toDouble()) {
              verifibool = true;
      anyConditionSatisfied = true;
      break;
              }

     
    } else if (VerificationDataDBData[i]['RestrictionType'].toString() == '3') {
       String ipname = ConstantValues.ipname.replaceAll('"', '');
      print("ConstantValues.  ipname::"+ipname+"ddddipname"+VerificationDataDBData[i]['RestrictionData'].toString());
           if (VerificationDataDBData[i]['RestrictionData'].toString() == ipname.toString()) {
                verifibool = true;
      anyConditionSatisfied = true; 
      break;
              }

    
    }
  }

  if (!anyConditionSatisfied) { 
    Get.offAllNamed(ConstantRoutes.restrictionValue);
  } else {
    // if (RestrictionPageState.loginbool == true) {
      Get.offAllNamed(ConstantRoutes.download);
    // }else{
    //    Get.offAllNamed(ConstantRoutes.login);
    // }
  }
}
          // if (verifibool == false) {
          //   // await HelperFunctions.clearHost();
          //   // await DBOperation.truncateLoginVerficationDB(db);

          //   Get.offAllNamed(ConstantRoutes.restrictionValue);
          // } else {
          //   if (RestrictionPageState.loginbool == true) {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          //   }
          // }
        // }
      }
      print("verifi bool:" + verifibool.toString());
    // });
  }
String geturlview='';
String deviceIDview='';
String licenseKeyview='';
String userCodeview='';
String passswordview='';
String tokenview='';
String isLoggedInview='';
String modelview='';
String brandview='';
  Future<void> checkBeforeLoginApi(BuildContext context) async {
    // await setURL();
    await checkPlatFrom();
// await HelperFunctions.clearCheckedDeviceIDSharedPref();
// String? ipaddress = await Config.getipaddress();
    String? getUrl = await HelperFunctions.getHostDSP();
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    // log("getUrl $getUrl");
    // log("userNamePM ${ConstantValues.userNamePM}");
// Url.queryApi = 'http://91.203.133.224:81/api/';
    Url.queryApi = 'http://${getUrl.toString()}/api/';
    geturlview=getUrl.toString();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    deviceIDview=deviceID.toString();
    String? licenseKey = await HelperFunctions.getLicenseKeySharedPreference();
    licenseKeyview=licenseKey.toString();
    String? userCode =
        await HelperFunctions.getLogginUserCodeSharedPreference();
        userCodeview=userCode.toString();
    String? passsword = await HelperFunctions.getPasswordSharedPreference();
    passswordview=passsword.toString();
    ConstantValues.tenetID =
        (await HelperFunctions.getTenetIDSharedPreference()).toString();
        

    bool? isLoggedIn = await HelperFunctions.getUserLoggedInSharedPreference();
    isLoggedInview=isLoggedIn.toString();
    token = (await getToken())!;
    tokenview=token;
    print("FCM Token: $deviceID");
    await HelperFunctions.saveFCMTokenSharedPreference(token);
    // log("licenseKey:::" + deviceID.toString());
    //  String? fcmToken = await HelperFunctions.getFCMTokenSharedPreference();
    //   log("Token:::" + fcmToken.toString());
    postLoginData.deviceCode = deviceID;
    postLoginData.licenseKey = licenseKey;
    postLoginData.username = userCode;
    postLoginData.fcmToken = token;
    postLoginData.password = passsword;
    String? model=await  Config.getdeviceModel() ;
    String? brand=await  Config.getdeviceBrand() ;
    modelview=model.toString();
    brandview=brand.toString();
postLoginData. devicename='${brand} ${model}';
    // print("isLoggedIn111: "+isLoggedIn.toString());
    if (deviceID == null) {
      // if (Platform.isAndroid) {
      // deviceID = await PlatformDeviceId.getDeviceId;
      deviceID = await Config.getdeviceId();
      print("deviceID"+deviceID.toString());
      // } else if (Platform.isIOS) {
      // deviceID = await PlatformDeviceId.getDeviceId;
      // }
   await   HelperFunctions.saveDeviceIDSharedPreference(deviceID!);

      checkLicenseKey(getUrl, isLoggedIn);
    } else {
      checkLicenseKey(getUrl, isLoggedIn);
    }
  }

  checkLicenseKey(String? URL, bool? isLoggedIn) async {
    print("URL: " + URL.toString());
    if (URL == null) {
      //&& licenseKey == null
      Get.offAllNamed(ConstantRoutes.login);
    } else if (URL != null) {
      //&& licenseKey != null
      // log("already login");
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        isLoading = false;
        exceptionOnApiCall = 'Please Check Internet Connection..!!';
      } else {
        callLoginApi();
      }
      // await config.getSetup();
    }
  }

  checkLoc() async {
    if (Platform.isAndroid) {
      await LocationTrack.determinePosition();
    } else {
      await LocationTrack2.determinePosition();
    }
    // await LocationTrack.determinePosition();
    await Future.delayed(Duration(seconds: 3));
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // log("result:::" + result.name.toString());
      // Got a new connectivity status!

      if (result.name == 'none') {
        ConstantValues.ipaddress = '';
        ConstantValues.ipname = '';
      } else if (result.name == 'mobile') {
        if (Platform.isAndroid) {
          final MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
          final String? name = await Config.getipaddress();

          // List<String>? wifiiInfo = await config.setNetwork();
          //
          final String? data = await mobileNetworkInfo.getMobileNetworkName();
          //
          ConstantValues.ipaddress = name == null ? 'null' : name;
          ConstantValues.ipname = data == null ? 'null' : data;
        } else if (Platform.isIOS) {
          List<String>? wifiiInfo = await config.getIosNetworkInfo();
          ConstantValues.ipaddress = wifiiInfo[1];
          ConstantValues.ipname = wifiiInfo[0];
        }
      } else if (result.name == 'wifi') {
        String? name= await Config.getipaddress();
        List<String>? wifiiInfo = await config.setNetwork();
        ConstantValues.ipaddress = name == null ? 'null' : name;
        ConstantValues.ipname = wifiiInfo[0];
      }
      // print("LocationTrack.Lat::" + LocationTrack.Lat.toString());
      // print("LocationTrack.Long::" + LocationTrack.Long.toString());
      // print("ConstantValues.lat::" + ConstantValues.latitude.toString());
      // print("ConstantValues.lang::" + ConstantValues.langtitude.toString());
      ConstantValues.latitude = LocationTrack.Lat.isEmpty
          ? "${ConstantValues.latitude}"
          : '${LocationTrack.Lat}';
      ConstantValues.langtitude = LocationTrack.Long.isEmpty
          ? "${ConstantValues.langtitude}"
          : '${LocationTrack.Long}';
      //
      if (ConstantValues.langtitude!.isEmpty ||
          ConstantValues.langtitude == '') {
        ConstantValues.langtitude = '0.000';
      }
      if (ConstantValues.latitude!.isEmpty || ConstantValues.latitude == '') {
        ConstantValues.latitude = '0.000';
      }
      ConstantValues.headerSetup =
          "${ConstantValues.latitude};${ConstantValues.langtitude};${ConstantValues.ipname};${ConstantValues.ipaddress}";
      //
      print("Location Header::" + ConstantValues.headerSetup.toString());
      EncryptData enc = new EncryptData();
      String? encryValue = enc.encryptAES("${ConstantValues.headerSetup}");
      // log("Encryped Location Header:::" + encryValue.toString());
      ConstantValues.EncryptedSetup = encryValue;
      // log("ConstantValues.EncryptedSetup::" +
      //     ConstantValues.EncryptedSetup.toString());
      //  await config.getSetup();
    });

    // await LocationTrack.checkcamlocation();
  }

  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  bool isLoading = true;
  bool get getisLoading => isLoading;

  callLoginApi([String? pageName, int? docEntry]) async {
    await checkLoc();
    
    await LoginAPi.getData(postLoginData).then((value) async {
      
      if (value.resCode! >= 200 && value.resCode! <= 210) {
        if (value.loginstatus!.toLowerCase().contains('success') &&
            value.data != null) {
               final Database db = (await DBHelper.getInstance())!;
               await HelperFunctions.saveTokenSharedPreference(value.token!);
          await DBOperation.truncateLoginVerficationDB(db);
          DashBoardController.isLogout = false;
          await HelperFunctions.saveLicenseKeySharedPreference(
              value.data!.licenseKey);
          // await HelperFunctions.saveSapUrlSharedPreference(
          //     value.data!.endPointUrl);
          await HelperFunctions.saveTenetIDSharedPreference(
              value.data!.tenantId);
          await HelperFunctions.saveUserIDSharedPreference(value.data!.UserID);
          ConstantValues.UserId = value.data!.UserID;
          ConstantValues.Usercode = value.data!.userCode;
          ConstantValues.storeid = int.parse(value.data!.storeid.toString());
          ConstantValues.Storecode = value.data!.storecode.toString();
          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.getFSTNameSharedPreference().then((value) {
            if (value != null) {
              ConstantValues.firstName = value;

              notifyListeners();
            }
          });

          // await HelperFunctions.saveuserDB(value.data!.userDB);
          await HelperFunctions.savedbUserName(value.data!.UserID);
          //   await HelperFunctions.savedbPassword(value.data!.dbPassword);

          await HelperFunctions.saveUserType(value.data!.userType);
          await HelperFunctions.saveSlpCode(value.data!.slpcode);
         

          List<LoginVerificationList>? loginVerifiList2 = [];
          List<VerificationData> values = []; //DB VAriable
          loginVerifiList2 = value.loginVerifiList; 
          // print("loginVerifiList2::"+loginVerifiList2!.length.toString());
          //Api data
          //
          
          if(loginVerifiList2 !=null &&  loginVerifiList2!.isNotEmpty){
for (int i = 0; i < loginVerifiList2!.length; i++) {
            values.add(VerificationData(
                id: loginVerifiList2[i].id,
                code: loginVerifiList2[i].code,
                restrictionData: loginVerifiList2[i].restrictionData,
                restrictionType: loginVerifiList2[i].restrictionType,
                remarks: loginVerifiList2[i].remarks));
          }
           
          
          }
          
         await DBOperation.insertLoginVerifiDetails(values, db);
         if(loginVerifiList2 !=null &&  loginVerifiList2!.isNotEmpty){
await checkLoginVerification();
         
         }
         else{
 Get.offAllNamed(ConstantRoutes.download);
          }
         
        } else if (value.loginstatus!.toLowerCase().contains("failed") &&
            value.data == null) {
          isLoading = false;
          exceptionOnApiCall = value.loginMsg!;
          notifyListeners();
        }
      } else if (value.resCode! >= 400 && value.resCode! <= 410) {
        isLoading = false;
        exceptionOnApiCall = value.excep!;
        notifyListeners();
      } else {
        print("value.excep:::"+value.excep.toString());
        if (value.excep == 'No route to host') {
          isLoading = false;
          isLoading = false;
          exceptionOnApiCall = "Check your internet connectivity..!!";
        } 
        
        else {
          isLoading = false;
          isLoading = false;
          exceptionOnApiCall =
              "${value.resCode!}..!!Network Issue..\nTry again Later..!!";
        }
        notifyListeners();
      }
    });
  }
  //
}

//  checkStartingPage()async{
//   //  print(await HelperFunctions.getOnBoardSharedPreference());
//   //  print(await HelperFunctions.getUserLoggedInSharedPreference());
//     if( await HelperFunctions.getOnBoardSharedPreference()==true &&
//      await HelperFunctions.getUserLoggedInSharedPreference()== true &&
//  (await HelperFunctions.getDownloadedSharedPreference()== null ||
//  await HelperFunctions.getDownloadedSharedPreference()== false)
//      ){

//       Get.offAllNamed(ConstantRoutes.download);
//     }
//     else if(await HelperFunctions.getOnBoardSharedPreference()==true &&
//       await HelperFunctions.getUserLoggedInSharedPreference()== true &&
//     await HelperFunctions.getDownloadedSharedPreference()== true ){
//       Get.offAllNamed(ConstantRoutes.dashboard);
//     }
//     else if(await HelperFunctions.getOnBoardSharedPreference()==true &&
//     (await HelperFunctions.getUserLoggedInSharedPreference()== null ||
//     await HelperFunctions.getUserLoggedInSharedPreference()== false) ){
//       Get.offAllNamed(ConstantRoutes.login);
//     }else {
//        Get.offAllNamed(ConstantRoutes.onBoard);
//     }
//   }
