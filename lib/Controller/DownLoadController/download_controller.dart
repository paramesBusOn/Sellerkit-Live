// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Models/configModel/getconfig_model.dart';
import 'package:sellerkit/Models/getuserbyidModel/getuserbyidmodel.dart';
import 'package:sellerkit/Models/ordergiftModel/ParticularpricelistModel.dart';
import 'package:sellerkit/Services/LoginVerificationApi/LoginVerificationApi.dart';
import 'package:sellerkit/Services/OrdergiftApi/pricelistparticularApi.dart';
import 'package:sellerkit/Services/configApi/configApi.dart';

import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Constant/database_config.dart';
import 'package:sellerkit/Constant/encripted.dart';
import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/OrderTypeModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/levelofinterestModel.dart';
import 'package:sellerkit/Models/PostQueryModel/ItemMasterModelNew.dart/itemviewModel.dart';
import 'package:sellerkit/Models/TestModel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Services/OfferZoneApi/OfferZoneAPi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/levelofApi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/ordertype.dart';
import 'package:sellerkit/Services/StateApi/stateApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/app_constant.dart';
import '../../Constant/Configuration.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import '../../Constant/Helper.dart';
import '../../Constant/menu_auth.dart';
import '../../DBHelper/db_helper.dart';
import '../../DBHelper/db_operation.dart';
import '../../DBModel/itemmasertdb_model.dart';
import '../../Models/CustomerMasterModel/customermaster_model.dart';
import '../../Models/MenuAuthModel/MenuAuthModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Services/CustomerMasterApi/CustomerMasterApi.dart';
import '../../Services/MenuAuthApi/MenuAuthApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/CustomerTag.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetEnqReffers.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetEnqType.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetUserApi.dart';
import '../../Services/PostQueryApi/ItemMasterApi/ItemMasterApiNew.dart';
import '../../Services/PostQueryApi/LeadsApi/GetLeadStatusApi.dart';
import '../../Services/PostQueryApi/ProfileApi/ProfileApi.dart';
import '../../Services/URL/LocalUrl.dart';
import '../../Services/VersionApi/VersionApi.dart';

class DownLoadController extends ChangeNotifier {
  bool cartLoading=false;
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  Config config = new Config();

  // Future<void> createDB() async {
  //   await DBOperation.createDB().then((value) {
  //     print("Value created....!!");
  //   });
  // }
 Future logOutMethod()async{
   String? fcm2 = await HelperFunctions.getFCMTokenSharedPreference();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    String? password =await HelperFunctions.getPasswordSharedPreference();
if (deviceID == null){
   
    deviceID = await Config.getdeviceId();
      // print("deviceID"+deviceID.toString());
       await   HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
       
 }
    LoginVerificationApi.getData(
            fcm2, deviceID, ConstantValues.tenetID, 1, ConstantValues.Usercode,password)
        .then((value) async {
// print('Sucess'+value.message);

 await HelperFunctions.clearHost();
  String? tenet2 = await HelperFunctions.getTenetIDSharedPreference();
    log("tenet2::"+tenet2.toString());
 Get.offAllNamed(ConstantRoutes.splash);
        });
}
  setURL() async {
    islogoutclick=false;
    notifyListeners();
    String? getUrl = await HelperFunctions.getHostDSP();
    // log("getUrl $getUrl");
    ConstantValues.userNamePM = await HelperFunctions.getUserName();
    Url.queryApi = '${getUrl.toString()}/api/';
  }

  ItemMasterApiNew itemMasterApiNew = ItemMasterApiNew();
  // TestNew testnew=TestNew();
  EnquiryTypeApi enquiryTypeApi = EnquiryTypeApi();
  CustomerTagTypeApi customerTagTypeApi = CustomerTagTypeApi();

  EnquiryRefferesApi enquiryRefferesApi = EnquiryRefferesApi();
  GetUserApi getUserApi = GetUserApi();
  GetLeadStatusApi getLeadStatusApi = GetLeadStatusApi();
  ProfileApi profileApi = ProfileApi();
  OfferZoneApi1 offerZoneApi1 = OfferZoneApi1();
  MenuAuthApi menuAuth = MenuAuthApi();
  CustomerMasterApiNew customerMaster1 = CustomerMasterApiNew();
  stateApiNew steteApinew = stateApiNew();
bool islogoutclick=false;
  callApiNew(BuildContext context) async {
    // log("123:");
    final Database db = (await DBHelper.getInstance())!;
    // DataBaseConfig.ip = (await HelperFunctions.gethostIP())!;
    // Map<Permission, PermissionStatus> statuses = await [
    //  await checkLocation();
    EncryptData enc = new EncryptData();
    if (ConstantValues.langtitude!.isEmpty || ConstantValues.langtitude == '') {
      ConstantValues.langtitude = '0.000';
    }
    if (ConstantValues.latitude!.isEmpty || ConstantValues.latitude == '') {
      ConstantValues.latitude = '0.000';
    }
    ConstantValues.headerSetup =
        "${ConstantValues.latitude};${ConstantValues.langtitude};${ConstantValues.ipname};${ConstantValues.ipaddress}";

    // log("before Encryped Location Header:::" +
    //     ConstantValues.headerSetup.toString());

    String? encryValue = enc.encryptAES("${ConstantValues.headerSetup}");
    // log("Encryped Location Header:::" + encryValue.toString());
    ConstantValues.EncryptedSetup = encryValue;
    notifyListeners();
    Future.delayed(Duration(seconds: 3));
    //   Permission.camera,
    // ].request();
// await config.getSetup();
    // Handle the statuses as needed
    // print('Location status: ${statuses[Permission.location]}');
    // print('Camera status: ${statuses[Permission.camera]}');

    // DataBaseConfig.database = (await HelperFunctions.getuserDB())!;
    // DataBaseConfig.password = (await HelperFunctions.getdbPassword())!;
    DataBaseConfig.userId = (await HelperFunctions.getdbUserName())!;
    await DBOperation.truncustomerMaster(db);
    await DBOperation.truncareItemMaster(db);
    await DBOperation.truncareEnqType(db);

    await DBOperation.truncarelevelofType(db);
    await DBOperation.truncareparticularprice(db);
    await DBOperation.truncareorderType(db);
    await DBOperation.truncateQuotFilter(db);
    
    
    await DBOperation.truncareCusTagType(db);
    await DBOperation.trunstateMaster(db);
    await DBOperation.truncareEnqReffers(db);
    await DBOperation.truncateUserList(db);
    await DBOperation.truncateLeadstatus(db);
    await DBOperation.truncateOfferZone(db);
    await DBOperation.truncateOfferZonechild1(db);
    await DBOperation.truncateOfferZonechild2(db);
    await DBOperation.truncatetableitemlist1(db);
    await DBOperation.truncatetableitemlist2(db);
loadingApi = "VersionApi Data ...";
    await VersionApi.getData().then((value) async {
      // log("123456:");

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          toLaunch = value.itemdata![0].url;
          content = value.itemdata![0].content;
          if (value.itemdata![0].version == AppConstant.version) {
         await   callDefaultApi();
         notifyListeners();
          } else {
            updateDialog(context);
          }
          notifyListeners();
        } else if (value.itemdata! == null) {
          exception = true;
          errorMsg = "${value.exception}..!! ";
          notifyListeners();
        }
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        errorMsg = "${value.exception}..${value.message}..!! ";
        notifyListeners();
      } else if (value.stcode! == 500) {
        exception = true;
        errorMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";
        notifyListeners();
        notifyListeners();
      }
    });
  }

  String? loadingApi = '';
  mapconfigvalues(List<GetconfigData> configData){
     ConstantValues.ssp1='';
      ConstantValues.ssp2='';
      ConstantValues.ssp3='';
      ConstantValues.ssp4='';
      ConstantValues.ssp5='';
ConstantValues.ssp1_Inc='';
ConstantValues.ssp2_Inc='';
ConstantValues.ssp3_Inc='';
ConstantValues.ssp4_Inc='';
ConstantValues.ssp5_Inc='';
ConstantValues.ageslab1='';
ConstantValues.ageslab2='';
ConstantValues.ageslab3='';
ConstantValues.ageslab4='';
ConstantValues.ageslab5='';
ConstantValues.splpricelogic='';
ConstantValues.unitpricelogic='';
ConstantValues.ordergiftlogic='';
ConstantValues.ordergiftskip='';
ConstantValues.showallslab='';
ConstantValues.configcost='';
ConstantValues.configmrp='';
ConstantValues.configsp='';
ConstantValues.quotesdisc='';

ConstantValues.leadchecklist='';
    for(int i=0;i<configData.length;i++){

      if(configData[i].config_Code =='ssp1'){
 ConstantValues.ssp1=configData[i].config_value;
     
      }
      if(configData[i].config_Code =='ssp2'){
 ConstantValues.ssp2=configData[i].config_value;
     
      }
       if(configData[i].config_Code =='Lead-checklist'){
 ConstantValues.leadchecklist=configData[i].config_value;
     
      }
      if(configData[i].config_Code =='ssp3'){
         ConstantValues.ssp3=configData[i].config_value;
     
      }
      if(configData[i].config_Code =='ssp4'){
         ConstantValues.ssp4=configData[i].config_value;
    
      }
      if(configData[i].config_Code =='ssp5'){
           ConstantValues.ssp5=configData[i].config_value;

      }
      if(configData[i].config_Code =='ssp1_Inc'){
          ConstantValues.ssp1_Inc=configData[i].config_value;

      }
      if(configData[i].config_Code =='ssp2_inc'){
          ConstantValues.ssp2_Inc=configData[i].config_value;


      }
      if(configData[i].config_Code =='ssp3_inc'){
         ConstantValues.ssp3_Inc=configData[i].config_value;


      }
      if(configData[i].config_Code =='ssp4_Inc'){
          ConstantValues.ssp4_Inc=configData[i].config_value;


      }
      if(configData[i].config_Code =='ssp5_Inc'){
         ConstantValues.ssp5_Inc=configData[i].config_value;


      }

      if(configData[i].config_Code =='age-slab1'){
         ConstantValues.ageslab1=configData[i].config_value;


      }
      if(configData[i].config_Code =='age-slab2'){
        ConstantValues.ageslab2=configData[i].config_value;


      }
      if(configData[i].config_Code =='age-slab3'){
       ConstantValues.ageslab3=configData[i].config_value;


      }
      if(configData[i].config_Code =='age-slab4'){
       ConstantValues.ageslab4=configData[i].config_value;


      }
      if(configData[i].config_Code =='age-slab5'){
         ConstantValues.ageslab5=configData[i].config_value;


      }
      if(configData[i].config_Code =='spl-price-logic'){
         ConstantValues.splpricelogic=configData[i].config_value;


      }  if(configData[i].config_Code =='slab_wise_approval'){
         ConstantValues.unitpricelogic=configData[i].config_value;


      }if(configData[i].config_Code =='enable-gift-offer'){
         ConstantValues.ordergiftlogic=configData[i].config_value;


      }if(configData[i].config_Code =='gift_offer_skip'){
         ConstantValues.ordergiftskip=configData[i].config_value;


      }if(configData[i].config_Code =='show-all-slab'){
         ConstantValues.showallslab=configData[i].config_value;


      }if(configData[i].config_Code =='cost'){
         ConstantValues.configcost=configData[i].config_value;


      }if(configData[i].config_Code =='mrp'){
         ConstantValues.configmrp=configData[i].config_value;


      }if(configData[i].config_Code =='sp'){
         ConstantValues.configsp=configData[i].config_value;


      }
      if(configData[i].config_Code =='Disc-itemlevel-Quotes'){
         ConstantValues.quotesdisc=configData[i].config_value;


      }
      if(configData[i].config_Code =='Disc-itemlevel-order'){
         ConstantValues.orderdisc=configData[i].config_value;


      }
     


    }
    log("ConstantValues.ageslab1::"+ConstantValues.ageslab1.toString());
    log("ConstantValues.ageslab2::"+ConstantValues.ssp1.toString());
notifyListeners();
  }
   double progressPercentage = 0.0;
   double progressPercentagedown = 0.0;
   simulateLoadingProgress()  async{
    progressPercentage = 0.0; 
    while (progressPercentage < 99) {
      // log("progressPercentage::"+progressPercentage.toString());
     await  Future.delayed(Duration(milliseconds: 10)); 
        notifyListeners();
      progressPercentage += 1; 
      notifyListeners();
    }
    if (progressPercentage > 100) progressPercentage = 100;
    // if(progressPercentage == 100){
    //    progressPercentage = 0.0;
    // }
  }
  int downloadprogress=0;
  int totalExpectedTime = 3000;
  final stopwatchdown = Stopwatch()..start();
  void adjustTotalExpectedTime() {
  int averageTimePerCall = stopwatchdown.elapsedMilliseconds;
  totalExpectedTime = averageTimePerCall * 1;
}
callpercent(){
  adjustTotalExpectedTime();
   double progress = (stopwatchdown.elapsedMilliseconds / totalExpectedTime) * 100;
    progressPercentagedown += progress;
     if (progressPercentagedown > 100) progressPercentagedown = 100;
   return progressPercentagedown.toStringAsFixed(1);  
}
callsecondaryApi()async{
 List<EnquiryTypeData> enqTypeData = [];
    List<CustomerTagTypeData> customerTagTypeData = [];
    List<CustomerData> customerdata = [];
 List<LevelofData> levelofdata=[];
 
List<ParticularpriceData> Particularprice=[];
 List<OrderTypeData> ordertypedata=[];
    List<EnqRefferesData> enqReffdata = [];

    List<UserListData> userListData = [];

    List<GetLeadStatusData> leadcheckdata = [];
    List<stateHeaderData> stateData = [];

    List<OfferZoneData> offerzone = [];
    List<offerproductlist> offerproduct = [];
    List<offerstorelist> offerstore = [];
    List<GetconfigData> configData=[];

      final Database db = (await DBHelper.getInstance())!;
 final stopwatch = Stopwatch()..start();
        // log("Start: Initial Loading.." ); 
        progressPercentage=100;
loadingApi = "Config Data ...";

// progressPercentagedown = 0.0;
  stopwatchdown.reset();
 simulateLoadingProgress();
  await      GetconfigApi.getData(ConstantValues.slpcode).then((value) {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
      exception = false;
      if (value.itemdata != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:EnquiryTypeAPI " );
          // log("EnquiryType ${value.itemdata!.length}");
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        configData = value.itemdata!;
        log("configData::"+configData.length.toString());
        mapconfigvalues(value.itemdata!);
        notifyListeners();
         stopwatch.stop();
            // log('API EnquiryType ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Enquiry Type Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    } 
   
        });
        progressPercentage=100;
    loadingApi = "Enquiry Type Data ...";
    // progressPercentage=100;
    // progressPercentagedown = 0.0;
     stopwatchdown.reset();
     simulateLoadingProgress();
     await enquiryTypeApi.getData(ConstantValues.slpcode).then((value) {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
      exception = false;
      if (value.itemdata != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:EnquiryTypeAPI " );
          // log("EnquiryType ${value.itemdata!.length}");
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        enqTypeData = value.itemdata!;
         stopwatch.stop();
            // log('API EnquiryType ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Enquiry Type Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
    
     });
   
//

    // CustomerTagTypeModal customerTagTypeModal =
    //     await customerTagTypeApi.getData(ConstantValues.slpcode);
    progressPercentage=100;
    loadingApi = "Customer TagType Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
     await customerTagTypeApi.getData(ConstantValues.slpcode).then((value){
if (value.stcode! >= 200 &&
        value.stcode! <= 210) {
      exception = false;
      if (value.itemdata != null) {
        final stopwatch = Stopwatch()..start();
        
        // log("Start:customerTagType " );
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        customerTagTypeData = value.itemdata!;
        stopwatch.stop();
            // log('API customerTagType ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Customer Tag Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
     });
    

    // LevelofModal levelofModal =
    //     await LevelofApi.getData(ConstantValues.slpcode);
    progressPercentage=100;
    loadingApi = "LevelofApi Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
    await LevelofApi.getData(ConstantValues.slpcode).then((value){
 if (value.stcode! >= 200 &&
        value.stcode! <= 210) {
      exception = false;
      if (value.itemdata != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:LevelofApi " );
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        levelofdata = value.itemdata!;
         stopwatch.stop();
            // log('API LevelofApi ${stopwatch.elapsedMilliseconds} milliseconds');
     
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Customer Tag Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
    });

    //particularpricelist
    if(ConstantValues.showallslab!.toLowerCase() != 'y'){
      progressPercentage=100;
      loadingApi = "PriceListApi Data ...";
      // progressPercentagedown = 0.0;
      //  stopwatchdown.reset();
      // progressPercentage=100;
       simulateLoadingProgress();
 await ParticularPriceListApi.getData().then((value){
 if (value.stcode! >= 200 &&
        value.stcode! <= 210) {
      exception = false;
      if (value.itemdata!.childdata != null && value.itemdata!.childdata!.isNotEmpty) {
         final stopwatch = Stopwatch()..start();
        
        // log("Start:LevelofApi " );
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        Particularprice = value.itemdata!.childdata!;
         stopwatch.stop();
            // log('API LevelofApi ${stopwatch.elapsedMilliseconds} milliseconds');
     
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Customer Tag Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
    });
    }
      
    
   
    //  OrderTypeModal orderTypeModal =
    //     await OrderTypeApi.getData(ConstantValues.slpcode);
    progressPercentage=100;
    loadingApi = "Customer TagType Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
      simulateLoadingProgress();
    await OrderTypeApi.getData(ConstantValues.slpcode).then((value) {
 if (value.stcode! >= 200 &&
        value.stcode! <= 210) {
      exception = false;
      if (value.itemdata != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:OrderTypeApi " );
        String date = config.currentDate();
        // for (int i = 0; i < values.itemdata!.length; i++) {
        //     enqTypeData.add(EnquiryTypeData(
        //       Code: values.itemdata![i].Code,
        //       Name:  values.itemdata![i].Name));
        // }
        ordertypedata = value.itemdata!;
        stopwatch.stop();
            // log('API OrderTypeApi ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.itemdata == null) {
        exception = true;
        errorMsg = 'No data - Customer Tag Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
    });
   

    // EnqRefferesModal enqRefferesModal =
    //     await enquiryRefferesApi.getData(ConstantValues.slpcode);
    progressPercentage=100;
    loadingApi = "Enquiry Refferel Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
     await enquiryRefferesApi.getData(ConstantValues.slpcode).then((value){
if (value.stcode! >= 200 && value.stcode! <= 210) {
      exception = false;
      if (value.enqReffersdata != null) {
        final stopwatch = Stopwatch()..start();
        
        // log("Start:enqReffersdata " );
        String date = config.currentDate();

        enqReffdata = value.enqReffersdata!;
         stopwatch.stop();
            // log('API enqReffersdata ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.enqReffersdata == null) {
        exception = true;
        errorMsg = 'No data - Enquiry Ref Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
     });
    
//New state
progressPercentage=100;
loadingApi = "StateApi Data ...";
// progressPercentagedown = 0.0;
//  stopwatchdown.reset();
// progressPercentage=100;
 simulateLoadingProgress();
    await stateApiNew.getData().then((value) {
      loadingApi = "stateData";
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          exception = false;
          final stopwatch = Stopwatch()..start();
          
        // log("Start:stateData " );
          for (int i = 0; i <= value.itemdata!.datadetail!.length; i++) {
            stateData = value.itemdata!.datadetail!;
            // filterstateData = stateData;
            // log("fil" + stateData.length.toString());
            notifyListeners();
            // log("stateData::" + stateData.length.toString());
          }
          stopwatch.stop();
            // log('API stateData ${stopwatch.elapsedMilliseconds} milliseconds');
    
        } else if (value.itemdata == null) {
          exception = true;
          errorMsg = 'No data - State Api..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        errorMsg =
            '${value.message}..! \n${value.exception}..!!${value.stcode}';

        notifyListeners();
      } else if (value.stcode == 500) {
        exception = true;
        errorMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';

        notifyListeners();
      }
    });

    // UserListModal userListModal =
    //     await getUserApi.getData(ConstantValues.UserId);
    progressPercentage=100;
    loadingApi = "UserList Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
     await getUserApi.getData(ConstantValues.UserId).then((value) {
if (value.stcode! >= 200 && value.stcode! <= 210) {
      exception = false;
      if (value.userLtData != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:userListData " );
        // log("userListModal.userLtData!.length::" +
        //     userListModal.userLtData!.length.toString());
        for (int ik = 0; ik < value.userLtData!.length; ik++) {
          // if(userListModal.userLtData![ik].storeid ==ConstantValues.storeid ){
          // for(int i=0;i<userListModal.userLtData!.length;i++){
          userListData.add(UserListData(
              userCode: value.userLtData![ik].userCode,
              storeid: value.userLtData![ik].storeid,
              mngSlpcode: value.userLtData![ik].mngSlpcode,
              UserName: value.userLtData![ik].UserName,
              color: value.userLtData![ik].color,
              slpcode: value.userLtData![ik].slpcode,
              SalesEmpID: value.userLtData![ik].SalesEmpID));
          // = userListModal.userLtData!;

          // }

          // log("message222::" +
          //     userListModal.userLtData![ik].storeid.toString() +
          //     "AAAA" +
          //     ConstantValues.storeid.toString());

          notifyListeners();
          // log("message::" + userListData.length.toString());
          // }
        }
        stopwatch.stop();
            // log('API userListData ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.userLtData == null) {
        exception = true;
        errorMsg = 'No data - User Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
     });
    

    // GetLeadStatusModal getLeadStatusModal = await getLeadStatusApi.getData();
    progressPercentage=100;
    loadingApi = "Lead Status Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
      simulateLoadingProgress();
    await getLeadStatusApi.getData().then((value) {
if (value.stcode! >= 200 &&
        value.stcode! <= 210) {
      ("statusINININ");
      exception = false;
      if (value.leadcheckdata != null) {
         final stopwatch = Stopwatch()..start();
         
        // log("Start:LeadStatusData " );
        for(int i=0;i<value.leadcheckdata!.length;i++){
          if(value.leadcheckdata![i].status ==1){
            leadcheckdata.add(GetLeadStatusData(
                  code: value.leadcheckdata![i].code,
                  name:value.leadcheckdata![i].name!,
                  statusType:value.leadcheckdata![i].statusType ,
                  ));
          }
        }
         stopwatch.stop();
            // log('API LeadStatusData ${stopwatch.elapsedMilliseconds} milliseconds');
        //         for (int i = 0; i < getLeadStatusModal.leadcheckdata!.length; i++) {
        // //            List<String>     result =  [];

        // //  result =   ;

        //         leadcheckdata.add(GetLeadStatusData(
        //           code: getLeadStatusModal.leadcheckdata![i].code,
        //           name:getLeadStatusModal.leadcheckdata![i].name!,
        //           statusType:getLeadStatusModal.leadcheckdata![i].statusType ,
        //           ));
        //    //  log("111leadcheckdata"+result.toString());
        //     }

        // leadcheckdata = getLeadStatusModal.leadcheckdata!;
      } else if (value.leadcheckdata == null) {
        exception = true;
        errorMsg = 'No data - LeadStatus Api..!!';
        notifyListeners();
      }
      notifyListeners();
    } else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
      notifyListeners();
    } else if (value.stcode == 500) {
      exception = true;
      errorMsg =
          '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      notifyListeners();
    }
    });
    

    // ProfileModel profileModel =
    //     await profileApi.getData(ConstantValues.slpcode);
    progressPercentage=100;
    loadingApi = "Profile Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
      simulateLoadingProgress();
      await profileApi.getData(ConstantValues.slpcode).then((value)async {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
      if (value.profileData != null) {
         final stopwatch = Stopwatch()..start();
        // log("Start:profileData " );
        
        exception = false;
        // log("firstName" + profileModel.profileData!.firstName!.toString());
        await HelperFunctions.saveFSTNameSharedPreference(
            value.profileData!.firstName!);
        await HelperFunctions.saveLSTNameSharedPreference(
            value.profileData!.lastName!);
        await HelperFunctions.saveBranchSharedPreference(
            value.profileData!.Branch!);
        await HelperFunctions.savemobileSharedPreference(
            value.profileData!.mobile!);
        await HelperFunctions.saveProfilePicSharedPreference(
            value.profileData!.ProfilePic!);
        await HelperFunctions.saveUSERIDSharedPreference(
            value.profileData!.USERID!);
        await HelperFunctions.saveemailSharedPreference(
            value.profileData!.email!);
        await HelperFunctions.saveManagerPhoneSharedPreference(
            value.profileData!.managerPhone!);
        await HelperFunctions.getFSTNameSharedPreference().then((value) {
          if (value != null) {
            ConstantValues.firstName = value;
            notifyListeners();

            // log("firstName" + ConstantValues.firstName.toString());
          }
          stopwatch.stop();
            // log('API profileData ${stopwatch.elapsedMilliseconds} milliseconds');
        
        });
      } else if (value.profileData == null) {
        exception = true;
        errorMsg = '${value.exception}';
      }
    } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
    } else if (value.stcode == 500) {
      if (value.exception == 'No route to host') {
        errorMsg = 'Check your Internet Connection...!!';
      } else {
        exception = true;
        errorMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    }
      });
   
    notifyListeners();
    // OfferZoneModel offerZoneModel =
    //     await offerZoneApi1.getOfferZone(ConstantValues.storeid);
    progressPercentage=100;
    loadingApi = "OfferZone Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
    await offerZoneApi1.getOfferZone(ConstantValues.storeid).then((value)async {
if (value != null) {
      exception = false;
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.offerZoneData1 != null) {
          
          // print("OfferZoneModel");
// final stopwatch = Stopwatch()..start();
//         log("Start:offerZoneData " );
          for (int ij = 0; ij < value.offerZoneData1!.length; ij++) {
            final Database db = (await DBHelper.getInstance())!;
            offerzone = value.offerZoneData1!;
            if(value.offerZoneData1![ij].offerproductlistdetails !=null){
offerproduct =
           
                value.offerZoneData1![ij].offerproductlistdetails!;
            }else{
           offerproduct=[];   
            }
            
            // offerstore =
            //     value.offerZoneData1![ij].offerstorelistdetails!;
            await DBOperation.insertOfferZonechild1(offerproduct, db);
            // await DBOperation.insertOfferZonechild2(offerstore, db);
            // log("offerzone" + offerzone.length.toString());
            // log("offerzone"+offerZoneModel.offerZoneData1![ij].offerstorelistdetails!.toString());
            // log("lrngth" + offerstore.length.toString());
          }
          //  stopwatch.stop();
          //   log('API offerZoneData ${stopwatch.elapsedMilliseconds} milliseconds');
        } else if (value.offerZoneData1 == null) {
          exception = true;
          errorMsg = 'No data - OfferZone Api..!!';
        }
      } else if (value.stcode! >= 400 &&
          value.stcode! <= 410) {
        exception = true;
        errorMsg = '${value.exception}';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          exception = true;
          errorMsg =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        } else {
          // exception = true;
          // errorMsg = '${offerZoneModel.exception}';
        }
      }
      notifyListeners();
    }

    });
    
    // MenuAuthModel menuAuthModel = await menuAuth.getOfferZone();
    progressPercentage=100;
    loadingApi = "MenuAuth Data ...";
    // progressPercentagedown = 0.0;
    //  stopwatchdown.reset();
    // progressPercentage=100;
     simulateLoadingProgress();
     await menuAuth.getOfferZone().then((value) {
 if (value.stcode! >= 200 && value.stcode! <= 210) {
      if (value.menuAuthData != null) {
        final stopwatch = Stopwatch()..start();
         
        // log("Start:menuAuthData " );
        setMenuAuth(value);
         stopwatch.stop();
            // log('API menuAuthData ${stopwatch.elapsedMilliseconds} milliseconds');
      
      } else if (value.menuAuthData == null) {
        exception = true;
        errorMsg = 'No data - Menu Authorized..!!';
      }
    } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      exception = true;
      errorMsg = '${value.exception}';
    } else if (value.stcode! == 500) {
      if (value.exception == 'No route to host') {
        exception = true;
        errorMsg = '${value.exception}';
      } else {
        exception = true;
        errorMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    }
     });
   
   
    // log("valuesInserMaster: " + valuesInserMaster.length.toString());
    // if (valuesInserMaster != null) {
      
     
       
         
    // }
    // log("valuesInserCusTag: " + customerTagTypeData.length.toString());
 await DBOperation.inserstateMaster(stateData, db);
    await DBOperation.insertCusTagType(customerTagTypeData, db);
await DBOperation.insertlevelofType(levelofdata, db);
await DBOperation.insertparticularprice(Particularprice, db);
await DBOperation.insertOrderTypeta(ordertypedata, db);
    // log("valuesInserEnq: " + enqTypeData.length.toString());
    await DBOperation.insertEnqType(enqTypeData, db);
    // log("enqReffersdata: " + enqReffdata.length.toString());
    await DBOperation.insertEnqReffers(enqReffdata, db);
    // log("userListData:" + userListData.length.toString());
    await DBOperation.insertUserList(userListData, db);
    await DBOperation.insertLeadStatusList(leadcheckdata, db);
    // log("leadcheckdata:" + leadcheckdata.length.toString());
    if (offerzone.isNotEmpty) {
      await DBOperation.insertOfferZone(offerzone, db);
    }
    // await DBOperation.inserCustomerMaster(customerdata, db);
    // log("customerMaster:" + customerdata.length.toString());

    await HelperFunctions.saveDonloadednSharedPreference(true);
    stopwatch.stop();
            log('API initialloading ${stopwatch.elapsedMilliseconds} milliseconds');
      
// stopwatch.stop();
            // log('API call took ${stopwatch.elapsedMilliseconds} milliseconds');
            if(islogoutclick ==false){

    Get.offAllNamed(ConstantRoutes.dashboard);
            }
}
 Future<void> callDefaultApi() async {
  ConstantValues.  multistoreuser =0;
    List<ItemMasterDBModel> valuesInserMaster = [];
    Itemlistdata1? valueitemlist1;
    Itemlistdata2? valueitemlist2;

    var time = DateTime.now();
    //New one
  
    final Database db = (await DBHelper.getInstance())!;
    //  await Future.delayed(Duration(seconds: 1));
//  final stopwatch = Stopwatch()..start();
//         log("Start: Initial Loading Defalult Api.." ); 
    // int? itemmasterCount = await DBOperation.getItemMasterCount(db);
    // int? customerMasterCount = await DBOperation.getCustomerMasterCount(db);
    // if (itemmasterCount == 0) {

     
       final stopwatch = Stopwatch()..start();
        loadingApi = "Item Master Data ...";
        progressPercentagedown = 0.0;
        //  stopwatchdown.reset();
         simulateLoadingProgress();
ItemMasterNewModal itemMasterData = await itemMasterApiNew.getData();
    
 
       stopwatch.stop();
        log('API ItemMasterDataAPPPPPPP ${stopwatch.elapsedMilliseconds} milliseconds');
        // log("Start: ItemMasterDataItemMasterDataItemMasterDataItemMasterData" ); 


        
  //   await itemMasterApiNew.getData().then((value) {
  //      stopwatch.stop();
  //           log('API ItemMasterDataAPPPPPPP ${stopwatch.elapsedMilliseconds} milliseconds');
  if (itemMasterData.stcode! >= 200 && itemMasterData.stcode! <= 210) {
        exception = false;
       
        if (itemMasterData.itemdata != null) {
           log("Api itemMasterData.itemdata!.length ${itemMasterData.itemdata!.length.toString()}");
ConstantValues.itemMasterlegth=itemMasterData.itemdata!.length.toString();
          String date = config.currentDate();
          
          // final stopwatch = Stopwatch()..start();
        // log("Start:API " );
          // log("Api itemMasterData.itemdata!.length ${value.itemdata![0].itemName}");

            for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
            valuesInserMaster.add(ItemMasterDBModel(
              Isbundle: itemMasterData.itemdata![ij].Isbundle.toString().isEmpty?false:itemMasterData.itemdata![ij].Isbundle=='1'?true:false,
              storeAgeSlab1:itemMasterData.itemdata![ij].storeAgeSlab1 ==''?0.00: double.parse( itemMasterData.itemdata![ij].storeAgeSlab1.toString()),
              storeAgeSlab2:itemMasterData.itemdata![ij].storeAgeSlab2 ==''?0.00:double.parse(itemMasterData.itemdata![ij].storeAgeSlab2.toString()),
              storeAgeSlab3:itemMasterData.itemdata![ij].storeAgeSlab3 ==''?0.00:double.parse(itemMasterData.itemdata![ij].storeAgeSlab3.toString()),
              storeAgeSlab4:itemMasterData.itemdata![ij].storeAgeSlab4 ==''?0.00:double.parse(itemMasterData.itemdata![ij].storeAgeSlab4.toString()),
              storeAgeSlab5:itemMasterData.itemdata![ij].storeAgeSlab5 ==''?0.00:double.parse(itemMasterData.itemdata![ij].storeAgeSlab5.toString()),
              whsAgeSlab1:itemMasterData.itemdata![ij].whsAgeSlab1 ==''?0.00:double.parse(itemMasterData.itemdata![ij].whsAgeSlab1.toString()),
              whsAgeSlab2:itemMasterData.itemdata![ij].whsAgeSlab2 ==''?0.00:double.parse(itemMasterData.itemdata![ij].whsAgeSlab2.toString()),
              whsAgeSlab3:itemMasterData.itemdata![ij].whsAgeSlab3 ==''?0.00:double.parse(itemMasterData.itemdata![ij].whsAgeSlab3.toString()),
              whsAgeSlab4:itemMasterData.itemdata![ij].whsAgeSlab4 ==''?0.00:double.parse(itemMasterData.itemdata![ij].whsAgeSlab4.toString()),
              whsAgeSlab5:itemMasterData.itemdata![ij].whsAgeSlab5 ==''?0.00:double.parse(itemMasterData.itemdata![ij].whsAgeSlab5.toString()),
              payOn:itemMasterData.itemdata![ij].payOn!,
              calcType:itemMasterData.itemdata![ij].calcType!,
                 id:itemMasterData.itemdata![ij].id.toString().isEmpty?0: int.parse (itemMasterData.itemdata![ij].id.toString()),
                 itemCode: itemMasterData.itemdata![ij].itemcode!.replaceAll("'", "''"),
                brand: itemMasterData.itemdata![ij].Brand!.replaceAll("'", "''"),
                division: itemMasterData.itemdata![ij].Division!.replaceAll("'", "''"),
                category: itemMasterData.itemdata![ij].Category!.replaceAll("'", "''"),
                itemName: itemMasterData.itemdata![ij].itemName!.replaceAll("'", "''"),
                segment: itemMasterData.itemdata![ij].Segment!,
                isselected: 0,
                favorite: itemMasterData.itemdata![ij].Favorite!,
                mgrPrice:itemMasterData.itemdata![ij].MgrPrice ==''?0.00: double.parse(
                    itemMasterData.itemdata![ij].MgrPrice.toString()),
                slpPrice:itemMasterData.itemdata![ij].SlpPrice ==''?0.00: double.parse(
                    itemMasterData.itemdata![ij].SlpPrice.toString()),
                storeStock:itemMasterData.itemdata![ij].StoreStock ==''?0.00: double.parse(
                    itemMasterData.itemdata![ij].StoreStock.toString()),
                whsStock:itemMasterData.itemdata![ij].WhsStock ==''?0.00: double.parse(
                    itemMasterData.itemdata![ij].WhsStock.toString()),
                refreshedRecordDate: date,
                itemDescription: itemMasterData.itemdata![ij].itemDescription!.replaceAll("'", "''"),
                modelNo: itemMasterData.itemdata![ij].modelNo!.replaceAll("'", "''"),
                partCode: itemMasterData.itemdata![ij].partCode!.replaceAll("'", "''"),
                skucode: itemMasterData.itemdata![ij].skucode,
                brandCode: itemMasterData.itemdata![ij].brandCode!.replaceAll("'", "''"),
                itemGroup: itemMasterData.itemdata![ij].itemGroup!.replaceAll("'", "''"),
                specification: itemMasterData.itemdata![ij].specification!.replaceAll("'", "''"),
                sizeCapacity: itemMasterData.itemdata![ij].sizeCapacity,
                clasification: itemMasterData.itemdata![ij].clasification!.replaceAll("'", "''"),
                uoM: itemMasterData.itemdata![ij].uoM,
               taxRate:itemMasterData.itemdata![ij].taxRate.toString().isEmpty?0.0: double.parse(itemMasterData.itemdata![ij].taxRate.toString()),
               
                catalogueUrl1: itemMasterData.itemdata![ij].catalogueUrl1,
                catalogueUrl2: itemMasterData.itemdata![ij].catalogueUrl2,
                imageUrl1: itemMasterData.itemdata![ij].imageUrl1,
                imageUrl2: itemMasterData.itemdata![ij].imageUrl2,
                textNote: itemMasterData.itemdata![ij].textNote,
                status: itemMasterData.itemdata![ij].status,
                movingType: itemMasterData.itemdata![ij].movingType,
               eol:itemMasterData.itemdata![ij].eol.toString().isEmpty?false:itemMasterData.itemdata![ij].eol=='1'?true:false,
                // bool.parse(itemMasterData.itemdata![ij].eol.toString()),
                veryFast:itemMasterData.itemdata![ij].veryFast.toString().isEmpty?false:itemMasterData.itemdata![ij].veryFast=='1'?true:false,
                //  bool.parse(itemMasterData.itemdata![ij].veryFast.toString()),
                fast:itemMasterData.itemdata![ij].fast.toString().isEmpty?false:itemMasterData.itemdata![ij].fast=='1'?true:false ,
                // bool.parse(itemMasterData.itemdata![ij].fast.toString()),
                slow:itemMasterData.itemdata![ij].slow.toString().isEmpty?false:itemMasterData.itemdata![ij].slow=='1'?true:false ,
                // bool.parse(itemMasterData.itemdata![ij].slow.toString()),
                verySlow:itemMasterData.itemdata![ij].verySlow.toString().isEmpty?false:itemMasterData.itemdata![ij].verySlow=='1'?true:false, 
                // bool.parse(itemMasterData.itemdata![ij].verySlow.toString()),
                serialNumber:itemMasterData.itemdata![ij].serialNumber.toString().isEmpty?false:itemMasterData.itemdata![ij].serialNumber=='1'?true:false ,
                // bool.parse(itemMasterData.itemdata![ij].serialNumber.toString()),
                priceStockId:itemMasterData.itemdata![ij].priceStockId.toString().isEmpty?0: int.parse(itemMasterData.itemdata![ij].priceStockId.toString()),
               
                storeCode: itemMasterData.itemdata![ij].storeCode,
                whseCode: itemMasterData.itemdata![ij].whseCode,
                sp:itemMasterData.itemdata![ij].sp ==''?0.00: double.parse( itemMasterData.itemdata![ij].sp.toString()),
                ssp1:itemMasterData.itemdata![ij].ssp1 ==''?0.00: double.parse( itemMasterData.itemdata![ij].ssp1.toString()),
                ssp2:itemMasterData.itemdata![ij].ssp2 ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp2.toString()),
                ssp3:itemMasterData.itemdata![ij].ssp3 ==''?0.00: double.parse( itemMasterData.itemdata![ij].ssp3.toString()),
                ssp4:itemMasterData.itemdata![ij].ssp4 ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp4.toString()),
                ssp5:itemMasterData.itemdata![ij].ssp5 ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp5.toString()),
                ssp1Inc:itemMasterData.itemdata![ij].ssp1Inc ==''?0.00: double.parse( itemMasterData.itemdata![ij].ssp1Inc.toString()),
                ssp2Inc:itemMasterData.itemdata![ij].ssp2Inc ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp2Inc.toString()),
                ssp3Inc:itemMasterData.itemdata![ij].ssp3Inc ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp3Inc.toString()),
                ssp4Inc:itemMasterData.itemdata![ij].ssp4Inc ==''?0.00:  double.parse(itemMasterData.itemdata![ij].ssp4Inc.toString()),
                ssp5Inc:itemMasterData.itemdata![ij].ssp5Inc ==''?0.00: double.parse( itemMasterData.itemdata![ij].ssp5Inc.toString()),
                allowNegativeStock:
                itemMasterData.itemdata![ij].allowNegativeStock.toString().isEmpty?false:  itemMasterData.itemdata![ij].allowNegativeStock=='1'?true:false,
                //  bool.parse( itemMasterData.itemdata![ij].allowNegativeStock.toString()),
                allowOrderBelowCost:
                  itemMasterData.itemdata![ij].allowOrderBelowCost.toString().isEmpty?false:itemMasterData.itemdata![ij].allowOrderBelowCost=='1'?true:false,
                  //  bool.parse( itemMasterData.itemdata![ij].allowOrderBelowCost.toString()),
                isFixedPrice:itemMasterData.itemdata![ij].isFixedPrice.toString().isEmpty?false:itemMasterData.itemdata![ij].isFixedPrice=='1'?true:false,
                // bool.parse( itemMasterData.itemdata![ij].isFixedPrice.toString()),
                validTill: itemMasterData.itemdata![ij].validTill.toString(),
                color: itemMasterData.itemdata![ij].color!.replaceAll("'", "''")
              //
              ));
            // log("valuesInserMaster2222" + valuesInserMaster.length.toString());
            // dbHelper.insertdocuments(valuesInserMaster[ij]);
          }


//  for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
//             valuesInserMaster.add(ItemMasterDBModel(
//                Isbundle: false,
           
//               storeAgeSlab1:double.parse( itemMasterData.itemdata![ij].storeAgeSlab1.toString()),
//               storeAgeSlab2:double.parse(itemMasterData.itemdata![ij].storeAgeSlab2.toString()),
//               storeAgeSlab3:double.parse(itemMasterData.itemdata![ij].storeAgeSlab3.toString()),
//               storeAgeSlab4:double.parse(itemMasterData.itemdata![ij].storeAgeSlab4.toString()),
//               storeAgeSlab5:double.parse(itemMasterData.itemdata![ij].storeAgeSlab5.toString()),
//               whsAgeSlab1:double.parse(itemMasterData.itemdata![ij].whsAgeSlab1.toString()),
//               whsAgeSlab2:double.parse(itemMasterData.itemdata![ij].whsAgeSlab2.toString()),
//               whsAgeSlab3:double.parse(itemMasterData.itemdata![ij].whsAgeSlab3.toString()),
//               whsAgeSlab4:double.parse(itemMasterData.itemdata![ij].whsAgeSlab4.toString()),
//               whsAgeSlab5:double.parse(itemMasterData.itemdata![ij].whsAgeSlab5.toString()),
//               payOn:itemMasterData.itemdata![ij].payOn!,
//               calcType:itemMasterData.itemdata![ij].calcType!,
//                  id:itemMasterData.itemdata![ij].id.toString().isEmpty?0: int.parse (itemMasterData.itemdata![ij].id.toString()),
//                  itemCode: itemMasterData.itemdata![ij].itemcode!.replaceAll("'", "''"),
//                 brand: itemMasterData.itemdata![ij].Brand!.replaceAll("'", "''"),
//                 division: itemMasterData.itemdata![ij].Division!.replaceAll("'", "''"),
//                 category: itemMasterData.itemdata![ij].Category!.replaceAll("'", "''"),
//                 itemName: itemMasterData.itemdata![ij].itemName!.replaceAll("'", "''"),
//                 segment: itemMasterData.itemdata![ij].Segment!,
//                 isselected: 0,
//                 favorite: itemMasterData.itemdata![ij].Favorite!,
//                 mgrPrice: double.parse(
//                     itemMasterData.itemdata![ij].MgrPrice.toString()),
//                 slpPrice: double.parse(
//                     itemMasterData.itemdata![ij].SlpPrice.toString()),
//                 storeStock: double.parse(
//                     itemMasterData.itemdata![ij].StoreStock.toString()),
//                 whsStock: double.parse(
//                     itemMasterData.itemdata![ij].WhsStock.toString()),
//                 refreshedRecordDate: date,
//                 itemDescription: itemMasterData.itemdata![ij].itemDescription!.replaceAll("'", "''"),
//                 modelNo: itemMasterData.itemdata![ij].modelNo!.replaceAll("'", "''"),
//                 partCode: itemMasterData.itemdata![ij].partCode!.replaceAll("'", "''"),
//                 skucode: itemMasterData.itemdata![ij].skucode,
//                 brandCode: itemMasterData.itemdata![ij].brandCode!.replaceAll("'", "''"),
//                 itemGroup: itemMasterData.itemdata![ij].itemGroup!.replaceAll("'", "''"),
//                 specification: itemMasterData.itemdata![ij].specification!.replaceAll("'", "''"),
//                 sizeCapacity: itemMasterData.itemdata![ij].sizeCapacity,
//                 clasification: itemMasterData.itemdata![ij].clasification!.replaceAll("'", "''"),
//                 uoM: itemMasterData.itemdata![ij].uoM,
//                taxRate:itemMasterData.itemdata![ij].taxRate.toString().isEmpty?0.0: double.parse(itemMasterData.itemdata![ij].taxRate.toString()),
               
//                 catalogueUrl1: itemMasterData.itemdata![ij].catalogueUrl1,
//                 catalogueUrl2: itemMasterData.itemdata![ij].catalogueUrl2,
//                 imageUrl1: itemMasterData.itemdata![ij].imageUrl1,
//                 imageUrl2: itemMasterData.itemdata![ij].imageUrl2,
//                 textNote: itemMasterData.itemdata![ij].textNote,
//                 status: itemMasterData.itemdata![ij].status,
//                 movingType: itemMasterData.itemdata![ij].movingType,
//                eol:itemMasterData.itemdata![ij].eol.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].eol.toString()),
//                 veryFast:itemMasterData.itemdata![ij].veryFast.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].veryFast.toString()),
//                 fast:itemMasterData.itemdata![ij].fast.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].fast.toString()),
//                 slow:itemMasterData.itemdata![ij].slow.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].slow.toString()),
//                 verySlow:itemMasterData.itemdata![ij].verySlow.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].verySlow.toString()),
//                 serialNumber:itemMasterData.itemdata![ij].serialNumber.toString().isEmpty?false: bool.parse(itemMasterData.itemdata![ij].serialNumber.toString()),
//                 priceStockId:itemMasterData.itemdata![ij].priceStockId.toString().isEmpty?0: int.parse(itemMasterData.itemdata![ij].priceStockId.toString()),
               
//                 storeCode: itemMasterData.itemdata![ij].storeCode,
//                 whseCode: itemMasterData.itemdata![ij].whseCode,
//                 sp:double.parse( itemMasterData.itemdata![ij].sp.toString()),
//                 ssp1:double.parse( itemMasterData.itemdata![ij].ssp1.toString()),
//                 ssp2: double.parse(itemMasterData.itemdata![ij].ssp2.toString()),
//                 ssp3:double.parse( itemMasterData.itemdata![ij].ssp3.toString()),
//                 ssp4: double.parse(itemMasterData.itemdata![ij].ssp4.toString()),
//                 ssp5: double.parse(itemMasterData.itemdata![ij].ssp5.toString()),
//                 ssp1Inc:double.parse( itemMasterData.itemdata![ij].ssp1Inc.toString()),
//                 ssp2Inc: double.parse(itemMasterData.itemdata![ij].ssp2Inc.toString()),
//                 ssp3Inc: double.parse(itemMasterData.itemdata![ij].ssp3Inc.toString()),
//                 ssp4Inc: double.parse(itemMasterData.itemdata![ij].ssp4Inc.toString()),
//                 ssp5Inc:double.parse( itemMasterData.itemdata![ij].ssp5Inc.toString()),
//                 allowNegativeStock:
//                 itemMasterData.itemdata![ij].allowNegativeStock.toString().isEmpty?false:   bool.parse( itemMasterData.itemdata![ij].allowNegativeStock.toString()),
//                 allowOrderBelowCost:
//                   itemMasterData.itemdata![ij].allowOrderBelowCost.toString().isEmpty?false: bool.parse( itemMasterData.itemdata![ij].allowOrderBelowCost.toString()),
//                 isFixedPrice:itemMasterData.itemdata![ij].isFixedPrice.toString().isEmpty?false:bool.parse( itemMasterData.itemdata![ij].isFixedPrice.toString()),
//                 validTill: itemMasterData.itemdata![ij].validTill.toString(),
//                 color: itemMasterData.itemdata![ij].color!.replaceAll("'", "''")
//               //
//               ));
//             // log("valuesInserMaster2222" + valuesInserMaster.length.toString());
//             // dbHelper.insertdocuments(valuesInserMaster[ij]);
//           }

          //old loop
          // for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
          //   valuesInserMaster.add(ItemMasterDBModel(
          //     storeAgeSlab1:itemMasterData.itemdata![ij].storeAgeSlab1,
          //     storeAgeSlab2:itemMasterData.itemdata![ij].storeAgeSlab2,
          //     storeAgeSlab3:itemMasterData.itemdata![ij].storeAgeSlab3,
          //     storeAgeSlab4:itemMasterData.itemdata![ij].storeAgeSlab4,
          //     storeAgeSlab5:itemMasterData.itemdata![ij].storeAgeSlab5,
          //     whsAgeSlab1:itemMasterData.itemdata![ij].whsAgeSlab1,
          //     whsAgeSlab2:itemMasterData.itemdata![ij].whsAgeSlab2,
          //     whsAgeSlab3:itemMasterData.itemdata![ij].whsAgeSlab3,
          //     whsAgeSlab4:itemMasterData.itemdata![ij].whsAgeSlab4,
          //     whsAgeSlab5:itemMasterData.itemdata![ij].whsAgeSlab5,
          //     payOn:itemMasterData.itemdata![ij].payOn!,
          //     calcType:itemMasterData.itemdata![ij].calcType!,
          //       id: itemMasterData.itemdata![ij].id!,
          //       itemCode: itemMasterData.itemdata![ij].itemcode!.replaceAll("'", "''"),
          //       brand: itemMasterData.itemdata![ij].Brand!.replaceAll("'", "''"),
          //       division: itemMasterData.itemdata![ij].Division!.replaceAll("'", "''"),
          //       category: itemMasterData.itemdata![ij].Category!.replaceAll("'", "''"),
          //       itemName: itemMasterData.itemdata![ij].itemName!.replaceAll("'", "''"),
          //       segment: itemMasterData.itemdata![ij].Segment!,
          //       isselected: 0,
          //       favorite: itemMasterData.itemdata![ij].Favorite!,
          //       mgrPrice: double.parse(
          //           itemMasterData.itemdata![ij].MgrPrice.toString()),
          //       slpPrice: double.parse(
          //           itemMasterData.itemdata![ij].SlpPrice.toString()),
          //       storeStock: double.parse(
          //           itemMasterData.itemdata![ij].StoreStock.toString()),
          //       whsStock: double.parse(
          //           itemMasterData.itemdata![ij].WhsStock.toString()),
          //       refreshedRecordDate: date,
          //       itemDescription: itemMasterData.itemdata![ij].itemDescription!.replaceAll("'", "''"),
          //       modelNo: itemMasterData.itemdata![ij].modelNo!.replaceAll("'", "''"),
          //       partCode: itemMasterData.itemdata![ij].partCode!.replaceAll("'", "''"),
          //       skucode: itemMasterData.itemdata![ij].skucode,
          //       brandCode: itemMasterData.itemdata![ij].brandCode!.replaceAll("'", "''"),
          //       itemGroup: itemMasterData.itemdata![ij].itemGroup!.replaceAll("'", "''"),
          //       specification: itemMasterData.itemdata![ij].specification!.replaceAll("'", "''"),
          //       sizeCapacity: itemMasterData.itemdata![ij].sizeCapacity,
          //       clasification: itemMasterData.itemdata![ij].clasification!.replaceAll("'", "''"),
          //       uoM: itemMasterData.itemdata![ij].uoM,
          //       taxRate: itemMasterData.itemdata![ij].taxRate,
          //       catalogueUrl1: itemMasterData.itemdata![ij].catalogueUrl1,
          //       catalogueUrl2: itemMasterData.itemdata![ij].catalogueUrl2,
          //       imageUrl1: itemMasterData.itemdata![ij].imageUrl1,
          //       imageUrl2: itemMasterData.itemdata![ij].imageUrl2,
          //       textNote: itemMasterData.itemdata![ij].textNote,
          //       status: itemMasterData.itemdata![ij].status,
          //       movingType: itemMasterData.itemdata![ij].movingType,
          //       eol: itemMasterData.itemdata![ij].eol,
          //       veryFast: itemMasterData.itemdata![ij].veryFast,
          //       fast: itemMasterData.itemdata![ij].fast,
          //       slow: itemMasterData.itemdata![ij].slow,
          //       verySlow: itemMasterData.itemdata![ij].verySlow,
          //       serialNumber: itemMasterData.itemdata![ij].serialNumber,
          //       priceStockId: itemMasterData.itemdata![ij].priceStockId,
          //       storeCode: itemMasterData.itemdata![ij].storeCode,
          //       whseCode: itemMasterData.itemdata![ij].whseCode,
          //       sp: itemMasterData.itemdata![ij].sp,
          //       ssp1: itemMasterData.itemdata![ij].ssp1,
          //       ssp2: itemMasterData.itemdata![ij].ssp2,
          //       ssp3: itemMasterData.itemdata![ij].ssp3,
          //       ssp4: itemMasterData.itemdata![ij].ssp4,
          //       ssp5: itemMasterData.itemdata![ij].ssp5,
          //       ssp1Inc: itemMasterData.itemdata![ij].ssp1Inc,
          //       ssp2Inc: itemMasterData.itemdata![ij].ssp2Inc,
          //       ssp3Inc: itemMasterData.itemdata![ij].ssp3Inc,
          //       ssp4Inc: itemMasterData.itemdata![ij].ssp4Inc,
          //       ssp5Inc: itemMasterData.itemdata![ij].ssp5Inc,
          //       allowNegativeStock:
          //           itemMasterData.itemdata![ij].allowNegativeStock,
          //       allowOrderBelowCost:
          //           itemMasterData.itemdata![ij].allowOrderBelowCost,
          //       isFixedPrice: itemMasterData.itemdata![ij].isFixedPrice,
          //       validTill: itemMasterData.itemdata![ij].validTill.toString(),
          //       color: itemMasterData.itemdata![ij].color!.replaceAll("'", "''")));
          //   // log("valuesInserMaster2222" + valuesInserMaster.length.toString());
          //   // dbHelper.insertdocuments(valuesInserMaster[ij]);
          // }
          //  stopwatch.stop();
            // log('API ITEMMASTER ${stopwatch.elapsedMilliseconds} milliseconds');
        } else if (itemMasterData.itemdata == null) {
          exception = true;
          errorMsg = 'No data - ItemMaster..!!';
          notifyListeners();
        }
        notifyListeners();
      } else if (itemMasterData.stcode! >= 400 &&
          itemMasterData.stcode! <= 410) {
        exception = true;
        errorMsg = '${itemMasterData.exception}..${itemMasterData.message}..!!';
        notifyListeners();
      } else if (itemMasterData.stcode == 500) {
        exception = true;
        errorMsg =
            '${itemMasterData.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
  //     });
  log("valuesInserMaster::"+valuesInserMaster.length.toString());
    final stopwatch2 = Stopwatch()..start();
     await   DBOperation.insertItemMaster(valuesInserMaster, db);
     stopwatch2.stop();
      log('DB DBOperationitem ${stopwatch2.elapsedMilliseconds} milliseconds');
  //  List<Map<String, Object?>> assignDB =
  //       await DBOperation.getstorecode("ItemCode", db);
  storelistdata.clear();
await userbyidApi.getData(ConstantValues.UserId).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        
        ConstantValues.userbyidmobile = value.ageLtData!.mobile!;
        if(value.ageLtData!.storelistdata !=null){
           storelistdata=value.ageLtData!.storelistdata!;
        
        }
       
      
      }
    });
  //       await ItemViewApiNew.getData(assignDB[0]["ItemCode"].toString()).then((value) {
  // if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.itemdatahead!.itemdata! != null && value.itemdatahead!.itemdata!.isNotEmpty) {
  //        itemviewdata=value.itemdatahead!.itemdata!;
  //         // spilitDatafirst(value.getvisitheaddata!.getvisitdetailsdata!);
  //         isloading = false;
  //         log("itemviewdata:::"+itemviewdata.length.toString());
  //         notifyListeners();
  //       } else if (value.itemdatahead!.itemdata == null|| value.itemdatahead!.itemdata!.isEmpty) {
  //         isloading = false;
  //         // lottie='Assets/no-data.png';
  //         errortabMsg = 'No data..!!';
        
  //         notifyListeners();
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       //   lottie='';
  //       isloading = false;
  //       errortabMsg =
  //           '${value.exception}..${value.message}..!!';
        
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       isloading = false;
  //         // lottie='Assets/NetworkAnimation.json';
  //       errortabMsg =
  //           '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
       
  //       notifyListeners();
  //     }
  // });
//  log("itemviewdata:::"+storelistdata.toString());
        log("itemviewdata:::"+storelistdata.length.toString());
         if(storelistdata !=null && storelistdata.isNotEmpty){
if(storelistdata.length>1){
        ConstantValues.  multistoreuser =1;
        notifyListeners();
        }else{
          ConstantValues.  multistoreuser =0;
          notifyListeners();
        }
         }else{
            ConstantValues.  multistoreuser =0;
          notifyListeners();
         }
        
        log("ConstantValues.  multistoreuserL::"+ConstantValues.  multistoreuser.toString());
     stopwatch.stop();
            // log('API Defaultinitila api ${stopwatch.elapsedMilliseconds} milliseconds');

    // insetitemMaste(valuesInserMaster);
    // 
     await Future.delayed(Duration(seconds: 1));
  await  callsecondaryApi();
  var time2 = DateTime.now();
  var d = time2.difference(time);
    // log("Finished ${valuesInserMaster.length} in $d");
    notifyListeners();
      // Get.offAllNamed(ConstantRoutes.dashboard);
  }
  
bool isloading=false;
String errortabMsg='';

List<storesListDtos> storelistdata=[];
List<ItemViewNewData> itemviewdata=[];
insetitemMaste(List<ItemMasterDBModel> valuesInserMaster)async{
   final stopwatch = Stopwatch()..start();
        log("Start:insetitemMaste " );
   final Database db = (await DBHelper.getInstance())!;
await DBOperation.insertItemMaster(valuesInserMaster, db);
 stopwatch.stop();
 List<Map<String, Object?>> assignDB =
        await DBOperation.getstorecode("StoreCode", db);
 log("assignDBaaaa:::"+assignDB.toString());
        log("assignDB:::"+assignDB.length.toString());
        if(assignDB.length>1){
        ConstantValues.  multistoreuser =1;
        }else{
          ConstantValues.  multistoreuser =0;
        }
            // log('API insetitemMaste api ${stopwatch.elapsedMilliseconds} milliseconds');
           notifyListeners(); 
}
  String? content;
  Future<void> updateDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return WillPopScope(
              onWillPop: dialogBackBun,
              child: AlertDialog(
                //content:
                title: Text(
                  "Upgrade Information",
                ),
                content: Container(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                      "This app is currently not supported.Please upgrade to enjoy our service.")
                ])),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        //  Navigator.of(context).pop();
                        // Navigator.of(context).pop(true);
                        exit(0);
                      },
                      child: Text(
                        "No",
                      ),
                      style: TextButton.styleFrom(backgroundColor: Colors.red)),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          _launchInBrowser(toLaunch!);
                        });
                      },
                      child: Text(
                        "Yes",
                      ))
                ],
              ),
            );
          });
        });
  }

  String? toLaunch;
  //"https://drive.google.com/file/d/15zlBCFGgrZLuklr4dlGloltjCPryxEUv/view?usp=sharing";
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  DateTime? currentBackPressTime;
  Future<bool> dialogBackBun() {
    //if is not work check material app is on the code
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    // print("objectqqqqq");
    return Future.value(false);
  }

  Future<int> getDefaultValues() async {
    int i = 0;
    await HelperFunctions.getSapURLSharedPreference().then((value) {
      if (value != null) {
        Url.SLUrl = value;
        // print("url: ${ Url.SLUrl}");
      }
      i = i + 1;
    });
    await HelperFunctions.getSlpCode().then((value) {
      if (value != null) {
        ConstantValues.slpcode = value;
        log("ConstantValues.slpcode : ${ConstantValues.slpcode}");
      }
      i = i + 1;
    });
    await HelperFunctions.getTenetIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.tenetID = value;
        //   print("url: ${ConstantValues.sapSessions}");
      }
      i = i + 1;
    });

    return i;
  }
}

setMenuAuth(MenuAuthModel menuAuthModel) {
  for (int i = 0; i < menuAuthModel.menuAuthData!.length; i++) {
    if (menuAuthModel.menuAuthData![i].MenuName == "ScoreCard") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.ScoreCard = 'Y';
      } else {
        MenuAuthDetail.ScoreCard = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Quotes") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.quotes = 'Y';
      } else {
        MenuAuthDetail.quotes = 'N';
      }
    }
     if (menuAuthModel.menuAuthData![i].MenuName == "Order-modify") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.ordermodify = 'Y';
      } else {
        MenuAuthDetail.ordermodify = 'N';
      }
    }
     if (menuAuthModel.menuAuthData![i].MenuName == "Collection-cancelupdate") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.cocancelupdate = 'Y';
      } else {
        MenuAuthDetail.cocancelupdate = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Order-PDF") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.orderpdf = 'Y';
      } else {
        MenuAuthDetail.orderpdf = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Order-InvoiceUpdate") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.isinvoice = 'Y';
      } else {
        MenuAuthDetail.isinvoice = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Order-DeliveryUpdate") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.isdeliver = 'Y';
      } else {
        MenuAuthDetail.isdeliver = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Earnings") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Earnings = 'Y';
      } else {
        MenuAuthDetail.Earnings = 'N';
      }
    }if (menuAuthModel.menuAuthData![i].MenuName == "Special Price") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.specialprice = 'Y';
      } else {
        MenuAuthDetail.specialprice = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Performance") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Performance = 'Y';
      } else {
        MenuAuthDetail.Performance = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Outstanding") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.outstanding = 'Y';
      } else {
        MenuAuthDetail.outstanding = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Target") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Target = 'Y';
      } else {
        MenuAuthDetail.Target = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Challenges") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Challenges = 'Y';
      } else {
        MenuAuthDetail.Challenges = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Stocks") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Stocks = 'Y';
      } else {
        MenuAuthDetail.Stocks = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "PriceList") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.PriceList = 'Y';
      } else {
        MenuAuthDetail.PriceList = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "OfferZone") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.OfferZone = 'Y';
      } else {
        MenuAuthDetail.OfferZone = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Enquiries") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Enquiries = 'Y';
      } else {
        MenuAuthDetail.Enquiries = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Walkins") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Walkins = 'Y';
      } else {
        MenuAuthDetail.Walkins = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Leads") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Leads = 'Y';
      } else {
        MenuAuthDetail.Leads = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Orders") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Orders = 'Y';
      } else {
        MenuAuthDetail.Orders = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Followup") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Followup = 'Y';
      } else {
        MenuAuthDetail.Followup = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Accounts") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Accounts = 'Y';
      } else {
        MenuAuthDetail.Accounts = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Profile") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Profile = 'Y';
      } else {
        MenuAuthDetail.Profile = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Dashboard") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Dashboard = 'Y';
      } else {
        MenuAuthDetail.Dashboard = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "KPI") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.KPI = 'Y';
      } else {
        MenuAuthDetail.KPI = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Feeds") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Feeds = 'Y';
      } else {
        MenuAuthDetail.Feeds = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "NewFeeds") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.NewFeeds = 'Y';
      } else {
        MenuAuthDetail.NewFeeds = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Analytics") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Analytics = 'Y';
      } else {
        MenuAuthDetail.Analytics = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Activities") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Activities = 'Y';
      } else {
        MenuAuthDetail.Activities = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "DayStartEnd") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.DayStartEnd = 'Y';
      } else {
        MenuAuthDetail.DayStartEnd = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Visitplane") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Visitplane = 'Y';
      } else {
        MenuAuthDetail.Visitplane = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "SiteIn") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.SiteIn = 'Y';
      } else {
        MenuAuthDetail.SiteIn = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "SiteOut") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.SiteOut = 'Y';
      } else {
        MenuAuthDetail.SiteOut = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "LeaveRequest") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.LeaveRequest = 'Y';
      } else {
        MenuAuthDetail.LeaveRequest = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "LeaveApproval") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.LeaveApproval = 'Y';
      } else {
        MenuAuthDetail.LeaveApproval = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Collection") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Collection = 'Y';
      } else {
        MenuAuthDetail.Collection = 'N';
      }
    }
    if (menuAuthModel.menuAuthData![i].MenuName == "Settlement") {
      if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
        MenuAuthDetail.Settlement = 'Y';
      } else {
        MenuAuthDetail.Settlement = 'N';
      }
    }
  }
}

// callApi() async {
//   int initial = 1;
//   String url =
//       "Items?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment,Properties1,ItemPrices,ItemWarehouseInfoCollection";

//   await HelperFunctions.getDownloadedSharedPreference().then((value) {
//     if (value == true) {
//       // await dbHelper.truncareItemMaster();
//       //  await dbHelper.truncareItemMasterPrice();
//     }
//   });
//   List<ItemMasterDBModel> valuesInserMaster = [];
//   List<ItemMasterPriceDBModel> valuesInsertMasterPrice = [];
//   for (int i = 0; i < initial; i++) {
//     log(url);
//     log("initaial: " + initial.toString());
//     await ItemMasterApi.getData(url).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         exception = false;
//         if (value.nextLink != 'null') {
//           print("nexturl: ${value.nextLink}");
//           initial = initial + 1;
//           url = value.nextLink!.replaceAll("/b1s/v1/", "");
//           print("nexturl22: $url");
//           for (int ij = 0; ij < value.itemValueValue!.length; ij++) {
//             valuesInserMaster.add(ItemMasterDBModel(
//                 itemCode: value.itemValueValue![ij].itemCode,
//                 brand: value.itemValueValue![ij].brand!,
//                 division: value.itemValueValue![ij].division!,
//                 category: value.itemValueValue![ij].category!,
//                 itemName: value.itemValueValue![ij].itemName!,
//                 segment: value.itemValueValue![ij].segement!,
//                 isselected: 0,
//                 favorite: value.itemValueValue![ij].properties1!,
//                 mgrPrice: null,
//                 slpPrice: null,
//                 storeStock: null,
//                 whsStock: null

//                 ));
//             for (int ijk = 0;
//                 ijk < value.itemValueValue![ij].itemPrices!.length;
//                 ijk++) {
//               if (value.itemValueValue![ij].itemPrices![ijk].PriceList == 1 ||
//                   value.itemValueValue![ij].itemPrices![ijk].PriceList == 2) {
//                 valuesInsertMasterPrice.add(ItemMasterPriceDBModel(
//                     priceList: value
//                         .itemValueValue![ij].itemPrices![ijk].PriceList
//                         .toString(),
//                     price: value.itemValueValue![ij].itemPrices![ijk].price!,
//                     foriegnKey: (valuesInserMaster.length).toString()));
//               }
//             }//next
//           }

//           log("valuesInserMaster: " + valuesInserMaster.length.toString());
//           log("valuesInsertMasterPrice: " +
//               valuesInsertMasterPrice.length.toString());
//         } else if (value.nextLink == 'null') {
//           //print("no nexturl: ${value.nextLink}");
//           initial = -1;
//         }
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         exception = true;
//         errorMsg = '${value.error!.message!.value}';
//         notifyListeners();
//       } else if (value.stcode == 500) {
//         exception = true;
//         errorMsg = '${value.exception}';
//         notifyListeners();
//       }
//     });
//     // print("i: ${i}");
//     // print("initial: ${initial}");
//     if (initial == -1) {
//       await dbHelper.insertItemMaster(valuesInserMaster).then((value) {
//         dbHelper.insertItemMasterPrice(valuesInsertMasterPrice).then((value) {
//           HelperFunctions.saveDonloadednSharedPreference(true).then((value) {
//             Get.offAllNamed(ConstantRoutes.dashboard);
//           });
//         });
//       });
//       break;
//     }
//   }
// }

    //    await HelperFunctions.getDownloadedSharedPreference().then((value) async{
    //   if (value == true) {
    //     log("data cleared");
    //   }
    // });
    // String dataIpadd = (await HelperFunctions.getHostDSP())!;






// // ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison

// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sellerkit/Constant/constant_sapvalues.dart';

// import 'package:sellerkit/Constant/DataBaseConfig.dart';
// import 'package:sellerkit/Constant/Encripted.dart';
// import 'package:sellerkit/DBModel/TestDbmodel1.dart';
// import 'package:sellerkit/DBModel/stateDBModel.dart';
// import 'package:sellerkit/DBModel/testdbmodel2.dart';
// import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
// import 'package:sellerkit/Models/TestModel.dart';
// import 'package:sellerkit/Models/stateModel/stateModel.dart';
// import 'package:sellerkit/Services/OfferZoneApi/OfferZoneAPi.dart';
// import 'package:sellerkit/Services/StateApi/stateApi.dart';
// import 'package:sellerkit/Services/testApi.dart';
// import 'package:sellerkit/main.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../Constant/AppConstant.dart';
// import '../../Constant/Configuration.dart';
// import 'package:sellerkit/Constant/constant_routes.dart';
// import '../../Constant/Helper.dart';
// import '../../Constant/MenuAuth.dart';
// import '../../DBHelper/DBHelper.dart';
// import '../../DBHelper/DBOperation.dart';
// import '../../DBModel/ItemMasertDBModel.dart';
// import '../../Models/CustomerMasterModel/CustomerMasterModel.dart';
// import '../../Models/MenuAuthModel/MenuAuthModel.dart';
// import '../../Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
// import '../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
// import '../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';
// import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
// import '../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
// import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
// import '../../Models/PostQueryModel/ProfileModel.dart/ProfileModel.dart';
// import '../../Services/CustomerMasterApi/CustomerMasterApi.dart';
// import '../../Services/MenuAuthApi/MenuAuthApi.dart';
// import '../../Services/PostQueryApi/EnquiriesApi/CustomerTag.dart';
// import '../../Services/PostQueryApi/EnquiriesApi/GetEnqReffers.dart';
// import '../../Services/PostQueryApi/EnquiriesApi/GetEnqType.dart';
// import '../../Services/PostQueryApi/EnquiriesApi/GetUserApi.dart';
// import '../../Services/PostQueryApi/ItemMasterApi/ItemMasterApiNew.dart';
// import '../../Services/PostQueryApi/LeadsApi/GetLeadStatusApi.dart';
// import '../../Services/PostQueryApi/ProfileApi/ProfileApi.dart';
// import '../../Services/URL/LocalUrl.dart';
// import '../../Services/VersionApi/VersionApi.dart';

// class DownLoadController extends ChangeNotifier {
//   String errorMsg = 'Some thing went wrong';
//   bool exception = false;
//   bool get getException => exception;
//   String get getErrorMsg => errorMsg;
//   Config config = new Config();

//   // Future<void> createDB() async {
//   //   await DBOperation.createDB().then((value) {
//   //     print("Value created....!!");
//   //   });
//   // }

//   setURL() async {
//     String? getUrl = await HelperFunctions.getHostDSP();
//     log("getUrl $getUrl");
//     ConstantValues.userNamePM = await HelperFunctions.getUserName();
//     Url.queryApi = 'http://${getUrl.toString()}/api/';
//   }

//   ItemMasterApiNew itemMasterApiNew = ItemMasterApiNew();
//   // TestNew testnew=TestNew();
//   EnquiryTypeApi enquiryTypeApi = EnquiryTypeApi();
//   CustomerTagTypeApi customerTagTypeApi = CustomerTagTypeApi();

//   EnquiryRefferesApi enquiryRefferesApi = EnquiryRefferesApi();
//   GetUserApi getUserApi = GetUserApi();
//   GetLeadStatusApi getLeadStatusApi = GetLeadStatusApi();
//   ProfileApi profileApi = ProfileApi();
//   OfferZoneApi1 offerZoneApi1 = OfferZoneApi1();
//   MenuAuthApi menuAuth = MenuAuthApi();
//   CustomerMasterApiNew customerMaster1 = CustomerMasterApiNew();
//   stateApiNew steteApinew = stateApiNew();

//   callApiNew(BuildContext context) async {
//     log("123:");
//     final Database db = (await DBHelper.getInstance())!;
//     DataBaseConfig.ip = (await HelperFunctions.gethostIP())!;
//     // Map<Permission, PermissionStatus> statuses = await [
//     //  await checkLocation();
//     EncryptData enc = new EncryptData();
//     if (ConstantValues.langtitude!.isEmpty || ConstantValues.langtitude == '') {
//       ConstantValues.langtitude = '0.000';
//     }
//     if (ConstantValues.latitude!.isEmpty || ConstantValues.latitude == '') {
//       ConstantValues.latitude = '0.000';
//     }
//     ConstantValues.headerSetup =
//         "${ConstantValues.latitude};${ConstantValues.langtitude};${ConstantValues.ipname};${ConstantValues.ipaddress}";
   
//     log("before Encryped Location Header:::" +
//         ConstantValues.headerSetup.toString());

//     String? encryValue = enc.encryptAES("${ConstantValues.headerSetup}");
//     log("Encryped Location Header:::" + encryValue.toString());
//     ConstantValues.EncryptedSetup = encryValue;
//     notifyListeners();
//     Future.delayed(Duration(seconds: 3));
//     //   Permission.camera,
//     // ].request();
// // await config.getSetup();
//     // Handle the statuses as needed
//     // print('Location status: ${statuses[Permission.location]}');
//     // print('Camera status: ${statuses[Permission.camera]}');

//     // DataBaseConfig.database = (await HelperFunctions.getuserDB())!;
//     // DataBaseConfig.password = (await HelperFunctions.getdbPassword())!;
//     DataBaseConfig.userId = (await HelperFunctions.getdbUserName())!;
//     await DBOperation.truncustomerMaster(db);
//     await DBOperation.truncareItemMaster(db);
//     await DBOperation.truncareEnqType(db);
//     await DBOperation.truncareCusTagType(db);
//     await DBOperation.trunstateMaster(db);
//     await DBOperation.truncareEnqReffers(db);
//     await DBOperation.truncateUserList(db);
//     await DBOperation.truncateLeadstatus(db);
//     await DBOperation.truncateOfferZone(db);
//     await DBOperation.truncateOfferZonechild1(db);
//     await DBOperation.truncateOfferZonechild2(db);
//      await DBOperation.truncatetableitemlist1(db);
//       await DBOperation.truncatetableitemlist2(db);


//     await VersionApi.getData().then((value) async {
//       log("123456:");

//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.itemdata != null) {
//           toLaunch = value.itemdata![0].url;
//           content = value.itemdata![0].content;
//           if (value.itemdata![0].version == AppConstant.version) {
//             callDefaultApi();
//           } else {
//             updateDialog(context);
//           }
//           notifyListeners();
//         } else if (value.itemdata! == null) {
//           exception = true;
//           errorMsg = "${value.exception}..!! ";
//           notifyListeners();
//         }
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         exception = true;
//         errorMsg = "${value.exception}..${value.message}..!! ";
//         notifyListeners();
//       } else if (value.stcode! == 500) {
//         exception = true;
//         errorMsg = "${value.stcode!}..!!Network Issue..\nTry again Later..!!";
//         notifyListeners();
//         notifyListeners();
//       }
//     });
//   }
//   String? loadingApi='';

//   callDefaultApi() async {
//     List<ItemMasterDBModel> valuesInserMaster = [];
// Itemlistdata1? valueitemlist1;
// Itemlistdata2? valueitemlist2;
//     List<EnquiryTypeData> enqTypeData = [];
//     List<CustomerTagTypeData> customerTagTypeData = [];
//     List<CustomerData> customerdata = [];

//     List<EnqRefferesData> enqReffdata = [];

//     List<UserListData> userListData = [];

//     List<GetLeadStatusData> leadcheckdata = [];
//     List<stateHeaderData> stateData = [];

//     List<OfferZoneData> offerzone = [];
//     List<offerproductlist> offerproduct = [];
//     List<offerstorelist> offerstore = [];
//     //New one
//     // List<StateMasterDBModel> valuesStateMaster = [];
//     // stateDetails statedata=await steteApinew.getData();
//     loadingApi="ItemMasterData";
//     ItemMasterNewModal itemMasterData = await itemMasterApiNew.getData();
//     // ItemListheader itemListheader=await testnew.getData();
// //     if(itemListheader.stcode! >=200 && itemListheader.stcode! <=200){
// //        exception = false;
// //        if(itemListheader.itemlispardara !=null){
// //         for (int ij = 0; ij < itemListheader.itemlispardara!.length; ij++) {
// //  final Database db = (await DBHelper.getInstance())!;
// // valueitemlist1=itemListheader.itemlispardara![ij].itemlist1!;

// // valueitemlist2=itemListheader.itemlispardara![ij].itemlist2!;
// // await DBOperation.insertitemlist1(valueitemlist1, db);
// // await DBOperation.insertitemlist2(valueitemlist2, db);
// // notifyListeners();
// //         }
// //        }
// //        log("valueitemlist1::"+valueitemlist1!.eol.toString());
// //     }
    
//     if (itemMasterData.stcode! >= 200 && itemMasterData.stcode! <= 210) {
      
//       exception = false;
//       // log("Api itemMasterData.itemdata!.length ${itemMasterData.itemdata!}");

//       if (itemMasterData.itemdata != null) {
//         String date = config.currentDate();
//         // log("Api itemMasterData.itemdata!.length ${itemMasterData.itemdata!.length}");
//         for (int ij = 0; ij < itemMasterData.itemdata!.length; ij++) {
//           valuesInserMaster.add(ItemMasterDBModel(
//               id: itemMasterData.itemdata![ij].id!,
//               itemCode: itemMasterData.itemdata![ij].itemcode,
//               brand: itemMasterData.itemdata![ij].Brand!,
//               division: itemMasterData.itemdata![ij].Division!,
//               category: itemMasterData.itemdata![ij].Category!,
//               itemName: itemMasterData.itemdata![ij].itemName!,
//               segment: itemMasterData.itemdata![ij].Segment!,
//               isselected: 0,
//               favorite: itemMasterData.itemdata![ij].Favorite!,
//               mgrPrice: double.parse(
//                   itemMasterData.itemdata![ij].MgrPrice.toString()),
//               slpPrice: double.parse(
//                   itemMasterData.itemdata![ij].SlpPrice.toString()),
//               storeStock: double.parse(
//                   itemMasterData.itemdata![ij].StoreStock.toString()),
//               whsStock: double.parse(
//                   itemMasterData.itemdata![ij].WhsStock.toString()),
//               refreshedRecordDate: date,
//               itemDescription:itemMasterData.itemdata![ij].itemDescription,
//               modelNo:itemMasterData.itemdata![ij].modelNo,
//               partCode: itemMasterData.itemdata![ij].partCode,
//               skucode:itemMasterData.itemdata![ij].skucode,
//               brandCode:itemMasterData.itemdata![ij].brandCode,
//               itemGroup:itemMasterData.itemdata![ij].itemGroup,
//               specification:itemMasterData.itemdata![ij].specification,
//               sizeCapacity:itemMasterData.itemdata![ij].sizeCapacity,
//               clasification:itemMasterData.itemdata![ij].clasification,
//               uoM:itemMasterData.itemdata![ij].uoM,
//               taxRate:itemMasterData.itemdata![ij].taxRate,
//               catalogueUrl1:itemMasterData.itemdata![ij].catalogueUrl1,
//               catalogueUrl2:itemMasterData.itemdata![ij].catalogueUrl2,
//               imageUrl1:itemMasterData.itemdata![ij].imageUrl1,
//               imageUrl2:itemMasterData.itemdata![ij].imageUrl2,
//               textNote:itemMasterData.itemdata![ij].textNote,
//               status:itemMasterData.itemdata![ij].status,
//               movingType:itemMasterData.itemdata![ij].movingType,
//               eol:itemMasterData.itemdata![ij].eol,
//               veryFast:itemMasterData.itemdata![ij].veryFast,
//               fast:itemMasterData.itemdata![ij].fast,
//               slow:itemMasterData.itemdata![ij].slow,
//               verySlow:itemMasterData.itemdata![ij].verySlow,
//               serialNumber:itemMasterData.itemdata![ij].serialNumber,
//               priceStockId:itemMasterData.itemdata![ij].priceStockId,
//               storeCode:itemMasterData.itemdata![ij].storeCode,
//               whseCode:itemMasterData.itemdata![ij].whseCode,
//               sp:itemMasterData.itemdata![ij].sp,
//               ssp1:itemMasterData.itemdata![ij].ssp1,
//               ssp2:itemMasterData.itemdata![ij].ssp2,
//               ssp3:itemMasterData.itemdata![ij].ssp3,
//               ssp4:itemMasterData.itemdata![ij].ssp4,
//               ssp5:itemMasterData.itemdata![ij].ssp5,
//               ssp1Inc:itemMasterData.itemdata![ij].ssp1Inc,
//               ssp2Inc:itemMasterData.itemdata![ij].ssp2Inc,
//               ssp3Inc:itemMasterData.itemdata![ij].ssp3Inc,
//               ssp4Inc:itemMasterData.itemdata![ij].ssp4Inc,
//               ssp5Inc:itemMasterData.itemdata![ij].ssp5Inc,
//               allowNegativeStock:itemMasterData.itemdata![ij].allowNegativeStock,
//               allowOrderBelowCost:itemMasterData.itemdata![ij].allowOrderBelowCost,
//               isFixedPrice:itemMasterData.itemdata![ij].isFixedPrice,
//               validTill:itemMasterData.itemdata![ij].validTill.toString(),
//               color:itemMasterData.itemdata![ij].color.toString()






              
              
//               ));
//           // log("valuesInserMaster" + valuesInserMaster.length.toString());
//           // dbHelper.insertdocuments(valuesInserMaster[ij]);
//         }
//       } else if (itemMasterData.itemdata == null) {
//         exception = true;
//         errorMsg = 'No data - ItemMaster..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (itemMasterData.stcode! >= 400 && itemMasterData.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${itemMasterData.exception}..${itemMasterData.message}..!!';
//       notifyListeners();
//     } else if (itemMasterData.stcode == 500) {
//       exception = true;
//       errorMsg = '${itemMasterData.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }
//     // CustomerDetails CustomerDetails2 = await customerMaster1.getData();
//     // loadingApi="CustomerDetails";
//     // // isLoading = false;
//     // if (CustomerDetails2.itemdata == null) {
//     //   // counti = 1;
//     //   // i = 2;!
//     //   notifyListeners();
//     // }
//     // if (CustomerDetails2.stcode! >= 200 && CustomerDetails2.stcode! <= 210) {
//     //   if (CustomerDetails2.itemdata != null) {
//     //     exception = false;
//     //     // errorMsg = '${CustomerDetails2.exception}';

//     //     // mapvalues(CustomerDetails2.itemdata!);
//     //     customerdata = CustomerDetails2.itemdata!;
//     //     // counti = counti! + 1;
//     //     notifyListeners();
//     //   }
//     // } else if (CustomerDetails2.stcode! >= 400 &&
//     //     CustomerDetails2.stcode! <= 410) {
//     //   exception = true;
//     //   errorMsg = '${CustomerDetails2.exception}';
//     //   notifyListeners();
//     // } else if (CustomerDetails2.stcode == 500) {
//     //   if (CustomerDetails2.exception == 'No route to host') {
//     //     exception = true;
//     //     errorMsg = '${CustomerDetails2.exception}';
//     //   } else {
//     //     exception = true;
//     //     errorMsg = '${CustomerDetails2.exception}';
//     //   }
//     //   exception = true;
//     //   errorMsg = '${CustomerDetails2.exception}';
//     //   notifyListeners();
//     // }

//     EnquiryTypeModal enquiryTypeModal =
//         await enquiryTypeApi.getData(ConstantValues.slpcode);
//         loadingApi="EnquiryType";
//     if (enquiryTypeModal.stcode! >= 200 && enquiryTypeModal.stcode! <= 210) {
//       exception = false;
//       if (enquiryTypeModal.itemdata != null) {
//         String date = config.currentDate();
//         // for (int i = 0; i < values.itemdata!.length; i++) {
//         //     enqTypeData.add(EnquiryTypeData(
//         //       Code: values.itemdata![i].Code,
//         //       Name:  values.itemdata![i].Name));
//         // }
//         enqTypeData = enquiryTypeModal.itemdata!;
//       } else if (enquiryTypeModal.itemdata == null) {
//         exception = true;
//         errorMsg = 'No data - Enquiry Type Api..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (enquiryTypeModal.stcode! >= 400 &&
//         enquiryTypeModal.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${enquiryTypeModal.exception}';
//       notifyListeners();
//     } else if (enquiryTypeModal.stcode == 500) {
//       exception = true;
//       errorMsg = '${enquiryTypeModal.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }
// //

//     CustomerTagTypeModal customerTagTypeModal =
//         await customerTagTypeApi.getData(ConstantValues.slpcode);
//          loadingApi="customerTagType";
//     if (customerTagTypeModal.stcode! >= 200 &&
//         customerTagTypeModal.stcode! <= 210) {
//       exception = false;
//       if (customerTagTypeModal.itemdata != null) {
//         String date = config.currentDate();
//         // for (int i = 0; i < values.itemdata!.length; i++) {
//         //     enqTypeData.add(EnquiryTypeData(
//         //       Code: values.itemdata![i].Code,
//         //       Name:  values.itemdata![i].Name));
//         // }
//         customerTagTypeData = customerTagTypeModal.itemdata!;
//       } else if (customerTagTypeModal.itemdata == null) {
//         exception = true;
//         errorMsg = 'No data - Customer Tag Api..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (customerTagTypeModal.stcode! >= 400 &&
//         customerTagTypeModal.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${customerTagTypeModal.exception}';
//       notifyListeners();
//     } else if (customerTagTypeModal.stcode == 500) {
//       exception = true;
//       errorMsg = '${customerTagTypeModal.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }

//     EnqRefferesModal enqRefferesModal =
//         await enquiryRefferesApi.getData(ConstantValues.slpcode);
//         loadingApi="enquiryRefferes";
//     if (enqRefferesModal.stcode! >= 200 && enqRefferesModal.stcode! <= 210) {
//       exception = false;
//       if (enqRefferesModal.enqReffersdata != null) {
//         String date = config.currentDate();

//         enqReffdata = enqRefferesModal.enqReffersdata!;
//       } else if (enqRefferesModal.enqReffersdata == null) {
//         exception = true;
//         errorMsg = 'No data - Enquiry Ref Api..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (enqRefferesModal.stcode! >= 400 &&
//         enqRefferesModal.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${enqRefferesModal.exception}';
//       notifyListeners();
//     } else if (enqRefferesModal.stcode == 500) {
//       exception = true;
//       errorMsg = '${enqRefferesModal.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }
// //New state
//     await stateApiNew.getData().then((value) {
//       loadingApi="stateData";
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.itemdata != null) {
//           exception = false;
//           for (int i = 0; i <= value.itemdata!.datadetail!.length; i++) {
//             stateData = value.itemdata!.datadetail!;
//             // filterstateData = stateData;
//             // log("fil" + stateData.length.toString());
//             notifyListeners();
//             log("stateData::" + stateData.length.toString());
//           }
//         } else if (value.itemdata == null) {
//           exception = true;
//           errorMsg = 'No data - State Api..!!';
//           notifyListeners();
//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         exception = true;
//         errorMsg =
//             '${value.message}..! \n${value.exception}..!!${value.stcode}';

//         notifyListeners();
//       } else if (value.stcode == 500) {
//         exception = true;
//         errorMsg =
//             '${value.stcode!}..!!Network Issue..\nTry again Later..!!';

//         notifyListeners();
//       }
//     });

//     // UserListModal userListModal =
//     //     await getUserApi.getData(ConstantValues.slpcode);
//     // if (userListModal.stcode! >= 200 && userListModal.stcode! <= 210) {
//     //   exception = false;
//     //   if (userListModal.userLtData != null) {
//     //     userListData = userListModal.userLtData!;
//     //     log("message::" + userListData[0].slpcode.toString());
//     //     log("message::" + userListData[0].SalesEmpID.toString());
//     //   } else if (userListModal.userLtData == null) {
//     //     exception = true;
//     //     errorMsg = 'No data - User Api..!!';
//     //     notifyListeners();
//     //   }
//     //   notifyListeners();
//     // } else if (userListModal.stcode! >= 400 && userListModal.stcode! <= 410) {
//     //   exception = true;
//     //   errorMsg = '${userListModal.exception}';
//     //   notifyListeners();
//     // } else if (userListModal.stcode == 500) {
//     //   exception = true;
//     //   errorMsg = '${userListModal.exception}';
//     //   notifyListeners();
//     // }
//     //Old

//     UserListModal userListModal =
//         await getUserApi.getData(ConstantValues.UserId);
//         loadingApi="userListData";
//     if (userListModal.stcode! >= 200 && userListModal.stcode! <= 210) {
//       exception = false;
//       if (userListModal.userLtData != null) {
//         // log("userListModal.userLtData!.length::" +
//         //     userListModal.userLtData!.length.toString());
//         for (int ik = 0; ik < userListModal.userLtData!.length; ik++) {
//           // if(userListModal.userLtData![ik].storeid ==ConstantValues.storeid ){
//           // for(int i=0;i<userListModal.userLtData!.length;i++){
//           userListData.add(UserListData(
//             userCode:userListModal.userLtData![ik].userCode ,
//               storeid: userListModal.userLtData![ik].storeid,
//               mngSlpcode: userListModal.userLtData![ik].mngSlpcode,
//               UserName: userListModal.userLtData![ik].UserName,
//               color: userListModal.userLtData![ik].color,
//               slpcode: userListModal.userLtData![ik].slpcode,
//               SalesEmpID: userListModal.userLtData![ik].SalesEmpID));
//           // = userListModal.userLtData!;

//           // }

//           // log("message222::" +
//           //     userListModal.userLtData![ik].storeid.toString() +
//           //     "AAAA" +
//           //     ConstantValues.storeid.toString());

//           notifyListeners();
//           // log("message::" + userListData.length.toString());
//           // }
//         }
//       } else if (userListModal.userLtData == null) {
//         exception = true;
//         errorMsg = 'No data - User Api..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (userListModal.stcode! >= 400 && userListModal.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${userListModal.exception}';
//       notifyListeners();
//     } else if (userListModal.stcode == 500) {
//       exception = true;
//       errorMsg = '${userListModal.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }

//     GetLeadStatusModal getLeadStatusModal = await getLeadStatusApi.getData();
//     loadingApi="LeadStatusData";
//     if (getLeadStatusModal.stcode! >= 200 &&
//         getLeadStatusModal.stcode! <= 210) {
//       ("statusINININ");
//       exception = false;
//       if (getLeadStatusModal.leadcheckdata != null) {
//         //         for (int i = 0; i < getLeadStatusModal.leadcheckdata!.length; i++) {
//         // //            List<String>     result =  [];

//         // //  result =   ;

//         //         leadcheckdata.add(GetLeadStatusData(
//         //           code: getLeadStatusModal.leadcheckdata![i].code,
//         //           name:getLeadStatusModal.leadcheckdata![i].name!,
//         //           statusType:getLeadStatusModal.leadcheckdata![i].statusType ,
//         //           ));
//         //    //  log("111leadcheckdata"+result.toString());
//         //     }

//         leadcheckdata = getLeadStatusModal.leadcheckdata!;
//       } else if (getLeadStatusModal.leadcheckdata == null) {
//         exception = true;
//         errorMsg = 'No data - LeadStatus Api..!!';
//         notifyListeners();
//       }
//       notifyListeners();
//     } else if (getLeadStatusModal.stcode! >= 400 &&
//         getLeadStatusModal.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${getLeadStatusModal.exception}';
//       notifyListeners();
//     } else if (getLeadStatusModal.stcode == 500) {
//       exception = true;
//       errorMsg = '${getLeadStatusModal.stcode!}..!!Network Issue..\nTry again Later..!!';
//       notifyListeners();
//     }

//     ProfileModel profileModel =
//         await profileApi.getData(ConstantValues.slpcode);
//         loadingApi="profileData";
//     if (profileModel.stcode! >= 200 && profileModel.stcode! <= 210) {
//       if (profileModel.profileData != null) {
//         exception = false;
//         // log("firstName" + profileModel.profileData!.firstName!.toString());
//         await HelperFunctions.saveFSTNameSharedPreference(
//             profileModel.profileData!.firstName!);
//         await HelperFunctions.saveLSTNameSharedPreference(
//             profileModel.profileData!.lastName!);
//         await HelperFunctions.saveBranchSharedPreference(
//             profileModel.profileData!.Branch!);
//         await HelperFunctions.savemobileSharedPreference(
//             profileModel.profileData!.mobile!);
//         await HelperFunctions.saveProfilePicSharedPreference(
//             profileModel.profileData!.ProfilePic!);
//         await HelperFunctions.saveUSERIDSharedPreference(
//             profileModel.profileData!.USERID!);
//         await HelperFunctions.saveemailSharedPreference(
//             profileModel.profileData!.email!);
//         await HelperFunctions.saveManagerPhoneSharedPreference(
//             profileModel.profileData!.managerPhone!);
//         await HelperFunctions.getFSTNameSharedPreference().then((value) {
//           if (value != null) {
//             ConstantValues.firstName = value;
//             notifyListeners();

//             log("firstName" + ConstantValues.firstName.toString());
//           }
//         });
//       } else if (profileModel.profileData == null) {
//         exception = true;
//         errorMsg = '${profileModel.exception}';
//       }
//     } else if (profileModel.stcode! >= 400 && profileModel.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${profileModel.exception}';
//     } else if (profileModel.stcode == 500) {
//       if (profileModel.exception == 'No route to host') {
//         errorMsg = 'Check your Internet Connection...!!';
//       } else {
//         exception = true;
//         errorMsg = '${profileModel.stcode!}..!!Network Issue..\nTry again Later..!!';
//       }
//     }
//     notifyListeners();
//     OfferZoneModel offerZoneModel =
//         await offerZoneApi1.getOfferZone(ConstantValues.storeid);
//         loadingApi="offerZoneData";
//     if (offerZoneModel != null) {
//       exception = false;
//       if (offerZoneModel.stcode! >= 200 && offerZoneModel.stcode! <= 210) {
//         if (offerZoneModel.offerZoneData1 != null) {
//           // print("OfferZoneModel");

//           for (int ij = 0; ij < offerZoneModel.offerZoneData1!.length; ij++) {
//             final Database db = (await DBHelper.getInstance())!;
//             offerzone = offerZoneModel.offerZoneData1!;
//             offerproduct =
//                 offerZoneModel.offerZoneData1![ij].offerproductlistdetails!;
//             offerstore =
//                 offerZoneModel.offerZoneData1![ij].offerstorelistdetails!;
//             await DBOperation.insertOfferZonechild1(offerproduct, db);
//             await DBOperation.insertOfferZonechild2(offerstore, db);
//             log("offerzone" + offerzone.length.toString());
//             // log("offerzone"+offerZoneModel.offerZoneData1![ij].offerstorelistdetails!.toString());
//             log("lrngth" + offerstore.length.toString());
//           }
//         } else if (offerZoneModel.offerZoneData1 == null) {
//           exception = true;
//           errorMsg = 'No data - OfferZone Api..!!';
//         }
//       } else if (offerZoneModel.stcode! >= 400 &&
//           offerZoneModel.stcode! <= 410) {
//         exception = true;
//         errorMsg = '${offerZoneModel.exception}';
//       } else if (offerZoneModel.stcode == 500) {
//         if (offerZoneModel.exception == 'No route to host') {
//           exception = true;
//           errorMsg = '${offerZoneModel.stcode!}..!!Network Issue..\nTry again Later..!!';
//         } else {
//           // exception = true;
//           // errorMsg = '${offerZoneModel.exception}';
//         }
//       }
//       notifyListeners();
//     }

//     MenuAuthModel menuAuthModel = await menuAuth.getOfferZone();
//     loadingApi="menuAuthData";
//     if (menuAuthModel.stcode! >= 200 && menuAuthModel.stcode! <= 210) {
//       if (menuAuthModel.menuAuthData != null) {
//         setMenuAuth(menuAuthModel);
//       } else if (menuAuthModel.menuAuthData == null) {
//         exception = true;
//         errorMsg = 'No data - Menu Authorized..!!';
//       }
//     } else if (menuAuthModel.stcode! >= 400 && menuAuthModel.stcode! <= 410) {
//       exception = true;
//       errorMsg = '${menuAuthModel.exception}';
//     } else if (menuAuthModel.stcode! == 500) {
//       if (menuAuthModel.exception == 'No route to host') {
//         exception = true;
//         errorMsg = '${menuAuthModel.exception}';
//       } else {
//         exception = true;
//         errorMsg = '${menuAuthModel.stcode!}..!!Network Issue..\nTry again Later..!!';
//       }
//     }
//     final Database db = (await DBHelper.getInstance())!;
//     await DBOperation.inserstateMaster(stateData, db);
//     // log("valuesInserMaster: " + valuesInserMaster.length.toString());
//     await DBOperation.insertItemMaster(valuesInserMaster, db);
//     // log("valuesInserCusTag: " + customerTagTypeData.length.toString());

//     await DBOperation.insertCusTagType(customerTagTypeData, db);

//     // log("valuesInserEnq: " + enqTypeData.length.toString());
//     await DBOperation.insertEnqType(enqTypeData, db);
//     // log("enqReffersdata: " + enqReffdata.length.toString());
//     await DBOperation.insertEnqReffers(enqReffdata, db);
//     // log("userListData:" + userListData.length.toString());
//     await DBOperation.insertUserList(userListData, db);
//     await DBOperation.insertLeadStatusList(leadcheckdata, db);
//     // log("leadcheckdata:" + leadcheckdata.length.toString());
//     if (offerzone.isNotEmpty) {
//       await DBOperation.insertOfferZone(offerzone, db);
//     }
//     await DBOperation.inserCustomerMaster(customerdata, db);
//     // log("customerMaster:" + customerdata.length.toString());

//     await HelperFunctions.saveDonloadednSharedPreference(true);

//     Get.offAllNamed(ConstantRoutes.dashboard);
//   }

//   String? content;
//   Future<void> updateDialog(BuildContext context) {
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             return WillPopScope(
//               onWillPop: dialogBackBun,
//               child: AlertDialog(
//                 //content:
//                 title: Text(
//                   "Upgrade Information",
//                 ),
//                 content: Container(
//                     child: Column(mainAxisSize: MainAxisSize.min, children: [
//                   Text(
//                       "This app is currently not supported.Please upgrade to enjoy our service.")
//                 ])),
//                 actions: <Widget>[
//                   TextButton(
//                       onPressed: () {
//                         //  Navigator.of(context).pop();
//                         // Navigator.of(context).pop(true);
//                         exit(0);
//                       },
//                       child: Text(
//                         "No",
//                       ),
//                       style: TextButton.styleFrom(primary: Colors.red)),
//                   TextButton(
//                       onPressed: () async {
//                         setState(() {
//                           _launchInBrowser(toLaunch!);
//                         });
//                       },
//                       child: Text(
//                         "Yes",
//                       ))
//                 ],
//               ),
//             );
//           });
//         });
//   }

//   String? toLaunch;
//   //"https://drive.google.com/file/d/15zlBCFGgrZLuklr4dlGloltjCPryxEUv/view?usp=sharing";
//   Future<void> _launchInBrowser(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: false,
//         forceWebView: false,
//         headers: <String, String>{'my_header_key': 'my_header_value'},
//       );
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> dialogBackBun() {
//     //if is not work check material app is on the code
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
//       currentBackPressTime = now;
//       return Future.value(false);
//     }
//     // print("objectqqqqq");
//     return Future.value(false);
//   }

//   Future<int> getDefaultValues() async {
//     int i = 0;
//     await HelperFunctions.getSapURLSharedPreference().then((value) {
//       if (value != null) {
//         Url.SLUrl = value;
//         // print("url: ${ Url.SLUrl}");
//       }
//       i = i + 1;
//     });
//     await HelperFunctions.getSlpCode().then((value) {
//       if (value != null) {
//         ConstantValues.slpcode = value;
//         log("ConstantValues.slpcode : ${ConstantValues.slpcode}");
//       }
//       i = i + 1;
//     });
//     await HelperFunctions.getTenetIDSharedPreference().then((value) {
//       if (value != null) {
//         ConstantValues.tenetID = value;
//         //   print("url: ${ConstantValues.sapSessions}");
//       }
//       i = i + 1;
//     });

//     return i;
//   }
// }

// setMenuAuth(MenuAuthModel menuAuthModel) {
//   for (int i = 0; i < menuAuthModel.menuAuthData!.length; i++) {
//     if (menuAuthModel.menuAuthData![i].MenuName == "ScoreCard") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.ScoreCard = 'Y';
//       } else {
//         MenuAuthDetail.ScoreCard = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Earnings") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Earnings = 'Y';
//       } else {
//         MenuAuthDetail.Earnings = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Performance") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Performance = 'Y';
//       } else {
//         MenuAuthDetail.Performance = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Target") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Target = 'Y';
//       } else {
//         MenuAuthDetail.Target = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Challenges") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Challenges = 'Y';
//       } else {
//         MenuAuthDetail.Challenges = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Stocks") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Stocks = 'Y';
//       } else {
//         MenuAuthDetail.Stocks = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "PriceList") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.PriceList = 'Y';
//       } else {
//         MenuAuthDetail.PriceList = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "OfferZone") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.OfferZone = 'Y';
//       } else {
//         MenuAuthDetail.OfferZone = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Enquiries") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Enquiries = 'Y';
//       } else {
//         MenuAuthDetail.Enquiries = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Walkins") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Walkins = 'Y';
//       } else {
//         MenuAuthDetail.Walkins = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Leads") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Leads = 'Y';
//       } else {
//         MenuAuthDetail.Leads = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Orders") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Orders = 'Y';
//       } else {
//         MenuAuthDetail.Orders = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Followup") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Followup = 'Y';
//       } else {
//         MenuAuthDetail.Followup = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Accounts") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Accounts = 'Y';
//       } else {
//         MenuAuthDetail.Accounts = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Profile") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Profile = 'Y';
//       } else {
//         MenuAuthDetail.Profile = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Dashboard") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Dashboard = 'Y';
//       } else {
//         MenuAuthDetail.Dashboard = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "KPI") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.KPI = 'Y';
//       } else {
//         MenuAuthDetail.KPI = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Feeds") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Feeds = 'Y';
//       } else {
//         MenuAuthDetail.Feeds = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "NewFeeds") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.NewFeeds = 'Y';
//       } else {
//         MenuAuthDetail.NewFeeds = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Analytics") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Analytics = 'Y';
//       } else {
//         MenuAuthDetail.Analytics = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Activities") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Activities = 'Y';
//       } else {
//         MenuAuthDetail.Activities = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "DayStartEnd") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.DayStartEnd = 'Y';
//       } else {
//         MenuAuthDetail.DayStartEnd = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Visitplane") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Visitplane = 'Y';
//       } else {
//         MenuAuthDetail.Visitplane = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "SiteIn") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.SiteIn = 'Y';
//       } else {
//         MenuAuthDetail.SiteIn = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "SiteOut") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.SiteOut = 'Y';
//       } else {
//         MenuAuthDetail.SiteOut = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "LeaveRequest") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.LeaveRequest = 'Y';
//       } else {
//         MenuAuthDetail.LeaveRequest = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "LeaveApproval") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.LeaveApproval = 'Y';
//       } else {
//         MenuAuthDetail.LeaveApproval = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Collection") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Collection = 'Y';
//       } else {
//         MenuAuthDetail.Collection = 'N';
//       }
//     }
//     if (menuAuthModel.menuAuthData![i].MenuName == "Settlement") {
//       if (menuAuthModel.menuAuthData![i].AuthStatus == "Y") {
//         MenuAuthDetail.Settlement = 'Y';
//       } else {
//         MenuAuthDetail.Settlement = 'N';
//       }
//     }
//   }
// }

// // callApi() async {
// //   int initial = 1;
// //   String url =
// //       "Items?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment,Properties1,ItemPrices,ItemWarehouseInfoCollection";

// //   await HelperFunctions.getDownloadedSharedPreference().then((value) {
// //     if (value == true) {
// //       // await dbHelper.truncareItemMaster();
// //       //  await dbHelper.truncareItemMasterPrice();
// //     }
// //   });
// //   List<ItemMasterDBModel> valuesInserMaster = [];
// //   List<ItemMasterPriceDBModel> valuesInsertMasterPrice = [];
// //   for (int i = 0; i < initial; i++) {
// //     log(url);
// //     log("initaial: " + initial.toString());
// //     await ItemMasterApi.getData(url).then((value) {
// //       if (value.stcode! >= 200 && value.stcode! <= 210) {
// //         exception = false;
// //         if (value.nextLink != 'null') {
// //           print("nexturl: ${value.nextLink}");
// //           initial = initial + 1;
// //           url = value.nextLink!.replaceAll("/b1s/v1/", "");
// //           print("nexturl22: $url");
// //           for (int ij = 0; ij < value.itemValueValue!.length; ij++) {
// //             valuesInserMaster.add(ItemMasterDBModel(
// //                 itemCode: value.itemValueValue![ij].itemCode,
// //                 brand: value.itemValueValue![ij].brand!,
// //                 division: value.itemValueValue![ij].division!,
// //                 category: value.itemValueValue![ij].category!,
// //                 itemName: value.itemValueValue![ij].itemName!,
// //                 segment: value.itemValueValue![ij].segement!,
// //                 isselected: 0,
// //                 favorite: value.itemValueValue![ij].properties1!,
// //                 mgrPrice: null,
// //                 slpPrice: null,
// //                 storeStock: null,
// //                 whsStock: null

// //                 ));
// //             for (int ijk = 0;
// //                 ijk < value.itemValueValue![ij].itemPrices!.length;
// //                 ijk++) {
// //               if (value.itemValueValue![ij].itemPrices![ijk].PriceList == 1 ||
// //                   value.itemValueValue![ij].itemPrices![ijk].PriceList == 2) {
// //                 valuesInsertMasterPrice.add(ItemMasterPriceDBModel(
// //                     priceList: value
// //                         .itemValueValue![ij].itemPrices![ijk].PriceList
// //                         .toString(),
// //                     price: value.itemValueValue![ij].itemPrices![ijk].price!,
// //                     foriegnKey: (valuesInserMaster.length).toString()));
// //               }
// //             }//next
// //           }

// //           log("valuesInserMaster: " + valuesInserMaster.length.toString());
// //           log("valuesInsertMasterPrice: " +
// //               valuesInsertMasterPrice.length.toString());
// //         } else if (value.nextLink == 'null') {
// //           //print("no nexturl: ${value.nextLink}");
// //           initial = -1;
// //         }
// //         notifyListeners();
// //       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
// //         exception = true;
// //         errorMsg = '${value.error!.message!.value}';
// //         notifyListeners();
// //       } else if (value.stcode == 500) {
// //         exception = true;
// //         errorMsg = '${value.exception}';
// //         notifyListeners();
// //       }
// //     });
// //     // print("i: ${i}");
// //     // print("initial: ${initial}");
// //     if (initial == -1) {
// //       await dbHelper.insertItemMaster(valuesInserMaster).then((value) {
// //         dbHelper.insertItemMasterPrice(valuesInsertMasterPrice).then((value) {
// //           HelperFunctions.saveDonloadednSharedPreference(true).then((value) {
// //             Get.offAllNamed(ConstantRoutes.dashboard);
// //           });
// //         });
// //       });
// //       break;
// //     }
// //   }
// // }

//     //    await HelperFunctions.getDownloadedSharedPreference().then((value) async{
//     //   if (value == true) {
//     //     log("data cleared");
//     //   }
//     // });
//     // String dataIpadd = (await HelperFunctions.getHostDSP())!;