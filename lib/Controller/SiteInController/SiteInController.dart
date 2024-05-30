// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:sellerkit/Controller/SiteInController/newcreatesitein.dart';
import 'package:sellerkit/Models/postvisitmodel/postvisitplan.dart';
import 'package:sellerkit/Models/purposeofvistModel/purposeofvisitmodel.dart';
import 'package:sellerkit/Pages/SiteIn/Widgets/NewSiteIn.dart';
import 'package:sellerkit/Services/getvisitscheduleAPi/getvistitApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
// import 'package:sellerkit/DBHelper/DBOperation.dart';
// import 'package:sellerkit/Pages/Settings/Screen/Settings.dart';
// import 'package:sellerkit/Services/siteinApi/siteinApi.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
// import '../../DBHelper/DBHelper.dart';
import '../../DBModel/SiteCheckInTableModel.dart';
import '../../Models/VisitPlanModel/VisitPlanModel.dart';
// import '../../Models/purposeofvistModel/purposeofvisitmodel.dart';
import '../../Models/siteinModel/siteinmodel.dart';
// import '../../Pages/SiteIn/Widgets/SiteInCardSuccessBox .dart';
// import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Pages/SiteIn/Widgets/successbox.dart';
import '../../Services/siteinApi/getsiteinApi.dart';
import '../../Widgets/AlertDilog.dart';
import '../VisitplanController/NewVisitController.dart';

// import '../../Models/VisitPlanModel/VisitPlanModel.dart';
import '../../Models/getvisitmodel/getvisitmodel.dart';
import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';

class SiteInController extends ChangeNotifier {
  // List<purposeofVisitData> purposeofVisitList = [];
  List<getvisitdetails> openVisitData = [];
  List<getvisitdetails> filteropenVisitData = [];
  List<getvisitdetails> get getopenVisitData => openVisitData;
  List<VisitPlanData> visitLists = [];

  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void init(BuildContext context) {
    clearAll();
    getallvisitdata(context);
    // getvisitpurpose();
    // clearAll();
  }
setListData(){
  filteropenVisitData=openVisitData;
  notifyListeners();
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

  clearAlldata() {
    isloading = false;
    errortabMsg = '';
    notifyListeners();
  }

  bool isloading = false;
  String errortabMsg = '';
  
String lottie='';
  getallvisitdata(BuildContext context) async {
    isloading = true;
     lottie='';
    notifyListeners();
    await getvisitApi.getdata().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getvisitheaddata!.getvisitdetailsdata != null &&
            value.getvisitheaddata!.getvisitdetailsdata!.isNotEmpty) {
          spilitDatafirst(value.getvisitheaddata!.getvisitdetailsdata!,context);
          // isloading = false;
          notifyListeners();
        } else if (value.getvisitheaddata!.getvisitdetailsdata == null ||
            value.getvisitheaddata!.getvisitdetailsdata!.isEmpty) {
          isloading = false;
            lottie='Assets/no-data.png';
          errortabMsg = 'No data..!!';
          // exception = true;
          //       errorMsg = 'No data found..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
         lottie='';
        isloading = false;
        errortabMsg = '${value.message}..!!${value.exception}....!!';
        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isloading = false;
          lottie='Assets/NetworkAnimation.json';
        errortabMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<getvisitdetails> visitdetailsdata = [];
  List<getvisitdetails> checkdetailsdata = [];
  spilitDatafirst(List<getvisitdetails> getvisitdetailsdata,BuildContext context) {
    bool ischeckin=false;
     String name='';
    openVisitData.clear();
    filteropenVisitData.clear();
    for(int ij = 0; ij < getvisitdetailsdata.length; ij++){
      if( getvisitdetailsdata[ij].visitstatus =='Open'){
        name=getvisitdetailsdata[ij].customername.toString();
ischeckin=true;
notifyListeners();
      }

    }
if(ischeckin==true){
  isloading = false;
  validateCheckIn(context, name);
   notifyListeners();
    // spilitData(visitdetailsdata);
    
    log("visitdetailsdata::" + visitdetailsdata.length.toString());
    notifyListeners();
}
else{
 for (int i = 0; i < getvisitdetailsdata.length; i++) {
   if(getvisitdetailsdata[i].visitstatus=='Planned'){
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
          PotentialBusinessValue: getvisitdetailsdata[i].PotentialBusinessValue,
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
           filteropenVisitData=openVisitData;
   }
    
    }
     notifyListeners();
    // spilitData(visitdetailsdata);
    isloading = false;
    log("visitdetailsdata::" + visitdetailsdata.length.toString());
    notifyListeners();
}

   
   
  }
searchfilter(String v){
  if(v.isNotEmpty){
filteropenVisitData = openVisitData.where((e) => (e).customername!.toLowerCase().contains(v.toLowerCase())).toList();
  notifyListeners();
  }else if(v.isEmpty){
filteropenVisitData= openVisitData;
 notifyListeners();
  }
  
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

  siteInModelDetailsData? siteInModelDetail;
//   validateCheckIn(BuildContext context) async {
//     // final Database db = (await DBHelper.getInstance())!;
//     int customerName;
//     if(siteInModelDetail !=null){
//       log("ANBUDOT");
// customerName = siteInModelDetail!.visitplanid!;
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return SuccessDialogPG(
//               heading: 'Response',
//               msg: 'Please Check-Out ${customerName}..!!',
//             );
//           }).then((value) {
//         Get.offAllNamed(ConstantRoutes.dashboard);
//       });
//     }else{
//        log("ANBUDOTDOTDOTDOT");
//     }
//     // List<Map<String, Object?>> serailbatchCheck =
//     //     await DBOperation.getValidateCheckIn(db);
//     // if (createSiteInController.siteInModelDetail!.visitplanid !=null) {

//     // }
//   }
  validateCheckIn(BuildContext context, String? name) async {
    // final Database db = (await DBHelper.getInstance())!;
    int customerName;
    // if(siteInModelDetail !=null){
    log("ANBUDOT");
// customerName = siteInModelDetail!.visitplanid!;
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return SuccessDialogPG(
            heading: 'Response',
            msg: 'Please Check-Out ${name}..!!',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
    // }else{
    //    log("ANBUDOTDOTDOTDOT");
    // }
    // List<Map<String, Object?>> serailbatchCheck =
    //     await DBOperation.getValidateCheckIn(db);
    // if (createSiteInController.siteInModelDetail!.visitplanid !=null) {

    // }
  }

  gesiteindata(BuildContext context) async {
    await GetsiteinApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getsiteInDetail != null) {
          log("SIteINN");
          String? customerName;
          customerName = value.getsiteInDetail![0].customercode;
          validateCheckIn(context, value.getsiteInDetail![0].customername);
        } else if (value.getsiteInDetail == null) {
          log("GETVISITDATA");
          // getallvisitdata();
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
  }

  clearAll() {
    isloading = false;
    errortabMsg = '';
    mycontroller[12].text='';
    purposeofVisitList.clear();
    openVisitData.clear();
    filteropenVisitData.clear();
    visitLists.clear();
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[9].text = "";
    notifyListeners();
  }

  clearText() {
    mycontroller[0].text = ""; //customer
    mycontroller[1].text = ""; //MobileNo
    mycontroller[2].text = ""; //contactname
    mycontroller[3].text = ""; //address1
    mycontroller[4].text = ""; //adrsss2
    mycontroller[5].text = ""; //area
    mycontroller[6].text = ""; //city
    mycontroller[7].text = ""; //pincode
    mycontroller[8].text = ""; //state
    mycontroller[9].text = ""; //pupose
    notifyListeners();
  }

  callAlertDialog3(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        // barrierDismissible: false,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.visitplan);
    });
  }

  callexistApi() {}
  callsiteinApi() {}
  List<SiteCheckInDBModel> siteCheckInData = [];
  // validateSchedule(BuildContext context) async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   if (formkey.currentState!.validate()) {
  //     List<SiteCheckInDBModel> siteCheckIn = [];
  //     siteCheckIn.add(SiteCheckInDBModel(
  //         customer: mycontroller[0].text.toString(),
  //         mobile: int.parse(mycontroller[1].text.toString()),
  //         cantactName: mycontroller[2].text.toString(),
  //         address1: mycontroller[3].text.toString(),
  //         address2: mycontroller[4].text.toString(),
  //         area: mycontroller[5].text.toString(),
  //         city: mycontroller[6].text.toString(),
  //         pincode: mycontroller[7].text.isEmpty
  //             ? 0
  //             : int.parse(mycontroller[7].text.toString()),
  //         siteType: "CheckIn",
  //         date: config.currentDateOnly2(),
  //         time: config.currentTimeOnly2(),
  //         datetime: config.currentDate(),
  //         purpose: mycontroller[9].text.toString(), //pupose,
  //         state: mycontroller[8].text.toString()));
  //     await DBOperation.insertSiteCheckIn(db, siteCheckIn);
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => SiteInSuccessCard(),
  //         ));
  //     //
  //     // showDialog<dynamic>(
  //     //     context: context,
  //     //     builder: (_) {
  //     //       return SuccessDialogPG(
  //     //         heading: 'Response',
  //     //         msg: 'Site Check-In Created Successfully..!!',
  //     //       );
  //     //     }).then((value) {
  //     //   Get.offAllNamed(ConstantRoutes.sitein);
  //     // });
  //   }
  // }

  spilitData(List<getvisitdetails> getvisitdetailsdata) {
    openVisitData.clear();
    filteropenVisitData.clear();
    for (int i = 0; i < getvisitdetailsdata.length; i++) {
      if (getvisitdetailsdata[i].visitstatus == "Planned") {
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
            filteropenVisitData=openVisitData;
      }
    }
  }

  selectedOpenVisits(getvisitdetails? openVisitData) {
    createSiteInController.comefromsitein.clear();
    createSiteInController.comefromsitein
        .add(openVisitData!.visitplan!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.customercode!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.customername!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.contactname!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.address1!.toString());

    createSiteInController.comefromsitein
        .add(openVisitData!.address2!.toString());
    createSiteInController.comefromsitein.add(openVisitData!.area!.toString());
    createSiteInController.comefromsitein.add(openVisitData!.city!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.pincode!.toString());
    createSiteInController.comefromsitein.add(openVisitData!.state!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.LookingFor!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.purposeofvisit!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.cusemail!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.BaseId!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.BaseType!.toString());
    createSiteInController.comefromsitein
        .add(openVisitData!.PotentialBusinessValue!.toString());
        createSiteInController.comefromsitein
        .add(openVisitData!.meetingtime!.toString());
          NewSiteInState.iscomfromLead=true;
 Get.toNamed(ConstantRoutes.newsitein);
    notifyListeners();
  }

  List<purposeofVisitData> purposeofVisitList = [];
  // getallvisitdata() async {
  //   await getvisitApi.getdata().then((value) async {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       if (value.getvisitheaddata!.getvisitdetailsdata != null &&value.getvisitheaddata!.getvisitdetailsdata!.isNotEmpty) {
  //         spilitData(value.getvisitheaddata!.getvisitdetailsdata!);
  //         notifyListeners();
  //       } else if (value.getvisitheaddata!.getvisitdetailsdata == null ||value.getvisitheaddata!.getvisitdetailsdata!.isEmpty) {
  //         // exception = true;
  //         //       errorMsg = 'No data found..!!';
  //         notifyListeners();
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       // exception = true;
  //       //       errorMsg = 'Some thing went wrong.!';
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       // datagotByApi = false;
  //       // exception = true;
  //       // errorMsg = 'Some thing went wrong..!';
  //       notifyListeners();
  //     }
  //   });
  // }

  getData() {
    visitLists.clear();
    purposeofVisitList = [
      purposeofVisitData(purpose: "Courtesy Visit"),
      purposeofVisitData(purpose: "Enquiry Visit"),
      purposeofVisitData(purpose: "Routine Visit"),
      purposeofVisitData(purpose: "Collection"),
      purposeofVisitData(purpose: "Customer Appointment"),
      purposeofVisitData(purpose: "New Demo"),
      purposeofVisitData(purpose: "Complaint Call Visit")
    ];
    visitLists = [
      VisitPlanData(
        customer: "Raja",
        datetime: "21-Jul-2023 2:11PM",
        purpose: "Courtesy Visit",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Open",
        Mobile: "1234567890",
        CantactName: "Arun",
        U_Address1: "104 West Street ,",
        U_Address2: "Srirangam,Trichy",
        U_City: "Trichy",
        U_Pincode: "6200005",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "24-Jun-2023 4:23PM",
        purpose: "Enquiry Visit",
        area: "Saibaba Colony ",
        product: "Looking For Table/Chair",
        type: "Closed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      ),
      VisitPlanData(
        customer: "Raja",
        datetime: "21-May-2023-4:23PM",
        purpose: "Customer Appointment",
        area: "Saibaba Colony Coimbatore",
        product: "Looking For Table/Chair",
        type: "Missed",
        Mobile: "9876543210",
        CantactName: "Raja",
        U_Address1: "124 KK Nagar Street ,",
        U_Address2: "Karur main Road,Karur",
        U_City: "Somur",
        U_Pincode: "6200024",
        U_State: "Tamil Nadu",
      )
    ];
    // filterpurposeofVisitList = purposeofVisitList;

    notifyListeners();
  }

  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  String? url;
  String? adrress;

  // Future<void> determinePosition(BuildContext context) async {
  //   bool? serviceEnabled;
  //   LocationPermission permission;
  //   try {
  //     LocationPermission permission;
  //     permission = await Geolocator.requestPermission();
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (serviceEnabled == false) {
  //       try {
  //         await Geolocator.getCurrentPosition();
  //         permission = await Geolocator.checkPermission();
  //         if (permission == LocationPermission.denied) {
  //           permission = await Geolocator.requestPermission();
  //           if (permission == LocationPermission.denied) {
  //             //return Future.error('Location permissions are denied');
  //           }
  //         }

  //         if (permission == LocationPermission.deniedForever) {}
  //         var pos = await Geolocator.getCurrentPosition();
  //         print('lattitude: ' + pos.latitude.toString());
  //         latitude = pos.latitude.toString();
  //         langitude = pos.longitude.toString();
  //         longi = langitude;
  //         lati = latitude;

  //         url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

  //         var lat = double.parse(latitude);
  //         var long = double.parse(langitude);
  //         await AddressMasterApi.getData(lat.toString(), long.toString())
  //             .then((value) {
  //           log("value.stcode::" + value.stcode.toString());
  //           if (200 >= value.stcode! && 210 <= value.stcode!) {
  //             adrress = value.address2;
  //             log("adress::" + adrress.toString());
  //             notifyListeners();
  //           } else {
  //             print("error:api");
  //           }
  //         });
  //         // var placemarks =
  //         //     await placemarkFromCoordinates(lat, long);

  //         // adrress = placemarks[0].street.toString() +
  //         //       ' ' +
  //         //       placemarks[0].thoroughfare.toString() +
  //         //       ' ' +
  //         //       placemarks[0].locality.toString();
  //         //    final coordinates = new Coordinates(lat, long);
  //         // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //         // var first = addresses.first;
  //         // print("AAAAAAAAAAAAA:::${first.featureName} : ${first.addressLine}");
  //         // adrress=first.addressLine;
  //         notifyListeners();
  //       } catch (e) {
  //         const snackBar = SnackBar(
  //             duration: Duration(seconds: 1),
  //             backgroundColor: Colors.red,
  //             content: Text('Please turn on the Location!!..'));
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         Future.delayed(
  //           const Duration(seconds: 2),
  //           () => Get.back<dynamic>(),
  //         );
  //       }
  //       notifyListeners();
  //     } else if (serviceEnabled == true) {
  //       var pos = await Geolocator.getCurrentPosition();
  //       print('lattitude: ' + pos.latitude.toString());
  //       latitude = pos.latitude.toString();
  //       langitude = pos.longitude.toString();
  //       longi = langitude;
  //       lati = latitude;

  //       url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

  //       var lat = double.parse(latitude);
  //       var long = double.parse(langitude);
  //       await AddressMasterApi.getData(lat.toString(), long.toString())
  //           .then((value) {
  //         log("value.stcode::" + value.stcode.toString());
  //         if (value.stcode! >= 200 && value.stcode! <= 210) {
  //           adrress = value.address2;
  //           log("adress::" + adrress.toString());
  //           notifyListeners();
  //         } else {
  //           print("error:api");
  //         }
  //       });
  //       // var placemarks = await placemarkFromCoordinates(lat, long);
  //       //   adrress = placemarks[0].street.toString() +
  //       //       ' ' +
  //       //       placemarks[0].thoroughfare.toString() +
  //       //       ' ' +
  //       //       placemarks[0].locality.toString();
  //       //  final coordinates = new Coordinates(lat, long);
  //       // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //       // var first = addresses.first;
  //       //         adrress=first.addressLine;

  //       // print("${first.featureName} : ${first.addressLine}");
  //       notifyListeners();
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     final snackBar =
  //         SnackBar(backgroundColor: Colors.red, content: Text('$e'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     // Future.delayed(
  //     //     const Duration(seconds: 2),
  //     //     () => Get.back<dynamic>(),
  //     //   );
  //   }
  //   notifyListeners();
  // }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/PosDBV2.db');
    return Future.value(source1);
  }

  Future<bool> getPermissionStorage() async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return Future.value(false);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sellerkit-FS Backup");
    return Future.value(copyTo);
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = copyTo!.path;
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      print("datata1111");
      print(e);
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/SellerkitDBV2.db";
      print(getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }

  showSnackBars(String e, Color color) {
    print(e);
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
      title: "Warning..",
      message: e,
      backgroundColor: Colors.green,
    ));
  }
}

class NewSitin {
  String? customer;
  String? mobileNo;

  String? contactName;

  String? address1;

  String? address2;

  String? area;

  String? city;
}
