// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/VisitplanController/NewVisitController.dart';
import 'package:sellerkit/Models/purposeofvistModel/purposeofvisitmodel.dart';
import 'package:sellerkit/Pages/VisitPlans/Screens/NewVisitPlan.dart';
import 'package:sellerkit/Services/VisitApi/cancelvisitApi.dart';
import 'package:sellerkit/Services/getvisitscheduleAPi/getvistitApi.dart';

import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';
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
  }
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
 List<TextEditingController> mycontroller =
      List.generate(20, (i) => TextEditingController());
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
    
   await  clearAll();
   
   await     getallvisitdata();
  //  await     getvisitpurpose();
notifyListeners();
    // callSummaryApi();

    //});
  }
  mapvaluesmodify(getvisitdetails? openVisitData){
    NewVisitplanController.datafrommodify.clear();
    NewVisitplanController.datafrommodify.add(openVisitData!.visitplan!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.customercode!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.customername!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.contactname!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.address1!.toString());

    NewVisitplanController.datafrommodify.add(openVisitData!.address2!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.area!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.city!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.pincode!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.state!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.LookingFor!.toString());
    NewVisitplanController.datafrommodify.add(openVisitData!.purposeofvisit!.toString());
     NewVisitplanController.datafrommodify.add(openVisitData!.cusemail!.toString());
     NewVisitplanController.datafrommodify.add(openVisitData!.BaseId!.toString());
     NewVisitplanController.datafrommodify.add(openVisitData!.BaseType!.toString());
     NewVisitplanController.datafrommodify.add(openVisitData!.PotentialBusinessValue!.toString());
      // NewVisitplanController.datafrommodify.add(openVisitData!.!.toString());
    NewVisitPlanState.iscomfromLead=true;
 Get.toNamed(ConstantRoutes.newvisitplan);
 notifyListeners();
  }
  
String lottie='';
  getallvisitdata() async {
     lottie='';
    isloading = true;
    notifyListeners();
    await getvisitApi.getdata().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getvisitheaddata!.getvisitdetailsdata != null && value.getvisitheaddata!.getvisitdetailsdata!.isNotEmpty) {
          spilitDatafirst(value.getvisitheaddata!.getvisitdetailsdata!);
          // isloading = false;
          notifyListeners();
        } else if (value.getvisitheaddata!.getvisitdetailsdata == null|| value.getvisitheaddata!.getvisitdetailsdata!.isEmpty) {
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
        errortabMsg =
            '${value.exception}..${value.message}..!!';
        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isloading = false;
          lottie='Assets/NetworkAnimation.json';
        errortabMsg =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
    notifyListeners();
  }
  String forwardSuccessMsg = '';
  bool leadLoadingdialog=false;
  cancelvisit(int followDocEntry) async {
    log("followDocEntry::"+followDocEntry.toString());
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
    await CancelVisitApi.getData(followDocEntry,)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        forwardSuccessMsg = 'Visit cancelled successfully..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        forwardSuccessMsg ='${value.exception}..${value.message}..!!';
        leadLoadingdialog = false;
        notifyListeners();
      } else if (value.stcode == 500) {
        forwardSuccessMsg = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
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
    String? temp='';
    if (purposevisit != null) {
      for (int i = 0; i < purposevisit!.length; i++) {
        if (id == purposevisit![i].description) {
          temp= purposevisit![i].description;
          return temp;
          
        }
      }
    }
    if(temp!.isEmpty){
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

  clearAll() async{
    isloading = false;
    errortabMsg = '';
    dropdownvalue = "";
  forwardSuccessMsg = '';
   leadLoadingdialog=false;
    testlistData.clear();
    visitLists.clear();
    openVisitData.clear();
    closedVisitdata.clear();
    missedVisitUserdata.clear();
    
  }
spilitDatafirst(List<getvisitdetails> getvisitdetailsdata){
  visitdetailsdata.clear();
   for (int i = 0; i < getvisitdetailsdata.length; i++) {
    if(getvisitdetailsdata[i].visitstatus=='Planned'){
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
    }

   }
   notifyListeners();
  spilitData(visitdetailsdata);
  log("visitdetailsdata::"+visitdetailsdata.length.toString());
  notifyListeners();
}

  String? dropdownvalue;

  spilitData(List<getvisitdetails> getvisitdetailsdata) {

    String currentdate;
    String? nextfollowdate;
    DateTime curentdate2;
    DateTime nextfollowdate2;
    currentdate = config.currentDateOnly();
    curentdate2 = DateTime.parse(currentdate);
    for (int i = 0; i < getvisitdetailsdata.length; i++) {

        nextfollowdate = config.aligndatefollow(getvisitdetailsdata[i].plannedDate!);
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
}else{
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
    isloading=false;
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
