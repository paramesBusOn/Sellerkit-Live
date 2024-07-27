import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryUserContoller.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/canceldialogmodel.dart';
import 'package:sellerkit/Models/QuoteModel/quotesQth.dart';
import 'package:sellerkit/Models/QuoteModel/quotesgetallModel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Pages/Quoatation/newqoute.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/OpenSaveOrderApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/canceldialogApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/paymentmode.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/QuotesQTHApi.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/cancelApi.dart';
import 'package:sellerkit/Services/PostQueryApi/QuotatationApi/quotegetAllApi.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';
import 'package:sellerkit/Services/userDialApi/userdialapi.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../DBModel/QuotFilterTableModel.dart';

class QuotestabController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());
  TabController? controller;

  String leadCheckDataExcep = '';
  String get getLeadCheckDataExcep => leadCheckDataExcep;
  List<GetAllQuotesData> QuotesOpenAllData = [];
  List<GetAllQuotesData> get getAllQuotesData => QuotesOpenAllData;
  List<GetAllQuotesData> QuotesOpenAllData2 = [];
  List<GetAllQuotesData> get getAllQuotesData2 => QuotesOpenAllData2;
  List<GetAllQuotesData> filterQuotesOpenAllData = [];
  List<GetAllQuotesData> get getFilterQuotesOpenAllData =>
      filterQuotesOpenAllData;

  List<GetAllQuotesData> QuotesClosedAllData = [];
  List<GetAllQuotesData> get getQuotesClosedAllData => QuotesClosedAllData;

  List<GetAllQuotesData> QuotesClosedAllData2 = [];
  List<GetAllQuotesData> get getQuotesClosedAllData2 => QuotesClosedAllData2;
  List<GetAllQuotesData> filterQuotesClosedAllData = [];
  List<GetAllQuotesData> get getFilterQuotesClosedAllData =>
      filterQuotesClosedAllData;
  List<Distcolumn> assigncolumn = [];
  List<Distcusgroupcolumn> cusgroupcolumn = [];
  List<DistEnqstatuscolumn> enqstatuscolumn = [];
  List<Distlookingforcolumn> lookingforcolumn = [];
  List<Distlookingforcolumn> filterlookingforcolumn = [];
  List<Distlookingforcolumn> lookingforcolumnforshow = [];
  List<Distlevelcolumn> intlevelcolumn = [];
  List<Distordercolumn> ordercolumn = [];
  List<Distcustnamecolumn> cusnamecolumn = [];
  List<String> selectedinterest = [];
  List<String> selectedorder = [];
  List<String> selectedlookingfor = [];
  List<String> selectedenqstatus = [];
  List<String> selectedcusgoup = [];
  List<String> selectedcusname = [];
  List<String> selectedassignto = [];
  bool isenqstatus = false;
  bool islookingfor = false;
  bool iscusgroup = false;
  bool iscusname = false;
  bool isassignto = false;
  bool isinterest = false;
  bool isorder = false;

  String? assignvalue;
  String? cusnamevalue;
  String? cardnamevalue;
  String? lookingforvalue;
  List<bool> lookingforvalue22 = [];
  String? interestlevelvalue;
  String? ordertypevalue;

  bool? islookloading = false;
  ontaporder() {
    isorder = !isorder;
    notifyListeners();
  }

  ontapinterest() {
    isinterest = !isinterest;
    notifyListeners();
  }

  ontapassignto() {
    isassignto = !isassignto;
    notifyListeners();
  }

  itemselectinterest(String itemvalue, bool isselected) {
    interestlevelvalue = '';
    if (isselected) {
      selectedinterest.add(itemvalue);
    } else {
      selectedinterest.remove(itemvalue);
    }
    interestlevelvalue = selectedinterest.join(', ');
    log("selectedinterest::" + selectedinterest.toString());
    log("interestlevelvalue::" + interestlevelvalue.toString());
    notifyListeners();
  }

  itemselectorder(String itemvalue, bool isselected) {
    ordertypevalue = '';
    if (isselected) {
      selectedorder.add(itemvalue);
    } else {
      selectedorder.remove(itemvalue);
    }
    ordertypevalue = selectedorder.join(', ');
    log("selectedorder::" + selectedorder.toString());
    log("ordertypevalue::" + ordertypevalue.toString());
    notifyListeners();
  }

  itemselectassignto(String itemvalue, bool isselected) {
    assignvalue = '';
    if (isselected) {
      selectedassignto.add(itemvalue);
    } else {
      selectedassignto.remove(itemvalue);
    }
    assignvalue = selectedassignto.join(', ');
    log("selectedassignto::" + selectedassignto.toString());
    log("assignvalue::" + assignvalue.toString());
    notifyListeners();
  }

  itemselectCusgroup(String itemvalue, bool isselected) {
    cusnamevalue = '';
    if (isselected) {
      selectedcusgoup.add(itemvalue);
    } else {
      selectedcusgoup.remove(itemvalue);
    }
    cusnamevalue = selectedcusgoup.join(', ');
    log("selectedcusgoup::" + selectedcusgoup.toString());
    log("cusnamevalue::" + cusnamevalue.toString());
    notifyListeners();
  }

  itemselectCusname(String itemvalue, bool isselected) {
    cusnamevalue = '';
    if (isselected) {
      selectedcusname.add(itemvalue);
    } else {
      selectedcusname.remove(itemvalue);
    }
    cardnamevalue = selectedcusname.join(', ');
    log("selectedcusgoup::" + selectedcusgoup.toString());
    log("cardnamevalue::" + cardnamevalue.toString());
    notifyListeners();
  }

  ontapcusgroup() {
    iscusgroup = !iscusgroup;
    notifyListeners();
  }

  ontapcusname() {
    iscusname = !iscusname;
    notifyListeners();
  }

  ontaplooking() {
    islookingfor = !islookingfor;
    notifyListeners();
  }

  onenqstatus() {
    isenqstatus = !isenqstatus;
    notifyListeners();
  }

  String? enquirystatusvalue = '';

  itemselectenqstatus(String itemvalue, bool isselected) {
    enquirystatusvalue = '';
    if (isselected) {
      selectedenqstatus.add(itemvalue);
    } else {
      selectedenqstatus.remove(itemvalue);
    }
    enquirystatusvalue = selectedenqstatus.join(', ');
    log("selectedlookingfor::" + selectedenqstatus.toString());
    log("Enquirystatusvalue::" + enquirystatusvalue.toString());
    notifyListeners();
  }

  itemselect(String itemvalue, bool isselected) {
    lookingforvalue = '';
    if (isselected) {
      selectedlookingfor.add(itemvalue);
    } else {
      selectedlookingfor.remove(itemvalue);
    }
    lookingforvalue = selectedlookingfor.join(', ');
    log("selectedlookingfor::" + selectedlookingfor.toString());
    log("lookingforvalue::" + lookingforvalue.toString());
    notifyListeners();
  }

  String opentab = '';
  String closedtab = '';
  String stserror = '';
  applyBtnMethod(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    stserror = '';
    opentab = '';
    closedtab = '';
    String? customerName = cusnamevalue ?? '';
    String? assignname = assignvalue ?? '';
    double? quotVal = mycontroller[23].text.isNotEmpty
        ? double.parse(mycontroller[23].text)
        : 0;
    String? quotStatus =
        enquirystatusvalue == null || enquirystatusvalue!.isEmpty
            ? ""
            : enquirystatusvalue;

    String frmDate = mycontroller[21].text.isNotEmpty
        ? config.alignDate1(mycontroller[21].text)
        : '0000-00-00';
    String toDate = mycontroller[22].text.isNotEmpty
        ? config.alignDate1(mycontroller[22].text)
        : "9999-12-31";
    String? ordertyp = ordertypevalue ?? "";

    QuotesOpenAllData = [];
    filterQuotesOpenAllData = [];
    QuotesClosedAllData = [];
    filterQuotesClosedAllData = [];
    List<Map<String, Object?>>? getCustoemrQuotLine =
        await DBOperation.getQuotfilterapply(
            db, assignname, quotStatus!, ordertyp, quotVal, frmDate, toDate);
    if (getCustoemrQuotLine.isNotEmpty) {
      for (int i = 0; i < getCustoemrQuotLine.length; i++) {
        if (getCustoemrQuotLine[i]['OrderStatus'].toString() == "Open") {
          opentab = "Open";
          QuotesOpenAllData.add(GetAllQuotesData(
              OrderType: getCustoemrQuotLine[i]['OrderType'].toString(),
              cusgroup: getCustoemrQuotLine[i]['Cusgroup'].toString(),
              createdon: getCustoemrQuotLine[i]['createdon'].toString(),
              isDelivered: getCustoemrQuotLine[i]['IsDelivered'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsDelivered'].toString())
                  : null,
              isInvoiced: getCustoemrQuotLine[i]['IsInvoiced'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsInvoiced'].toString())
                  : null,
              OrderDocEntry: getCustoemrQuotLine[i]['OrderDocEntry'] != null
                  ? int.parse(
                      getCustoemrQuotLine[i]['OrderDocEntry'].toString())
                  : null,
              OrderNum:
                  int.parse(getCustoemrQuotLine[i]['OrderNum'].toString()),
              Mobile: getCustoemrQuotLine[i]['Mobile'].toString(),
              CustomerName: getCustoemrQuotLine[i]['CustomerName'].toString(),
              DocDate: getCustoemrQuotLine[i]['DocDate'].toString(),
              AssignedTo: getCustoemrQuotLine[i]['AssignedTo'].toString(),
              AttachURL1: getCustoemrQuotLine[i]['AttachURL1'].toString(),
              AttachURL2: getCustoemrQuotLine[i]['AttachURL2'].toString(),
              AttachURL3: getCustoemrQuotLine[i]['AttachURL3'].toString(),
              BaseDocDate: getCustoemrQuotLine[i]['BaseDocDate'].toString(),
              BaseID: int.parse(getCustoemrQuotLine[i]['BaseID'].toString()),
              BaseType: getCustoemrQuotLine[i]['BaseType'].toString(),
              CurrentStatus: getCustoemrQuotLine[i]['CurrentStatus'].toString(),
              DealID: getCustoemrQuotLine[i]['DealID'].toString(),
              Del_Address2: getCustoemrQuotLine[i]['Del_Address2'].toString(),
              Del_Address3: getCustoemrQuotLine[i]['Del_Address3'].toString(),
              Del_Area: getCustoemrQuotLine[i]['Del_Area'].toString(),
              Del_City: getCustoemrQuotLine[i]['Del_City'].toString(),
              Del_Country: getCustoemrQuotLine[i]['Del_Country'].toString(),
              Del_District: getCustoemrQuotLine[i]['Del_District'].toString(),
              Del_Pincode: getCustoemrQuotLine[i]['Del_Pincode'].toString(),
              Del_State: getCustoemrQuotLine[i]['Del_State'].toString(),
              DeliveryFrom: getCustoemrQuotLine[i]['DeliveryFrom'].toString(),
              Discount:
                  double.parse(getCustoemrQuotLine[i]['Discount'].toString()),
              FollowupEntry:
                  int.parse(getCustoemrQuotLine[i]['FollowupEntry'].toString()),
              LastUpdateMessage:
                  getCustoemrQuotLine[i]['LastUpdateMessage'].toString(),
              GrossTotal:
                  double.parse(getCustoemrQuotLine[i]['GrossTotal'].toString()),
              LastUpdateTime:
                  getCustoemrQuotLine[i]['LastUpdateTime'].toString(),
              OrderStatus: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              Product: getCustoemrQuotLine[i]['Product'].toString(),
              RoundOff:
                  double.parse(getCustoemrQuotLine[i]['RoundOff'].toString()),
              Status: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              StoreCode: getCustoemrQuotLine[i]['StoreCode'].toString(),
              SubTotal: getCustoemrQuotLine[i]['SubTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['SubTotal'].toString())
                  : null,
              TaxAmount: getCustoemrQuotLine[i]['TaxAmount'] != null
                  ? double.parse(getCustoemrQuotLine[i]['TaxAmount'].toString())
                  : null,
              Value: getCustoemrQuotLine[i]['DocTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['DocTotal'].toString())
                  : null,
              alternateMobileNo:
                  getCustoemrQuotLine[i]['AlternateMobileNo'].toString(),
              bil_Address1: getCustoemrQuotLine[i]['Bil_Address1'].toString(),
              bil_Address2: getCustoemrQuotLine[i]['Bil_Address2'].toString(),
              bil_Address3: getCustoemrQuotLine[i]['Bil_Address3'].toString(),
              bil_Area: getCustoemrQuotLine[i]['Bil_Area'].toString(),
              bil_City: getCustoemrQuotLine[i]['Bil_City'].toString(),
              bil_Country: getCustoemrQuotLine[i]['Bil_Country'].toString(),
              bil_District: getCustoemrQuotLine[i]['Bil_District'].toString(),
              bil_Pincode: getCustoemrQuotLine[i]['Bil_Pincode'].toString(),
              bil_State: getCustoemrQuotLine[i]['Bil_State'].toString(),
              companyName: getCustoemrQuotLine[i]['CompanyName'].toString(),
              contactName: getCustoemrQuotLine[i]['ContactName'].toString(),
              customerEmail: getCustoemrQuotLine[i]['CustomerEmail'].toString(),
              customerPORef: getCustoemrQuotLine[i]['CustomerPORef'].toString(),
              del_Address1: getCustoemrQuotLine[i]['Del_Address1'].toString(),
              deliveryDueDate:
                  getCustoemrQuotLine[i]['DeliveryDueDate'].toString(),
              enqid: getCustoemrQuotLine[i]['Enqid'].toString(),
              gSTNo: getCustoemrQuotLine[i]['GSTNo'].toString(),
              leadid: getCustoemrQuotLine[i]['Leadid'].toString(),
              pAN: getCustoemrQuotLine[i]['PAN'].toString(),
              paymentDueDate:
                  getCustoemrQuotLine[i]['PaymentDueDate'].toString()));

          filterQuotesOpenAllData = QuotesOpenAllData;
          log('filterQuotesOpenAllData length::${filterQuotesOpenAllData.length}');
          filterQuotesClosedAllData = QuotesClosedAllData;

          notifyListeners();
        } else if (getCustoemrQuotLine[i]['OrderStatus'].toString() ==
            "Closed") {
          closedtab = "Closed";
          QuotesClosedAllData.add(GetAllQuotesData(
              OrderType: getCustoemrQuotLine[i]['OrderType'].toString(),
              cusgroup: getCustoemrQuotLine[i]['Cusgroup'].toString(),
              createdon: getCustoemrQuotLine[i]['createdon'].toString(),
              isDelivered: getCustoemrQuotLine[i]['IsDelivered'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsDelivered'].toString())
                  : null,
              isInvoiced: getCustoemrQuotLine[i]['IsInvoiced'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsInvoiced'].toString())
                  : null,
              OrderDocEntry: getCustoemrQuotLine[i]['OrderDocEntry'] != null
                  ? int.parse(
                      getCustoemrQuotLine[i]['OrderDocEntry'].toString())
                  : null,
              OrderNum:
                  int.parse(getCustoemrQuotLine[i]['OrderNum'].toString()),
              Mobile: getCustoemrQuotLine[i]['Mobile'].toString(),
              CustomerName: getCustoemrQuotLine[i]['CustomerName'].toString(),
              DocDate: getCustoemrQuotLine[i]['DocDate'].toString(),
              AssignedTo: getCustoemrQuotLine[i]['AssignedTo'].toString(),
              AttachURL1: getCustoemrQuotLine[i]['AttachURL1'].toString(),
              AttachURL2: getCustoemrQuotLine[i]['AttachURL2'].toString(),
              AttachURL3: getCustoemrQuotLine[i]['AttachURL3'].toString(),
              BaseDocDate: getCustoemrQuotLine[i]['BaseDocDate'].toString(),
              BaseID: int.parse(getCustoemrQuotLine[i]['BaseID'].toString()),
              BaseType: getCustoemrQuotLine[i]['BaseType'].toString(),
              CurrentStatus: getCustoemrQuotLine[i]['CurrentStatus'].toString(),
              DealID: getCustoemrQuotLine[i]['DealID'].toString(),
              Del_Address2: getCustoemrQuotLine[i]['Del_Address2'].toString(),
              Del_Address3: getCustoemrQuotLine[i]['Del_Address3'].toString(),
              Del_Area: getCustoemrQuotLine[i]['Del_Area'].toString(),
              Del_City: getCustoemrQuotLine[i]['Del_City'].toString(),
              Del_Country: getCustoemrQuotLine[i]['Del_Country'].toString(),
              Del_District: getCustoemrQuotLine[i]['Del_District'].toString(),
              Del_Pincode: getCustoemrQuotLine[i]['Del_Pincode'].toString(),
              Del_State: getCustoemrQuotLine[i]['Del_State'].toString(),
              DeliveryFrom: getCustoemrQuotLine[i]['DeliveryFrom'].toString(),
              Discount:
                  double.parse(getCustoemrQuotLine[i]['Discount'].toString()),
              FollowupEntry:
                  int.parse(getCustoemrQuotLine[i]['FollowupEntry'].toString()),
              LastUpdateMessage:
                  getCustoemrQuotLine[i]['LastUpdateMessage'].toString(),
              GrossTotal:
                  double.parse(getCustoemrQuotLine[i]['GrossTotal'].toString()),
              LastUpdateTime:
                  getCustoemrQuotLine[i]['LastUpdateTime'].toString(),
              OrderStatus: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              Product: getCustoemrQuotLine[i]['Product'].toString(),
              RoundOff:
                  double.parse(getCustoemrQuotLine[i]['RoundOff'].toString()),
              Status: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              StoreCode: getCustoemrQuotLine[i]['StoreCode'].toString(),
              SubTotal: getCustoemrQuotLine[i]['SubTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['SubTotal'].toString())
                  : null,
              TaxAmount: getCustoemrQuotLine[i]['TaxAmount'] != null
                  ? double.parse(getCustoemrQuotLine[i]['TaxAmount'].toString())
                  : null,
              Value: getCustoemrQuotLine[i]['DocTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['DocTotal'].toString())
                  : null,
              alternateMobileNo:
                  getCustoemrQuotLine[i]['AlternateMobileNo'].toString(),
              bil_Address1: getCustoemrQuotLine[i]['Bil_Address1'].toString(),
              bil_Address2: getCustoemrQuotLine[i]['Bil_Address2'].toString(),
              bil_Address3: getCustoemrQuotLine[i]['Bil_Address3'].toString(),
              bil_Area: getCustoemrQuotLine[i]['Bil_Area'].toString(),
              bil_City: getCustoemrQuotLine[i]['Bil_City'].toString(),
              bil_Country: getCustoemrQuotLine[i]['Bil_Country'].toString(),
              bil_District: getCustoemrQuotLine[i]['Bil_District'].toString(),
              bil_Pincode: getCustoemrQuotLine[i]['Bil_Pincode'].toString(),
              bil_State: getCustoemrQuotLine[i]['Bil_State'].toString(),
              companyName: getCustoemrQuotLine[i]['CompanyName'].toString(),
              contactName: getCustoemrQuotLine[i]['ContactName'].toString(),
              customerEmail: getCustoemrQuotLine[i]['CustomerEmail'].toString(),
              customerPORef: getCustoemrQuotLine[i]['CustomerPORef'].toString(),
              del_Address1: getCustoemrQuotLine[i]['Del_Address1'].toString(),
              deliveryDueDate:
                  getCustoemrQuotLine[i]['DeliveryDueDate'].toString(),
              enqid: getCustoemrQuotLine[i]['Enqid'].toString(),
              gSTNo: getCustoemrQuotLine[i]['GSTNo'].toString(),
              leadid: getCustoemrQuotLine[i]['Leadid'].toString(),
              pAN: getCustoemrQuotLine[i]['PAN'].toString(),
              paymentDueDate:
                  getCustoemrQuotLine[i]['PaymentDueDate'].toString()));

          filterQuotesClosedAllData = QuotesClosedAllData;
          // filterQuotesOpenAllData = QuotesOpenAllData;

          notifyListeners();
        }
      }
      // navigatePagw(context);
      notifyListeners();
    }
    // else {

    //   Navigator.pop(context);
    //   notifyListeners();
    // }

    notifyListeners();
    // }
    log('message2');
    notifyListeners();

    log('message3');
  }

  navigatePagw(
    BuildContext context,
  ) {
    if (closedtab == "Closed" && controller!.index == 0) {
      Navigator.of(context).pop();
      controller!.index = 1;
      notifyListeners();
    } else if (opentab == "Open" && controller!.index == 1) {
      log('QuotesOpenAllData length 000::${filterQuotesOpenAllData.length}');
      Navigator.pop(context);
      controller!.index = 0;

      notifyListeners();
    } else if (closedtab == "Closed" && controller!.index == 1) {
      Navigator.of(context).pop();

      notifyListeners();
    } else if (opentab == "Open" && controller!.index == 0) {
      Navigator.pop(context);

      notifyListeners();
    }
    notifyListeners();
  }

  clearfilterval() {
    filterapiwonpurchaseDate = '';
    checkdate = null;
    enquirystatusvalue = null;
    stserror = '';
    assignvalue = null;
    cusnamevalue = null;
    islookingfor = false;
    selectedlookingfor.clear();
    isenqstatus = false;
    selectedenqstatus.clear();
    selectedcusgoup.clear();
    iscusgroup = false;
    isassignto = false;
    isorder = false;
    isinterest = false;
    selectedinterest.clear();
    selectedorder.clear();
    selectedassignto.clear();
    enquirystatusvalue = null;
    lookingforvalue = null;
    ordertypevalue = null;
    // islookloading = false;
    interestlevelvalue = null;
    lookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();

    notifyListeners();
  }

  String? levelofInterest;
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

  String? apidate;
  bool iscalltrue = false;
  String? userid = '';
  String? usernumber = '';
  calldialApi(String? number) async {
    usernumber = '';
    iscalltrue = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 40), () {
      log("secondsoverrr:::");
      iscalltrue = false;
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
        usernumber = element['mobile'].toString();

        log("fsdfdf::" + usernumber.toString());
        if (ConstantValues.userbyidmobile == usernumber) {
          log("fsdfdf::user number match");
          userid = element['id'].toString();
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

  clearAllListData() async {
    iscalltrue = false;
    userid = '';
    usernumber = '';
    quotFilterList = [];
    final Database db = (await DBHelper.getInstance())!;
    orderdialogdata.clear();
    datagotByApi = false;
    feedbackcancel = 'Give your feedback:*';
    valuecancelStatus = null;
    updateFollowUpDialog = false;
    caseStatusSelected = '';
    hinttextforcancel = 'Cancellation Reason:* ';
    leadCheckDataExcep = '';
    mycontroller[5].text = '';
    leadDeatilsQTHData.clear();
    leadDeatilsQTLData.clear();
    leadLoadingdialog = false;
    updateFollowUpdialog = false;
    viewDetailsdialog = false;
    leadForwarddialog = false;
    leadWondialog = false;
    QuotesOpenAllData.clear();
    filterQuotesOpenAllData.clear();
    forwardSuccessMsg = '';
    QuotesClosedAllData.clear();
    filterQuotesClosedAllData.clear();
    await DBOperation.truncateQuotFilter(db);
    filterapiwonpurchaseDate = '';
    // dropdownValue = null;
    assignvalue = null;
    cusnamevalue = null;
    enquirystatusvalue = null;
    lookingforvalue = null;
    ordertypevalue = null;
    levelofInterest = null;
    mycontroller[21].text = '';
    mycontroller[22].text = '';
    mycontroller[23].text = '';
    closedtab = '';
    notifyListeners();
  }

  List<QuotFilterModel> quotFilterList = [];
  insertQuotListData(
      List<GetAllQuotesData> leadcheckdata, BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    quotFilterList = [];

    for (int i = 0; i < leadcheckdata.length; i++) {
      log("message Status::${leadcheckdata[i].Status}");
      quotFilterList.add(QuotFilterModel(
          custName: leadcheckdata[i].CustomerName.toString(),
          lastUpdatedDate: leadcheckdata[i].LastUpdateTime.toString(),
          orderNum: leadcheckdata[i].OrderNum.toString(),
          product: leadcheckdata[i].Product.toString(),
          quotDate: leadcheckdata[i].createdon.toString(),
          quotStatus: leadcheckdata[i].Status.toString(),
          assignTo: leadcheckdata[i].AssignedTo.toString(),
          orderType: leadcheckdata[i].OrderType!,
          cusgroup: leadcheckdata[i].cusgroup,
          createdon: leadcheckdata[i].createdon,
          isDelivered: leadcheckdata[i].isDelivered != null
              ? leadcheckdata[i].isDelivered
              : null,
          isInvoiced: leadcheckdata[i].isInvoiced,
          OrderDocEntry: leadcheckdata[i].OrderDocEntry,
          Mobile: leadcheckdata[i].Mobile,
          DocDate: leadcheckdata[i].DocDate,
          AttachURL1: leadcheckdata[i].AttachURL1,
          AttachURL2: leadcheckdata[i].AttachURL2,
          AttachURL3: leadcheckdata[i].AttachURL3,
          BaseDocDate: leadcheckdata[i].BaseDocDate,
          BaseID: leadcheckdata[i].BaseID,
          BaseType: leadcheckdata[i].BaseType,
          CurrentStatus: leadcheckdata[i].CurrentStatus,
          DealID: leadcheckdata[i].DealID,
          Del_Address1: leadcheckdata[i].del_Address1,
          Del_Address2: leadcheckdata[i].Del_Address2,
          Del_Address3: leadcheckdata[i].Del_Address3,
          Del_Area: leadcheckdata[i].Del_Area,
          Del_City: leadcheckdata[i].Del_City,
          Del_Country: leadcheckdata[i].Del_Country,
          Del_District: leadcheckdata[i].Del_District,
          Del_Pincode: leadcheckdata[i].Del_Pincode,
          Del_State: leadcheckdata[i].Del_State,
          DeliveryFrom: leadcheckdata[i].DeliveryFrom,
          Discount: leadcheckdata[i].Discount,
          FollowupEntry: leadcheckdata[i].FollowupEntry,
          LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
          GrossTotal: leadcheckdata[i].GrossTotal,
          LastUpdateTime: leadcheckdata[i].LastUpdateTime,
          OrderStatus: leadcheckdata[i].OrderStatus,
          Product: leadcheckdata[i].Product,
          RoundOff: leadcheckdata[i].RoundOff,
          Status: leadcheckdata[i].Status,
          StoreCode: leadcheckdata[i].StoreCode,
          SubTotal: leadcheckdata[i].SubTotal,
          TaxAmount: leadcheckdata[i].TaxAmount,
          docTotal: leadcheckdata[i].Value,
          alternateMobileNo: leadcheckdata[i].alternateMobileNo,
          bil_Address1: leadcheckdata[i].bil_Address1,
          bil_Address2: leadcheckdata[i].bil_Address2,
          bil_Address3: leadcheckdata[i].bil_Address3,
          bil_Area: leadcheckdata[i].bil_Area,
          bil_City: leadcheckdata[i].bil_City,
          bil_Country: leadcheckdata[i].bil_Country,
          bil_District: leadcheckdata[i].bil_District,
          bil_Pincode: leadcheckdata[i].bil_Pincode,
          bil_State: leadcheckdata[i].bil_State,
          companyName: leadcheckdata[i].companyName,
          contactName: leadcheckdata[i].contactName,
          customerEmail: leadcheckdata[i].customerEmail,
          customerPORef: leadcheckdata[i].customerPORef,
          deliveryDueDate: leadcheckdata[i].deliveryDueDate,
          enqid: leadcheckdata[i].enqid,
          gSTNo: leadcheckdata[i].gSTNo,
          leadid: leadcheckdata[i].leadid,
          pAN: leadcheckdata[i].pAN,
          paymentDueDate: leadcheckdata[i].paymentDueDate));
      notifyListeners();
    }
    await DBOperation.insertQuotFilter(db, quotFilterList);

    // List<Map<String, Object?>>? getQuotFilterLine =
    //     await DBOperation.getQuotFilterassign(db);
    // List<Map<String, Object?>>? getQuotstsFilterLine =
    //     await DBOperation.getQuotFilterQStatus(db);
    // for (int i = 0; i < getQuotFilterLine!.length; i++) {
    //   quotFilterList2.add(QuotFilterModel(
    //     assignTo: getQuotFilterLine[i]['AssignedTo'].toString(),
    //     // orderType: getQuotFilterLine[i]['OrderType'].toString(),
    //   ));
    //   notifyListeners();
    // }

    // if (quotFilterList2.length == 1) {
    //   assignvalue = quotFilterList2[0].assignTo;
    //   notifyListeners();
    // }
    // for (int i = 0; i < getQuotstsFilterLine!.length; i++) {
    //   quotFilterList4.add(QuotFilterModel(
    //     OrderStatus: getQuotstsFilterLine[i]['OrderStatus'].toString(),
    //   ));
    //   notifyListeners();
    // }

    // List<Map<String, Object?>>? getCustoemrQuotLine =
    //     await DBOperation.getCustoemrQuotFilter(db);
    // for (int i = 0; i < getCustoemrQuotLine!.length; i++) {
    //   quotFilterList3.add(QuotFilterModel(
    //       custName: getCustoemrQuotLine[i]['CustomerName'].toString()));
    //   notifyListeners();
    // }
    getdbmodel(context);
    notifyListeners();
  }

  getQuotDataDb() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>>? getCustoemrQuotLine =
        await DBOperation.geQuotationtData(
      db,
    );
    if (getCustoemrQuotLine.isNotEmpty) {
      QuotesOpenAllData = [];
      filterQuotesOpenAllData = [];
      QuotesClosedAllData = [];
      filterQuotesClosedAllData = [];
      for (int i = 0; i < getCustoemrQuotLine.length; i++) {
        if (getCustoemrQuotLine[i]['OrderStatus'].toString() == "Open") {
          QuotesOpenAllData.add(GetAllQuotesData(
              OrderType: getCustoemrQuotLine[i]['OrderType'].toString(),
              cusgroup: getCustoemrQuotLine[i]['Cusgroup'].toString(),
              createdon: getCustoemrQuotLine[i]['createdon'].toString(),
              isDelivered: getCustoemrQuotLine[i]['IsDelivered'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsDelivered'].toString())
                  : null,
              isInvoiced: getCustoemrQuotLine[i]['IsInvoiced'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsInvoiced'].toString())
                  : null,
              OrderDocEntry: getCustoemrQuotLine[i]['OrderDocEntry'] != null
                  ? int.parse(
                      getCustoemrQuotLine[i]['OrderDocEntry'].toString())
                  : null,
              OrderNum:
                  int.parse(getCustoemrQuotLine[i]['OrderNum'].toString()),
              Mobile: getCustoemrQuotLine[i]['Mobile'].toString(),
              CustomerName: getCustoemrQuotLine[i]['CustomerName'].toString(),
              DocDate: getCustoemrQuotLine[i]['DocDate'].toString(),
              AssignedTo: getCustoemrQuotLine[i]['AssignedTo'].toString(),
              AttachURL1: getCustoemrQuotLine[i]['AttachURL1'].toString(),
              AttachURL2: getCustoemrQuotLine[i]['AttachURL2'].toString(),
              AttachURL3: getCustoemrQuotLine[i]['AttachURL3'].toString(),
              BaseDocDate: getCustoemrQuotLine[i]['BaseDocDate'].toString(),
              BaseID: int.parse(getCustoemrQuotLine[i]['BaseID'].toString()),
              BaseType: getCustoemrQuotLine[i]['BaseType'].toString(),
              CurrentStatus: getCustoemrQuotLine[i]['CurrentStatus'].toString(),
              DealID: getCustoemrQuotLine[i]['DealID'].toString(),
              Del_Address2: getCustoemrQuotLine[i]['Del_Address2'].toString(),
              Del_Address3: getCustoemrQuotLine[i]['Del_Address3'].toString(),
              Del_Area: getCustoemrQuotLine[i]['Del_Area'].toString(),
              Del_City: getCustoemrQuotLine[i]['Del_City'].toString(),
              Del_Country: getCustoemrQuotLine[i]['Del_Country'].toString(),
              Del_District: getCustoemrQuotLine[i]['Del_District'].toString(),
              Del_Pincode: getCustoemrQuotLine[i]['Del_Pincode'].toString(),
              Del_State: getCustoemrQuotLine[i]['Del_State'].toString(),
              DeliveryFrom: getCustoemrQuotLine[i]['DeliveryFrom'].toString(),
              Discount:
                  double.parse(getCustoemrQuotLine[i]['Discount'].toString()),
              FollowupEntry:
                  int.parse(getCustoemrQuotLine[i]['FollowupEntry'].toString()),
              LastUpdateMessage:
                  getCustoemrQuotLine[i]['LastUpdateMessage'].toString(),
              GrossTotal:
                  double.parse(getCustoemrQuotLine[i]['GrossTotal'].toString()),
              LastUpdateTime:
                  getCustoemrQuotLine[i]['LastUpdateTime'].toString(),
              OrderStatus: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              Product: getCustoemrQuotLine[i]['Product'].toString(),
              RoundOff:
                  double.parse(getCustoemrQuotLine[i]['RoundOff'].toString()),
              Status: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              StoreCode: getCustoemrQuotLine[i]['StoreCode'].toString(),
              SubTotal: getCustoemrQuotLine[i]['SubTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['SubTotal'].toString())
                  : null,
              TaxAmount: getCustoemrQuotLine[i]['TaxAmount'] != null
                  ? double.parse(getCustoemrQuotLine[i]['TaxAmount'].toString())
                  : null,
              Value: getCustoemrQuotLine[i]['DocTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['DocTotal'].toString())
                  : null,
              alternateMobileNo:
                  getCustoemrQuotLine[i]['AlternateMobileNo'].toString(),
              bil_Address1: getCustoemrQuotLine[i]['Bil_Address1'].toString(),
              bil_Address2: getCustoemrQuotLine[i]['Bil_Address2'].toString(),
              bil_Address3: getCustoemrQuotLine[i]['Bil_Address3'].toString(),
              bil_Area: getCustoemrQuotLine[i]['Bil_Area'].toString(),
              bil_City: getCustoemrQuotLine[i]['Bil_City'].toString(),
              bil_Country: getCustoemrQuotLine[i]['Bil_Country'].toString(),
              bil_District: getCustoemrQuotLine[i]['Bil_District'].toString(),
              bil_Pincode: getCustoemrQuotLine[i]['Bil_Pincode'].toString(),
              bil_State: getCustoemrQuotLine[i]['Bil_State'].toString(),
              companyName: getCustoemrQuotLine[i]['CompanyName'].toString(),
              contactName: getCustoemrQuotLine[i]['ContactName'].toString(),
              customerEmail: getCustoemrQuotLine[i]['CustomerEmail'].toString(),
              customerPORef: getCustoemrQuotLine[i]['CustomerPORef'].toString(),
              del_Address1: getCustoemrQuotLine[i]['Del_Address1'].toString(),
              deliveryDueDate:
                  getCustoemrQuotLine[i]['DeliveryDueDate'].toString(),
              enqid: getCustoemrQuotLine[i]['Enqid'].toString(),
              gSTNo: getCustoemrQuotLine[i]['GSTNo'].toString(),
              leadid: getCustoemrQuotLine[i]['Leadid'].toString(),
              pAN: getCustoemrQuotLine[i]['PAN'].toString(),
              paymentDueDate:
                  getCustoemrQuotLine[i]['PaymentDueDate'].toString()));

          filterQuotesOpenAllData = QuotesOpenAllData;
          log('filterQuotesOpenAllData length::${filterQuotesOpenAllData.length}');
          filterQuotesClosedAllData = QuotesClosedAllData;
          notifyListeners();
        } else if (getCustoemrQuotLine[i]['OrderStatus'].toString() ==
            "Closed") {
          QuotesClosedAllData.add(GetAllQuotesData(
              OrderType: getCustoemrQuotLine[i]['OrderType'].toString(),
              cusgroup: getCustoemrQuotLine[i]['Cusgroup'].toString(),
              createdon: getCustoemrQuotLine[i]['createdon'].toString(),
              isDelivered: getCustoemrQuotLine[i]['IsDelivered'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsDelivered'].toString())
                  : null,
              isInvoiced: getCustoemrQuotLine[i]['IsInvoiced'] != null
                  ? int.parse(getCustoemrQuotLine[i]['IsInvoiced'].toString())
                  : null,
              OrderDocEntry: getCustoemrQuotLine[i]['OrderDocEntry'] != null
                  ? int.parse(
                      getCustoemrQuotLine[i]['OrderDocEntry'].toString())
                  : null,
              OrderNum:
                  int.parse(getCustoemrQuotLine[i]['OrderNum'].toString()),
              Mobile: getCustoemrQuotLine[i]['Mobile'].toString(),
              CustomerName: getCustoemrQuotLine[i]['CustomerName'].toString(),
              DocDate: getCustoemrQuotLine[i]['DocDate'].toString(),
              AssignedTo: getCustoemrQuotLine[i]['AssignedTo'].toString(),
              AttachURL1: getCustoemrQuotLine[i]['AttachURL1'].toString(),
              AttachURL2: getCustoemrQuotLine[i]['AttachURL2'].toString(),
              AttachURL3: getCustoemrQuotLine[i]['AttachURL3'].toString(),
              BaseDocDate: getCustoemrQuotLine[i]['BaseDocDate'].toString(),
              BaseID: int.parse(getCustoemrQuotLine[i]['BaseID'].toString()),
              BaseType: getCustoemrQuotLine[i]['BaseType'].toString(),
              CurrentStatus: getCustoemrQuotLine[i]['CurrentStatus'].toString(),
              DealID: getCustoemrQuotLine[i]['DealID'].toString(),
              Del_Address2: getCustoemrQuotLine[i]['Del_Address2'].toString(),
              Del_Address3: getCustoemrQuotLine[i]['Del_Address3'].toString(),
              Del_Area: getCustoemrQuotLine[i]['Del_Area'].toString(),
              Del_City: getCustoemrQuotLine[i]['Del_City'].toString(),
              Del_Country: getCustoemrQuotLine[i]['Del_Country'].toString(),
              Del_District: getCustoemrQuotLine[i]['Del_District'].toString(),
              Del_Pincode: getCustoemrQuotLine[i]['Del_Pincode'].toString(),
              Del_State: getCustoemrQuotLine[i]['Del_State'].toString(),
              DeliveryFrom: getCustoemrQuotLine[i]['DeliveryFrom'].toString(),
              Discount:
                  double.parse(getCustoemrQuotLine[i]['Discount'].toString()),
              FollowupEntry:
                  int.parse(getCustoemrQuotLine[i]['FollowupEntry'].toString()),
              LastUpdateMessage:
                  getCustoemrQuotLine[i]['LastUpdateMessage'].toString(),
              GrossTotal:
                  double.parse(getCustoemrQuotLine[i]['GrossTotal'].toString()),
              LastUpdateTime:
                  getCustoemrQuotLine[i]['LastUpdateTime'].toString(),
              OrderStatus: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              Product: getCustoemrQuotLine[i]['Product'].toString(),
              RoundOff:
                  double.parse(getCustoemrQuotLine[i]['RoundOff'].toString()),
              Status: getCustoemrQuotLine[i]['OrderStatus'].toString(),
              StoreCode: getCustoemrQuotLine[i]['StoreCode'].toString(),
              SubTotal: getCustoemrQuotLine[i]['SubTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['SubTotal'].toString())
                  : null,
              TaxAmount: getCustoemrQuotLine[i]['TaxAmount'] != null
                  ? double.parse(getCustoemrQuotLine[i]['TaxAmount'].toString())
                  : null,
              Value: getCustoemrQuotLine[i]['DocTotal'] != null
                  ? double.parse(getCustoemrQuotLine[i]['DocTotal'].toString())
                  : null,
              alternateMobileNo:
                  getCustoemrQuotLine[i]['AlternateMobileNo'].toString(),
              bil_Address1: getCustoemrQuotLine[i]['Bil_Address1'].toString(),
              bil_Address2: getCustoemrQuotLine[i]['Bil_Address2'].toString(),
              bil_Address3: getCustoemrQuotLine[i]['Bil_Address3'].toString(),
              bil_Area: getCustoemrQuotLine[i]['Bil_Area'].toString(),
              bil_City: getCustoemrQuotLine[i]['Bil_City'].toString(),
              bil_Country: getCustoemrQuotLine[i]['Bil_Country'].toString(),
              bil_District: getCustoemrQuotLine[i]['Bil_District'].toString(),
              bil_Pincode: getCustoemrQuotLine[i]['Bil_Pincode'].toString(),
              bil_State: getCustoemrQuotLine[i]['Bil_State'].toString(),
              companyName: getCustoemrQuotLine[i]['CompanyName'].toString(),
              contactName: getCustoemrQuotLine[i]['ContactName'].toString(),
              customerEmail: getCustoemrQuotLine[i]['CustomerEmail'].toString(),
              customerPORef: getCustoemrQuotLine[i]['CustomerPORef'].toString(),
              del_Address1: getCustoemrQuotLine[i]['Del_Address1'].toString(),
              deliveryDueDate:
                  getCustoemrQuotLine[i]['DeliveryDueDate'].toString(),
              enqid: getCustoemrQuotLine[i]['Enqid'].toString(),
              gSTNo: getCustoemrQuotLine[i]['GSTNo'].toString(),
              leadid: getCustoemrQuotLine[i]['Leadid'].toString(),
              pAN: getCustoemrQuotLine[i]['PAN'].toString(),
              paymentDueDate:
                  getCustoemrQuotLine[i]['PaymentDueDate'].toString()));

          filterQuotesClosedAllData = QuotesClosedAllData;

          notifyListeners();
        }
        notifyListeners();
      }
      notifyListeners();
    }
    notifyListeners();
  }

  getdbmodel(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    GetfromdbEnqData = await DBOperation.getEnqdatafilter(db);
    log("GetfromdbEnqData::${GetfromdbEnqData.length}");
    List<Map<String, Object?>> assignDB =
        await DBOperation.getQuotftr("AssignedTo", db);
    List<Map<String, Object?>> cusgropDB =
        await DBOperation.getQuotftr("CustomerName", db);
    List<Map<String, Object?>> enqstatusDB =
        await DBOperation.getQuotftr("OrderStatus", db);
    // List<Map<String, Object?>> lookingforDB =
    //     await DBOperation.getQuotftr("Lookingfor", db);
    // List<Map<String, Object?>> intlevelDB =
    //     await DBOperation.getQuotftr("InterestLevel", db);
    List<Map<String, Object?>> ordertypeDB =
        await DBOperation.getQuotftr("OrderType", db);
    notifyListeners();

    await dataget(
        assignDB,
        cusgropDB,
        enqstatusDB,
        //  lookingforDB,
        // intlevelDB,
        ordertypeDB);

    notifyListeners();
  }

  List<EnquiriesData> GetfromdbEnqData = [];

  Future<void> dataget(
      List<Map<String, Object?>> assignDB,
      cusgropDB,
      enqstatusDB,
      // lookingforDB,
      // intlevelDB,
      ordertypeDB) async {
    assigncolumn.clear();
    cusgroupcolumn.clear();
    enqstatuscolumn.clear();
    // lookingforcolumn.clear();
    filterlookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    intlevelcolumn.clear();
    ordercolumn.clear();

    notifyListeners();
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      assigncolumn
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      log("assigncolumn::${assigncolumn.length}");
      notifyListeners();
    }
    for (int i = 0; i < cusgropDB.length; i++) {
      cusgroupcolumn.add(
          Distcusgroupcolumn(name: cusgropDB[i]['CustomerName'].toString()));
      notifyListeners();
    }
    for (int i = 0; i < enqstatusDB.length; i++) {
      enqstatuscolumn.add(
          DistEnqstatuscolumn(name: enqstatusDB[i]['OrderStatus'].toString()));
      log("enqstatuscolumn::${enqstatuscolumn.length}");
      notifyListeners();
    }
    // for (int i = 0; i < lookingforDB.length; i++) {
    //   lookingforcolumn.add(Distlookingforcolumn(
    //       name: lookingforDB[i]['Lookingfor'].toString(), ischecck: false));

    //   filterlookingforcolumn = lookingforcolumn;
    //   //   log("lookingforcolumn::" + filterlookingforcolumn.length.toString());

    //   notifyListeners();
    // }

    notifyListeners();
    // for (int i = 0; i < intlevelDB.length; i++) {
    //   intlevelcolumn.add(
    //       Distlevelcolumn(name: intlevelDB[i]['InterestLevel'].toString()));
    //   log("intlevelcolumn::" + intlevelcolumn.length.toString());
    //   notifyListeners();
    // }
    for (int i = 0; i < ordertypeDB.length; i++) {
      ordercolumn
          .add(Distordercolumn(name: ordertypeDB[i]['OrderType'].toString()));
      log("assigncolumn::${ordercolumn.length}");
      notifyListeners();
    }
  }

  Future<void> swipeRefreshIndiactor(BuildContext context) async {
    await clearAllListData();
    await callgetAllApi(context);
    await callusermobileApi();
  }

  String? filterapiwonpurchaseDate = '';
  DateTime? checkdate;
  void showfromDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      mycontroller[22].clear();
      String chooseddate = value.toString();
      checkdate = value;
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      filterapiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[21].text = chooseddate;
      notifyListeners();
    });
  }

  void showToDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: checkdate ?? DateTime.now(),
      firstDate: checkdate ?? DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      filterapiwonpurchaseDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      mycontroller[22].text = chooseddate;
      notifyListeners();
    });
  }

  bool datagotByApi = false;
  customerdetData? customermodeldata;
  callcustomerapi() async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        customermodeldata = value.leadcheckdata;
      }
    });
  }

  List<PaymodeModalData> paymode = [];
  callpaymodeApi() async {
    paymode.clear();
    notifyListeners();
    await PaymodeApi.getData("${ConstantValues.slpcode}").then((value) {
      //
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.paymode != null) {
          paymode = value.paymode!.paymodeModalData!;

          notifyListeners();
        } else if (value.paymode == null) {
          log("DONR222");
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        notifyListeners();
      } else if (value.stcode == 500) {
        notifyListeners();
      }
    });
  }

  String forwardSuccessMsg = '';
  String get getforwardSuccessMsg => forwardSuccessMsg;

  String lottie = '';
  callgetAllApi(BuildContext context) async {
    lottie = '';
    datagotByApi = false;
    notifyListeners();
    await GetAllQuotesApi.getData().then((value) {
      log("Step 2" + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.Quotescheckdatageader != null &&
            value.Quotescheckdatageader!.Quotescheckdata!.isNotEmpty) {
          log("not null");
          insertQuotListData(
              value.Quotescheckdatageader!.Quotescheckdata!, context);
          mapValues(value.Quotescheckdatageader!.Quotescheckdata!);
        } else if (value.Quotescheckdatageader == null ||
            value.Quotescheckdatageader!.Quotescheckdata!.isEmpty) {
          log("Order data null");
          lottie = 'Assets/no-data.png';
          leadCheckDataExcep = 'No Quotations..!!';
          datagotByApi == true;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        lottie = '';
        leadCheckDataExcep = '${value.message}..!!${value.exception}....!!';
        datagotByApi == true;
        notifyListeners();
      } else if (value.stcode == 500) {
        if (value.exception!.contains("Network is unreachable")) {
         lottie = 'Assets/NetworkAnimation.json';
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        datagotByApi == true;
          notifyListeners();
        } else {
          lottie = 'Assets/warning.png';
        leadCheckDataExcep =
            '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
        datagotByApi == true;
          notifyListeners();
        }
        // lottie = 'Assets/NetworkAnimation.json';
        // leadCheckDataExcep =
        //     '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        // datagotByApi == true;
        notifyListeners();
      }
      notifyListeners();
    });
    await callpaymodeApi();
    await callinitApi();
    await callusermobileApi();
  }

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;
  clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
    leadLostSaveClicked = false;
    leadOpenSaveClicked = true;
    leadWonSaveClicked = false;
    callRequiredCancel(followDocEntry);
  }

  callRequiredCancel(String followDocEntry) {
    int i = 0;
    if (valuecancelStatus == null) {
      i = i + 1;
      hinttextforcancel = "Cancellation Reason: *";
    } else {
      hinttextforcancel = "Cancellation Reason:*";
    }
    if (mycontroller[5].text.isEmpty) {
      i = i + 1;
      feedbackcancel = 'Give your feedback: *';
    } else {
      feedbackcancel = 'Give your feedback:*';
    }

    if (i < 1) {
      print("ssssss");
      openSave(
        followDocEntry,
        mycontroller[5].text,
      );
    }
    notifyListeners();
  }

  openSave(String followDocEntry, feedback) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    ForwardQuoteUserDataOpen forwardLeadUserDataOpen =
        new ForwardQuoteUserDataOpen();
    forwardLeadUserDataOpen.curentDate = config.currentDate();
    forwardLeadUserDataOpen.ReasonCode = valuecancelStatus;
    // forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
    // forwardLeadUserDataOpen.nextFD = nextFPdate;
    // forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    forwardLeadUserDataOpen.feedback = feedback;
    notifyListeners();

    //OpenSaveLeadApi.printjson(followDocEntry,forwardLeadUserDataOpen);
    await CancelApi.getData(followDocEntry, forwardLeadUserDataOpen)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = '${value.errorTitle}..${value.message}..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    // checkValues();
  }

  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;

  caseStatusSelectBtn(String val) {
    caseStatusSelected = val;
    notifyListeners();
  }

  changetoFolloweUp() {
    updateFollowUpDialog = true;
    notifyListeners();
  }

  String? feedbackcancel = 'Give your feedback:*'; //cl Give your feedback
  String? get getfeedbackcancel => feedbackcancel;
  Config config = new Config();
  SearchFilterOpenTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterQuotesOpenAllData = QuotesOpenAllData.where((e) =>
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .OrderNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .Value!
                  .toDouble()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e).Mobile.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterQuotesOpenAllData = QuotesOpenAllData;
      notifyListeners();
    }
  }

  setListData() {
    filterQuotesOpenAllData = QuotesOpenAllData;
    filterQuotesClosedAllData = QuotesClosedAllData;
    notifyListeners();
  }

  SearchFilterlostTab(String v) {
    if (v.isNotEmpty) {
      filterQuotesClosedAllData = QuotesClosedAllData.where((e) =>
              (e).CustomerName!.toLowerCase().contains(v.toLowerCase()) ||
              (e).Product!.toLowerCase().contains(v.toLowerCase()) ||
              (e)
                  .OrderNum!
                  .toInt()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e)
                  .Value!
                  .toDouble()
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              (e).Mobile.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterQuotesClosedAllData = QuotesClosedAllData;
      notifyListeners();
    }
  }

  mapValues(List<GetAllQuotesData> leadcheckdata) {
    log("inside method" + leadcheckdata.length.toString());
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status.toString().toLowerCase() == "open") {
        QuotesOpenAllData.add(GetAllQuotesData(
          OrderType: leadcheckdata[i].OrderType,
          cusgroup: leadcheckdata[i].cusgroup,
          createdon: leadcheckdata[i].createdon,
          isDelivered: leadcheckdata[i].isDelivered,
          isInvoiced: leadcheckdata[i].isInvoiced,
          OrderDocEntry: leadcheckdata[i].OrderDocEntry,
          OrderNum: leadcheckdata[i].OrderNum,
          Mobile: leadcheckdata[i].Mobile,
          CustomerName: leadcheckdata[i].CustomerName,
          DocDate: leadcheckdata[i].DocDate,
          AssignedTo: leadcheckdata[i].AssignedTo,
          AttachURL1: leadcheckdata[i].AttachURL1,
          AttachURL2: leadcheckdata[i].AttachURL2,
          AttachURL3: leadcheckdata[i].AttachURL3,
          BaseDocDate: leadcheckdata[i].BaseDocDate,
          BaseID: leadcheckdata[i].BaseID,
          BaseType: leadcheckdata[i].BaseType,
          CurrentStatus: leadcheckdata[i].CurrentStatus,
          DealID: leadcheckdata[i].DealID,
          Del_Address2: leadcheckdata[i].Del_Address2,
          Del_Address3: leadcheckdata[i].Del_Address3,
          Del_Area: leadcheckdata[i].Del_Area,
          Del_City: leadcheckdata[i].Del_City,
          Del_Country: leadcheckdata[i].Del_Country,
          Del_District: leadcheckdata[i].Del_District,
          Del_Pincode: leadcheckdata[i].Del_Pincode,
          Del_State: leadcheckdata[i].Del_State,
          DeliveryFrom: leadcheckdata[i].DeliveryFrom,
          Discount: leadcheckdata[i].Discount,
          FollowupEntry: leadcheckdata[i].FollowupEntry,
          LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
          GrossTotal: leadcheckdata[i].GrossTotal,
          LastUpdateTime: leadcheckdata[i].LastUpdateTime,
          OrderStatus: leadcheckdata[i].OrderStatus,
          Product: leadcheckdata[i].Product,
          RoundOff: leadcheckdata[i].RoundOff,
          Status: leadcheckdata[i].Status,
          StoreCode: leadcheckdata[i].StoreCode,
          SubTotal: leadcheckdata[i].SubTotal,
          TaxAmount: leadcheckdata[i].TaxAmount,
          Value: leadcheckdata[i].Value,
          alternateMobileNo: leadcheckdata[i].alternateMobileNo,
          bil_Address1: leadcheckdata[i].bil_Address1,
          bil_Address2: leadcheckdata[i].bil_Address2,
          bil_Address3: leadcheckdata[i].bil_Address3,
          bil_Area: leadcheckdata[i].bil_Area,
          bil_City: leadcheckdata[i].bil_City,
          bil_Country: leadcheckdata[i].bil_Country,
          bil_District: leadcheckdata[i].bil_District,
          bil_Pincode: leadcheckdata[i].bil_Pincode,
          bil_State: leadcheckdata[i].bil_State,
          companyName: leadcheckdata[i].companyName,
          contactName: leadcheckdata[i].contactName,
          customerEmail: leadcheckdata[i].customerEmail,
          customerPORef: leadcheckdata[i].customerPORef,
          del_Address1: leadcheckdata[i].del_Address1,
          deliveryDueDate: leadcheckdata[i].deliveryDueDate,
          enqid: leadcheckdata[i].enqid,
          gSTNo: leadcheckdata[i].gSTNo,
          leadid: leadcheckdata[i].leadid,
          pAN: leadcheckdata[i].pAN,
          paymentDueDate: leadcheckdata[i].paymentDueDate,
        ));
        filterQuotesOpenAllData = QuotesOpenAllData;
        notifyListeners();
// log("isDelivered::"+filterQuotesOpenAllData[0].isDelivered.toString());
      } else {
        // log("inside Open Docentry  "+leadcheckdata[i].Status.toString());

        QuotesClosedAllData.add(GetAllQuotesData(
          OrderType: leadcheckdata[i].OrderType,
          cusgroup: leadcheckdata[i].cusgroup,
          createdon: leadcheckdata[i].createdon,
          isDelivered: leadcheckdata[i].isDelivered,
          isInvoiced: leadcheckdata[i].isInvoiced,
          OrderDocEntry: leadcheckdata[i].OrderDocEntry,
          OrderNum: leadcheckdata[i].OrderNum,
          Mobile: leadcheckdata[i].Mobile,
          CustomerName: leadcheckdata[i].CustomerName,
          DocDate: leadcheckdata[i].DocDate,
          AssignedTo: leadcheckdata[i].AssignedTo,
          AttachURL1: leadcheckdata[i].AttachURL1,
          AttachURL2: leadcheckdata[i].AttachURL2,
          AttachURL3: leadcheckdata[i].AttachURL3,
          BaseDocDate: leadcheckdata[i].BaseDocDate,
          BaseID: leadcheckdata[i].BaseID,
          BaseType: leadcheckdata[i].BaseType,
          CurrentStatus: leadcheckdata[i].CurrentStatus,
          DealID: leadcheckdata[i].DealID,
          Del_Address2: leadcheckdata[i].Del_Address2,
          Del_Address3: leadcheckdata[i].Del_Address3,
          Del_Area: leadcheckdata[i].Del_Area,
          Del_City: leadcheckdata[i].Del_City,
          Del_Country: leadcheckdata[i].Del_Country,
          Del_District: leadcheckdata[i].Del_District,
          Del_Pincode: leadcheckdata[i].Del_Pincode,
          Del_State: leadcheckdata[i].Del_State,
          DeliveryFrom: leadcheckdata[i].DeliveryFrom,
          Discount: leadcheckdata[i].Discount,
          FollowupEntry: leadcheckdata[i].FollowupEntry,
          LastUpdateMessage: leadcheckdata[i].LastUpdateMessage,
          GrossTotal: leadcheckdata[i].GrossTotal,
          LastUpdateTime: leadcheckdata[i].LastUpdateTime,
          OrderStatus: leadcheckdata[i].OrderStatus,
          Product: leadcheckdata[i].Product,
          RoundOff: leadcheckdata[i].RoundOff,
          Status: leadcheckdata[i].Status,
          StoreCode: leadcheckdata[i].StoreCode,
          SubTotal: leadcheckdata[i].SubTotal,
          TaxAmount: leadcheckdata[i].TaxAmount,
          Value: leadcheckdata[i].Value,
          alternateMobileNo: leadcheckdata[i].alternateMobileNo,
          bil_Address1: leadcheckdata[i].bil_Address1,
          bil_Address2: leadcheckdata[i].bil_Address2,
          bil_Address3: leadcheckdata[i].bil_Address3,
          bil_Area: leadcheckdata[i].bil_Area,
          bil_City: leadcheckdata[i].bil_City,
          bil_Country: leadcheckdata[i].bil_Country,
          bil_District: leadcheckdata[i].bil_District,
          bil_Pincode: leadcheckdata[i].bil_Pincode,
          bil_State: leadcheckdata[i].bil_State,
          companyName: leadcheckdata[i].companyName,
          contactName: leadcheckdata[i].contactName,
          customerEmail: leadcheckdata[i].customerEmail,
          customerPORef: leadcheckdata[i].customerPORef,
          del_Address1: leadcheckdata[i].del_Address1,
          deliveryDueDate: leadcheckdata[i].deliveryDueDate,
          enqid: leadcheckdata[i].enqid,
          gSTNo: leadcheckdata[i].gSTNo,
          leadid: leadcheckdata[i].leadid,
          pAN: leadcheckdata[i].pAN,
          paymentDueDate: leadcheckdata[i].paymentDueDate,
        ));
        filterQuotesClosedAllData = QuotesClosedAllData;

        notifyListeners();
      }
    }
    datagotByApi = true;
    notifyListeners();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool leadLoadingdialog = false;
  bool get getleadLoadingdialog => leadLoadingdialog;
  bool updateFollowUpdialog = false;
  bool get getupdateFollowUpdialog => updateFollowUpdialog;
  bool viewDetailsdialog = false;
  bool get getviewDetailsdialog => viewDetailsdialog;
  bool updateFollowUpDialog = false;
  bool get getupdateFollowUpDialog => updateFollowUpDialog;
  bool leadForwarddialog = false;
  bool get getleadForwarddialog => leadForwarddialog;
  bool leadWondialog = false;
  bool get getleadWondialog => leadWondialog;
  static bool isSameBranch = true;
  bool get getisSameBranch => isSameBranch;
  viweDetailsClicked() {
    viewDetailsdialog = !viewDetailsdialog;
    notifyListeners();
  }

  List<GetQuotesDeatilsQTHData> leadDeatilsQTHData = [];
  List<GetQuotesDeatilsQTHData> get getleadDeatilsQTHData => leadDeatilsQTHData;
  List<GetQuotesQTLData> leadDeatilsQTLData = [];
  List<GetQuotesQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;
  List<GetQuotesQTLData> leadDeatilsLData = [];
  List<GetQuotesQTLData> get getleadDeatilsLeadData => leadDeatilsLData;
  refershAfterClosedialog(BuildContext context) async {
    await clearAllListData();
    await callgetAllApi(context);
    await callusermobileApi();
    notifyListeners();
  }

  mapvaluesmodify(GetAllQuotesData? leadOpenAllData) {
    NewquoteController.datafrommodify.clear();
    NewquoteController.datafrommodify
        .add(leadOpenAllData!.OrderDocEntry.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.Mobile.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.CustomerName.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.alternateMobileNo.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.customerEmail.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.contactName.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.bil_Address1.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.bil_Address2.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.bil_Area.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.bil_City.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.bil_Pincode.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.bil_State.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.del_Address1.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.Del_Address2.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.Del_Area.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.Del_City.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.Del_Pincode.toString());

    NewquoteController.datafrommodify
        .add(leadOpenAllData!.Del_State.toString());

    NewquoteController.datafrommodify.add(leadOpenAllData!.OrderNum.toString());
    NewquoteController.datafrommodify.add(leadOpenAllData!.gSTNo.toString());
    NewquoteController.datafrommodify.add(leadOpenAllData!.cusgroup.toString());
    NewquoteController.datafrommodify
        .add(leadOpenAllData!.OrderType.toString());
    NewquoteController.datafrommodify.add(leadOpenAllData!.DocDate.toString());
    QuoteNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.quotesnew);
    notifyListeners();
  }

  mapvaluestoorder(GetAllQuotesData? leadOpenAllData) {
    OrderNewController.datafromquotes.clear();
    OrderNewController.datafromquotes
        .add(leadOpenAllData!.OrderDocEntry.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.Mobile.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.CustomerName.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.alternateMobileNo.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.customerEmail.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.contactName.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.bil_Address1.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.bil_Address2.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.bil_Area.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.bil_City.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.bil_Pincode.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.bil_State.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.del_Address1.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.Del_Address2.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.Del_Area.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.Del_City.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.Del_Pincode.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.Del_State.toString());

    OrderNewController.datafromquotes.add(leadOpenAllData!.OrderNum.toString());
    OrderNewController.datafromquotes.add(leadOpenAllData!.gSTNo.toString());
    OrderNewController.datafromquotes.add(leadOpenAllData!.cusgroup.toString());

    OrderNewController.datafromquotes
        .add(leadOpenAllData!.OrderType.toString());
    OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.ordernew);
    notifyListeners();
  }

  callGetLeadDeatilsApi(String leadDocEnt) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();

    await GetQuotesQTHApi.getData(leadDocEnt).then((value) {
      log("ststus code");
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.QuotesDeatilsheaderData != null) {
          leadDeatilsQTHData =
              value.QuotesDeatilsheaderData!.OrderDeatilsQTHData!;
          leadDeatilsQTLData =
              value.QuotesDeatilsheaderData!.OrderDeatilsQTLData!;
          forwardSuccessMsg = '';
          leadLoadingdialog = false;
          leadForwarddialog = false;
          updateFollowUpDialog = false;
          viewDetailsdialog = true;

          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = '${value.stcode!}..${value.exception!}..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
  }

  String? hinttextforcancel = 'Cancellation Reason:* ';
  String? get gethinttextforcancel => hinttextforcancel;
  String? valuecancelStatus; //cl
  String? get getvaluecancelStatus => valuecancelStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;
  choosedcancelStatus(String val) {
    valuecancelStatus = val;
    notifyListeners();
  }

  List<GetOrderdialogData> orderdialogdata = [];
  callinitApi() async {
    await GetcanceldialogApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        orderdialogdata = value.orderdialogdata!;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        leadCheckDataExcep = '${value.exception}..!!';
        notifyListeners();
      } else {
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';

        notifyListeners();
      }
    });
  }
//   clearAllListData(){
//     orderdialogdata.clear();
//     datagotByApi=false;
//     feedbackcancel  = 'Give your feedback:*';
//     valuecancelStatus=null;
//     updateFollowUpDialog=false;
//     caseStatusSelected='';
//     hinttextforcancel = 'Cancellation Reason:* ';
// leadCheckDataExcep = '';
// mycontroller[5].text='';
// leadDeatilsQTHData.clear();
// leadDeatilsQTLData.clear();
// leadLoadingdialog = false;
// updateFollowUpdialog = false;
// viewDetailsdialog = false;
// leadForwarddialog = false;
// leadWondialog = false;
// QuotesOpenAllData.clear();
// filterQuotesOpenAllData.clear();
// forwardSuccessMsg = '';
// QuotesClosedAllData.clear();
// filterQuotesClosedAllData.clear();
// notifyListeners();
//       }
}
