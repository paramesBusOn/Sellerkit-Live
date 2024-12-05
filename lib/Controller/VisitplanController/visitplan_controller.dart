// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellerkit/DBHelper/db_helper.dart';
import 'package:sellerkit/DBHelper/db_operation.dart';
import 'package:sellerkit/Services/getuserbyId/getuserbyid.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Controller/VisitplanController/newvisit_controller.dart';
import 'package:sellerkit/Models/purposeofvistModel/purposeofvisitmodel.dart';
import 'package:sellerkit/Pages/VisitPlans/Screens/NewVisitPlan.dart';
import 'package:sellerkit/Services/VisitApi/cancelvisitApi.dart';
import 'package:sellerkit/Services/getvisitscheduleAPi/getvistitApi.dart';

import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';
import 'package:sellerkit/Services/userDialApi/userdialapi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constant/Configuration.dart';
import '../../Models/VisitPlanModel/VisitPlanModel.dart';
import '../../Models/getvisitmodel/getvisitmodel.dart';

class VisitplanController extends ChangeNotifier {
  Config config = new Config();

  List<VisitPlanData> visitLists = [];

  init() {
    clearAll();
    getallvisitdata();
    getvisitpurpose();
    callusermobileApi();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  List<TextEditingController> mycontroller =
      List.generate(30, (i) => TextEditingController());
      List<getvisitdetails> getAlldata = [];
     List<getvisitdetails> GetfromdborderData =[];
  List<getvisitdetails> visitdetailsdata = [];
  List<getvisitdetails> get getvisitdetailsdata => visitdetailsdata;
  List<getvisitdetails> openVisitData = [];
  List<getvisitdetails> closedVisitdata = [];
  List<getvisitdetails> missedVisitUserdata = [];

  List<getvisitdetails> get getopenVisitData => openVisitData;
  List<getvisitdetails> get getclosedVisitdata => closedVisitdata;
  List<getvisitdetails> get getmissedVisitUserdata => missedVisitUserdata;
// callAlertDialog2(BuildContext context, String mesg) {
//     showDialog<dynamic>(
//         context: context,
//         builder: (_) {
//           return AlertMsg(
//             msg: '$mesg',
//           );
//         }).then((value) {
//     });
//   }
  //  successmsge(BuildContext context){
  //     showDialog<dynamic>(
  //         context: context,
  //         builder: (_) {
  //           return SuccessDialogPG(
  //             heading: 'Response',
  //             msg: 'Visit Plan Created Successfully..!!',
  //           );
  //         }).then((value) {
  //           // Get.offAllNamed(ConstantRoutes.visitplan);
  //         });
  // }
  bool isloading = false;
  String errortabMsg = '';
  Future<void> swipeRefreshIndiactor() async {
    await clearAll();

    await getallvisitdata();
    //  await     getvisitpurpose();
    notifyListeners();
    // callSummaryApi();

    //});
  }

  mapvaluesmodify(getvisitdetails? openVisitData) {
    NewVisitplanController.datafrommodify.clear();
    NewVisitplanController.datafrommodify
        .add(openVisitData!.visitplan!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.customercode!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.customername!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.contactname!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.address1!.toString());

    NewVisitplanController.datafrommodify
        .add(openVisitData!.address2!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.area!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.city!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.pincode!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.state!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.LookingFor!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.purposeofvisit!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.cusemail!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.BaseId!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.BaseType!.toString());
    NewVisitplanController.datafrommodify
        .add(openVisitData!.PotentialBusinessValue!.toString());
    // NewVisitplanController.datafrommodify.add(openVisitData!.!.toString());
    NewVisitPlanState.iscomfromLead = true;
    Get.toNamed(ConstantRoutes.newvisitplan);
    notifyListeners();
  }
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
 String? filterapiwonpurchaseDate = '';
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
  onfilterapply() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getvisitfilterapply(
      db,
      assignvalue == null ? '' : assignvalue!,
    
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
       getAlldata.clear();
      GetfromdborderData.clear();
      missedVisitUserdata.clear();
      openVisitData.clear();
      GetfromdborderData = value;
      await spilitDatafirst(GetfromdborderData);
      clearfilterval();
      notifyListeners();
    });
  }
  String lottie = '';
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
    // islookloading = false;/
    interestlevelvalue = null;
    customernameforcolumn.clear();
    lookingforcolumnforshow.clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();

    notifyListeners();
  }
  tableinsert(List<getvisitdetails> getalldata) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncarevisitplanfilter(db);
log("insertbefore::"+getalldata.length.toString());
    await DBOperation.insertvisitplandata(getalldata, db);
    notifyListeners();
    await getdbmodel();
    notifyListeners();
  }
  getdbmodel() async {
        getAlldata.clear();

   
    final Database db = (await DBHelper.getInstance())!;
    GetfromdborderData = await DBOperation.getvisitplanfilter(db);
    log("GetfromdbEnqData::" + GetfromdborderData.length.toString());
    List<Map<String, Object?>> assignDB =
        await DBOperation.getvisitftr("AssignedTo", db);
    List<Map<String, Object?>> lookingFor =
        await DBOperation.getvisitftr("LookingFor", db);
    List<Map<String, Object?>> enqstatusDB =
        await DBOperation.getvisitftr("VisitStatus", db);
    List<Map<String, Object?>> customernameforDB =
        await DBOperation.getvisitftr("Customername", db);
    // List<Map<String, Object?>> intlevelDB =
    // await DBOperation.getorderftr("InterestLevel", db);
    // List<Map<String, Object?>> ordertypeDB =
    //     await DBOperation.getorderftr("OrderType", db);
    notifyListeners();

    await dataget(
        assignDB, enqstatusDB, lookingFor, customernameforDB);
    await spilitDatafirst(GetfromdborderData);
    notifyListeners();
  }
  List<Distcolumn> assigncolumn = [];
  List<Distcusgroupcolumn> cusgroupcolumn = [];
  List<DistEnqstatuscolumn> enqstatuscolumn = [];
  List<Distlookingforcolumn> customernameforcolumn = [];
  List<Distlookingforcolumn> filterlookingforcolumn = [];
  List<Distlookingforcolumn> lookingforcolumnforshow = [];
  Future<void> dataget(List<Map<String, Object?>> assignDB,enqstatusDB,lookingFor,
       customernameDB) async {
    assigncolumn.clear();
   
    enqstatuscolumn.clear();
    customernameforcolumn.clear();
  filterlookingforcolumn.clear();
    lookingforcolumnforshow.clear();
    

    notifyListeners();
    for (int i = 0; i < assignDB.length; i++) {
      assigncolumn.add(Distcolumn(name: assignDB[i]['AssignedTo'].toString()));
      assigncolumn
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      log("assigncolumn::" + assigncolumn.length.toString());
      notifyListeners();
    }
    
    for (int i = 0; i < enqstatusDB.length; i++) {
      enqstatuscolumn.add(
          DistEnqstatuscolumn(name: enqstatusDB[i]['VisitStatus'].toString()));
      log("enqstatuscolumn::" + enqstatuscolumn[i].name.toString());
      notifyListeners();
    }
    for (int i = 0; i < customernameDB.length; i++) {
      customernameforcolumn.add(Distlookingforcolumn(
          name: customernameDB[i]['CustomerName'].toString(), ischecck: false));

      filterlookingforcolumn = customernameforcolumn;
      //   log("lookingforcolumn::" + filterlookingforcolumn.length.toString());

      notifyListeners();
    }
     for(int i=0;i<lookingFor.length;i++){
      filterlookingforcolumn.add(
        Distlookingforcolumn(name: lookingFor[i]['LookingFor'].toString()??'',
        // ischecck: lookingFor[i].ischecck
        ));
       log("lookingforcolumn::" + filterlookingforcolumn[i].ischecck.toString());
       notifyListeners();
     }
    notifyListeners();
    // for (int i = 0; i < customernameDB.length; i++) {
    //   customernameforcolumn.add(Distlookingforcolumn(name: customernameDB[i]['InterestLevel'].toString()));
    //   log("intlevelcolumn::" + intlevelcolumn.length.toString());
    //   notifyListeners();
    // }
   
  }
  getallvisitdata() async {
    getAlldata.clear();
    
    lottie = '';
    isloading = true;
    notifyListeners();
    await getvisitApi.getdata().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getvisitheaddata!.getvisitdetailsdata != null &&
            value.getvisitheaddata!.getvisitdetailsdata!.isNotEmpty) {
          getAlldata =value.getvisitheaddata!.getvisitdetailsdata!;
          tableinsert(getAlldata);
          // spilitDatafirst(value.getvisitheaddata!.getvisitdetailsdata!);
          // isloading = false;
          notifyListeners();
        } else if (value.getvisitheaddata!.getvisitdetailsdata == null ||
            value.getvisitheaddata!.getvisitdetailsdata!.isEmpty) {
          isloading = false;
          lottie = 'Assets/no-data.png';
          errortabMsg = 'No data..!!';
          // exception = true;
          //       errorMsg = 'No data found..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        lottie = '';
        isloading = false;
        errortabMsg = '${value.exception}..${value.message}..!!';
        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {

        if (value.exception!.contains("Network is unreachable")) {
         isloading = false;
        lottie = 'Assets/network-signal.png';
        errortabMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          notifyListeners();
        } else {
           isloading = false;
        lottie = 'Assets/warning.png';
        errortabMsg =
            '${value.stcode}..Something Went Wrong..!!\nContact System Admin..!';
         

          notifyListeners();
        }
        // isloading = false;
        // lottie = 'Assets/NetworkAnimation.json';
        // errortabMsg =
        //     '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
    notifyListeners();
  }

  String forwardSuccessMsg = '';
  bool leadLoadingdialog = false;
  cancelvisit(int followDocEntry) async {
    log("followDocEntry::" + followDocEntry.toString());
    forwardSuccessMsg = '';
    leadLoadingdialog = true;

    // ForwardOrderUserDataOpen forwardLeadUserDataOpen =
    //     new ForwardOrderUserDataOpen();
    // forwardLeadUserDataOpen.curentDate = config.currentDate();
    // forwardLeadUserDataOpen.ReasonCode = valuecancelStatus;
    // // forwardLeadUserDataOpen.followupMode = isSelectedFollowUp;
    // // forwardLeadUserDataOpen.nextFD = nextFPdate;
    // // forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
    // forwardLeadUserDataOpen.feedback = feedback;
    notifyListeners();

    //OpenSaveLeadApi.printjson(followDocEntry,forwardLeadUserDataOpen);
    await CancelVisitApi.getData(
      followDocEntry,
    ).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        forwardSuccessMsg = 'Visit cancelled successfully..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        forwardSuccessMsg = '${value.exception}..${value.message}..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stcode == 500) {
        forwardSuccessMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        leadLoadingdialog = false;
        notifyListeners();
      }
    });
  }

  List<visitpurpose>? purposevisit = [];
  getvisitpurpose() async {
    purposevisit = [];
    await purposeofvisitApi.getOfferZone().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.purposevisit != null) {
          purposevisit = value.purposevisit;
          // filterpurposeofVisitList = purposevisit!;
          notifyListeners();
        } else if (value.purposevisit == null) {
          log("NONONDATA");
          notifyListeners();
        }
      }
    });
  }

  getPurposeofVisitName(String id) {
    String? temp = '';
    if (purposevisit != null) {
      for (int i = 0; i < purposevisit!.length; i++) {
        if (id == purposevisit![i].description) {
          temp = purposevisit![i].description;
          return temp;
        }
      }
    }
    if (temp!.isEmpty) {
      return '';
    }
  }

  // getData() {
  //   visitLists = [
  //     VisitPlanData(
  //       customer: "Raja",
  //       datetime: "21-Jul-2023 2:11PM",
  //       purpose: "Courtesy Visit",
  //       area: "Saibaba Colony Coimbatore",
  //       product: "Looking For Table/Chair",
  //       type: "Open",
  //       Mobile: "1234567890",
  //       CantactName: "Arun",
  //       U_Address1: "104 West Street ,",
  //       U_Address2: "Srirangam,Trichy",
  //       U_City: "Trichy",
  //       U_Pincode: "6200005",
  //       U_State: "Tamil Nadu",
  //     ),
  //     VisitPlanData(
  //       customer: "Raja",
  //       datetime: "24-Jun-2023 4:23PM",
  //       purpose: "Enquiry Visit",
  //       area: "Saibaba Colony Coimbatore",
  //       product: "Looking For Table/Chair",
  //       type: "Closed",
  //       Mobile: "9876543210",
  //       CantactName: "Raja",
  //       U_Address1: "124 KK Nagar Street ,",
  //       U_Address2: "Karur main Road,Karur",
  //       U_City: "Somur",
  //       U_Pincode: "6200024",
  //       U_State: "Tamil Nadu",
  //     ),
  //     VisitPlanData(
  //       customer: "Raja",
  //       datetime: "21-May-2023-4:23PM",
  //       purpose: "Customer Appointment",
  //       area: "Saibaba Colony Coimbatore",
  //       product: "Looking For Table/Chair",
  //       type: "Missed",
  //       Mobile: "9876543210",
  //       CantactName: "Raja",
  //       U_Address1: "124 KK Nagar Street ,",
  //       U_Address2: "Karur main Road,Karur",
  //       U_City: "Somur",
  //       U_Pincode: "6200024",
  //       U_State: "Tamil Nadu",
  //     )
  //   ];
  //   notifyListeners();
  // }
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

  clearAll() async {
    clearfilterval();
    iscalltrue = false;
    userid = '';
    usernumber = '';
    isloading = false;
    errortabMsg = '';
    dropdownvalue = "";
    forwardSuccessMsg = '';
    leadLoadingdialog = false;
    testlistData.clear();
    visitLists.clear();
    getAlldata.clear();
    openVisitData.clear();
    closedVisitdata.clear();
    missedVisitUserdata.clear();
  }

  spilitDatafirst(List<getvisitdetails> getvisitdetailsdata) {
    log("getvisitdetailsdataspliiii::"+getvisitdetailsdata.length.toString());
    visitdetailsdata.clear();
    for (int i = 0; i < getvisitdetailsdata.length; i++) {
      log("getvisitdetailsdata[i].visitstatus::"+getvisitdetailsdata[i].visitstatus.toString());
      if (getvisitdetailsdata[i].visitstatus == 'Planned') {
        visitdetailsdata.add(getvisitdetails(
            address1: getvisitdetailsdata[i].address1,
            address2: getvisitdetailsdata[i].address2,
            address3: getvisitdetailsdata[i].address3,
            city: getvisitdetailsdata[i].city,
            closed: getvisitdetailsdata[i].closed,
            createdby: getvisitdetailsdata[i].createdby,
            customercode: getvisitdetailsdata[i].customercode,
            customername: getvisitdetailsdata[i].customername,
            meetingtime: getvisitdetailsdata[i].meetingtime,
            product: getvisitdetailsdata[i].product,
            purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
            userid: getvisitdetailsdata[i].userid,
            visitplan: getvisitdetailsdata[i].visitplan,
            visitstatus: getvisitdetailsdata[i].visitstatus,
            pincode: getvisitdetailsdata[i].pincode,
            state: getvisitdetailsdata[i].state,
            cusmobile: getvisitdetailsdata[i].cusmobile,
            cusemail: getvisitdetailsdata[i].cusemail,
            contactname: getvisitdetailsdata[i].contactname,
            AssignedTo: getvisitdetailsdata[i].AssignedTo,
            Att1: getvisitdetailsdata[i].Att1,
            Att2: getvisitdetailsdata[i].Att2,
            Att3: getvisitdetailsdata[i].Att3,
            Att4: getvisitdetailsdata[i].Att4,
            BaseId: getvisitdetailsdata[i].BaseId,
            BaseType: getvisitdetailsdata[i].BaseType,
            CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
            CheckinLat: getvisitdetailsdata[i].CheckinLat,
            CheckinLong: getvisitdetailsdata[i].CheckinLong,
            CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
            CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
            CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
            CreatedBy: getvisitdetailsdata[i].CreatedBy,
            CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
            IsClosed: getvisitdetailsdata[i].IsClosed,
            LookingFor: getvisitdetailsdata[i].LookingFor,
            PotentialBusinessValue:
                getvisitdetailsdata[i].PotentialBusinessValue,
            TargetId: getvisitdetailsdata[i].TargetId,
            TargetType: getvisitdetailsdata[i].TargetType,
            UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
            UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
            VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
            VisitStatus: getvisitdetailsdata[i].VisitStatus,
            area: getvisitdetailsdata[i].area,
            country: getvisitdetailsdata[i].country,
            district: getvisitdetailsdata[i].district,
            plannedDate: getvisitdetailsdata[i].plannedDate,
            storecode: getvisitdetailsdata[i].storecode,
            traceid: getvisitdetailsdata[i].traceid));
      }
    }
    notifyListeners();
    spilitData(visitdetailsdata);
    log("visitdetailsdata::" + visitdetailsdata.length.toString());
    notifyListeners();
  }

  String? dropdownvalue;

  spilitData(List<getvisitdetails> getvisitdetailsdata) {
    log("getvisitdetailsdatasplit::"+getvisitdetailsdata.length.toString());
    String currentdate;
    String? nextfollowdate;
    DateTime curentdate2;
    DateTime nextfollowdate2;
    currentdate = config.currentDateOnly();
    curentdate2 = DateTime.parse(currentdate);
    for (int i = 0; i < getvisitdetailsdata.length; i++) {
      nextfollowdate =
          config.aligndatefollow(getvisitdetailsdata[i].plannedDate!);
      nextfollowdate2 = DateTime.parse(nextfollowdate);
      // log("Open:::" + getvisitdetailsdata[i].visitstatus.toString());
      if (nextfollowdate2.isBefore(curentdate2)) {
        missedVisitUserdata.add(getvisitdetails(
            address1: getvisitdetailsdata[i].address1,
            address2: getvisitdetailsdata[i].address2,
            address3: getvisitdetailsdata[i].address3,
            city: getvisitdetailsdata[i].city,
            closed: getvisitdetailsdata[i].closed,
            createdby: getvisitdetailsdata[i].createdby,
            customercode: getvisitdetailsdata[i].customercode,
            customername: getvisitdetailsdata[i].customername,
            meetingtime: getvisitdetailsdata[i].meetingtime,
            product: getvisitdetailsdata[i].product,
            purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
            userid: getvisitdetailsdata[i].userid,
            visitplan: getvisitdetailsdata[i].visitplan,
            visitstatus: getvisitdetailsdata[i].visitstatus,
            pincode: getvisitdetailsdata[i].pincode,
            state: getvisitdetailsdata[i].state,
            cusmobile: getvisitdetailsdata[i].cusmobile,
            cusemail: getvisitdetailsdata[i].cusemail,
            contactname: getvisitdetailsdata[i].contactname,
            AssignedTo: getvisitdetailsdata[i].AssignedTo,
            Att1: getvisitdetailsdata[i].Att1,
            Att2: getvisitdetailsdata[i].Att2,
            Att3: getvisitdetailsdata[i].Att3,
            Att4: getvisitdetailsdata[i].Att4,
            BaseId: getvisitdetailsdata[i].BaseId,
            BaseType: getvisitdetailsdata[i].BaseType,
            CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
            CheckinLat: getvisitdetailsdata[i].CheckinLat,
            CheckinLong: getvisitdetailsdata[i].CheckinLong,
            CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
            CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
            CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
            CreatedBy: getvisitdetailsdata[i].CreatedBy,
            CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
            IsClosed: getvisitdetailsdata[i].IsClosed,
            LookingFor: getvisitdetailsdata[i].LookingFor,
            PotentialBusinessValue:
                getvisitdetailsdata[i].PotentialBusinessValue,
            TargetId: getvisitdetailsdata[i].TargetId,
            TargetType: getvisitdetailsdata[i].TargetType,
            UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
            UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
            VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
            VisitStatus: getvisitdetailsdata[i].VisitStatus,
            area: getvisitdetailsdata[i].area,
            country: getvisitdetailsdata[i].country,
            district: getvisitdetailsdata[i].district,
            plannedDate: getvisitdetailsdata[i].plannedDate,
            storecode: getvisitdetailsdata[i].storecode,
            traceid: getvisitdetailsdata[i].traceid));
      } else {
        openVisitData.add(getvisitdetails(
            address1: getvisitdetailsdata[i].address1,
            address2: getvisitdetailsdata[i].address2,
            address3: getvisitdetailsdata[i].address3,
            city: getvisitdetailsdata[i].city,
            closed: getvisitdetailsdata[i].closed,
            createdby: getvisitdetailsdata[i].createdby,
            customercode: getvisitdetailsdata[i].customercode,
            customername: getvisitdetailsdata[i].customername,
            meetingtime: getvisitdetailsdata[i].meetingtime,
            product: getvisitdetailsdata[i].product,
            purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
            userid: getvisitdetailsdata[i].userid,
            visitplan: getvisitdetailsdata[i].visitplan,
            visitstatus: getvisitdetailsdata[i].visitstatus,
            pincode: getvisitdetailsdata[i].pincode,
            state: getvisitdetailsdata[i].state,
            cusmobile: getvisitdetailsdata[i].cusmobile,
            cusemail: getvisitdetailsdata[i].cusemail,
            contactname: getvisitdetailsdata[i].contactname,
            AssignedTo: getvisitdetailsdata[i].AssignedTo,
            Att1: getvisitdetailsdata[i].Att1,
            Att2: getvisitdetailsdata[i].Att2,
            Att3: getvisitdetailsdata[i].Att3,
            Att4: getvisitdetailsdata[i].Att4,
            BaseId: getvisitdetailsdata[i].BaseId,
            BaseType: getvisitdetailsdata[i].BaseType,
            CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
            CheckinLat: getvisitdetailsdata[i].CheckinLat,
            CheckinLong: getvisitdetailsdata[i].CheckinLong,
            CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
            CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
            CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
            CreatedBy: getvisitdetailsdata[i].CreatedBy,
            CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
            IsClosed: getvisitdetailsdata[i].IsClosed,
            LookingFor: getvisitdetailsdata[i].LookingFor,
            PotentialBusinessValue:
                getvisitdetailsdata[i].PotentialBusinessValue,
            TargetId: getvisitdetailsdata[i].TargetId,
            TargetType: getvisitdetailsdata[i].TargetType,
            UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
            UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
            VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
            VisitStatus: getvisitdetailsdata[i].VisitStatus,
            area: getvisitdetailsdata[i].area,
            country: getvisitdetailsdata[i].country,
            district: getvisitdetailsdata[i].district,
            plannedDate: getvisitdetailsdata[i].plannedDate,
            storecode: getvisitdetailsdata[i].storecode,
            traceid: getvisitdetailsdata[i].traceid));
      }
      // if (getvisitdetailsdata[i].visitstatus == "Planned") {
      //   openVisitData.add(getvisitdetails(
      //     address1: getvisitdetailsdata[i].address1,
      //     address2: getvisitdetailsdata[i].address2,
      //     address3: getvisitdetailsdata[i].address3,
      //     city: getvisitdetailsdata[i].city,
      //     closed: getvisitdetailsdata[i].closed,
      //     createdby: getvisitdetailsdata[i].createdby,
      //     customercode: getvisitdetailsdata[i].customercode,
      //     customername: getvisitdetailsdata[i].customername,
      //     meetingtime: getvisitdetailsdata[i].meetingtime,
      //     product: getvisitdetailsdata[i].product,
      //     purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
      //     userid: getvisitdetailsdata[i].userid,
      //     visitplan: getvisitdetailsdata[i].visitplan,
      //     visitstatus: getvisitdetailsdata[i].visitstatus,
      //     pincode: getvisitdetailsdata[i].pincode,
      //     state: getvisitdetailsdata[i].state,
      //     cusmobile: getvisitdetailsdata[i].cusmobile,
      //     cusemail: getvisitdetailsdata[i].cusemail,
      //     contactname: getvisitdetailsdata[i].contactname,
      //     AssignedTo: getvisitdetailsdata[i].AssignedTo,
      //     Att1: getvisitdetailsdata[i].Att1,
      //     Att2: getvisitdetailsdata[i].Att2,
      //     Att3: getvisitdetailsdata[i].Att3,
      //     Att4: getvisitdetailsdata[i].Att4,
      //     BaseId: getvisitdetailsdata[i].BaseId,
      //     BaseType: getvisitdetailsdata[i].BaseType,
      //     CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
      //      CheckinLat: getvisitdetailsdata[i].CheckinLat,
      //      CheckinLong: getvisitdetailsdata[i].CheckinLong,
      //      CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
      //      CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
      //      CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
      //      CreatedBy: getvisitdetailsdata[i].CreatedBy,
      //      CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
      //      IsClosed: getvisitdetailsdata[i].IsClosed,
      //      LookingFor: getvisitdetailsdata[i].LookingFor,
      //      PotentialBusinessValue: getvisitdetailsdata[i].PotentialBusinessValue,
      //      TargetId: getvisitdetailsdata[i].TargetId,
      //      TargetType: getvisitdetailsdata[i].TargetType,
      //      UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
      //      UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
      //      VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
      //      VisitStatus: getvisitdetailsdata[i].VisitStatus,
      //      area: getvisitdetailsdata[i].area,
      //      country: getvisitdetailsdata[i].country,
      //      district: getvisitdetailsdata[i].district,
      //      plannedDate: getvisitdetailsdata[i].plannedDate,
      //      storecode: getvisitdetailsdata[i].storecode,
      //      traceid: getvisitdetailsdata[i].traceid));
      //   log("Open:::" + openVisitData.length.toString());
      // }
      // if (getvisitdetailsdata[i].visitstatus == "Closed") {
      //   closedVisitdata.add(getvisitdetails(
      //       address1: getvisitdetailsdata[i].address1,
      //     address2: getvisitdetailsdata[i].address2,
      //     address3: getvisitdetailsdata[i].address3,
      //     city: getvisitdetailsdata[i].city,
      //     closed: getvisitdetailsdata[i].closed,
      //     createdby: getvisitdetailsdata[i].createdby,
      //     customercode: getvisitdetailsdata[i].customercode,
      //     customername: getvisitdetailsdata[i].customername,
      //     meetingtime: getvisitdetailsdata[i].meetingtime,
      //     product: getvisitdetailsdata[i].product,
      //     purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
      //     userid: getvisitdetailsdata[i].userid,
      //     visitplan: getvisitdetailsdata[i].visitplan,
      //     visitstatus: getvisitdetailsdata[i].visitstatus,
      //     pincode: getvisitdetailsdata[i].pincode,
      //     state: getvisitdetailsdata[i].state,
      //     cusmobile: getvisitdetailsdata[i].cusmobile,
      //     cusemail: getvisitdetailsdata[i].cusemail,
      //     contactname: getvisitdetailsdata[i].contactname,
      //     AssignedTo: getvisitdetailsdata[i].AssignedTo,
      //     Att1: getvisitdetailsdata[i].Att1,
      //     Att2: getvisitdetailsdata[i].Att2,
      //     Att3: getvisitdetailsdata[i].Att3,
      //     Att4: getvisitdetailsdata[i].Att4,
      //     BaseId: getvisitdetailsdata[i].BaseId,
      //     BaseType: getvisitdetailsdata[i].BaseType,
      //     CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
      //      CheckinLat: getvisitdetailsdata[i].CheckinLat,
      //      CheckinLong: getvisitdetailsdata[i].CheckinLong,
      //      CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
      //      CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
      //      CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
      //      CreatedBy: getvisitdetailsdata[i].CreatedBy,
      //      CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
      //      IsClosed: getvisitdetailsdata[i].IsClosed,
      //      LookingFor: getvisitdetailsdata[i].LookingFor,
      //      PotentialBusinessValue: getvisitdetailsdata[i].PotentialBusinessValue,
      //      TargetId: getvisitdetailsdata[i].TargetId,
      //      TargetType: getvisitdetailsdata[i].TargetType,
      //      UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
      //      UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
      //      VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
      //      VisitStatus: getvisitdetailsdata[i].VisitStatus,
      //      area: getvisitdetailsdata[i].area,
      //      country: getvisitdetailsdata[i].country,
      //      district: getvisitdetailsdata[i].district,
      //      plannedDate: getvisitdetailsdata[i].plannedDate,
      //      storecode: getvisitdetailsdata[i].storecode,
      //      traceid: getvisitdetailsdata[i].traceid));
      // }
      // if (getvisitdetailsdata[i].visitstatus == "Missed") {
      //   missedVisitUserdata.add(getvisitdetails(
      //       address1: getvisitdetailsdata[i].address1,
      //     address2: getvisitdetailsdata[i].address2,
      //     address3: getvisitdetailsdata[i].address3,
      //     city: getvisitdetailsdata[i].city,
      //     closed: getvisitdetailsdata[i].closed,
      //     createdby: getvisitdetailsdata[i].createdby,
      //     customercode: getvisitdetailsdata[i].customercode,
      //     customername: getvisitdetailsdata[i].customername,
      //     meetingtime: getvisitdetailsdata[i].meetingtime,
      //     product: getvisitdetailsdata[i].product,
      //     purposeofvisit: getvisitdetailsdata[i].purposeofvisit,
      //     userid: getvisitdetailsdata[i].userid,
      //     visitplan: getvisitdetailsdata[i].visitplan,
      //     visitstatus: getvisitdetailsdata[i].visitstatus,
      //     pincode: getvisitdetailsdata[i].pincode,
      //     state: getvisitdetailsdata[i].state,
      //     cusmobile: getvisitdetailsdata[i].cusmobile,
      //     cusemail: getvisitdetailsdata[i].cusemail,
      //     contactname: getvisitdetailsdata[i].contactname,
      //     AssignedTo: getvisitdetailsdata[i].AssignedTo,
      //     Att1: getvisitdetailsdata[i].Att1,
      //     Att2: getvisitdetailsdata[i].Att2,
      //     Att3: getvisitdetailsdata[i].Att3,
      //     Att4: getvisitdetailsdata[i].Att4,
      //     BaseId: getvisitdetailsdata[i].BaseId,
      //     BaseType: getvisitdetailsdata[i].BaseType,
      //     CheckinDateTime: getvisitdetailsdata[i].CheckinDateTime,
      //      CheckinLat: getvisitdetailsdata[i].CheckinLat,
      //      CheckinLong: getvisitdetailsdata[i].CheckinLong,
      //      CheckoutDateTime: getvisitdetailsdata[i].CheckoutDateTime,
      //      CheckoutLat: getvisitdetailsdata[i].CheckoutLat,
      //      CheckoutLong: getvisitdetailsdata[i].CheckoutLong,
      //      CreatedBy: getvisitdetailsdata[i].CreatedBy,
      //      CreatedDateTime: getvisitdetailsdata[i].CreatedDateTime,
      //      IsClosed: getvisitdetailsdata[i].IsClosed,
      //      LookingFor: getvisitdetailsdata[i].LookingFor,
      //      PotentialBusinessValue: getvisitdetailsdata[i].PotentialBusinessValue,
      //      TargetId: getvisitdetailsdata[i].TargetId,
      //      TargetType: getvisitdetailsdata[i].TargetType,
      //      UpdatedBy: getvisitdetailsdata[i].UpdatedBy,
      //      UpdatedDateTime: getvisitdetailsdata[i].UpdatedDateTime,
      //      VisitOutcome: getvisitdetailsdata[i].VisitOutcome,
      //      VisitStatus: getvisitdetailsdata[i].VisitStatus,
      //      area: getvisitdetailsdata[i].area,
      //      country: getvisitdetailsdata[i].country,
      //      district: getvisitdetailsdata[i].district,
      //      plannedDate: getvisitdetailsdata[i].plannedDate,
      //      storecode: getvisitdetailsdata[i].storecode,
      //      traceid: getvisitdetailsdata[i].traceid));
      //   // log("ANBUUUU:::"+missedVisitUserdata.)
      // }
    }
    isloading = false;
    notifyListeners();
  }

  List<test> testlistData = [
    //   "raja1",
    //   "raja12",
    //   "raja13",
    //  "raja123",
    test(customername: "ramu1", tagid: "19"),
    test(customername: "ramu12", tagid: "192"),
    test(customername: "ramu13", tagid: "193"),
    test(customername: "ramu123", tagid: "1923"),
  ];
}

class visitplanDataList {
  String? customer;
  String? datetime;
  String? purpose;
  String? area;
  String? product;
  String? type;

  visitplanDataList({
    required this.customer,
    required this.datetime,
    required this.purpose,
    required this.area,
    required this.product,
    required this.type,
  });
}

class test {
  String? customername;

  String? tagid;
  // String shipCity;
  // String shipstate;
  // String shipPincode;
  // String shipCountry;
  test({
    this.tagid,
    this.customername,

    // required this.shipCity,
    //required this.shipAddress,

    // required this.shipCountry,
    // required this.shipPincode,
    // required this.shipstate
  });
}
class Distcolumn {
  String name;
  Distcolumn({
    required this.name,
  });
}class Distcusgroupcolumn {
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
  String? name;
  bool? ischecck;
  Distlookingforcolumn({required this.name,  this.ischecck});
}
