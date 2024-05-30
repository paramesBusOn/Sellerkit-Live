// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, unused_import, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors, prefer_if_null_operators

import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get_ip_address/get_ip_address.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sellerkit/Constant/AppConstant.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Encripted.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Constant/LocationTrackIos.dart';
import 'package:sellerkit/Constant/methodchannel.dart';
import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
import 'package:sellerkit/Services/URL/GetURLApi.dart';
import 'package:sellerkit/Widgets/Dialogbox.dart';
import 'package:sellerkit/main.dart';
// import 'package:share/share.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/LoginModel/LoginModel.dart';
import '../../Services/TestApi/TestApi.dart';
import '../../Services/URL/LocalUrl.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class LoginController extends ChangeNotifier {
  LoginController(BuildContext context) {
    check(context);
  }
  LocationPermission? permission;
  bool? locationbool = false;
  bool? TCbool = false;

  bool? camerabool = false;
  bool? notificationbool = false;
  check(BuildContext context) async {
    // await checkLocation();

    final permission = Permission.notification;
    PermissionStatus status = await permission.status;

    var locationStatus = await Permission.location.status;
    // var cameraStatus = await Permission.camera.status;
    // var notifiStatus = await Permission.notification.status;

    print('location' + locationStatus.toString());
    // print('cameraStatus' + cameraStatus.toString());
    // print('notifiStatus2' + notifiStatus.toString());

    if (locationStatus.isGranted) {
      locationbool = true;
      notifyListeners();
    }
    // if (cameraStatus.isGranted) {
    //   camerabool = true;
    //   notifyListeners();
    // }
    // if (notifiStatus.isGranted) {
    //   notificationbool = true;
    //   notifyListeners();
    // }
    // if (Platform.isIOS) {
    if (locationbool == false
        // ||
        //     camerabool == false ||
        //     notificationbool == false
        ) {
      LocationPermission permission;

      await showDialog<dynamic>(
          context: context,
          builder: (_) {
            return PermissionShowDialog(
              locationbool: locationbool,
              camerabool: camerabool,
              notificationbool: notificationbool,
            );
          }).then((value) async {
        await Geolocator.requestPermission().then((value) async {
          // permission = await Geolocator.checkPermission();
          // if (LocationPermission.always != value) {
          //  await Geolocator.requestPermission();
          // }
        });
      });
    }
    // }
    await getHost();
    notifyListeners();
  }

  Config config = new Config();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isLoading = false;
  bool erroMsgVisble = false;
  bool settingError = false;

  String errorMsh = '';
  static bool loginPageScrn = false;

  bool get getHidepassword => hidePassword;
  bool get getIsLoading => isLoading;
  bool get geterroMsgVisble => erroMsgVisble;
  bool get getsettingError => settingError;

  String get getErrorMshg => errorMsh;

  void obsecure() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  showLoginDialog(BuildContext context) {
    config.msgDialog(context, '', '');
  }

  Future<void> getUrlApi() async {
    String? Url = "";
    //Get Url Api
    print("get Url Api call:" + mycontroller[3].text.toString());
    await GetURLApi.getData(mycontroller[3].text.toString().trim())
        .then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.url != null) {
          Url = value.url;
          print("url method::" + Url.toString());
          await HelperFunctions.saveHostSP(Url!.trim());
          await HelperFunctions.saveTenetIDSharedPreference(
              mycontroller[3].text.toString().trim());
          setURL();
          errorMsh = "";
          erroMsgVisble = false;
          settingError = false;
          notifyListeners();
        } else {
          print("object1:" + value.exception.toString());
          erroMsgVisble = true;
          isLoading = false;
          errorMsh = value.exception.toString();
        }
      } else {
        print("object2:" + value.exception.toString());
        erroMsgVisble = true;
        isLoading = false;
        errorMsh = value.exception.toString();
      }
    });
    notifyListeners();
  }

  validateLogin(BuildContext context) async {
    // PermissionStatus locationStatus;

    //  locationStatus = await Permission.location.status;

    // if (locationStatus.isGranted) {
    // if(Platform.isIOS){
    //   print('testLogin');
    //   await checkLocation();
    //   await Future.delayed(Duration(seconds: 3));
    // }
    if (mycontroller[3].text.toString().trim().isEmpty) {
      errorMsh = "Complete the setup..!!";
    } else {
      if (formkey.currentState!.validate()) {
        disableKeyBoard(context);
        isLoading = true;
        //**** */
        //  await config.getSetup();

        //Get URL APi

        String? Url = "";
        //Get Url Api
        print("get Url Api call:" + mycontroller[3].text.toString());
        await GetURLApi.getData(mycontroller[3].text.toString().trim())
            .then((value) async {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            if (value.url != null) {
              Url = value.url;
              print("url method::" + Url.toString());
              await HelperFunctions.saveHostSP(Url!.trim());
              await HelperFunctions.saveTenetIDSharedPreference(
                  mycontroller[3].text.toString().trim());
              setURL();
              errorMsh = "";
              erroMsgVisble = false;
              settingError = false;
              notifyListeners();
            } else {
              print("object1:" + value.exception.toString());
              erroMsgVisble = true;
              isLoading = false;
              errorMsh = value.exception.toString();
            }
          } else {
            print("object2:" + value.exception.toString());
            erroMsgVisble = true;
            isLoading = false;
            errorMsh = value.exception.toString();
          }
        });

        //
        await getUrlApi();
        //**** */
        log("is is is ");
        notifyListeners();
        PostLoginData postLoginData = new PostLoginData();
        postLoginData.deviceCode =
            await HelperFunctions.getDeviceIDSharedPreference();
        postLoginData.licenseKey =
            await HelperFunctions.getLicenseKeySharedPreference();
        postLoginData.fcmToken =
            await HelperFunctions.getFCMTokenSharedPreference();
        // log("fcmmmm: "+postLoginData.fcmToken.toString());
        postLoginData.username = mycontroller[0].text;
        postLoginData.password = mycontroller[1].text;
        ConstantValues.tenetID =
            await HelperFunctions.getTenetIDSharedPreference();

        await LoginAPi.getData(postLoginData).then((value) async {
          if (value.resCode! >= 200 && value.resCode! <= 200) {
            if (value.loginstatus!.toLowerCase().contains('success') &&
                value.data != null) {
              DashBoardController.isLogout = false;
              isLoading = false;
              erroMsgVisble = false;
              errorMsh = '';
              ConstantValues.userNamePM = mycontroller[0].text;
              await HelperFunctions.saveUserName(mycontroller[0].text);
              await HelperFunctions.saveLicenseKeySharedPreference(
                  value.data!.licenseKey);
              await HelperFunctions.saveLogginUserCodeSharedPreference(
                  mycontroller[0].text);
              // await HelperFunctions.saveSapUrlSharedPreference(
              //     value.data!.endPointUrl);
              await HelperFunctions.saveTenetIDSharedPreference(
                  value.data!.tenantId);
              await HelperFunctions.saveUserIDSharedPreference(
                  value.data!.UserID);
              ConstantValues.UserId = value.data!.UserID;
              ConstantValues.Usercode = value.data!.userCode;
              ConstantValues.storeid =
                  int.parse(value.data!.storeid.toString());
              ConstantValues.Storecode = value.data!.storecode.toString();
              await HelperFunctions.saveUserLoggedInSharedPreference(true);
              await HelperFunctions.savePasswordSharedPreference(
                  mycontroller[1].text);

              log("message");
              // await HelperFunctions.saveuserDB(value.data!.userDB);
              await HelperFunctions.savedbUserName(value.data!.UserID);
              // await HelperFunctions.savedbPassword(value.data!.dbPassword);

              await HelperFunctions.saveUserType(value.data!.userType);
              await HelperFunctions.saveSlpCode(value.data!.slpcode);

              mycontroller[0].clear();
              mycontroller[1].clear();
              notifyListeners();
              Get.offAllNamed(ConstantRoutes.download);
            } else if (value.loginstatus!.toLowerCase().contains("failed") &&
                value.data == null) {
              isLoading = false;
              erroMsgVisble = true;
              errorMsh = value.loginMsg!;
              notifyListeners();
            }
          } else if (value.resCode! >= 400 && value.resCode! <= 410) {
            erroMsgVisble = true;

            isLoading = false;
            errorMsh = value.excep!;
            notifyListeners();
          } else {
            if (value.excep == 'No route to host') {
              isLoading = false;
              erroMsgVisble = true;
              errorMsh = 'Check your Internet Connection...!!';
            } else {
              isLoading = false;
              erroMsgVisble = true;
              errorMsh = '${value.resCode!}..!!Network Issue..\nTry again Later..!!';
            }
            notifyListeners();
          }
        });
        // Get.offAllNamed(ConstantRoutes.dashboard);
      }
    }
    // } else {
    //   await showDialog<dynamic>(
    //         context: context,
    //         builder: (_) {
    //           return PermissionShowDialog(
    //             locationbool: locationbool,
    //             camerabool: camerabool,
    //             notificationbool: notificationbool,
    //           );
    //         }).then((value) async {
    //             permission = await Geolocator.checkPermission();

    //     });
    // }
  }

  // showShare(String deviceID) {
  //   Share.share(
  //     'Dear Sir/Madam,\n  Kindly Register My Mobile For Sellerkit App,\n My Device ID : \n $deviceID \n Thanks & Regards',
  //   );
  // }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  // testApi()async{
  //  await TestApi.getData();
  // }
  setTermsAConditionsValue(bool? val) {
    print(val);

    TCbool = (TCbool! == true) ? false : val;
    notifyListeners();
  }

  getHost() async {
    mycontroller[2].clear();
    mycontroller[3].clear();
    TCbool = false;
    await HelperFunctions.clearHost();
    await HelperFunctions.clearCheckedTennetIDSharedPref();
    await HelperFunctions.clearhostIP();
//Existing Coding below
    // String? host = await HelperFunctions.getHostDSP();
    // String? tenet = await HelperFunctions.getTenetIDSharedPreference();

    // log("host ${host}");
    // if (host != null) {
    //   settingError = false;
    //   erroMsgVisble = false;
    //   mycontroller[2].text = host;
    //   mycontroller[3].text = tenet!;
    // }
    // if (host == null) {
    erroMsgVisble = true;
    settingError = true;
    errorMsh = "Complete the setup..!!";
    notifyListeners();
    // }
  }

  bool progrestext = false;
  void settingvalidate(BuildContext context) async {
   
    await checkLoc();
    // await  checkLocation();
    // await LocationTrack.determinePosition();
    notifyListeners();
    if (formkey2.currentState!.validate()) {
       progrestext = true;
      errorMsh = "";
      erroMsgVisble = false;
      settingError = false;
      // setURL();
      progrestext = false;
      notifyListeners();

      Navigator.pop(context);
    }
  }

  checkLoc() async {
    if (Platform.isAndroid) {
      await LocationTrack.determinePosition();
    } else {
      await LocationTrack2.determinePosition();
    } // await Future.delayed(Duration(seconds: 3));
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      log("result:::" + result.name.toString());
      // Got a new connectivity status!

      if (result.name == 'none') {
        ConstantValues.ipaddress = '';
        ConstantValues.ipname = '';
      } else if (result.name == 'mobile') {
        if (Platform.isAndroid) {
          final MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
          final String? name = await mobileNetworkInfo.getMobileNetworkName();

          // List<String>? wifiiInfo = await config.setNetwork();
          //
          var ipAddress = IpAddress(type: RequestType.text);
          String data = await ipAddress.getIpAddress();
          //
          ConstantValues.ipaddress = name == null ? 'null' : name;
          ConstantValues.ipname = data == null ? 'null' : data;
        } else if (Platform.isIOS) {
         List<String>? wifiiInfo = await config.getIosNetworkInfo();
        ConstantValues.ipaddress =  wifiiInfo[1];
        ConstantValues.ipname =  wifiiInfo[0];
        }
      } else if (result.name == 'wifi') {
         String? name= await Config.getipaddress();
        List<String>? wifiiInfo = await config.setNetwork();
        ConstantValues.ipaddress = name == null ? 'null' : name;
        ConstantValues.ipname = wifiiInfo[0];
      }
      print("LocationTrack.Lat2::" + LocationTrack.Lat.toString());
      print("LocationTrack.Long2::" + LocationTrack.Long.toString());
      print("ConstantValues.lat::" + ConstantValues.latitude.toString());
      print("ConstantValues.lang::" + ConstantValues.langtitude.toString());
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
      log("Encryped Location Header:::" + encryValue.toString());
      ConstantValues.EncryptedSetup = encryValue;
      log("ConstantValues.EncryptedSetup::" +
          ConstantValues.EncryptedSetup.toString());
      //  await config.getSetup();
    });

    // await LocationTrack.checkcamlocation();
  }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    String hostip = '';
    if (getUrl != null) {
      for (int i = 0; i < getUrl.length; i++) {
        if (getUrl[i] == ":") {
          break;
        }
        // log("for ${hostip}");
        hostip = hostip + getUrl[i];
      }
    }

    // log("for last ${hostip}");
    HelperFunctions.savehostIP(hostip);
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = "http://${getUrl.toString()}/api/";
  }

  Future<bool> checkloc() async {
    bool res = false;
    print('test1');
    res = await LocationTrack.checkPermission();

    return res;
  }
}
