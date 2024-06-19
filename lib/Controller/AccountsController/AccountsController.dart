import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/AccountsController/NewCustomerController.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/Controller/VisitplanController/NewVisitController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/AccountsModel/AccountsModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/CutomerTagModel.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Pages/Accounts/NewCustomer.dart';
import 'package:sellerkit/Pages/Enquiries/NewEnquiry.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Pages/Outstanding/Screens/OutstandingScreen.dart';
import 'package:sellerkit/Pages/VisitPlans/Screens/NewVisitPlan.dart';
import 'package:sellerkit/Services/OutstandingApi/outstandingApi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/userDialApi/userdialapi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Helper.dart';
import '../../Constant/Screen.dart';
import '../../Models/AccountsModel/AccountsdetailsModel.dart';
import '../../Services/AccountsApi/AccountdetailsApi.dart';
import '../../Services/AccountsApi/AccountsApi.dart';
import '../../Services/AccountsApi/AccountsdetailsleadApi.dart';
import '../EnquiryController/NewEnqController.dart';
import '../LeadController/LeadNewController.dart';

class AccountsContoller extends ChangeNotifier {
  Config config = new Config();
  AccountsContoller() {}
  //
  List<GetCustomerData> customerdetails = [];
  List<AccountsNewData> AccountsData = [];
  List<AccountsNewData> AccountsDataFilter = [];
  List<AccountsNewData> get getAccountsData => AccountsData;
  List<AccountsNewData> get getAccountsDataFilter => AccountsDataFilter;
  List<GetenquiryData> detaildataEnq = [];
  List<GetenquiryData> get getdetaildataEnq => detaildataEnq;
  List<GetenquiryData> detaildataLead = [];
  List<GetenquiryData> get getdetaildataLead => detaildataLead;
  //
  //
  int? count = 0;
  int get getcount => count!;
  int? counti = 1;
  int get getcounti => counti!;
  List<CustomerTagTypeData> customerTagTypeData = [];
  String isSelectedCusTag = '';
  String isSelectedCusTagcode = '';
  String get getisSelectedCusTag => isSelectedCusTag;
  getCustomerTag(String tag) async {
    customerTagTypeData = [];
    final Database db = (await DBHelper.getInstance())!;
    customerTagTypeData = await DBOperation.getCusTagData(db);
    notifyListeners();
    choosecustag(tag);
    notifyListeners();
  }

  String? apidate;
  bool iscalltrue = false;
  String? userid = '';
//   calldialApi(String? number)async{
//     userid='';
//      iscalltrue=true;
//     notifyListeners();
//     Future.delayed(Duration(seconds: 30),(){
//       log("secondsoverrr:::");
//   iscalltrue=false;
//     notifyListeners();
//     });

//     final FirebaseProduct = FirebaseFirestore.instance.collection("myoperator");

//     FirebaseProduct.get().then((value) {
// value.docs.forEach((element) {
//   userid=element!['id'].toString();
//   log("fsdfdf::"+element!.toString());
// log("fsdfdf::"+element!['id'].toString());
//  UserdialApi.getdata(userid!, number!).then((value) {

//     });
// });
//     });

//   }
  choosecustag(String tag) {
    for (int i = 0; i < customerTagTypeData.length; i++) {
      if (customerTagTypeData[i].Name == tag) {
        isSelectedCusTagcode = customerTagTypeData[i].Code.toString();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  callApi(String? cuscode, BuildContext context) {
    detaildataLead.clear();
    detaildataEnq.clear();
    customerdetails.clear();
    //
    //fs
    log("APIININININ");
    isLoading = false;
    notifyListeners();
    GetCutomerDetailsApi.getData(cuscode, "${ConstantValues.slpcode}")
        .then((value) {
      //
      // log("value" + value.itemdata.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          if (value.itemdata!.customerdetails!.isNotEmpty &&
              value.itemdata!.customerdetails != null) {
            customerdetails = value.itemdata!.customerdetails!;
            // mapValues(value.itemdata!.customerdetails![0]);

            if (value.itemdata!.enquirydetails != null &&
                value.itemdata!.enquirydetails!.isNotEmpty) {
              for (int i = 0; i < value.itemdata!.enquirydetails!.length; i++) {
//                 if(value.itemdata!.enquirydetails![i].DocType =="Lead"){
// detaildataLead!.add(GetenquiryData(
//   DocType: value.itemdata!.enquirydetails![i].DocType,
//   AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo,
//   BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue,
//   CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus,
//   DocDate: value.itemdata!.enquirydetails![i].DocDate,
//   DocNum: value.itemdata!.enquirydetails![i].DocNum,
//   Status: value.itemdata!.enquirydetails![i].Status,
//   Store: value.itemdata!.enquirydetails![i].Store
//   ));
//   // log("leaddetails::"+leaddetails!.length.toString());
//                 }
                // else if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
                if (value.itemdata!.enquirydetails![i].DocType == "Order") {
                  detaildataEnq!.add(GetenquiryData(
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

                  // log("enquirydetails::"+enquirydetails!.length.toString());     // }
                }
                isLoading = false;

                notifyListeners();
              }
            } else {
              isLoading = false;
              exception = true;
              errorMsg = "No Recent Activies";
              notifyListeners();
            }
          }
        } else if (value.itemdata == null) {
          isLoading = false;
          exception = true;
          errorMsg = "No Recent Activies";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = true;
        errorMsg = '${value.respCode!}..!! ${value.exception}..!! ';
        notifyListeners();
      } else if (value.stcode == 500) {
        exception = true;
        errorMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

  bool isAnother = true;
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  //
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  ScrollController scrollController = ScrollController();

  //
  List<String> items = [
    "VIP",
    "PREMIER",
    "FAKE",
  ];
  List<String> get getitems => items;
  List<String> countitemlength = [];
  List<String> get getcountitemlength => countitemlength;
  List<String> countitem = [];
  List<String> get getcountitem => countitem;
  //
  String errorMsg = '';
  bool exception = false;
  bool cartLoading = false;
  bool isLoading = true;
  bool get getisLoading => isLoading;
  bool get getcartLoading => cartLoading;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  //
  //
  Future<void> swipeRefreshIndiactor() async {
    AccountsData.clear();
    iscalltrue = false;
    userid = '';
    usernumber = '';
    notifyListeners();
    callAccountsApi();
  }

  boolmethod() {
    iscalltrue = false;
    userid = '';
    usernumber = '';
    cartLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 5), () {
      cartLoading = false;
      notifyListeners();
    });
  }

  showcalldialog() {}
  bool ismoredata = false;
  bool get getismoredata => ismoredata;
  loadmore() {
    int plus = detaildataEnq.length + detaildataLead.length;

    log("detaildataEnq.length" + plus.toString());
    if (detaildataEnq.length > 0 || detaildataLead.length > 0) {
      ismoredata = true;
    }
    notifyListeners();
  }

  createLead(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    LeadNewController.dataAcc.clear();
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].CustomerCode!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].CustomerName!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_Address1!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_Address2!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_Pincode!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_City!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].AlternateMobileNo!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].CustomerEmail!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].CustomerGroup!);

    LeadNewController.dataAcc.add(AccountsDataFilter[ind].ContactName!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_Area!);
    LeadNewController.dataAcc.add(AccountsDataFilter[ind].Bil_State!);
    LeadNewController.isComeFromEnq = true;
    Get.toNamed(ConstantRoutes.leads);
  }

  createOrder(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    OrderNewController.datafromAcc.clear();
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].CustomerCode!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].CustomerName!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_Address1!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_Address2!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_Pincode!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_City!);
    OrderNewController.datafromAcc
        .add(AccountsDataFilter[ind].AlternateMobileNo!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].CustomerEmail!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].CustomerGroup!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].ContactName!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_Area!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Bil_State!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_Address1!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_Address2!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_Area!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_City!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_Pincode!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].Del_State!);
    OrderNewController.datafromAcc.add(AccountsDataFilter[ind].GSTNo!);
    OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.ordernew);
  }

  createOutstanding(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    Outstandingcontroller.datafromAcc.clear();
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].CustomerCode!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].CustomerName!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].Bil_Address1!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].Bil_Address2!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Bil_Pincode!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Bil_City!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].AlternateMobileNo!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].CustomerEmail!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].CustomerGroup!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].ContactName!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Bil_Area!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Bil_State!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].Del_Address1!);
    Outstandingcontroller.datafromAcc
        .add(AccountsDataFilter[ind].Del_Address2!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Del_Area!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Del_City!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Del_Pincode!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].Del_State!);
    Outstandingcontroller.datafromAcc.add(AccountsDataFilter[ind].GSTNo!);
    OutStandingPageState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.outstanding);
  }

  createCollection(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    NewCollectionContoller.comefromAcc.clear();
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].CustomerCode!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].CustomerName!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Bil_Address1!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Bil_Address2!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Bil_Pincode!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Bil_City!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].AlternateMobileNo!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].CustomerEmail!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].CustomerGroup!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].ContactName!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Bil_Area!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Bil_State!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Del_Address1!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Del_Address2!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Del_Area!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Del_City!);
    NewCollectionContoller.comefromAcc
        .add(AccountsDataFilter[ind].Del_Pincode!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].Del_State!);
    NewCollectionContoller.comefromAcc.add(AccountsDataFilter[ind].GSTNo!);
    // OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.newcollection);
  }

  createVisitplan(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    NewVisitplanController.datafromAcc.clear();
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].CustomerCode!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].CustomerName!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Bil_Address1!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Bil_Address2!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Bil_Pincode!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Bil_City!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].AlternateMobileNo!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].CustomerEmail!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].CustomerGroup!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].ContactName!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Bil_Area!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Bil_State!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Del_Address1!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Del_Address2!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Del_Area!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Del_City!);
    NewVisitplanController.datafromAcc
        .add(AccountsDataFilter[ind].Del_Pincode!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].Del_State!);
    NewVisitplanController.datafromAcc.add(AccountsDataFilter[ind].GSTNo!);
    NewVisitPlanState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.newvisitplan);
  }

  double? AccoundBalance = 0.0;
  bool? outloading = false;
  GetAllOutstandingscall(String name) async {
    outloading = true;
    notifyListeners();
    // outsatandingmodel outsatandingModel = await GetoutstandingApi.getData();
    await GetoutstandingApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.outstandhead!.outstanddata != null &&
            value.outstandhead!.outstanddata!.isNotEmpty &&
            value.outstandhead!.outstandline != null &&
            value.outstandhead!.outstandline!.isNotEmpty) {
          notifyListeners();
          for (int i = 0; i < value.outstandhead!.outstandline!.length; i++) {
            log("ssss::" +
                value.outstandhead!.outstandline![i].customerName.toString());
            if (value.outstandhead!.outstandline![i].customerName == name) {
              AccoundBalance = AccoundBalance! +
                  value.outstandhead!.outstandline![i].balanceToPay!;
              log("AccoundBalance::" + AccoundBalance.toString());
            } else {
              AccoundBalance = AccoundBalance;
              log("AccoundBalance222::" + AccoundBalance.toString());
            }
          }

          outloading = false;
          notifyListeners();
        } else {
          // apiloading = true;
          // log("NODAta on outstanding");
          // errormsg = 'No Outstanding..!!';
          AccoundBalance = 0.0;
          outloading = false;
          notifyListeners();
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        AccoundBalance = 0.0;
        outloading = false;
        notifyListeners();
        // apiloading = true;
        // errormsg = '${value.message}..${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode! == 500) {
        AccoundBalance = 0.0;
        outloading = false;
        notifyListeners();
        // apiloading = true;
        // errormsg = '${value.exception}..${value.message}..!!';

        notifyListeners();
      }
    });
  }

  Mapvaluestomodify(int ind) {
    NewCustomerContoller.datafrommodify.clear();
    //  NewCustomerContoller.datafrommodify.add(AccountsDataFilter[ind]!.OrderDocEntry.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.CustomerCode.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.CustomerName.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.AlternateMobileNo.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.CustomerEmail.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.ContactName.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_Address1.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_Address2.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_Area.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_City.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_Pincode.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Bil_State.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_Address1.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_Address2.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_Area.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_City.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_Pincode.toString());

    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.Del_State.toString());

// NewCustomerContoller.datafrommodify.add(AccountsDataFilter[ind]!.OrderNum.toString());
    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.GSTNo.toString());
    NewCustomerContoller.datafrommodify
        .add(AccountsDataFilter[ind]!.CustomerGroup.toString());
    NewCustomerRegState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.newcustomerReg);
  }

  createEnq(int ind) {
    log("SUCCSS" + AccountsDataFilter[ind].toString());
    NewEnqController.comeFromAcc.clear();
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].CustomerCode!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].CustomerName!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_Address1!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_Address2!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_Pincode!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_City!);
    NewEnqController.comeFromAcc
        .add(AccountsDataFilter[ind].AlternateMobileNo!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].CustomerEmail!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].CustomerGroup!);

    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].ContactName!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_Area!);
    NewEnqController.comeFromAcc.add(AccountsDataFilter[ind].Bil_State!);

    NewEnquiryState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.newEnq);
    notifyListeners();
  }

  bool isEnq = false;
  bool get getisEnq => isEnq;
  bool isLead = false;
  bool get getisLead => isLead;
  // callenqdetailsApi(String number) async {
  //   await AccountsdetailsApiNew.getData(number).then((value) {
  //     if (value.detaildataEnq != null ) {
  //       isEnq=true;
  //       if (value.stcode! >= 200 && value.stcode! <= 210 && value.detaildataEnq!.isNotEmpty) {
  //         detaildataEnq = value.detaildataEnq!;
  //         log("detaildataEnq::"+detaildataEnq.length.toString());
  //          log("detaildataEnq::"+detaildataEnq[0].cardcode.toString());
  //         notifyListeners();
  //       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //         exception = true;
  //         errorMsg = '${value.exception}';
  //       } else if (value.stcode == 500) {
  //         if (value.exception == 'No route to host') {
  //           errorMsg = 'Check your Internet Connection...!!';
  //         } else {
  //           errorMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
  //         }
  //         exception = true;
  //         // errorMsg = '${value.exception}';
  //         notifyListeners();
  //       }
  //     } else {
  //       errorMsg = "Something went wrong try again ${value.stcode} ${value.exception}...!!";
  //       notifyListeners();
  //     }
  //   }
  //   );

  //   await AccountsLeaddetailsApiNew.getData(number).then((value) {
  //     if (value.detaildataLead != null) {
  //       if (value.stcode! >= 200 && value.stcode! <= 210) {
  //         isLead=true;
  //         detaildataLead = value.detaildataLead!;
  //         notifyListeners();
  //       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //         exception = true;
  //         errorMsg = '${value.exception}';
  //       } else if (value.stcode == 500) {
  //         if (value.exception == 'No route to host') {
  //           errorMsg = 'Check your Internet Connection...!!';
  //         } else {
  //           errorMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
  //         }
  //         exception = true;
  //         // errorMsg = '${value.exception}';
  //         notifyListeners();
  //       }
  //     } else {
  //       errorMsg = "No data found..!!";
  //       notifyListeners();
  //     }
  //   }
  //   );
  // }

  String lottie = '';
  callAccountsApi() async {
    AccountsData.clear();
    AccountsDataFilter.clear();
    isLoading = true;
    lottie = '';
    notifyListeners();

    //  int  counti=100;
    // for (int i = 1; i == counti!; i++) {
    // log("first....... loop:"+i.toString());

    // final stopwatch = Stopwatch()..start();
    await AccountsApiNew.getData().then((value) {
      // stopwatch.stop();
      // log('API call took ${stopwatch.elapsedMilliseconds} milliseconds');

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata!.childdata != null &&
            value.itemdata!.childdata!.isNotEmpty) {
          mapvalues(value.itemdata!.childdata!);

          // counti = counti! + 1;
          notifyListeners();
        } else if (value.itemdata!.childdata == null ||
            value.itemdata!.childdata!.isEmpty) {
          // counti = 1;
          log("hiiii");
          // i = 2;
          isLoading = false;
          exception = true;
          lottie = 'Assets/no-data.png';
          errorMsg = 'No Data..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isLoading = false;
        exception = true;
        lottie = '';
        errorMsg = '${value.message}..!!${value.exception}..!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isLoading = false;
        if (value.exception == 'No route to host') {
          errorMsg = 'Check your Internet Connection...!!';
        } else {
          lottie = 'Assets/NetworkAnimation.json';
          errorMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        }
        exception = true;
        // errorMsg = '${value.exception}';
        notifyListeners();
      }
      notifyListeners();
    });
    // print("iteration" + i.toString());
    // print("counti" + counti.toString());
    count = count! + AccountsData.length;
    notifyListeners();
    // }
    await callusermobileApi();
    // print("accountdata outside legnth:" + AccountsData.length.toString());
    // print(counti);
    // log("Totalll: " + count.toString());
  }

  mapvalues(List<AccountsNewData> itemdata) {
    for (int k = 0; k < itemdata.length; k++) {
      // log("second loop:" + itemdata.length.toString());
      // log("second loop:" + itemdata[0].cardname.toString());

      AccountsData.add(AccountsNewData(
          AlternateMobileNo: itemdata[k].AlternateMobileNo,
          AssignedTo: itemdata[k].AssignedTo,
          Bil_Address1: itemdata[k].Bil_Address1,
          Bil_Address2: itemdata[k].Bil_Address2,
          Bil_Address3: itemdata[k].Bil_Address3,
          Bil_Area: itemdata[k].Bil_Area,
          Bil_City: itemdata[k].Bil_City,
          Bil_Country: itemdata[k].Bil_Country,
          Bil_District: itemdata[k].Bil_District,
          Bil_Pincode: itemdata[k].Bil_Pincode,
          Bil_State: itemdata[k].Bil_State,
          CompanyName: itemdata[k].CompanyName,
          ContactName: itemdata[k].ContactName,
          CreatedBy: itemdata[k].CreatedBy,
          CreatedOn: itemdata[k].CreatedOn,
          CustomerCode: itemdata[k].CustomerCode,
          CustomerEmail: itemdata[k].CustomerEmail,
          CustomerGroup: itemdata[k].CustomerGroup,
          CustomerMobile: itemdata[k].CustomerMobile,
          CustomerName: itemdata[k].CustomerName,
          Del_Address1: itemdata[k].Del_Address1,
          Del_Address2: itemdata[k].Del_Address2,
          Del_Address3: itemdata[k].Del_Address3,
          Del_Area: itemdata[k].Del_Area,
          Del_City: itemdata[k].Del_City,
          Del_Country: itemdata[k].Del_Country,
          Del_District: itemdata[k].Del_District,
          Del_Pincode: itemdata[k].Del_Pincode,
          Del_State: itemdata[k].Del_State,
          GSTNo: itemdata[k].GSTNo,
          PAN: itemdata[k].PAN,
          Status: itemdata[k].Status,
          StoreCode: itemdata[k].StoreCode,
          UpdatedBy: itemdata[k].UpdatedBy,
          UpdatedOn: itemdata[k].UpdatedOn,
          traceid: itemdata[k].traceid));
      // log("AccountsDataFilter11::" + AccountsData[k].cardname.toString());
      // AccountsData = value.itemdata!;
      AccountsDataFilter = AccountsData;
      isLoading = false;
      exception = false;
      notifyListeners();
      // log("AccountsDataFilter::" + AccountsDataFilter[k].cardname.toString());
    }
  }

  callusermobileApi() async {
    await userbyidApi.getData(ConstantValues.UserId).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        ConstantValues.userbyidmobile = value.ageLtData!.mobile!;
        log("ConstantValues. userbyidmobile:::" +
            ConstantValues.userbyidmobile.toString());
        getfirebase();
      }
    });
  }

  String? usernumber = '';
  calldialApi(String? number, BuildContext context) async {
    //  iscalltrue=true;

    Future.delayed(Duration(seconds: 40), () {
      log("secondsoverrr:::");
      // iscalltrue=false;
      Navigator.pop(context);
      notifyListeners();
    });

    // final FirebaseProduct = FirebaseFirestore.instance.collection("myoperator");

//     FirebaseProduct.get().then((value) {
// value.docs.forEach((element) {
//   usernumber=element!['mobile'].toString();
//   userid=element!['id'].toString();
// log("fsdfdf::"+userid.toString());
    // if(ConstantValues.userbyidmobile==usernumber){
    log("fsdfdf::user number match");
    UserdialApi.getdata(userid!, number!).then((value) {});
    // }
//   else{
// log("fsdfdf::no user number not match");
//   }

// });
    // });
  }

  getfirebase() async {
    userid = '';
    notifyListeners();
    final FirebaseProduct = FirebaseFirestore.instance.collection("myoperator");

    await FirebaseProduct.get().then((value) {
      value.docs.forEach((element) {
        usernumber = element!['mobile'].toString();

        log("fsdfdf::" + usernumber.toString());
        if (ConstantValues.userbyidmobile == usernumber) {
          log("fsdfdf::user number match");
          userid = element!['id'].toString();
          notifyListeners();
//  UserdialApi.getdata(userid!, number!).then((value) {

//     });
        }
//   else{
// log("fsdfdf::no user number not match");
//   }
      });
    });
  }

  SearchFilter(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      AccountsDataFilter = AccountsData.where((e) =>
          (e).CustomerCode!.toLowerCase().contains(v.toLowerCase()) ||
          (e).CustomerName!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      AccountsDataFilter = AccountsData;
      notifyListeners();
    }
  }

  scrollcontrollerAddlistener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // if (mycontroller[0].text.isEmpty) {
        // if(StockItemAPi.nextLink!='null'){
        //   getmoredata();
        // }

        // }
      }
    });
  }
}
