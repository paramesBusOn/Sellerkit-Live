// ignore_for_file: unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, unused_import, use_build_context_synchronously, sort_child_properties_last
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:charts_flutter_new/flutter.dart' as charts;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/DBModel/ScreenShotModel.dart';
import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
import 'package:sellerkit/DBModel/outstandinglinechild.dart';
import 'package:sellerkit/Models/OutStandingModel/outstandingmodel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Pages/Dashboard/Screens/Dashboard.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/SetupAlertBox.dart';
import 'package:sellerkit/Pages/callerNotification/custom_overlayNew.dart';
import 'package:sellerkit/Services/AddressGetApi/AddressGetApi.dart';
import 'package:sellerkit/Services/LocalNotification/LocalNotification.dart';
import 'package:sellerkit/Services/LoginVerificationApi/LoginVerificationApi.dart';
import 'package:sellerkit/Services/LogoutApi/LogoutApi.dart';
import 'package:sellerkit/Services/OutstandingApi/outstandingApi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Widgets/Dialogbox.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Constant/Helper.dart';
import '../../Constant/Screen.dart';
import '../../Models/DashBoardModels/SegementWiseModel.dart';
import '../../Models/DashBoardModels/TargetAchievementsModel.dart';
import '../../Models/GridContainerModels/GridContainerModel.dart';
import '../../Models/KpiModel/KpiModelList.dart';
import '../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';
import '../../Services/DashBoardApi/FeedsApi/FeedsApi.dart';
import '../../Services/DashBoardApi/FeedsApi/ReactionApi.dart';
import '../../Services/DashBoardApi/KpiApi/KpiApi.dart';
import '../../Services/DashBoardApi/KpiApi/NewKPIAPI.dart';
import '../../Services/URL/LocalUrl.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:http/http.dart' as http;

class DashBoardController extends ChangeNotifier {
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  Config config = Config();
  init(BuildContext context) {
    //  getUnSeenNotify();
    //setURL();
    
    if (isLogout == false) {
      clearAllData();
      getDefaultValues();
    } else if (isLogout == true) {
      logoutSession();
    }
    checkPermission(context);

    //onReciveFCM();
    trackScreenShot();
  }


  bool loadOrderViewDtlsApi = false;
  String errorOrderViewDtls = '';
  bool viewOrderDtls = false;
  bool viewLeadDtls = false;
  bool viewOutStatndingDtls = false;
  bool viewDefault = true;

  List<GetCustomerData> customerdetails=[];
  List<GetenquiryData> enquirydetails = [];
  List<GetenquiryData> leaddetails = [];
  List<GetenquiryData>? quotationdetails = [];
  List<GetenquiryData>? orderdetails = [];
  List<GetenquiryData>? customerDatalist = [];

  String adrress = '';

  LocationPermission? permission;
  bool? locationbool = false;
  bool? camerabool = false;
  bool? notificationbool = false;
  
  String docentry = '';
  setDocentry(String value) {
    docentry = value;
    notifyListeners();
  }

  clearAllData() {
    loadOrderViewDtlsApi = false;
    errorOrderViewDtls = '';
    viewOrderDtls = false;
    viewLeadDtls = false;
    viewOutStatndingDtls = false;
    viewDefault = true;
    data = '';
    feedint = 0;
    customerdetails = [];
    enquirydetails = [];
    leaddetails = [];
    quotationdetails = [];
    orderdetails = [];
    customerDatalist = [];
    adrress = '';
    permission = null;
    locationbool = false;
    camerabool = false;
    notificationbool = false;
    docentry = '';
    adrress = '';
    totaloutstanding = 0.0;
    overdue = 0.0;
    upcoming = 0.0;
    valueDBmodel = [];
    valueDBmodelchild = [];
    outstandingkpi = [];
    outstanddata = [];
    outstandline = [];
    ontapKpi2 = [];
    newKpiData2 = [];
    apiOutloading = false;
    errorOutstdmsg = '';
    mycontroller = List.generate(30, (i) => TextEditingController());
    reactionvisible = false;
    feedsApiExcp = '';
    lottiurl = '';
    KpiApiExcp = '';
    isloading = false;
    feedData = [];
    allProductDetails = [];
    feeddata2;
    searchfeedfilter = [];
    notifyListeners();
  }
  // viewDetailsMethod(String mobile, String docentry, String doctype,
  //     BuildContext context) async {
  //   String doctype2 = doctype;
  //   switch (doctype2) {
  //     case 'Order':
  //       viewOrderDtls = !viewOrderDtls;
  //       notifyListeners();
  //       if (viewOrderDtls == true) {
  //         setDocentry(docentry);
  //         await callOrderDetailsQTHApi(docentry);
  //         setviewBool(doctype, context);
  //       } else {
  //         setviewBool('', context);
  //       }
  //       break;
  //     case 'Outstanding':
  //       viewOutStatndingDtls = !viewOutStatndingDtls;
  //       notifyListeners();
  //       if (viewOutStatndingDtls == true) {
  //         setDocentry(docentry);

  //         await setOutstandingDetails(mobile);
  //         setviewBool(doctype, context);
  //       } else {
  //         setviewBool('', context);
  //       }
  //       break;
  //     case 'Lead':
  //       viewLeadDtls = !viewLeadDtls;
  //       notifyListeners();
  //       if (viewLeadDtls == true) {
  //         await refershAfterClosedialog();
  //         await clearAllListData();
  //         setDocentry(docentry);
  //         await callGetLeadDeatilsApi(docentry);
  //         setviewBool(doctype, context);
  //       } else {
  //         await refershAfterClosedialog();
  //         await clearAllListData();
  //         setviewBool('', context);
  //       }
  //       break;
  //     default:
  //   }
  //   notifyListeners();
  // }

  // setviewBool(String doctype, BuildContext context) {
  //   String doctype2 = doctype;
  //   switch (doctype2) {
  //     case 'Order':
  //       viewOrderDtls = true;
  //       viewLeadDtls = false;
  //       viewOutStatndingDtls = false;
  //       viewDefault = false;
  //       notifyListeners();

  //       break;
  //     case 'Outstanding':
  //       viewOrderDtls = false;
  //       viewLeadDtls = false;
  //       viewOutStatndingDtls = true;
  //       viewDefault = false;
  //       notifyListeners();

  //       break;
  //     case 'Lead':
  //       viewOrderDtls = false;
  //       viewLeadDtls = true;
  //       viewOutStatndingDtls = false;
  //       viewDefault = false;
  //       notifyListeners();

  //       break;
  //     default:
  //       callApi(context, dashbordTextController.text);
  //       refreshSucessdialog();
  //       clearAllListData();
  //       viewOrderDtls = false;
  //       viewLeadDtls = false;
  //       viewOutStatndingDtls = false;
  //       viewDefault = true;
  //       notifyListeners();
  //   }
  //   notifyListeners();
  // }


double? totaloutstanding = 0.0;
  double? overdue = 0.0;
  double? upcoming = 0.0;
  //

  List<outstandingDBModel> valueDBmodel = [];
  List<outstandinglineDBModel> valueDBmodelchild = [];
  List<outstandKPI> outstandingkpi = [];
  List<outstandingData> outstanddata = [];
  List<outstandingLine> outstandline = [];
  List<ontapKpi> ontapKpi2 = [];

  bool apiOutloading = false;
  String errorOutstdmsg = '';
  getAllOutstandingscall() async {
    outstanddata.clear();
    outstandline.clear();
    apiOutloading = true;
    // outsatandingmodel outsatandingModel = await GetoutstandingApi.getData();
    // String meth = ConstantApiUrl.outStandingApi!;
    await GetoutstandingApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.outstandhead!.outstanddata != null &&
            value.outstandhead!.outstanddata!.isNotEmpty &&
            value.outstandhead!.outstandline != null &&
            value.outstandhead!.outstandline!.isNotEmpty) {
          apiOutloading = false;
          notifyListeners();
          outstanddata = value.outstandhead!.outstanddata!;
          outstandline = value.outstandhead!.outstandline!;
          await tableinsert();
        } else {
          apiOutloading = false;
          errorOutstdmsg = 'No Outstanding..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        apiOutloading = false;
        errorOutstdmsg = '${value.message}..${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode! == 500) {
        apiOutloading = false;
        errorOutstdmsg = '${value.exception}..${value.message}..!!';

        notifyListeners();
      }
    });
  }

  tableinsert() async {
    final Database db = (await DBHelper.getInstance())!;
    // await DBOperation.truncareoutstandingmaste(db);
    // await DBOperation.truncareoutstandingline(db);
    await DBOperation.insertOutstandingMaster(outstanddata, db);
    await DBOperation.insertOutstandingchild(outstandline, db);

    notifyListeners();
    await getdbmodel();
    notifyListeners();
  }

  showdialogcircular(BuildContext context,) async {
    // mobileno2 = mobileno;
    // dashbordTextController.text = mobileno2;
    // print(dashbordTextController);
    notifyListeners();

    // await Future.delayed(const Duration(milliseconds: 50));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // if (mobileno.isNotEmpty) {
     
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              // title: Text("hi"),
              content:  Container(
        width: Screens.width(context) * 0.9,
        height: Screens.bodyheight(context) * 0.3,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ))
              
              );
        },
      ).then((value) {
        if(customerapicLoading ==false){
Navigator.pop(context);
        }
        
      });
    // }
    notifyListeners();
    // await HelperFunctions.saveNavigationCountSharedPreference('false');
    // });
  }
   showdialog(BuildContext context,List<GetCustomerData> customerdata,List<GetenquiryData>? customerDatalist) async {
    // mobileno2 = mobileno;
    // dashbordTextController.text = mobileno2;
    // print(dashbordTextController);
    notifyListeners();

    // await Future.delayed(const Duration(milliseconds: 50));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // if (mobileno.isNotEmpty) {
     
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

              // title: Text("hi"),
              content:  NewWidget(customerdata: customerdata,customerDatalist:customerDatalist));
        },
      ).then((value) {
        refershAfterClosedialog();
      });
    // }
    notifyListeners();
    // await HelperFunctions.saveNavigationCountSharedPreference('false');
    // });
  }
  refershAfterClosedialog() {
    viewDefault = false;
    viewLeadDtls = false;
    viewOutStatndingDtls = false;
    viewOrderDtls = false;
    // dashbordTextController.clear();
    //
    // forwaVisitTime = '';
    // forwardnextWonFD = '';
    // nextpurchasedate = '';
    // nextpurchasedate = '';
    mycontroller[5].clear();
    // leadCheckDataExcep = '';
    // iscorectime = false;
    // iscorectime2 = false;
    // leadOpenAllData.clear();
    // leadClosedAllData.clear();
    // leadLostAllData.clear();
    // filterleadOpenAllData.clear();

    // filterleadClosedAllData.clear();

    // viewDetailsdialog = false;
    // isSameBranch = true;
    // quataDate = "";
    // apiQuaDate = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    // forwardSuccessMsg = "";
    // updateConvertToQuatationUpdialog = false;
    // caseStatusSelectedcode = "";
    // caseStatusSelected = "";
    // isSelectedFollowUp = '';
    // isSelectedFollowUpcode = '';
    // assignVisitTime = "Followup Time";
    // leadDeatilsQTHData.clear();
    // leadDeatilsQTLData.clear();
    // leadDeatilsLData.clear();
    // selectedUserList = '';

    notifyListeners();
  }
getdbmodel() async {
    apiOutloading = true;
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    valueDBmodel = await DBOperation.getoutstandingMaster(db);
    valueDBmodelchild = await DBOperation.getoutstandingchild(db);
    // await countofKpi();
    log("valueDBmodel.${valueDBmodel.length}");
    log("valueDBmodelchild::${valueDBmodelchild.length}");
    List<Map<String, Object?>> assignDB =
        await DBOperation.getOutLFtr("AssignedTo", db);

    List<Map<String, Object?>> customerDB =
        await DBOperation.getOutLFtr("CustomerName", db);
    notifyListeners();
    // await dataget(assignDB, customerDB);
    notifyListeners();
    apiOutloading = false;
    notifyListeners();
  }
bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  bool oldcutomer = false;
  String exceptionOnApiCall = '';
  callApi(BuildContext context, String mobile) async {
    //a
    //fs
    customerdetails.clear();
    customerDatalist = [];
    customerapicLoading = true;
    notifyListeners();
    if( customerapicLoading == true){
      // showdialogcircular(context);
    }else{}
    // GetCutomerpost reqpost = GetCutomerpost(customermobile: mobile);
    // String meth = ConstantApiUrl.getCustomerApi!;
    await GetCutomerDetailsApi.getData(mobile,"${ConstantValues.slpcode}").then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          if (value.itemdata!.customerdetails != null &&value.itemdata!.customerdetails!.isNotEmpty
              ) {
            // customerdetails = value.itemdata!.customerdetails!;
            customerdetails.add(GetCustomerData(
              del_Address1: value.itemdata!.customerdetails![0].del_Address1, 
              del_Address2: value.itemdata!.customerdetails![0].del_Address2, 
              del_Address3: value.itemdata!.customerdetails![0].del_Address3, 
              del_Area: value.itemdata!.customerdetails![0].del_Area, 
              del_city: value.itemdata!.customerdetails![0].del_city, 
              del_country: value.itemdata!.customerdetails![0].del_country, 
              del_district: value.itemdata!.customerdetails![0].del_district, 
              del_pincode:value.itemdata!.customerdetails![0]. del_pincode, 
              del_state: value.itemdata!.customerdetails![0].del_state, 
              pan:value.itemdata!.customerdetails![0]. pan, 
              website: value.itemdata!.customerdetails![0].website, 
              facebook: value.itemdata!.customerdetails![0].facebook, 
              cardtype:value.itemdata!.customerdetails![0]. cardtype, 
              status: value.itemdata!.customerdetails![0].status, 
              contactName: value.itemdata!.customerdetails![0].contactName, 
              altermobileNo:value.itemdata!.customerdetails![0]. altermobileNo, 
              customerGroup:value.itemdata!.customerdetails![0]. customerGroup, 
              Mgr_UserName:value.itemdata!.customerdetails![0]. Mgr_UserName, 
              comapanyname:value.itemdata!.customerdetails![0]. comapanyname, 
              visitTime:value.itemdata!.customerdetails![0]. visitTime, 
              remindOn:value.itemdata!.customerdetails![0]. remindOn, 
              isClosed: value.itemdata!.customerdetails![0].isClosed, 
              isVisitRequired:value.itemdata!.customerdetails![0]. isVisitRequired, 
              storecode:value.itemdata!.customerdetails![0]. storecode, 
              area:value.itemdata!.customerdetails![0]. area, 
              district: value.itemdata!.customerdetails![0].district, 
              itemCode:value.itemdata!.customerdetails![0]. itemCode, 
              itemname:value.itemdata!.customerdetails![0]. itemname, 
              leadConverted:value.itemdata!.customerdetails![0]. leadConverted, 
              createdBy:value.itemdata!.customerdetails![0]. createdBy, 
              createdDateTime:value.itemdata!.customerdetails![0]. createdDateTime, 
              updatedBy:value.itemdata!.customerdetails![0]. updatedBy, 
              updatedDateTime:value.itemdata!.customerdetails![0]. updatedDateTime, 
              enquirydscription:value.itemdata!.customerdetails![0]. enquirydscription, 
              quantity:value.itemdata!.customerdetails![0]. quantity,
               ID: value.itemdata!.customerdetails![0].ID, 
              customerCode:value.itemdata!.customerdetails![0]. customerCode, 
              Status:value.itemdata!.customerdetails![0]. Status, 
              customerName:value.itemdata!.customerdetails![0]. customerName, 
              AssignedTo_User:value.itemdata!.customerdetails![0]. AssignedTo_User, 
              EnqDate:value.itemdata!.customerdetails![0]. EnqDate, 
              Followup:value.itemdata!.customerdetails![0]. Followup, 
              Mgr_UserCode:value.itemdata!.customerdetails![0]. Mgr_UserCode, 
              AssignedTo_UserName:value.itemdata!.customerdetails![0]. AssignedTo_UserName, 
              EnqType:value.itemdata!.customerdetails![0]. EnqType, 
              Lookingfor:value.itemdata!.customerdetails![0]. Lookingfor, 
              PotentialValue:value.itemdata!.customerdetails![0]. PotentialValue, 
              Address_Line_1:value.itemdata!.customerdetails![0]. Address_Line_1, 
              Address_Line_2:value.itemdata!.customerdetails![0]. Address_Line_2, 
              Pincode:value.itemdata!.customerdetails![0]. Pincode, 
              City: value.itemdata!.customerdetails![0].City, 
              State:value.itemdata!.customerdetails![0]. State, 
              Country: value.itemdata!.customerdetails![0].Country, 
              Manager_Status_Tab:value.itemdata!.customerdetails![0]. Manager_Status_Tab, 
              Slp_Status_Tab:value.itemdata!.customerdetails![0]. Slp_Status_Tab, 
              email:value.itemdata!.customerdetails![0]. email, 
              referal: value.itemdata!.customerdetails![0].referal, 
              gst:value.itemdata!.customerdetails![0]. gst, 
              mobileNo:value.itemdata!.customerdetails![0]. mobileNo, 
              codeid: value.itemdata!.customerdetails![0].codeid, 
              address3:value.itemdata!.customerdetails![0]. address3
              ));
            log("customerdetails::"+customerdetails.length.toString());
            // mapValues(value.itemdata!.customerdetails![0]);
            oldcutomer = true;
            // }
            
            // customerDatalist = [];

            if (value.itemdata!.enquirydetails != null) {
              for (int i = 0; i < value.itemdata!.enquirydetails!.length; i++) {
                // if ((value.itemdata!.enquirydetails![i].DocType == 'Lead' ||
                //         value.itemdata!.enquirydetails![i].DocType == 'Order' ||
                //         value.itemdata!.enquirydetails![i].DocType ==
                //             'Outstanding') ) {
                  customerDatalist!.add(GetenquiryData(
                      DocType: value.itemdata!.enquirydetails![i].DocType,
                      AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo,
                      BusinessValue:
                          value.itemdata!.enquirydetails![i].BusinessValue,
                      CurrentStatus:
                          value.itemdata!.enquirydetails![i].CurrentStatus,
                      DocDate: value.itemdata!.enquirydetails![i].DocDate,
                      DocNum: value.itemdata!.enquirydetails![i].DocNum,
                      Status: value.itemdata!.enquirydetails![i].Status,
                      Store: value.itemdata!.enquirydetails![i].Store));
                // }
              }
              // await Future.delayed(Duration(milliseconds: 50));
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   showDialog(
              //       builder: (_) {
              //         return CustomerDetailsViewBox(
              //           customerDatalist: customerDatalist!,
              //           customerdetails: customerdetails,
              //           // dashbordCnt: dashbordCnt,
              //         );
              //       },
              //       context: context);
              // });
            }
            // else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   for (int i = 0; i < value.itemdata!.enquirydetails!.length; i++) {

            //   }
            //   log("Anbuenq");
            //   enquirydetails = value.itemdata!.enquirydetails;

            // }

             for (int i = 0; i < valueDBmodel.length; i++) {
      if (valueDBmodel[i].customerCode == mobile) {
        customerDatalist!.add(GetenquiryData(
            DocType: 'Outstanding',
            AssignedTo: valueDBmodel[i].assignedTo,
            BusinessValue: valueDBmodel[i].amountPaid,
            CurrentStatus: 'Open',
            DocDate: '',
            DocNum: valueDBmodel[i].customerCode != null
                ? int.parse(valueDBmodel[i].customerCode.toString())
                : 0,
            Status: 'Open',
            Store: valueDBmodel[i].storeCode));
      }
    }
     customerapicLoading = false;
    //  Navigator.pop(context);
          showdialog(context,customerdetails!,customerDatalist);
          } else {
            oldcutomer = false;
            customerapicLoading = false;
            showtoastproduct();
            // await Future.delayed(const Duration(milliseconds: 50));
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   showDialog(
            //       builder: (_) {
            //         return CustomerDetailsViewBox(
            //           customerDatalist: customerDatalist!,
            //           customerdetails: customerdetails,
            //           // dashbordCnt: dashbordCnt,
            //         );
            //       },
            //       context: context);
            // });
          }
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          showtoastproduct();
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = '${value.stcode!}..!!${value.exception}..!! ';
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    });
   
  }
  void showtoastproduct() {
    Fluttertoast.showToast(
        msg: "No Data..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
 static Future logOutMethod()async{
   String? fcm2 = await HelperFunctions.getFCMTokenSharedPreference();
    String? deviceID = await HelperFunctions.getDeviceIDSharedPreference();
    String? password =await HelperFunctions.getPasswordSharedPreference();
if (deviceID == null){
   
    deviceID = await Config.getdeviceId();
      print("deviceID"+deviceID.toString());
       await   HelperFunctions.saveDeviceIDSharedPreference(deviceID!);
       
 }
    LoginVerificationApi.getData(
            fcm2, deviceID, ConstantValues.tenetID, 1, ConstantValues.Usercode,password)
        .then((value) async {
print('Sucess'+value.message);

 await HelperFunctions.clearHost();
 Get.offAllNamed(ConstantRoutes.splash);
        });
}
  checkPermission(BuildContext context) async {
    LocationTrack.determinePosition();

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
      await showDialog<dynamic>(
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return PermissionShowDialog(
              locationbool: locationbool,
              camerabool: camerabool,
              notificationbool: notificationbool,
            );
          }).then((value) {}).then((value) {
        notifyListeners();
      }).then((value) {});
    }
    // }
    notifyListeners();
  }
// Future<void> getWifiInfo() async {
//   var connectivityResult = await Connectivity().checkConnectivity();

//   if (connectivityResult == ConnectivityResult.wifi) {
//     final wifiInfo = await Connectivity().getWifiInfo();

//     if (wifiInfo != null) {
//       final networkName = wifiInfo.ssid;
//       final ipAddress = wifiInfo.ip;

//       print("Network Name: $networkName");
//       print("IP Address: $ipAddress");
//     } else {
//       print("Not connected to a WiFi network.");
//     }
//   } else {
//     print("Not connected to a WiFi network.");
//   }
// }

  popupmenu(BuildContext context) async {
    final theme = Theme.of(context);
    await showDialog<dynamic>(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return setupAlerbox(
            address: adrress,
          );
        }).then((value) {}).then((value) {
      notifyListeners();
    }).then((value) {});
  }

  var text;
  List<File> file = [];
  trackScreenShot() async {
    final Database db = (await DBHelper.getInstance())!;
    //
    screenListener.isRecording().then((value) {
      if (value) {
        print("Screen Record listener1");
        text = "You're Still Recording";
      } else {
        print(" Screen Record listener2");
        text = "You're not recording";
      }
    });
    screenListener.addScreenRecordListener((recorded) async {
      print("Hi i'm 2nd Screen Record listener1");

      ///Recorded was your record status (bool)
      text = recorded ? "Start Recording" : "Stop Recording";
    });

    screenListener.addScreenShotListener((filePath) {
      ///filePath only available for Android
      text = "Screenshot stored on : $filePath";
      file.add(File(filePath));
    });

    ///You can add multiple listener ^-^
    screenListener.addScreenRecordListener((recorded) async {
      print("Hi i'm 2nd Screen Record listener");
    });
    //
    List<ScreenShotModel> values = [];
    screenListener.addScreenShotListener((filePath) async {
      print("Wohooo i'm 2nd Screenshot listener:" + filePath.toString());
      values.add(
          ScreenShotModel(dateTime: config.currentDate(), filePath: filePath));
      await Future.delayed(Duration(seconds: 2));
      await DBOperation.insertScreenShot(values, db);
    });

    screenListener.watch();
    notifyListeners();
  }

  setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    //  Url.queryApi = 'http://91.203.133.224:81/api/';
    Url.queryApi = 'http://${getUrl.toString()}/api/';
  }

  int checkContent(FeedsModalData2 feedDatas) {
    int res = 0;
    if (feedDatas.MediaURL1.isNotEmpty) {
      res = res + 1;
    }
    if (feedDatas.MediaURL2.isNotEmpty) {
      res = res + 1;
    }
    if (feedDatas.MediaURL3.isNotEmpty) {
      res = res + 1;
    }
    return res;
  }
  // int? unSeenNotify;
  // int get getunSeenNotify=>unSeenNotify!=null?unSeenNotify!:0;

//   onReciveFCM(){
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       List<NotificationModel> notify = [];
//   if (message.notification != null) {
//    localNotificationService.showNitification(titile:message.notification!.title,msg:message.notification!.body);
//  notify.add(
//   NotificationModel(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     titile: message.notification!.title,
//     description: message.notification!.body!,
//     receiveTime: config.currentDate(),
//     seenTime: '0', ));

//   dbHelper.insertNotification(notify);
//    NotificationUpdateApi.getData(
//     docEntry: int.parse(message.data['DocEntry'].toString()),
//     deliveryDT: config.currentDate(),
//     readDT: 'null',
//     deviceCode: 'null'
//   );
//   print("repeat 1 dash");
//   }
// });
// }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

// getUnSeenNotify()
// async{
//   unSeenNotify = await dbHelper.getUnSeenNotificationCount();
//   notifyListeners();
// }
  static bool isLogout = false;

  logoutSession() async {
    //  HelperFunctions.clearLicenseKeyDSharedPref();
    //  HelperFunctions.clearUserCodeDSharedPref();

    HelperFunctions.clearUserLoggedInSharedPref();
    HelperFunctions.clearUserName();
    LogoutAPi.getData().then((value) {
      isLogout = false;
      Get.offAllNamed(ConstantRoutes.login);
    });
  }

//  Future<void> listener( int j) async{
//     log("ssdasdasdada $j");
//     for (int i = 0; i < feedData2.length; i++) {
  //log("i $i");
  //   if (i != j) {
  // log("i!=j: $i");
  // FijkState? state = feedData2[i].player!.state;
  // if (state == FijkState.started) {
  //   if( feedData2[i].player!=null){
  //     feedData2[i].player!.pause();
  //  log("sate::: ${feedData2[i].player!.state}");
  //   }
  // } else if (state == FijkState.paused) {
  //  feedData2[i].player!.start();
  // } else if (state == FijkState.completed) {
  //   feedData2[i].player!.start();
  // }

  // }
  // if(i != j){
  //   if( feedData2[i].player!=null){
  //     await feedData2[i].player!.pause();
  //  log("if sate $i::: ${feedData2[i].player!.state}");
  //   }
  // }
  // else{
  //    if( feedData2[i].player!=null){
  //  log("else sate $i::: ${feedData2[i].player!.state}");
  //   }
  // }
  //   }
  // }

  String data = '';

  int feedint = 0;

  value() {
    data = 'final';
  }

  WebViewController? controllerGlobal;
  // final LocalAuthentication auth = LocalAuthentication();

  // checkAuth() async {
  //   try {
  //     final bool didAuthenticate = await auth.authenticate(
  //         localizedReason: 'Please authenticate to show account balance',
  //         options: const AuthenticationOptions(useErrorDialogs: false));
  //   } on PlatformException catch (e) {
  //     if (e.code == auth_error.notEnrolled) {
  //       print("if: " + e.code.toString());
  //     } else if (e.code == auth_error.lockedOut ||
  //         e.code == auth_error.permanentlyLockedOut) {
  //       print("else if: " + e.code.toString());
  //     } else {
  //       print("else: ");
  //     }
  //   }
  // }

  Future<int> getDefaultValues() async {
    //  String? getUrl = await HelperFunctions.getHostDSP();
    //        log("getUrlgetUrl222::"+getUrl.toString());
    // CustomOverlayNewState.geturlnew = await HelperFunctions.getHostDSP();
    // CustomOverlayNewState.gettokennew =await HelperFunctions. getTokenSharedPreference();
    int i = 0;
    await HelperFunctions.getSapURLSharedPreference().then((value) {
      if (value != null) {
        Url.SLUrl = value;
      }
      i = i + 1;
    });
    await HelperFunctions.getSlpCode().then((value) {
      if (value != null) {
        ConstantValues.slpcode = value;
      }
      i = i + 1;
    });
    await HelperFunctions.getTenetIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.tenetID = value;
      }
      i = i + 1;
    });

    await HelperFunctions.getFSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.firstName = value;
        notifyListeners();
      }
    });

    await HelperFunctions.getmProfilePicSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.profilepic = value;
      }
    });
    await HelperFunctions.getLSTNameSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.lastName = value;
      }
    });
    await HelperFunctions.getemailSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.mailId = value;
      }
    });
    await HelperFunctions.getmobileSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.phoneNum = value;
      }
    });
    await HelperFunctions.getBranchSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.branch = value;
      }
    });
    await HelperFunctions.getDeviceIDSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.deviceId = value;
      }
    });
    await HelperFunctions.getManagerPhoneSharedPreference().then((value) {
      if (value != null) {
        ConstantValues.managerPhonenum = value;
      }
    });

    await HelperFunctions.getUserType().then((value) {
      if (value != null) {
        ConstantValues.sapUserType = value;
      }
    });
//
// log("Profile pic : ${ConstantValues.profilepic}");
    log("firstName : ${ConstantValues.firstName}");
    notifyListeners();
    await callFeedsApi();
   await getdataFromDb();
    await callKpiApi();
    notifyListeners();
    // notifyListeners();
    return i;
  }

  BuildContext? context;
  List<charts.Series<TargetAchievmentModel, String>> createSampleData() {
    final desktopSalesData = [
      new TargetAchievmentModel('2014', 5),
      new TargetAchievmentModel('2015', 25),
      new TargetAchievmentModel('2016', 100),
      new TargetAchievmentModel('2017', 75),
    ];

    final tableSalesData = [
      new TargetAchievmentModel('2014', 25),
      new TargetAchievmentModel('2015', 50),
      new TargetAchievmentModel('2016', 10),
      new TargetAchievmentModel('2017', 20),
    ];

    return [
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Desktop',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<TargetAchievmentModel, String>(
        id: 'Tablet',
        domainFn: (TargetAchievmentModel sales, _) => sales.year,
        measureFn: (TargetAchievmentModel sales, _) => sales.sales,
        data: tableSalesData,
      ),
    ];
  }

  ////
  Map<String, double> dataMap = {
    "STAB": 40,
    "SBS": 40,
    "DC": 20,
    "FF": 20,
  };

  List<charts.Series<SegmentWiseModel, DateTime>> createSampleData2() {
    final us_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 5),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 25),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 78),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 54),
    ];

    final uk_data = [
      new SegmentWiseModel(new DateTime(2017, 9, 19), 15),
      new SegmentWiseModel(new DateTime(2017, 9, 26), 33),
      new SegmentWiseModel(new DateTime(2017, 10, 3), 68),
      new SegmentWiseModel(new DateTime(2017, 10, 10), 48),
    ];

    return [
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'US Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: us_data,
      ),
      new charts.Series<SegmentWiseModel, DateTime>(
        id: 'UK Sales',
        domainFn: (SegmentWiseModel sales, _) => sales.time,
        measureFn: (SegmentWiseModel sales, _) => sales.sales,
        data: uk_data,
      )
    ];
  }

  List<GridConValue> data21 = [
    GridConValue("New customers", "45", 'fcedee'),
    GridConValue("Repeated", "13", 'ebf4fa'),
    GridConValue("Institution Customers", "4", 'ebfaef'),
  ];

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //  print("are you sure");
      const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'Are you want to exit press again!!..',
          style: TextStyle(color: Colors.white),
        ),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
      return Future.value(false);
    }
    ScaffoldMessenger.of(context!).removeCurrentSnackBar();
    return Future.value(true);
  }

  //// Feeds controller

  // List<FijkPlayer> player2 = [];
  String feedsApiExcp = '';
  String lottiurl='';
  String KpiApiExcp = '';
  String get getfeedsApiExcp => feedsApiExcp;
  bool isloading = false;
  bool get getisloading => isloading;
  List<FeedsModalData> feedData = [];
 List<ItemMasterDBModel> allProductDetails = [];
getdataFromDb() async {
    final Database db = (await DBHelper.getInstance())!;
    allProductDetails = await DBOperation.getAllProducts(db);
    log("allProductDetails::"+allProductDetails.length.toString());
   notifyListeners();
  }
  List<FeedsModalData> get getfeedData => feedData;
  FeedsModalData2? feeddata2;
  FeedsModalData2? get getfeeddata2 => feeddata2;
  List<FeedsModalData> searchfeedfilter = [];
  List<FeedsModalData> get getsearchfeedfilter => searchfeedfilter;
  // List<FeedsModalData> feedData2 = [];
  // List<FeedsModalData> get getfeedData2 => feedData;
  callFeedsApi() async {
    lottiurl='';
    isloading = true;

    notifyListeners();
    await FeedsApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leadcheckdata != null) {
          for (int i = 0; i < value.leadcheckdata!.length; i++) {
            feedData = value.leadcheckdata!;
            feeddata2 = value.leadcheckdata![i].leadcheckdata2;
            searchfeedfilter = feedData;
            isloading = false;
            // log("cames111" +
            //     feedData[0].leadcheckdata2!.CreatedDate.toString());
            // evictImage(feedData[0].ProfilePic!);
            //iniS();
            // initializedData();
            notifyListeners();
          }
        } else {
          lottiurl='Assets/no-data.png';
          feedsApiExcp = ' No Data..!! ';
          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         lottiurl='';
        feedsApiExcp =
            'Something went wrong try again...!! ${value.stcode} \n${value.exception}';
        isloading = false;
        notifyListeners();
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          lottiurl='Assets/NetworkAnimation.json';
          feedsApiExcp =
              'Something went wrong try again...!! ${value.stcode} \n${value.exception}';
          isloading = false;
          notifyListeners();
        } else {
          lottiurl='Assets/NetworkAnimation.json';
          feedsApiExcp =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          isloading = false;
          notifyListeners();
        }
      }
    });
  }

  // feedsearchfilter(String v,){
  //   if(v.isNotEmpty){
  //   searchfeedfilter =feedData.where((e) =>
  //    (e).
  //    )
  //   }

  // }
   List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());

  SearchFilter(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      searchfeedfilter = feedData
          .where((e) => (e)
              .leadcheckdata2!
              .Title!
              .toLowerCase()
              .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      searchfeedfilter = feedData;
      notifyListeners();
    }
  }

  void evictImage(String url) {
    final NetworkImage provider = NetworkImage(url);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
    });
  }

  // initializedData() {
  //   int ip = 0;
  //   log("Videoooooo11111");
  //   for (int i = 0; i < feedData.length; i++) {
  //     if (feedData[i].MediaType == "Video") {
  //       // FijkPlayer player = new FijkPlayer();

  //       log("Videoooooo2222");
  // player2.add(player);
  // player2[ip].setDataSource(
  //     //"http://216.48.186.108:19977/SK/s1.mp4",
  //     feedData[i].MediaURL1.toString(),
  //     // "http://216.48.186.108:19977/SK/%E0%AE%A4%E0%AE%AE%E0%AE%BF%E0%AE%B4%E0%AF%8D%20%20%E0%AE%A8%E0%AE%BE%E0%AE%9F%E0%AF%86%E0%AE%99%E0%AF%8D%E0%AE%95%E0%AF%81%E0%AE%AE%E0%AF%8D%20SATHYA.mp4",
  //     showCover: true,
  //     autoPlay: false);

  //     player2[ip].addListener(()=>listener(i));

  //   feedData2.add(FeedsModalData(
  //     FeedsID: feedData[i].FeedsID,
  //     CreatedDate: feedData[i].CreatedDate,
  //     Title: feedData[i].Title,
  //     Description: feedData[i].Description,
  //     MediaType: feedData[i].MediaType,
  //     MediaURL1: feedData[i].MediaURL1,
  //     MediaURL2: feedData[i].MediaURL2,
  //     MediaURL3: feedData[i].MediaURL3,
  //     ValidTill: feedData[i].ValidTill,
  //     UserCode: feedData[i].UserCode,
  //     Reaction: feedData[i].Reaction,
  //     ProfilePic: feedData[i].ProfilePic,
  //     CreatedBy: feedData[i].CreatedBy,
  //     //player: player2[ip]
  //   ));
  //   ip = ip + 1;
  // } else {
  //   log("Videoooooo333333");

  //   feedData2.add(FeedsModalData(
  //         FeedsID: feedData[i].FeedsID,
  //         CreatedDate: feedData[i].CreatedDate,
  //         Title: feedData[i].Title,
  //         Description: feedData[i].Description,
  //         MediaType: feedData[i].MediaType,
  //         MediaURL1: feedData[i].MediaURL1,
  //         MediaURL2: feedData[i].MediaURL2,
  //         MediaURL3: feedData[i].MediaURL3,
  //         ValidTill: feedData[i].ValidTill,
  //         UserCode: feedData[i].UserCode,
  //         Reaction: feedData[i].Reaction,
  //         ProfilePic: feedData[i].ProfilePic,
  //         CreatedBy: feedData[i].CreatedBy,
  //       ));
  //     }
  //   }

  //   ///

  //   log("ssss: " + feedData2.map((e) => e.toMap()).toList().toString());
  // }

  //  iniS(){
  //   int ip=0;
  //      for(int i=0; i<feedData.length; i++){
  //     if( feedData[i].MediaType == "Video"){
  //       player2.add(player);
  //       player2[ip].setDataSource(
  //         "http://216.48.186.108:19977/SK/%E0%AE%A4%E0%AE%AE%E0%AE%BF%E0%AE%B4%E0%AF%8D%20%20%E0%AE%A8%E0%AE%BE%E0%AE%9F%E0%AF%86%E0%AE%99%E0%AF%8D%E0%AE%95%E0%AF%81%E0%AE%AE%E0%AF%8D%20SATHYA.mp4",
  //          showCover: true, autoPlay: false);
  //       ip = ip+1;
  //   }}
  //  }

  Future<void> launchUrlInBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  List<Emojis> emoji = [
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F606', value: '\u{1F606}'),
    Emojis(key: '1F923', value: '\u{1F923}'),
    Emojis(key: '1F914', value: '\u{1F914}'),
    Emojis(key: '1F910', value: '\u{1F910}'),
    Emojis(key: '1F922', value: '\u{1F922}'),
    Emojis(key: '1F61F', value: '\u{1F61F}'),
    Emojis(key: '1F633', value: '\u{1F633}'),
    Emojis(key: '1F621', value: '\u{1F621}'),
    Emojis(key: '1F49B', value: '\u{1F49B}'),
    Emojis(key: '1F44C', value: '\u{1F44C}'),
    Emojis(key: '1F44D', value: '\u{1F44D}'),
    Emojis(key: '1F44F', value: '\u{1F44F}'),
    Emojis(key: '1F600', value: '\u{1F600}'),
    Emojis(key: '1F64f', value: '\u{1F64f}'),
  ];

  List<String> listEmoji = [
    '0x1F600',
    '0x1F606',
    '0x1F923',
    '0x1F914',
    '0x1F910',
    '0x1F922',
    '0x1F61F',
    '0x1F633',
    '0x1F621',
    '0x1F49B',
    '0x1F44C',
    '0x1F44D',
    '0x1F44F',
    '0x1F64f'
  ];
  bool reactionvisible = false;
  bool get getreactionvisible => reactionvisible;

  getsselectedEmojies(BuildContext context, FeedsModalData feedData, int i) {
    Navigator.pop(context);
    // selectedEmoji = listEmoji[i];
    feedData.Reaction = listEmoji[i];
    reactionvisible = true;
    log("data: " + feedData.Reaction.toString());
    notifyListeners();
    callReactionApi(feedData.leadcheckdata2!.FeedsID!, feedData.Reaction!);
  }

  showBottomSheet(BuildContext context, FeedsModalData feedData) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    //nznznz
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.35,
                    child: GridView.builder(
                        itemCount: listEmoji.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 2, //heightofcontainer
                            crossAxisSpacing: 0, //width
                            mainAxisSpacing: 4), //spacebeetweenheight,
                        itemBuilder: (BuildContext ctx, i) {
                          return Card(
                            elevation: 2,
                            shadowColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  getsselectedEmojies(context, feedData, i);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            String.fromCharCode(
                                                int.parse("${listEmoji[i]}")),
                                            style: theme.textTheme.headline6
                                                ?.copyWith(
                                                    color: theme
                                                        .primaryColor))), //
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
        // )),
      ),
    );
  }

  callReactionApi(int feedid, String reaction) async {
    log("feedid" + feedid.toString());
    await ReactionApi.getData(feedid, reaction).then((value) {
      Future.delayed(Duration(seconds: 3), () {
        reactionvisible = false;
        notifyListeners();
      });
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.userLtData != null) {
        } else {}
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      } else {}
    });
  }

  Future<void> refreshFeeds() async {
    feedData.clear();
    notifyListeners();
    callFeedsApi();
    await getdataFromDb();
  }

  ////kpi controller

  // KpiModelData? kpiData;
  // KpiModelData? get getKpiData => kpiData;
    List<KpiModelData2> newKpiData2 = [];

  List<KpiModelData2>? get getNewKpiData2 => newKpiData2;
  bool exception = false;

  Future<void> swipeRefreshIndiactor() async {
    newKpiData2 = [];
    notifyListeners();
    callKpiApi();
  }
String kpilottie='';
  callKpiApi() async {
    newKpiData2 = [];
    kpilottie = '';
    await NewKpiApi.sampleDetails().then((value) {
      if (value.stsCode! >= 200 && value.stsCode! <= 210) {
        if (value.data != null && value.data!.length > 0) {
          newKpiData2 = value.data!;
          notifyListeners();
        } else if (value.data == null || value.data!.length < 1) {
          kpilottie = 'Assets/Nodata2Animation.json';
          KpiApiExcp = "No Data..!!";
          notifyListeners();
        }
      } else if (value.stsCode! >= 400 && value.stsCode! <= 410) {
        kpilottie = '';
        KpiApiExcp = "Something Went Wrong ..!!";
        // \n Try again after some times..!!";
        notifyListeners();
      } else if (value.stsCode == 500) {
        kpilottie = 'Assets/NetworkAnimation.json';
        KpiApiExcp = "500..!!Network Issue..\nTry again Later..!!'";
        notifyListeners();
      }
    });
  }
  // callKpiApi() async {
  //   kpilottie='';
  //   await KpiApi.sampleDetails().then((value) {
  //     if (value.resCode! >= 200 && value.resCode! <= 210) {
  //       if (value.data != null) {
  //         kpiData = value.data!;
  //         notifyListeners();
  //       } else if (value.data == null) {
  //          kpilottie='Assets/Nodata2Animation.json';
  //         KpiApiExcp = "No Data..!!";
  //       }
  //     } else if (value.resCode! >= 400 && value.resCode! <= 410) {
  //       kpilottie='';
  //       KpiApiExcp = "No Data..!!";
  //       notifyListeners();
  //     } else if (value.resCode == 500) {
  //       kpilottie='Assets/NetworkAnimation.json';
  //       KpiApiExcp = "500..!!Network Issue..\nTry again Later..!!'";
  //       notifyListeners();
  //     }
  //   });
  // }
}

class Emojis {
  String? key;
  String? value;
  Emojis({required this.key, required this.value});
}

class Callloginfo {
  String? name;
  String? number;
  String? duration;
  Callloginfo({
    this.name,
    required this.number,
    required this.duration,
  });
}

class Contact {
  String? firstName;
  String? lastName;
  List<dynamic>? phoneNumbers;

  Contact(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumbers});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumbers: List<dynamic>.from(json['phoneNumbers'] ?? ''),
    );
  }
}
