import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String sPLocale = "Locale";
//  static String sPLocale = "Locale";
  static String spStgIP = "SettingIP";
  static String spHost = "spHost";
  static String spDeviceID = "spDeviceID";
  static String spSiteCode = "spSiteCode";
  static String islogggedIN = "IslogggedIN";
  static String spUser = "spUser";
  static String splicense = "license";
  static String spuserId = "userId";
  static String branchSp = "branchSp";
  static String dayStart = "dayStart";

  static String isDatadownloaded = "isDatadownloaded";

  static Future<bool> saveDatadonld(bool isDatad) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isDatadownloaded, isDatad);
  }

  static Future<bool?> getDatadonld() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(isDatadownloaded);
  }

  static Future<bool> saveLocaleSP(String locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sPLocale, locale);
  }

  static Future<String?> getLocaleSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sPLocale);
  }

  static Future<bool> saveStngIPSP(String stngIP) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spStgIP, stngIP);
  }

  static Future<String?> getStngIPSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spStgIP);
  }
  // static Future<bool> saveLocaleSP(String locale) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.setString(sPLocale, locale);
  // }

  // static Future<String?> getLocaleSP() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.getString(sPLocale);
  // }

  static Future<bool> saveHostSP(String spHost1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spHost, spHost1);
  }

  static Future<String?> getHostDSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spHost);
  }

  static clearHost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spHost);
  }

  static Future<bool> saveDeviceIDSP(String spDeviceID1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spDeviceID, spDeviceID1);
  }

  static Future<String?> getDeviceIDSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spDeviceID);
  }

  static clearDeviceID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spDeviceID);
  }

  static Future<bool> saveSiteCodeSP(String spSiteCode1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spSiteCode, spSiteCode1);
  }

  static Future<String?> getSiteCodeSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spSiteCode);
  }

  static clearSiteCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spSiteCode);
  }

  static Future<bool> saveLoggedInSP(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(islogggedIN, isUserLoggedIn);
  }

  static Future<bool?> getLoggedINSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(islogggedIN);
  }

  static clearLoggedIN() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(islogggedIN);
  }

  static Future<bool> saveUserSP(String spUser1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spUser, spUser1);
  }

  static Future<String?> getUSerSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spUser);
  }

  static clearUserSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spUser);
  }

  static Future<bool> saveLicenseSP(String license1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(splicense, license1);
  }

  static Future<String?> getLicenseSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(splicense);
  }

  static clrLicenseSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(splicense);
  }

  static Future<bool> saveUserIdeSP(String UserId1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(spuserId, UserId1);
  }

  static Future<String?> getUserIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(spuserId);
  }

  static clrUserIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(spuserId);
  }

  static Future<bool> saveBranchSP(String branchSp1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(branchSp, branchSp1);
  }

  static Future<String?> getBranchSSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(branchSp);
  }

  static clrBranchSSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(branchSp);
  }

 static Future<bool> saveDayStart(String dayStart1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dayStart, dayStart1);
  }

  static Future<String?> getDayStart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(dayStart);
  }

  static clearDayStart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(dayStart);
  }
}
