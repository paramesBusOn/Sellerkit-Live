import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserCheckedOnBoard = "OnBoard";
  static String sharedPreferenceDeviceID = "DeviceID";
  static String sharedPreferenceSapURl = "SapURl";
  static String sharedPreferenceSapUserID = "SapUserID";
  static String sharedPreferenceTenetID = "TenetID";
  static String sharedPreferenceDownloaded = "Downloaded";
  static String sharedPreferencePaassword = "Password";
  static String sharedPreferenceIPaddress = "IpAddress";
  static String sharedPreferenceIpName = "IPName";
  static String sharedPreferenceLatitude = "Latitude";
  static String sharedPreferenceLangtitude= "Langtitude";
 //
  static String sharedPrefPermiLocation= "location";
  static String sharedPrefPermiCamera= "camera";
  static String sharedPrefPermiWifi= "wifi";

// for login
  static Future<bool> savePasswordSharedPreference(String deviceID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencePaassword, deviceID);
  }

  static Future<String?> getPasswordSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencePaassword);
  }

//IpAddress
static Future<bool> saveIpAddressSharedPreference(String ipAdd) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceIPaddress, ipAdd);
  }

  static Future<String?> getIpAddressSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceIPaddress);
    }

//Ip NAme
static Future<bool> saveIpNameSharedPreference(String ipName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceIpName, ipName);
  }

  static Future<String?> getIpNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceIpName);
    }

//Latitude
static Future<bool> saveLatitudeSharedPreference(String Latitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceIpName, Latitude);
  }

  static Future<String?> getLatitudeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLatitude);
    }
    
//Langtittude
static Future<bool> saveLangtitudeSharedPreference(String Langtitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLangtitude, Langtitude);
  }

  static Future<String?> getLangtitudeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLangtitude);
    }

  //New Above
  static String sharedPreferenceLisenceKey = "LicenseKey";
  static String sharedPreferenceLogginUserCode = "Usercode";

  // saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveOnBoardSharedPreference(bool userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserCheckedOnBoard, userName);
  }

  //location
static Future<bool> saveLocationSharedPref(String location) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefPermiLocation, location);
  }
  //camera
static Future<bool> savecameraSharedPref(String camera) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefPermiCamera, camera);
  }
  //Wifi
static Future<bool> saveWifiSharedPref(String wifi) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPrefPermiWifi, wifi);
  }

  static Future<bool> saveDeviceIDSharedPreference(String deviceID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceDeviceID, deviceID);
  }

  static Future<bool> saveSapUrlSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceSapURl, userEmail);
  }

  static Future<bool> saveTenetIDSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceTenetID, userEmail);
  }
  
  static clearCheckedTennetIDSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceTenetID);
  }

  static Future<bool> saveUserIDSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceSapUserID, userEmail);
  }

  static Future<bool> saveDonloadednSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceDownloaded, isUserLoggedIn);
  }

  // fetching data from sharedpreference
  static Future<bool?> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<bool?> getDownloadedSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceDownloaded);
  }

  static Future<bool?> getOnBoardSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserCheckedOnBoard);
  }

    static Future<String?> getLocationSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPrefPermiLocation);
    }
 
    static Future<String?> getCameraSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPrefPermiCamera);
    }

    static Future<String?> getWifiSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPrefPermiWifi);
    }
  static Future<String?> getDeviceIDSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceDeviceID);
  }

  static Future<String?> getSapUserIDSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceSapUserID);
  }

  static Future<String?> getSapURLSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceSapURl);
  }

  static Future<String?> getTenetIDSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceTenetID);
  }

  //SAVE LICENSE KEY

  static Future<bool> saveLicenseKeySharedPreference(String licenseKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLisenceKey, licenseKey);
  }

  static Future<String?> getLicenseKeySharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLisenceKey);
  }

  static Future<bool> saveLogginUserCodeSharedPreference(
      String loggedInUsercode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceLogginUserCode, loggedInUsercode);
  }

  static Future<String?> getLogginUserCodeSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLogginUserCode);
  }

  //CLEAR DATA FROM SHAREDPREFERENCE

  static clearUserLoggedInSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceUserLoggedInKey);
  }

  static clearCheckedOnBoardSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceUserCheckedOnBoard);
  }

  static clearCheckedDeviceIDSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceDeviceID);
  }

  static clearLicenseKeyDSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceLisenceKey);
  }

  static clearUserCodeDSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(sharedPreferenceLogginUserCode);
  }

  //for profile

  static String sharedPreferenceFirstName = "FirstName";
  static String sharedPreferenceLastName = "LastName";
  static String sharedPreferenceUSERID = "USERID";
  static String sharedPreferenceBranch = "Branch";
  static String sharedPreferenceLastemail = "email";
  static String sharedPreferenceLastmobile = "mobile";
  static String sharedPreferenceLastProfilePic = "ProfilePic";
  static String sharedPreferencemanagerphonenum = "ManagerPhone";

  static String sharedPreferenceFCMToken = "FCMToken";

  static Future<bool> saveProfilePicSharedPreference(String ProfilePic) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferenceLastProfilePic, ProfilePic);
  }

  static Future<String?> getmProfilePicSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLastProfilePic);
  }

  static Future<bool> savemobileSharedPreference(String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLastmobile, mobile);
  }

  static Future<String?> getmobileSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLastmobile);
  }

  static Future<bool> saveemailSharedPreference(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLastemail, email);
  }

  static Future<String?> getemailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLastemail);
  }

  static Future<bool> saveBranchSharedPreference(String Branch) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceBranch, Branch);
  }

  static Future<String?> getBranchSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceBranch);
  }

  static Future<bool> saveUSERIDSharedPreference(int USERID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedPreferenceUSERID, USERID);
  }

  static Future<String?> getUSERIDSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUSERID);
  }

  static Future<bool> saveLSTNameSharedPreference(String lastname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceLastName, lastname);
  }

  static Future<String?> getLSTNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceLastName);
  }

  static Future<bool> saveFSTNameSharedPreference(String firstname) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceFirstName, firstname);
  }

  static Future<String?> getFSTNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceFirstName);
  }

  static Future<bool> saveManagerPhoneSharedPreference(
      String managernum) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferencemanagerphonenum, managernum);
  }

  static Future<String?> getManagerPhoneSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferencemanagerphonenum);
  }

  static Future<bool> saveFCMTokenSharedPreference(String fcmToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceFCMToken, fcmToken);
  }

  static Future<String?> getFCMTokenSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceFCMToken);
  }

  // config

  static String spHost = "spHost";

  static Future<bool> saveHostSP(String spHost1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.reload();

    return await preferences.setString(spHost, spHost1);
  }

  static Future<String?> getHostDSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.reload();

    return await preferences.getString(spHost);
  }

  static clearHost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.reload();
   await preferences.remove(spHost);
  }

  static String userName = "UserName";

  static Future<bool> saveUserName(String userName1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userName, userName1);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(userName);
  }

  static clearUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(userName);
  }

  //

  static String hostip = "IP";
  static String userDB = "userDB";
  static String dbUserName = "dbUserName";
  static String dbPassword = "dbPassword";
  static String userType = "userType";
  static String slpCode = "slpCode";

  static Future<bool> saveuserDB(String userDB1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userDB, userDB1);
  }

  static Future<String?> getuserDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(userDB);
  }

  static clearuserDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(userDB);
  }

  static Future<bool> savedbUserName(String dbUserName1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dbUserName, dbUserName1);
  }

  static Future<String?> getdbUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(dbUserName);
  }

  static cleardbUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(dbUserName);
  }

  static Future<bool> savedbPassword(String dbPassworde1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dbPassword, dbPassworde1);
  }

  static Future<String?> getdbPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(dbPassword);
  }

  static cleardbPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(dbPassword);
  }

  static Future<bool> savehostIP(String hostip1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(hostip, hostip1);
  }

  static Future<String?> gethostIP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(hostip);
  }

  static clearhostIP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(hostip);
  }

  static Future<bool> saveUserType(String userType1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userType, userType1);
  }

  static Future<String?> getUserType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(userType);
  }

  static clearUserType() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(userType);
  }

  static Future<bool> saveSlpCode(String slpCode1) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(slpCode, slpCode1);
  }

  static Future<String?> getSlpCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(slpCode);
  }

  static clearSlpCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(slpCode);
  }
}
