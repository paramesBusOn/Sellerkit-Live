// ignore_for_file: empty_constructor_bodies, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/paymentmode.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';
import 'package:sellerkit/Services/userDialApi/userdialapi.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/LocationTrack.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/GetOrderSummary.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/canceldialogmodel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/canceldialogApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/GetAllOrderModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/GetOrderStatuModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/GetOrderDetailsL.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/GetOderDetailsQTHModel.dart';
import '../../Pages/OrderBooking/Widgets/FollowDialog.dart';
import '../../Services/PostQueryApi/OrdersApi/CancelOrderWonApi.dart';
import '../../Services/PostQueryApi/OrdersApi/CloseOrderwonApi.dart';
import '../../Services/PostQueryApi/OrdersApi/ForwardOrderUserApi.dart';
import '../../Services/PostQueryApi/OrdersApi/GetAllOrders.dart';
import '../../Services/PostQueryApi/OrdersApi/GetOrderDeatilsQTH.dart';
import '../../Services/PostQueryApi/OrdersApi/GetOrderDetailsL.dart';
import '../../Services/PostQueryApi/OrdersApi/GetOrderSummaryApi.dart';
import '../../Services/PostQueryApi/OrdersApi/LostSaveOrderApi.dart';
import '../../Services/PostQueryApi/OrdersApi/OpenSaveOrderApi.dart';
import '../../Services/PostQueryApi/OrdersApi/WonSaveOrderApi.dart';
import '../EnquiryController/NewEnqController.dart';

class OrderTabController extends ChangeNotifier {
  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());

  Config config = new Config();

  List<GetAllOrderData> leadOpenAllData = [];
  List<GetAllOrderData> get getAllLeadData => leadOpenAllData;
  List<GetAllOrderData> filterleadOpenAllData = [];
  List<GetAllOrderData> get getFilterleadOpenAllData => filterleadOpenAllData;
  //
  List<GetAllOrderData> leadClosedAllData = [];
  List<GetAllOrderData> get getleadClosedAllData => leadClosedAllData;
  List<GetAllOrderData> leadinProcessAllData = [];
  List<GetAllOrderData> get getleadinProcessAllData => leadinProcessAllData;
  List<GetAllOrderData> filterleadinProcessAllData = [];
  List<GetAllOrderData> get getfilterleadinProcessAllData =>
      filterleadinProcessAllData;
  List<GetAllOrderData> filterleadClosedAllData = [];
  List<GetAllOrderData> get getFilterleadClosedAllData =>
      filterleadClosedAllData;
  // List<GetAllOrderData> leadLostAllData = [];
  // List<GetAllOrderData> get getleadLostAllData => leadLostAllData;
  String leadCheckDataExcep = '';
  String get getLeadCheckDataExcep => leadCheckDataExcep;
  bool opendialogbool = false;
  bool reminderOn = false;
  printLogic() {
    log("leadCheckDataExcep: ${leadCheckDataExcep}");
    // log("leadSummaryLost: ${leadSummaryLost.length}");
    log("leadSummaryOpen: ${leadSummaryOpen.length}");
    log("leadSummaryWon: ${leadSummaryWon.length}");
    log("leadOpenAllData: ${leadOpenAllData.length}");
    log("leadClosedAllData: ${leadClosedAllData.length}");
    // log("leadLostAllData: ${leadLostAllData.length}");
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

  int? reyear;
  int? remonth;
  int? reday;
  int? rehours;
  int? reminutes;
  setReminderOnMethod(bool val, String? title) {
    reminderOn = val;
    if (reminderOn == true) {
      addgoogle(title);
      notifyListeners();
    }
    notifyListeners();
  }

  addgoogle(String? title) {
    Config config2 = Config();
    tz.TZDateTime? tzChosenDate;
    final DateTime chosenDate =
        DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
    final tz.Location indian = tz.getLocation('Asia/Kolkata');
    tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
    config2.addEventToCalendar(tzChosenDate!, "$title", "Lead");
  }

  clearAllListData() {
    datagotByApi = false;
    GetAllData.clear();
    iscalltrue = false;
    userid = '';
    usernumber = '';
    assigncolumn.clear();
    cusgroupcolumn.clear();
    enqstatuscolumn.clear();
    customernameforcolumn.clear();
    filterlookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    intlevelcolumn.clear();
    ordercolumn.clear();
    GetfromdborderData.clear();
    orderInvBillRefer = 'Invoice Reference*';
    orderInvvalue = 'Invoice Value*';
    orderInvvalue = 'Invoice Value*';
    files.clear();
    reminderOn = false;
    reyear = null;
    remonth = null;
    reday = null;
    rehours = null;
    reminutes = null;
    filedata.clear();
    leadCheckDataExcep = '';
    apiInvFDate = "";
    nextInvFD = "";
    mycontroller[0].clear();
    mycontroller[2].clear();
    mycontroller[1].clear();
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    files.clear();
    filedata.clear();
    // leadSummaryLost.clear();
    leadOpenAllData.clear();
    // leadLostAllData.clear();
    leadClosedAllData.clear();
    mycontroller[5].clear();
    mycontroller[10].clear();
    notifyListeners();
  }

  refershAfterClosedialog() {
    files.clear();
    filedata.clear();
    apiInvFDate = "";
    nextInvFD = "";
    leadCheckDataExcep = '';
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadinProcessAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadinProcessAllData.clear();
    // leadLostAllData.clear();
    iscalltrue = false;
    leadSummaryOpen.clear();
    leadSummaryWon.clear();
    leadSummaryinprocess.clear();
    // leadSummaryLost.clear();
    comeFromEnq = -1;
    viewDetailsdialog = false;
    mycontroller[5].clear();
    mycontroller[10].clear();
    notifyListeners();
  }

  Future<void> swipeRefreshIndiactor() async {
    // return Future.delayed(Duration.zero,(){
    // refershAfterClosedialog();
    await clearAllListData();
    await callinitApi();
    await callGetAllApi();
    await callpaymodeApi();
    await callusermobileApi();

    // callSummaryApi();

    //});
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

  customerdetData? customermodeldata;
  callcustomerapi() async {
    await customerDetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        customermodeldata = value.leadcheckdata;
      }
    });
  }

  List<GetAllOrderData> GetAllData = [];
  List<GetAllOrderData> GetfromdborderData = [];
  onfilterapply() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getorderfilterapply(
      db,
      assignvalue == null ? '' : assignvalue!,
      cusnamevalue == null ? '' : cusnamevalue!,
      lookingforvalue == null ? '' : lookingforvalue!,
      Enquirystatusvalue == null ? '' : Enquirystatusvalue!,
      ordertypevalue == null ? '' : ordertypevalue!,
      mycontroller[23].text.isEmpty ? 0.0 : double.parse(mycontroller[23].text),
      mycontroller[21].text.isEmpty
          ? '0000-00-00'
          : config.alignDate1(mycontroller[21].text),
      mycontroller[22].text.isEmpty
          ? '9999-12-31'
          : config.alignDate1(mycontroller[22].text),
    ).then((value) async {
      //  GetAllData.clear();
      GetfromdborderData.clear();
      leadOpenAllData.clear();
      leadClosedAllData.clear();
      leadinProcessAllData.clear();
      filterleadOpenAllData.clear();
      filterleadClosedAllData.clear();
      filterleadinProcessAllData.clear();
      GetfromdborderData = value;
      await mapValues(GetfromdborderData);
      clearfilterval();
      notifyListeners();
    });
  }

  bool? islookloading = false;
  clearfilterval() {
    checkdate = null;
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
    Enquirystatusvalue = null;
    lookingforvalue = null;
    ordertypevalue = null;
    islookloading = false;
    interestlevelvalue = null;
    customernameforcolumn.clear();
    lookingforcolumnforshow.clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();

    notifyListeners();
  }

  List<Distcolumn> assigncolumn = [];
  List<Distcusgroupcolumn> cusgroupcolumn = [];
  List<DistEnqstatuscolumn> enqstatuscolumn = [];
  List<Distlookingforcolumn> customernameforcolumn = [];
  List<Distlookingforcolumn> filterlookingforcolumn = [];
  List<Distlookingforcolumn> lookingforcolumnforshow = [];
  List<Distlevelcolumn> intlevelcolumn = [];
  List<Distordercolumn> ordercolumn = [];
  List<String> selectedinterest = [];
  List<String> selectedorder = [];
  List<String> selectedlookingfor = [];
  List<String> selectedenqstatus = [];
  List<String> selectedcusgoup = [];
  List<String> selectedassignto = [];
  bool isenqstatus = false;
  bool islookingfor = false;
  bool iscusgroup = false;
  bool isassignto = false;
  bool isinterest = false;
  bool isorder = false;
  String? assignvalue;
  String? cusnamevalue;
  String? Enquirystatusvalue;
  String? lookingforvalue;
  String? interestlevelvalue;
  String? ordertypevalue;
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

  ontapcusgroup() {
    iscusgroup = !iscusgroup;
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

  itemselectenqstatus(String itemvalue, bool isselected) {
    Enquirystatusvalue = '';
    if (isselected) {
      selectedenqstatus.add(itemvalue);
    } else {
      selectedenqstatus.remove(itemvalue);
    }
    Enquirystatusvalue = selectedenqstatus.join(', ');
    log("selectedlookingfor::" + selectedenqstatus.toString());
    log("Enquirystatusvalue::" + Enquirystatusvalue.toString());
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

  Future<void> dataget(List<Map<String, Object?>> assignDB, cusgropDB,
      enqstatusDB, ordertypeDB, customernameDB) async {
    assigncolumn.clear();
    cusgroupcolumn.clear();
    enqstatuscolumn.clear();
    customernameforcolumn.clear();
    filterlookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    intlevelcolumn.clear();
    ordercolumn.clear();

    notifyListeners();
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      assigncolumn
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      log("assigncolumn::" + assigncolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < cusgropDB.length; i++) {
      cusgroupcolumn.add(
          Distcusgroupcolumn(name: cusgropDB[i]['CustomerGroup'].toString()));
      log("cusgroupcolumn::" + cusgroupcolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < enqstatusDB.length; i++) {
      enqstatuscolumn.add(
          DistEnqstatuscolumn(name: enqstatusDB[i]['OrderStatus'].toString()));
      log("enqstatuscolumn::" + enqstatuscolumn.length.toString());
      notifyListeners();
    }
    for (int i = 0; i < customernameDB.length; i++) {
      customernameforcolumn.add(Distlookingforcolumn(
          name: customernameDB[i]['CustomerName'].toString(), ischecck: false));

      filterlookingforcolumn = customernameforcolumn;
      //   log("lookingforcolumn::" + filterlookingforcolumn.length.toString());

      notifyListeners();
    }
    //  for(int i=0;i<lookingforcolumn.length;i++){
    //   filterlookingforcolumn.add(Distlookingforcolumn(name: lookingforcolumn[i].name.toString(),ischecck: lookingforcolumn[i].ischecck));
    //    log("lookingforcolumn::" + filterlookingforcolumn[i].ischecck.toString());
    //    notifyListeners();
    //  }
    notifyListeners();
    // for (int i = 0; i < customernameDB.length; i++) {
    //   customernameforcolumn.add(Distlookingforcolumn(name: customernameDB[i]['InterestLevel'].toString()));
    //   log("intlevelcolumn::" + intlevelcolumn.length.toString());
    //   notifyListeners();
    // }
    for (int i = 0; i < ordertypeDB.length; i++) {
      ordercolumn
          .add(Distordercolumn(name: ordertypeDB[i]['OrderType'].toString()));
      log("assigncolumn::" + ordercolumn.length.toString());
      notifyListeners();
    }
  }

  getdbmodel() async {
    GetfromdborderData.clear();
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadinProcessAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadinProcessAllData.clear();
    final Database db = (await DBHelper.getInstance())!;
    GetfromdborderData = await DBOperation.getorderdatafilter(db);
    log("GetfromdbEnqData::" + GetfromdborderData.length.toString());
    List<Map<String, Object?>> assignDB =
        await DBOperation.getorderftr("AssignedTo", db);
    List<Map<String, Object?>> cusgropDB =
        await DBOperation.getorderftr("CustomerGroup", db);
    List<Map<String, Object?>> enqstatusDB =
        await DBOperation.getorderftr("OrderStatus", db);
    List<Map<String, Object?>> customernameforDB =
        await DBOperation.getorderftr("CustomerName", db);
    // List<Map<String, Object?>> intlevelDB =
    // await DBOperation.getorderftr("InterestLevel", db);
    List<Map<String, Object?>> ordertypeDB =
        await DBOperation.getorderftr("OrderType", db);
    notifyListeners();

    await dataget(
        assignDB, cusgropDB, enqstatusDB, ordertypeDB, customernameforDB);
    await mapValues(GetfromdborderData);
    notifyListeners();
  }

  tableinsert(List<GetAllOrderData> getalldata) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncareorderfilter(db);

    await DBOperation.insertOrderdata(getalldata, db);
    notifyListeners();
    await getdbmodel();
    notifyListeners();
  }

  bool datagotByApi = false;

  String lottie = '';
  callGetAllApi() async {
    datagotByApi = false;
    notifyListeners();
    GetAllData.clear();
    GetfromdborderData.clear();
    leadOpenAllData.clear();
    leadClosedAllData.clear();
    leadinProcessAllData.clear();
    filterleadOpenAllData.clear();
    filterleadClosedAllData.clear();
    filterleadinProcessAllData.clear();
    lottie = '';
    //  final Database db = (await DBHelper.getInstance())!;
    // leadStatusLost = await DBOperation.getLeadStatusLost(db);
    // log(leadStatusLost.length.toString());
    log("Step 1");
    await GetAllOrderApi.getData(ConstantValues.slpcode).then((value) {
      log("Step 2" + value.stcode.toString());

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log("Step 3" + value.Ordercheckdatageader.toString());

        if (value.Ordercheckdatageader != null &&
            value.Ordercheckdatageader!.Ordercheckdata!.isNotEmpty) {
          log("not null");
          GetAllData = value.Ordercheckdatageader!.Ordercheckdata!;
          tableinsert(GetAllData);

          // mapValues(value.Ordercheckdatageader!.Ordercheckdata!);
        } else if (value.Ordercheckdatageader == null ||
            value.Ordercheckdatageader!.Ordercheckdata!.isEmpty) {
          log("Order data null");
          datagotByApi = true;
          lottie = 'Assets/no-data.png';
          leadCheckDataExcep = 'No Orders..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        datagotByApi = true;
        lottie = '';
        leadCheckDataExcep = '${value.message}..!!${value.exception}....!!';
        notifyListeners();
      } else {
        datagotByApi = true;
        lottie = 'Assets/NetworkAnimation.json';
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
      notifyListeners();
    });

    notifyListeners();
  }

  SearchFilterOpenTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterleadOpenAllData = leadOpenAllData
          .where((e) =>
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
      filterleadOpenAllData = leadOpenAllData;
      notifyListeners();
    }
  }

  setListData() {
    filterleadOpenAllData = leadOpenAllData;
    filterleadClosedAllData = leadClosedAllData;
    notifyListeners();
  }

  SearchFilterlostTab(String v) {
    if (v.isNotEmpty) {
      filterleadClosedAllData = leadClosedAllData
          .where((e) =>
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
      filterleadClosedAllData = leadClosedAllData;
      notifyListeners();
    }
  }

  SearchFilterWonTab(String v) {
    print('saearch :' + v);
    if (v.isNotEmpty) {
      filterleadinProcessAllData = leadinProcessAllData
          .where((e) =>
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
      filterleadinProcessAllData = leadinProcessAllData;
      notifyListeners();
    }
  }

  mapValues(List<GetAllOrderData> leadcheckdata) async {
    log("inside method" + leadcheckdata.length.toString());
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status.toString().toLowerCase() == "open") {
        leadOpenAllData.add(GetAllOrderData(
          CustomerGroup: leadcheckdata[i].CustomerGroup,
          OrderType: leadcheckdata[i].OrderType,
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
        filterleadOpenAllData = leadOpenAllData;
        notifyListeners();
        log("isDelivered::" + filterleadOpenAllData[0].isDelivered.toString());
      } else if (leadcheckdata[i].Status.toString().toLowerCase() ==
          "in-process") {
        leadinProcessAllData.add(GetAllOrderData(
          CustomerGroup: leadcheckdata[i].CustomerGroup,
          OrderType: leadcheckdata[i].OrderType,
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
        filterleadinProcessAllData = leadinProcessAllData;
        notifyListeners();
      } else {
        log("inside Open Docentry  " + leadcheckdata[i].Status.toString());

        leadClosedAllData.add(GetAllOrderData(
          CustomerGroup: leadcheckdata[i].CustomerGroup,
          OrderType: leadcheckdata[i].OrderType,
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
        filterleadClosedAllData = leadClosedAllData;

        notifyListeners();
      }
    }

    notifyListeners();
    await callSummaryApi();
    await callinitApi();
    datagotByApi = true;
    notifyListeners();
  }

  // call summary api
  List<SummaryOrderData> leadSummaryOpen = [];
  List<SummaryOrderData> leadSummaryWon = [];
  List<SummaryOrderData> leadSummaryinprocess = [];
  // List<SummaryOrderData> leadSummaryLost = [];
  List<SummaryOrderData> get getleadSummaryinprocess => leadSummaryinprocess;
  List<SummaryOrderData> get getleadSummaryOpen => leadSummaryOpen;
  List<SummaryOrderData> get getleadSummaryWon => leadSummaryWon;
  // List<SummaryOrderData> get getleadSummaryLost => leadSummaryLost;

  callSummaryApi() async {
    lottie = '';
    // openlea();
    await GetOrderSummaryApi.getData(ConstantValues.slpcode).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("summary stcode"+value.stcode.toString());
        // log("summary stcode"+value.OrderSumarydata.toString());
        if (value.OrderSummaryheader!.OrderSumarydata != null) {
          // log("summary"+value.OrderSumarydata.toString());
          mapValuesSummary(value.OrderSummaryheader!.OrderSumarydata!);
        } else if (value.OrderSummaryheader!.OrderSumarydata == null) {
          log("OrderSummary data null");
          lottie = 'Assets/no-data.png';
          leadCheckDataExcep =
              'No Oders..!! ${value.stcode} ${value.exception}';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        leadCheckDataExcep =
            'Some thing went wrong..!! ${value.stcode} ${value.exception}';
      } else if (value.stcode == 500) {
        lottie = 'Assets/NetworkAnimation.json';
        leadCheckDataExcep =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
      notifyListeners();
    });
  }

  mapValuesSummary(List<SummaryOrderData> leadcheckdata) {
    for (int i = 0; i < leadcheckdata.length; i++) {
      if (leadcheckdata[i].Status == "Open") {
        leadSummaryOpen.add(SummaryOrderData(
            BTG: leadcheckdata[i].BTG,
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "Closed") {
        leadSummaryWon.add(SummaryOrderData(
            BTG: leadcheckdata[i].BTG,
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      } else if (leadcheckdata[i].Status == "In-Process") {
        leadSummaryinprocess.add(SummaryOrderData(
            BTG: leadcheckdata[i].BTG,
            Caption: leadcheckdata[i].Caption,
            Target: leadcheckdata[i].Target,
            Value: leadcheckdata[i].Value,
            Status: leadcheckdata[i].Status,
            column: leadcheckdata[i].column));
      }
    }
  }

  /////  for fialog
  String isSelectedFollowUp = '';
  String get getisSelectedFollowUp => isSelectedFollowUp;
  selectFollowUp(String selected) {
    isSelectedFollowUp = selected;
    notifyListeners();
  }

  bool updateFollowUpDialog = false;
  bool get getupdateFollowUpDialog => updateFollowUpDialog;
  bool leadForwarddialog = false;
  bool get getleadForwarddialog => leadForwarddialog;
  bool leadWondialog = false;
  bool get getleadWondialog => leadWondialog;
  // bool leadLostdialog = false;
  // bool get getleadLostdialog => leadLostdialog;
  bool leadLoadingdialog = false;
  bool get getleadLoadingdialog => leadLoadingdialog;
  bool updateFollowUpdialog = false;
  bool get getupdateFollowUpdialog => updateFollowUpdialog;
  bool viewDetailsdialog = false;
  bool get getviewDetailsdialog => viewDetailsdialog;

  printLogic2() {
    log("updateFollowUpDialog: ${updateFollowUpDialog}");
    log("leadForwarddialog: ${leadForwarddialog}");
    log("leadLoadingdialog: ${leadLoadingdialog}");
    log("viewDetailsdialog: ${viewDetailsdialog}");
    log("forwardSuccessMsg: ${forwardSuccessMsg}");
  }

  changetoFolloweUp() {
    updateFollowUpDialog = true;
    notifyListeners();
  }

  mapvaluesmodify(GetAllOrderData? leadOpenAllData) {
    OrderNewController.datafrommodify.clear();
    OrderNewController.datafrommodify
        .add(leadOpenAllData!.OrderDocEntry.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.Mobile.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.CustomerName.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.alternateMobileNo.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.customerEmail.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.contactName.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.bil_Address1.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.bil_Address2.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.bil_Area.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.bil_City.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.bil_Pincode.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.bil_State.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.del_Address1.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.Del_Address2.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.Del_Area.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.Del_City.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.Del_Pincode.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.Del_State.toString());

    OrderNewController.datafrommodify.add(leadOpenAllData!.OrderNum.toString());
    OrderNewController.datafrommodify.add(leadOpenAllData!.gSTNo.toString());
    OrderNewController.datafrommodify
        .add(leadOpenAllData!.CustomerGroup.toString());

    OrderNewController.datafrommodify
        .add(leadOpenAllData!.OrderType.toString());
    OrderNewController.datafrommodify.add(leadOpenAllData!.DocDate.toString());
    OrderBookNewState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.ordernew);
    notifyListeners();
  }

  String apiFDate = '';
  String nextFD = '';
  String get getnextFD => nextFD;

  void showFollowupDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      nextFD = chooseddate;
      notifyListeners();
    });
  }

  String apiWonFDate = '';
  String nextWonFD = '';
  String get getnextWonFD => nextWonFD;
  void showFollowupWonDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
      apiWonFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}.${date.millisecond.toString().padLeft(3, '0')}Z";
      print(apiWonFDate);

      nextWonFD = chooseddate;
      notifyListeners();
    });
  }

  String apiInvFDate = '';
  String nextInvFD = '';
  String get getnextInvFD => nextInvFD;
  void showFollowupInvDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
      apiInvFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}Z";
      print(apiWonFDate);

      nextInvFD = chooseddate;
      notifyListeners();
    });
  }

  String apiforwardNextFollowUPDate = '';
  String forwardnextWonFD = '';
  String get getforwardnextWonFD => forwardnextWonFD;
  void showForwardNextDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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
      apiforwardNextFollowUPDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiforwardNextFollowUPDate);

      forwardnextWonFD = chooseddate;
      notifyListeners();
    });
  }

  resetValuesIS1() async {
    final Database db = (await DBHelper.getInstance())!;
    isSelectedFollowUp = '';
    nextFD = '';
    updateFollowUpDialog = false;
    leadForwarddialog = false;
    leadWondialog = false;
    // leadLostdialog = false;
    leadLoadingdialog = false;
    valueChosedReason = null;
    valueChosedStatus = null;
    valueChosedStatusWon = null;
    valuecancelStatus = null;
    viewDetailsdialog = false;
    forwardSuccessMsg = '';
    caseStatusSelected = '';
    selectedUserList = '';
    forwardnextWonFD = '';
    hinttextforOpenLead = 'Select Status:* ';
    hinttextforcancel = 'Cancellation Reason:* ';
    hinttextforWonLead = 'Select Status:* ';
    hinttextforLostLead = 'Select Reason*';
    feedbackLead = 'Feed back:*';

    feedbackcancel = 'Give your feedback*';
    nextFollowupDate = 'Next Follow up:';
    mycontroller[1].clear();
    mycontroller[0].clear();
    mycontroller[2].clear();
    hinttextforWonLead = "Select Status:";
    hinttextforLostLead = "Select Status:";
    hinttextforOpenLead = "Select Status:";
    orderBillRefer = 'Delivery Reference*';
    feedbackLead = 'Give your feedback*';
    nextFollowupDate = 'Next Follow up:';
    orderBillDate = 'Delivery Date*';
    orderInvBillRefer = 'Invoice Reference*';
    orderInvvalue = 'Invoice Value*';
    orderInvvalue = 'Invoice Value*';
    followup = 'How you made the follow up?';
    forwardNextFollowDate = 'Next FollowUp';
    leadOpenSaveClicked = false;
    leadWonSaveClicked = false;
    leadLostSaveClicked = false;
    nextWonFD = '';
    userLtData = await DBOperation.getUserList(db);
    notifyListeners();
  }

  // resetValuesISnot1() async {
  //   isSelectedFollowUp = '';
  //   nextFD = '';
  //   updateFollowUpDialog = false;
  //   leadForwarddialog = false;
  //   leadWondialog = false;
  //   leadLostdialog = false;
  //   leadLoadingdialog = false;
  //   valueChosedReason = null;
  //   valueChosedStatus = null;
  //   valueChosedStatusWon = null;
  //   viewDetailsdialog = true;
  //   forwardSuccessMsg = '';
  //   caseStatusSelected = '';
  //   selectedUserList = '';
  //   forwardnextWonFD = '';
  //   hinttextforOpenLead = 'Select Status: ';
  //   hinttextforWonLead = 'Select Status: ';
  //   hinttextforLostLead = 'Select Reason';
  //   feedbackLead = 'Feed back:';
  //   nextFollowupDate = 'Next Follow up:';
  //   mycontroller[1].clear();
  //   mycontroller[0].clear();
  //   mycontroller[2].clear();
  //   hinttextforWonLead = "Select Status:";
  //   hinttextforLostLead = "Select Status:";
  //   hinttextforOpenLead = "Select Status:";
  //   orderBillRefer = 'Order/Invoice Reference';
  //   feedbackLead = 'Give your feedback';
  //   nextFollowupDate = 'Next Follow up:';
  //   orderBillDate = 'Order/Invoice Date:';
  //   followup = 'How you made the follow up?';
  //   forwardNextFollowDate = 'Next FollowUp';
  //   leadOpenSaveClicked = false;
  //   leadWonSaveClicked = false;
  //   leadLostSaveClicked = false;
  //   nextWonFD = '';
  //   userLtData = await dbHelper.getUserList();
  //   notifyListeners();
  // }

  // for dialog
  String? valueChosedReason; //cl
  String? get getvalueChosedReason => valueChosedReason;
  String? valueChosedStatus; //cl
  String? get getvalueChosedStatus => valueChosedStatus;
  String? valuecancelStatus; //cl
  String? get getvaluecancelStatus => valuecancelStatus;
  String? valueChosedStatusWon; //cl
  String? get getvalueChosedStatusWon => valueChosedStatusWon;
  List<String> data = ['', 'a'];
  String? hinttextforcancel = 'Cancellation Reason:* ';
  String? get gethinttextforcancel => hinttextforcancel;
  String? hinttextforOpenLead = 'Select Status:* '; //cl
  String? get gethinttextforOpenLead => hinttextforOpenLead;
  String? hinttextforWonLead = 'Select Status:* '; //cl
  String? get gethinttextforWonLead => hinttextforWonLead;
  String? hinttextforLostLead = 'Select Reason*'; //cl
  String? get gethinttextforLostLead => hinttextforLostLead;
  String? feedbackLead = 'Give your feedback*'; //cl Give your feedback
  String? get getfeedbackLead => feedbackLead;
  String? feedbackcancel = 'Give your feedback*'; //cl Give your feedback
  String? get getfeedbackcancel => feedbackcancel;
  String? nextFollowupDate = 'Next Follow up:'; //cl
  String? get getnextFollowupDate => nextFollowupDate;
  String? orderBillRefer = 'Delivery Reference*'; //cl
  String? get getorderBillRefer => orderBillRefer;

  String? orderBillDate = 'Delivery Date*'; //cl
  String? get getorderBillDate => orderBillDate;
  String? orderInvBillDate = 'Invoice Date*'; //cl
  String? get getorderInvBillDate => orderInvBillDate;
  String? orderInvvalue = 'Invoice Value*'; //cl
  String? get getorderInvvalue => orderInvvalue;

  String? orderInvBillRefer = 'Invoice Reference*'; //cl
  String? get getorderInvBillRefer => orderInvBillRefer;
  String? followup =
      'How you made the follow up?'; //cl How the follow up has been made
  String? get getfollowup => followup;
  String? forwardNextFollowDate = 'Next Follow Up:'; //cl
  String? get getforwardNextFollowDate => forwardNextFollowDate;

  choosedReason(String val) {
    valueChosedReason = val;
    notifyListeners();
  }

  choosedStatus(String val) {
    valueChosedStatus = val;
    notifyListeners();
  }

  choosedcancelStatus(String val) {
    valuecancelStatus = val;
    notifyListeners();
  }

  choosedStatusWon(String val) {
    valueChosedStatusWon = val;
    notifyListeners();
  }

  String caseStatusSelected = ''; //cl
  String? get getcaseStatusSelected => caseStatusSelected;

  caseStatusSelectBtn(String val) {
    caseStatusSelected = val;
    notifyListeners();
  }

  FilePickerResult? result;
  //  filesz = [];
  List<File> files = [];
  bool? fileValidation = false;

  Future imagetoBinary(ImageSource source) async {
    List<File> filesz = [];
    await LocationTrack.checkcamlocation();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // files.add(File(image.path));
    // filedata.clear();
    if (filedata.isEmpty) {
      filedata.clear();
      filesz.clear();
    }
    filesz.add(File(image.path));
    notifyListeners();

    if (files.length <= 1) {
      for (int i = 0; i < filesz.length; i++) {
        files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
        String fileName = filesz[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
        String tempPath = '';
        if (Platform.isAndroid) {
          tempPath = (await getExternalStorageDirectory())!.path;
        } else if (Platform.isIOS) {
          tempPath = (await getApplicationDocumentsDirectory())!.path;
        }

        String fullPath = '$tempPath/$fileName';
        await filesz[i].copy(fullPath);
        File(fullPath).writeAsBytesSync(intdata);
        final result =
            await ImageGallerySaver.saveFile(fullPath, isReturnPathOfIOS: true);

        if (Platform.isAndroid) {
          filedata.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: fullPath
                  // files[i].path.split('/').last
                  ));
        } else {
          filedata.add(
              FilesData(fileBytes: base64Encode(intdata), fileName: image.path
                  // files[i].path.split('/').last
                  ));
        }
        // filedata.add(FilesData(
        //     fileBytes: base64Encode(intdata),
        //     fileName: fullPath));
        notifyListeners();
      }
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());
      showtoast();
      notifyListeners();
    }
    log("camera fileslength" + files.length.toString());
    // showtoast();

    notifyListeners();
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than 2 Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  selectattachment() async {
    List<File> filesz = [];
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
      if (filedata.isEmpty) {
        files.clear();
        filesz.clear();
        filedata.clear();
        notifyListeners();
      }

      filesz = result!.paths.map((path) => File(path!)).toList();
      log("filesz::" + filesz.length.toString());
      // if (filesz.length != 0) {
      log("filedata::" + filedata.length.toString());
      int remainingSlots = 2 - files.length;
      log("remainingSlots::" + remainingSlots.toString());
      if (filesz.length <= remainingSlots) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

          // showtoast();
          files.add(filesz[i]);
          // log("Files Lenght :::::" + files.length.toString());
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData(
              fileBytes: base64Encode(intdata), fileName: filesz[i].path));
          notifyListeners();

          // return null;
        }
      } else {
        showtoast();
        notifyListeners();
      }
      // }
      notifyListeners();
    }
    notifyListeners();
  }

  List<FilesData> filedata = [];
  List<String> filelink = [];
  List<String> fileException = [];

  ///get lead status api
  List<GetOrderStatusData> leadStatusOpen = [];
  // List<GetOrderStatusData> leadStatusLost = [];
  List<GetLeadStatusData> leadStatusWon = [];
  List<GetOrderStatusData> get getleadStatusOpen => leadStatusOpen;
  // List<GetOrderStatusData> get getleadStatusLost => leadStatusLost;
  List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;

  /// gget user list frpm db

  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;

  String selectedUserList = '';
  String get getselectedUserList => selectedUserList;
  List<String> openlead = [];
  List<String> get getopenlead => openlead;
  List<String> wonlead = [];
  List<String> get getwonlead => wonlead;
  // List<String> lostlead = [];
  // List<String> get getlostlead => lostlead;

  getLeadStatus() async {
    final Database db = (await DBHelper.getInstance())!;
    leadStatusOpen = await DBOperation.getOrderStatusOpen(db);
    // leadStatusLost = await DBOperation.getOrderStatusLost(db);
    // log("leadStatusOpen:" + leadStatusOpen[0].name.toString());
    leadStatusWon = await DBOperation.getLeadStatusWon(db);
    userLtData = await DBOperation.getUserList(db);
    openlea();
    wonlea();
    await callpaymodeApi();
    await callusermobileApi();
    // lostlea();

    notifyListeners();
  }

  openlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusOpen.length; i++) {
      var openleadcode = leadStatusOpen[i].code!;
      openlead = leadStatusOpen[i].name!.split(',');
      //  return openlead[i];
      log("openlea" + openlead[i].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  wonlea() {
    log("GGGG");
    for (int i = 0; i < leadStatusWon.length; i++) {
      var wonleadcode = leadStatusWon[i].code!;
      wonlead = leadStatusWon[i].name!.split(',');

      // log("openlea" + openlead[i].toString());
    }

    notifyListeners();
  }

  // lostlea() {
  //   log("GGGG");
  //   for (int i = 0; i < leadStatusLost.length; i++) {
  //     var lostleadcode = leadStatusLost[i].code!;
  //     lostlead = leadStatusLost[i].name!.split(',');
  //     // return openlead[i];
  //     log("openlea" + openlead[i].toString());
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  getSelectedUserSalesEmpId(int i) {
    selectedUserList = userLtData[i].SalesEmpID.toString();
    selectUser(i);
  }

  int? salesEmpIdForward;
  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].SalesEmpID == userLtData[ij].SalesEmpID) {
        userLtData[i].color = 1;
        salesEmpIdForward = userLtData[ij].SalesEmpID;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  forwardClicked() {
    leadForwarddialog = !leadForwarddialog;
    notifyListeners();
  }

  viweDetailsClicked() {
    viewDetailsdialog = !viewDetailsdialog;
    notifyListeners();
  }
  //callGetLeadDeatilsApi();

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool leadOpenSaveClicked = false;
  bool leadWonSaveClicked = false;
  bool leadLostSaveClicked = false;

  clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
    log("followDocEntry: $followDocEntry");
    log("leadDocEntry: $leadDocEntry");

    log("caseStatusSelected: $caseStatusSelected");

    if (caseStatusSelected == 'Open') {
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      // leadLostSaveClicked = false;
      log("followDocEntry: $followDocEntry");
      log("leadDocEntry: $leadDocEntry");

      callRequiredOpen(followDocEntry);
    } else if (caseStatusSelected == 'Won') {
      leadWonSaveClicked = true;
      leadOpenSaveClicked = false;
      // leadLostSaveClicked = false;
      callRequiredWon(followDocEntry, leadDocEntry);
    } else if (caseStatusSelected == 'Invoice') {
      leadLostSaveClicked = true;
      leadOpenSaveClicked = false;
      leadWonSaveClicked = false;
      callRequiredLost(followDocEntry, leadDocEntry);
    } else if (caseStatusSelected == 'Cancel') {
      leadLostSaveClicked = false;
      leadOpenSaveClicked = true;
      leadWonSaveClicked = false;
      callRequiredCancel(followDocEntry);
    }
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
      feedbackcancel = 'Give your feedback *';
    } else {
      feedbackcancel = 'Give your feedback*';
    }

    hinttextforWonLead = "Select Status:";
    orderBillRefer = 'Delivery Reference';
    orderBillDate = 'Delivery Date*';
    hinttextforLostLead = 'Select Reason:';
    if (i < 1) {
      print("ssssss");
      openSave(
        followDocEntry,
        valueChosedStatus,
        mycontroller[5].text,
      );
    }
    notifyListeners();
  }

  callRequiredOpen(String followDocEntry) {
    int i = 0;
    if (valueChosedStatus == null) {
      i = i + 1;
      hinttextforOpenLead = "Select Status:*";
    } else {
      hinttextforOpenLead = "Select Status:";
    }
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      feedbackLead = 'Give your feedback *';
    } else {
      feedbackLead = 'Give your feedback*';
    }
    if (nextFD == '') {
      i = i + 1;
      nextFollowupDate = 'Next Follow up:*';
    } else {
      nextFollowupDate = 'Next Follow up:';
    }
    if (isSelectedFollowUp == '') {
      print("4");

      i = i + 1;
      followup = 'How you made the follow up?*';
    } else {
      followup = 'How you made the follow up?';
    }
    hinttextforWonLead = "Select Status:";
    orderBillRefer = 'Delivery Reference';
    orderBillDate = 'Delivery Date';
    hinttextforLostLead = 'Select Reason:';
    if (i < 1) {
      print("ssssss");
      openSave(followDocEntry, valueChosedStatus, mycontroller[1].text);
    }
    notifyListeners();
  }

  callRequiredWon(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (hinttextforWonLead == null) {
      print("1a");
      i = i + 1;
      hinttextforWonLead = "Select Status:*";
    } else {
      hinttextforWonLead = "Select Status:";
    }
    if (mycontroller[0].text.isEmpty) {
      i = i + 1;
      print("2");

      orderBillRefer = 'Delivery Reference *';
    } else {
      orderBillRefer = 'Delivery Reference*';
    }
    if (nextWonFD == '') {
      print("3");

      i = i + 1;
      orderBillDate = 'Delivery Date *';
    } else {
      orderBillDate = 'Delivery Date*';
    }
    // if (isSelectedFollowUp == '') {
    //   print("4");

    //   i = i + 1;
    //   followup = 'ow you made the follow up?*';
    // } else {
    //   followup = 'ow you made the follow up?';
    // }
    feedbackLead = 'Give your feedback';
    nextFollowupDate = 'Next Follow up:';
    hinttextforLostLead = 'Select Reason:';
    hinttextforOpenLead = "Select Status:";
    print(i);
    if (i < 1) {
      print("ssssss");
      WonSave(followDocEntry, leadDocEntry, valueChosedStatusWon,
          isSelectedFollowUp, apiWonFDate, mycontroller[0].text);
    }
    notifyListeners();
  }

  callRequiredLost(String followDocEntry, String leadDocEntry) {
    int i = 0;
    if (mycontroller[1].text.isEmpty) {
      i = i + 1;
      orderInvBillRefer = 'Invoice Reference *';
    } else {
      orderInvBillRefer = 'Invoice Reference*';
    }
    if (mycontroller[2].text.isEmpty) {
      i = i + 1;
      orderInvvalue = 'Invoice Value *';
    } else {
      orderInvvalue = 'Invoice Value*';
    }
    // if (valueChosedReason == null) {
    //   i = i + 1;
    //   hinttextforLostLead = 'Select Reason:*';
    // } else {
    //   hinttextforLostLead = 'Select Reason:';
    // }
    if (nextInvFD == '') {
      i = i + 1;
      orderInvBillDate = 'Invoice Date: *';
    } else {
      orderInvBillDate = 'Invoice Date:*';
    }
    // hinttextforWonLead = "Select Status:";
    // orderBillRefer = 'Delivery Reference';
    // orderBillDate = 'Delivery Date';
    // nextFollowupDate = 'Next Follow up:';
    // hinttextforOpenLead = "Select Status:";
    if (i < 1) {
      lostSave(followDocEntry, leadDocEntry, valueChosedReason,
          mycontroller[1].text, mycontroller[2].text);
    }
    notifyListeners();
  }

  validatebtnChanged() {
    if (caseStatusSelected == "Open") {
      if (leadOpenSaveClicked == true) {
        hinttextforOpenLead = "Select Status:*";
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?*';
      } else {
        hinttextforOpenLead = "Select Status:";
        feedbackLead = 'Give your feedback';
        nextFollowupDate = 'Next Follow up:';
        followup = 'How you made the follow up?';
      }
    } else {}

    if (caseStatusSelected == "Won") {
      if (leadWonSaveClicked == true) {
        hinttextforWonLead = "Select Status:*";
        orderBillRefer = 'Delivery Reference *';
        followup = 'How you made the follow up?*';
      } else {
        hinttextforWonLead = "Select Status:";
        orderBillRefer = 'Delivery Reference*';
        feedbackLead = 'Give your feedback*';
        nextFollowupDate = 'Next Follow up:*';
        followup = 'How you made the follow up?';
      }
      nextFD = '';
      nextWonFD = '';
    } else {}

    if (caseStatusSelected == "Invoice") {
      if (leadLostSaveClicked == true) {
        orderInvBillRefer = 'Invoice Reference *';
        orderInvvalue = 'Invoice Value *';
        orderInvvalue = 'Invoice Value *';
      } else {
        orderInvBillRefer = 'Invoice Reference*';
        orderInvvalue = 'Invoice Value*';
        orderInvvalue = 'Invoice Value*';
      }
      nextInvFD = '';
      nextInvFD = '';
    } else {}

    if (caseStatusSelected == "Cancel") {
      if (leadOpenSaveClicked == true) {
        hinttextforcancel = "Cancellation Reason: *";
        feedbackcancel = 'Give your feedback *';
      } else {
        hinttextforcancel = "Cancellation Reason:*";
        feedbackcancel = 'Give your feedback*';
      }
    }
    notifyListeners();
  }

  ///cal forwardApi
  String forwardSuccessMsg = '';
  String get getforwardSuccessMsg => forwardSuccessMsg;

  forwardApi(String followDocEntry, int salesPersonEmpId) async {
    notifyListeners();
    if (forwardnextWonFD.isEmpty) {
      //selectedUserList
      forwardNextFollowDate = 'Next FollowUp*';
      notifyListeners();
    } else {
      forwardSuccessMsg = '';
      leadLoadingdialog = true;
      ForwardOrderUserData forwardLeadUserData = new ForwardOrderUserData();
      forwardLeadUserData.curentDate = config.currentDateOnly();
      forwardLeadUserData.nextFD = apiforwardNextFollowUPDate;
      forwardLeadUserData.nextUser = salesPersonEmpId;
      await ForwardOrderUserApi.getData(followDocEntry, forwardLeadUserData)
          .then((value) {
        if (value.stCode >= 200 && value.stCode <= 210) {
          forwardSuccessMsg = 'Successfully Forwarded..!!';
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode >= 400 && value.stCode <= 410) {
          forwardSuccessMsg = value.errorTitle!;
          leadLoadingdialog = false;
          notifyListeners();
        } else if (value.stCode == 500) {
          forwardSuccessMsg =
              '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      });
      checkValues();
    }
  }

  openSave(String followDocEntry, status, feedback) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    ForwardOrderUserDataOpen forwardLeadUserDataOpen =
        new ForwardOrderUserDataOpen();
    forwardLeadUserDataOpen.curentDate = config.currentDate();
    forwardLeadUserDataOpen.ReasonCode = valuecancelStatus;
    // forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
    // forwardLeadUserDataOpen.nextFD = nextFPdate;
    // forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    forwardLeadUserDataOpen.feedback = feedback;
    notifyListeners();

    //OpenSaveLeadApi.printjson(followDocEntry,forwardLeadUserDataOpen);
    await OpenSaveOrderApi.getData(followDocEntry, forwardLeadUserDataOpen)
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
    checkValues();
  }

  WonSave(followDocEntry, String leadDocEntry, status, followup, billwonDate,
      billreference) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;

    notifyListeners();
    PostOrder? postLead = new PostOrder();
    List<String> filename = [];
    List<String>? fileError = [];

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              log("message");
              postLead.attachmenturl2 = value;
            }
          }
        });
      }
    }
    log("filename:::${filename.length}");

    String errorFiles = "";
    if (fileError != null) {
      for (int i = 0; i < fileError.length; i++) {
        errorFiles += errorFiles + "/";
      }
    }
    notifyListeners();

    ForwardOrderUserDataWon forwardLeadUserDataWon =
        new ForwardOrderUserDataWon();

    forwardLeadUserDataWon.billDate = apiWonFDate;
    forwardLeadUserDataWon.billRef = billreference;
    forwardLeadUserDataWon.curentDate = config.currentDateOnly();
    // forwardLeadUserDataWon.feedback = feedback;
    forwardLeadUserDataWon.followupMode = followup;
    // forwardLeadUserDataWon.nextFD = null;
    forwardLeadUserDataWon.updatedBy = ConstantValues.slpcode;

    //WonSaveLeadApi.prinjson( followDocEntry,forwardLeadUserDataWon);
    await WonSaveOrderApi.getData(
            followDocEntry, forwardLeadUserDataWon, postLead)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
        // callCloseApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = "${value.errorTitle}..!!${value.message}..!!";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  lostSave(
    followDocEntry,
    String leadDocEntry,
    reason,
    refrence,
    value,
  ) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();

    PostOrder? postLead = new PostOrder();
    List<String> filename = [];
    List<String>? fileError = [];

    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              log("message");
              postLead.attachmenturl1 = value;
            } else if (i == 1) {
              log("message");
              postLead.attachmenturl2 = value;
            }
          }
        });
      }
    }
    log("filename:::${filename.length}");

    String errorFiles = "";
    if (fileError != null) {
      for (int i = 0; i < fileError.length; i++) {
        errorFiles += errorFiles + "/";
      }
    }
    notifyListeners();

    ForwardOrderUserDataLost forwardLeadUserDataLost =
        new ForwardOrderUserDataLost();

    forwardLeadUserDataLost.curentDate = config.currentDateOnly();
    forwardLeadUserDataLost.feedback = refrence;

    forwardLeadUserDataLost.nextFD = apiInvFDate;

    forwardLeadUserDataLost.value = double.parse(value);

    //LostSaveLeadApi.prinjson(followDocEntry,forwardLeadUserDataLost);

    await LostSaveLeadApi.getData(
            followDocEntry, forwardLeadUserDataLost, postLead)
        .then((value) {
      if (value.stCode >= 200 && value.stCode <= 210) {
        forwardSuccessMsg = 'Successfully Saved..!!';
        leadLoadingdialog = false;
        notifyListeners();
        // callCancelApi(leadDocEntry);
      } else if (value.stCode >= 400 && value.stCode <= 410) {
        forwardSuccessMsg = "${value.errorTitle}..!!${value.message}..!!";
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stCode == 500) {
        forwardSuccessMsg =
            '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    checkValues();
  }

  showMsgDialog() {
    forwardSuccessMsg = 'hello';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
  }

  // callCloseApi(String leadDocEntry) async {
  //   await CloseOrderApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardSuccessMsg = 'Successfully Saved..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardSuccessMsg = '${value.errorTitle}';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // callCancelApi(String leadDocEntry) async {
  //   await CancelOrderApi.getData(leadDocEntry).then((value) {
  //     if (value.stCode >= 200 && value.stCode <= 210) {
  //       forwardSuccessMsg = 'Successfully Saved..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else if (value.stCode >= 400 && value.stCode <= 490) {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     } else {
  //       forwardSuccessMsg = 'Something wemt wrong..!!';
  //       leadLoadingdialog = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  List<GetOrderDeatilsQTHData> leadDeatilsQTHData = [];
  List<GetOrderDeatilsQTHData> get getleadDeatilsQTHData => leadDeatilsQTHData;

  List<GetOrderQTLData> leadDeatilsQTLData = [];
  List<GetOrderQTLData> get getleadDeatilsQTLData => leadDeatilsQTLData;

  List<GetOrderDeatilsLData> leadDeatilsLData = [];
  List<GetOrderDeatilsLData> get getleadDeatilsLeadData => leadDeatilsLData;
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

  callGetLeadDeatilsApi(String leadDocEnt) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    notifyListeners();
    await GetOrderQTHApi.getData(leadDocEnt).then((value) {
      log("ststus code");
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.OrderDeatilsheaderData != null) {
          leadDeatilsQTHData =
              value.OrderDeatilsheaderData!.OrderDeatilsQTHData!;
          leadDeatilsQTLData =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData!;
          forwardSuccessMsg = '';
          leadLoadingdialog = false;
          leadForwarddialog = false;
          updateFollowUpDialog = false;
          viewDetailsdialog = true;

          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        forwardSuccessMsg = '${value.stcode!}..!!..${value.exception}';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    // await GetLeadQTLApi.getData(leadDocEnt).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     leadDeatilsQTLData = value.leadDeatilsQTLData!;
    //     // forwardSuccessMsg = 'Successfully Saved..!!';
    //     // leadLoadingdialog = false;
    //     // leadForwarddialog = false;
    //     // updateFollowUpDialog = false;
    //     // viewDetailsdialog = true;
    //     // notifyListeners();
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     forwardSuccessMsg = 'Something wemt wrong..!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     forwardSuccessMsg = 'Something wemt wrong..!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });

    // await GetOrderDetailsLApi.getData(leadDocEnt).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if (value.OrderDeatilsOrderData != null) {
    //       leadDeatilsLData = value.OrderDeatilsOrderData!;
    //       // forwardSuccessMsg = 'Successfully Saved..!!';
    //       leadLoadingdialog = false;
    //       leadForwarddialog = false;
    //       updateFollowUpDialog = false;
    //       viewDetailsdialog = true;
    //       notifyListeners();
    //     } else {
    //       forwardSuccessMsg = 'Something wemt wrong..!!';
    //       leadLoadingdialog = false;
    //       notifyListeners();
    //     }
    //     // forwardSuccessMsg = 'Successfully Saved..!!';
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     forwardSuccessMsg = 'Something wemt wrong..!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     forwardSuccessMsg = 'Something wemt wrong..!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });
  }

  ///
  static int comeFromEnq = -1;
  static int isanyExcep = 0;
  static bool isSameBranch = true;
  bool get getisSameBranch => isSameBranch;

  comeFromEnqApi(BuildContext context, String comeFromEnqdata) async {
    forwardSuccessMsg = '';
    leadLoadingdialog = true;
    leadForwarddialog = true;
    updateFollowUpDialog = false;
    viewDetailsdialog = false;
    notifyListeners();
    //printLogic2();
    await GetOrderQTHApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.OrderDeatilsheaderData != null) {
          leadDeatilsQTHData =
              value.OrderDeatilsheaderData!.OrderDeatilsQTHData!;
          leadDeatilsQTLData =
              value.OrderDeatilsheaderData!.OrderDeatilsQTLData!;
        } else {
          isanyExcep = -2;
          forwardSuccessMsg = 'Some internal error..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        isanyExcep = -2;
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });

    // await GetLeadQTLApi.getData(comeFromEnqdata).then((value) {
    //   if (value.stcode! >= 200 && value.stcode! <= 210) {
    //     if(value.leadDeatilsQTLData != null){
    //     leadDeatilsQTLData = value.leadDeatilsQTLData!;
    //     }
    //      else{
    //        isanyExcep = -2;
    //        forwardSuccessMsg = 'Some internal error..!!';
    //        leadLoadingdialog = false;
    //        notifyListeners();
    //     }
    //   } else if (value.stcode! >= 400 && value.stcode! <= 490) {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   } else {
    //     isanyExcep = -2;
    //     forwardSuccessMsg = 'Something went wrong try again!!';
    //     leadLoadingdialog = false;
    //     notifyListeners();
    //   }
    // });

    await GetOrderDetailsLApi.getData(comeFromEnqdata).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.OrderDeatilsOrderData != null) {
          leadDeatilsLData = value.OrderDeatilsOrderData!;
          leadLoadingdialog = false;
          leadForwarddialog = false;
          updateFollowUpDialog = false;
          viewDetailsdialog = true;
          notifyListeners();
        } else {
          isanyExcep = -2;
          forwardSuccessMsg = 'Some internal error..!!';
          leadLoadingdialog = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 490) {
        isanyExcep = -2;
        forwardSuccessMsg = 'Something went wrong try again!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else {
        isanyExcep = -2;
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
    await showLeadDeatilsDialog(context);
    printLogic2();
  }

  mapValuesToEnq(BuildContext context) {
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].CardCode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].CardName!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Address1!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Address2!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].Pincode!);
    NewEnqController.comeFromEnq.add(leadDeatilsQTHData![0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.newEnq);
  }

  mapValuesToLead(BuildContext context) {
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].CardCode!);
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].CardName!);
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].Address1!);
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].Address2!);
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].Pincode!);
    OrderNewController.dataenq.add(leadDeatilsQTHData![0].City!);
    Navigator.pop(context);
    Get.toNamed(ConstantRoutes.leads);
  }

  showLeadDeatilsDialog(BuildContext context) async {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          updateFollowUpDialog = false;
          // context.read<OrderTabController>().resetValues();
          return FollowDialog(
            index: 0,
          );
        }).then((value) {
      refershAfterClosedialog();
      callGetAllApi();
      // callSummaryApi();
    });
  }

  checkValues() {
    print("getupdateFollowUpDialog: " + getupdateFollowUpDialog.toString());
    print("getleadForwarddialog: " + getleadForwarddialog.toString());
    print("getleadLoadingdialog: " + getleadLoadingdialog.toString());
    print("getforwardSuccessMsg: " + getforwardSuccessMsg.toString());
  }
}

class Distcolumn {
  String name;
  Distcolumn({
    required this.name,
  });
}

class Distcusgroupcolumn {
  String name;
  Distcusgroupcolumn({
    required this.name,
  });
}

class DistEnqstatuscolumn {
  String name;
  DistEnqstatuscolumn({
    required this.name,
  });
}

class Distlookingforcolumn {
  String name;
  bool ischecck;
  Distlookingforcolumn({required this.name, required this.ischecck});
}

class Distlevelcolumn {
  String name;
  Distlevelcolumn({
    required this.name,
  });
}

class Distordercolumn {
  String name;
  Distordercolumn({
    required this.name,
  });
}

/// phone call -> Phone
/// sms/whats => Text
/// store  vist => Visit cj
/// other => Other
