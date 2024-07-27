// //
// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'dart:ui';
// import 'package:call_log/call_log.dart';
// import 'package:external_app_launcher/external_app_launcher.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/src/extensions/string_extensions.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Constant/Helper.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Constant/Utils.dart';
// import 'package:sellerkit/Constant/getCallLog_NativeCode.dart';
// import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
// import 'package:sellerkit/Controller/callNotificationController/callNotificationController.dart';
// import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
// import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
// import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
// import 'package:sellerkit/Pages/callerNotification/keyboardhelper.dart';
// import 'package:sellerkit/Pages/callerNotification/widgets/assigndata.dart';
// import 'package:sellerkit/Pages/callerNotification/widgets/custom_keyboard_handler.dart';
// import 'package:sellerkit/Pages/callerNotification/widgets/custom_text_field.dart';
// import 'package:sellerkit/Pages/callerNotification/widgets/showsearchdialog.dart';
// import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
// import 'package:sellerkit/Services/PostQueryApi/LeadsApi/OpenSaveApi.dart';
// import 'package:sellerkit/Services/QuickEnqApi/quickenqApi.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import 'package:sellerkit/Services/selfNotificationApi/selfNotificationApi.dart';
// import 'package:sellerkit/main.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:system_alert_window/system_alert_window.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../Constant/Configuration.dart';
// import '../../dBHelper/dBHelper.dart';
// import '../../dBHelper/dBOperation.dart';
// import '../../dBModel/outstandinglinechild.dart';

// class CustomOverlayNew extends StatefulWidget {
//   const CustomOverlayNew({Key? key}):super(key:key);

//   @override
//   State<CustomOverlayNew> createState() => CustomOverlayNewState();
// }

// class CustomOverlayNewState extends State<CustomOverlayNew>
//     with WidgetsBindingObserver {
//   static const String _mainAppPort = 'MainApp';
//     FocusNode focusNode1=FocusNode();
//     FocusNode focusNode2=FocusNode();
//     final TextEditingController _controller =TextEditingController();
//   SendPort? mainAppPort;
//   bool update = false;
//   bool? isAddcus=false;
//   bool? isshowEnq=false;
//   bool? isshowfollowup=false;
//   bool? isshowothers=false;
//   bool? isopenstatus=false;
//   bool? isclosedstatus=false;
//   bool? isloststatus=false;
//  static String? geturlnew='';
//   static String? gettokennew='';
//    List<TextEditingController> mycontroller =
//       List.generate(40, (i) => TextEditingController());
//   GetCallerData? callerList;
//   static String token = '';
//   static String getUrl = '';
//    String caseStatusSelected = ''; //cl
//   String? get getcaseStatusSelected => caseStatusSelected;
//   String caseStatusSelectedcode = ''; //cl
//   String? get getcaseStatusSelectedcode => caseStatusSelectedcode;
  
//   bool leadOpenSaveClicked = false;
//   bool leadWonSaveClicked = false;
//   bool leadLostSaveClicked = false;

//   String? hinttextforOpenLead = 'Select Status:* '; //cl
//   String? get gethinttextforOpenLead => hinttextforOpenLead;
//   String? hinttextforWonLead = 'Select Status:* '; //cl
//   String? get gethinttextforWonLead => hinttextforWonLead;
//   String? hinttextforLostLead = 'Select Reason*'; //cl
//   String? get gethinttextforLostLead => hinttextforLostLead;
//   String? feedbackLead = 'Give your feedback*'; //cl Give your feedback
//   String? get getfeedbackLead => feedbackLead;
//   String? nextFollowupDate = 'Next Follow up:*'; //cl
//   String? get getnextFollowupDate => nextFollowupDate;
//   String? nextFollowupTime = 'Follow up Time:*';
//   String? get getnextFollowupTime => nextFollowupTime;
// //
//   String? nextVisitDate = 'Visit Date:*'; //cl
//   String? get getnextVisitDate => nextVisitDate;
//   String? nextVisitTime = 'Visit Time:*';
//   String? get getnextVisitTime => nextVisitTime;
// //

//   String? orderBillRefer = 'Order/Bill Reference*'; //cl
//   String? get getorderBillRefer => orderBillRefer;
//   String? orderBillDate = 'Order/Bill Date:*'; //cl
//   String? get getorderBillDate => orderBillDate;
//   String apiFDate = '';
//   String nextFD = '';
//   //Vsiplan
//   String apivisitate = '';
//   String visitDt = '';
//   String VisitTime = '';
//   String get getVsitTime => VisitTime;
//   //
//   String nextWonFD = '';
//   String get getnextFD => nextFD;
//   String nextFDTime = '';
//   String get getnextFDTime => nextFDTime;

//   String? valueChosedReason; //cl
//   String? get getvalueChosedReason => valueChosedReason;
//   String? valueChosedStatus; //cl
//   String? get getvalueChosedStatus => valueChosedStatus;
//   String? valueChosedStatusWon; //cl
//   String? get getvalueChosedStatusWon => valueChosedStatusWon;

//   bool? sitevisitreq = false;
//   bool? get getsitevisitreq => sitevisitreq;
//   choosedStatus(String val) {
//    setState(() {
//     valueChosedStatus = val;
//    });
    
    
//   }
//   choosedStatusWon(String val) {
//     setState(() {
//      valueChosedStatusWon = val;
//    });
   
  
   
//   }
//   String isSelectedFollowUp = '';
//   String get getisSelectedFollowUp => isSelectedFollowUp;
// String? followup =
//       'How you made the follow up?'; //cl How the follow up has been made
//   String? get getfollowup => followup;
//   String isSelectedFollowUpcode = '';
//   String get getisSelectedFollowUpcode => isSelectedFollowUpcode;
//   selectFollowUp(String selected, String selectcode) {
//     setState(() { 
//  isSelectedFollowUp = selected;
//     isSelectedFollowUpcode = selectcode;
//     log('isSelectedFollowUpcode::+'+isSelectedFollowUpcode.toString());
//     });
   
//     // notifyListeners();
//   }
//   validatebtnChanged() {
//     setState(() {
//     if (caseStatusSelected == "Open") {
//       sitevisitreq = false;
//       if (leadOpenSaveClicked == true) {
//         hinttextforOpenLead = "Select Status: *";
//         feedbackLead = 'Give your feedback *';
//         nextFollowupDate = 'Next Follow up: *';
//         followup = 'How you made the follow up? *';
//         nextFollowupTime = 'Follow up Time: *';
//         nextVisitDate = 'Visit Date: *';
//         nextVisitTime = 'Visit Time: *';
//       } else {
//         hinttextforOpenLead = "Select Status:*";
//         feedbackLead = 'Give your feedback*';
//         nextFollowupDate = 'Next Follow up:*';
//         followup = 'How you made the follow up?*';
//         nextFollowupTime = 'Follow up Time:*';
//         nextVisitDate = 'Visit Date:*';
//         nextVisitTime = 'Visit Time:*';
//       }
     
//     } else {}

//     if (caseStatusSelected == "Won") {
//       if (leadWonSaveClicked == true) {
//         hinttextforWonLead = "Select Status: *";
//         orderBillRefer = 'Order/Bill Reference *';
//         followup = 'How you made the follow up? *';
//       } else {
//         hinttextforWonLead = "Select Status:*";
//         orderBillRefer = 'Order/Bill Reference*';
//         feedbackLead = 'Give your feedback*';
//         nextFollowupDate = 'Next Follow up:*';
//         followup = 'How you made the follow up?*';
//       }
//       nextFD = '';
//       nextFDTime = '';
//       nextWonFD = '';
//     } else {}

//     if (caseStatusSelected == "Lost") {
//       if (leadLostSaveClicked == true) {
//         feedbackLead = 'Give your feedback *';
//         hinttextforLostLead = 'Select Reason: *';
//         followup = 'How you made the follow up? *';
//       } else {
//         feedbackLead = 'Give your feedback*';
//         hinttextforLostLead = 'Select Reason:*';
//         followup = 'How you made the follow up?*';
//       }
//       nextFD = '';
//       nextFDTime = '';
//       nextWonFD = '';
//     } else {}  
//     });
    
//   }

//   String errorTime = "";
//   selectTime(BuildContext context) async {
//     TimeOfDay timee = TimeOfDay.now();
//      TimeOfDay   startTime = TimeOfDay(hour: 7, minute: 0);
//   TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0); 
//     if (nextFD.isNotEmpty) {
//       errorTime = "";
//       final TimeOfDay? newTime = await showTimePicker(
//         context: context,
//         initialTime: timee,
//         builder: (context,child){
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(
//               alwaysUse24HourFormat: false
//             ),
//             child: child!,
//           );
//         }
//       );

//       if (newTime != null) {
//         timee = newTime;
//         log("timee:::"+timee.toString());
//         // if (timee.hour < startTime.hour ||
//         //       timee.hour > endTime.hour|| (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
//         //         nextFDTime = "";
 
//         //     nextFollowupTime = 'Follow up Time: *';
//         //     errorTime=' Choose 7AM to 10PM';
//         //     notifyListeners();
//         //       }else{
//         if (nextFD == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
//           if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
//            setState(() {
//              errorTime = "Please Choose Correct Time";
//             nextFDTime = "";
//            });
           
           
//             print("error");
//           } else {
//               setState(() {
//               errorTime = "";
//             print("correct11"+timee.format(context).toString());
//             nextFDTime = formatTimeOfDay(timee,context);
//             log("nextFDTime::"+nextFDTime.toString());
//             // timee.format(context).toString();
//            });
          
//           }
//         } else {
//            setState(() {
//                errorTime = "";
//           print("correct22");
//           timee = newTime;
//           // nextFDTime = timee.format(context).toString();
//            nextFDTime = formatTimeOfDay(timee,context);
//             log("nextFDTime::"+nextFDTime.toString());
//            });
         
//         }
// nextFollowupTime = 'Follow up Time:*';
      
//       //  }
//       }
    
     
//     } else {
//       setState(() {
//        nextFDTime = "";
//       errorTime = "Please Choose First Date";
       
//       });
     
//     }
  
//   }

//     String formatTimeOfDay(TimeOfDay time, BuildContext context) {
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     final format = DateFormat.jm();  // This will format time as '5:08 PM'
//     return format.format(dt);
//   }
//  String errorVisitTime = "";
//  bool iscorectime2=false;
//   String forwarderrorVisitTime = "";
//   String forwaVisitTime = '';
//   String get getVisitTime => VisitTime;
//   String? assignvisitDt = '';
//   String? assignVisitTime = 'Followup Time:*';
//   String forwardnextWonFD = '';
//   String get getforwardnextWonFD => forwardnextWonFD;
//   selectVisitTime(BuildContext context) async {
//     // setState(() async{
//       TimeOfDay timee = TimeOfDay.now();
//     TimeOfDay   startTime = TimeOfDay(hour: 7, minute: 0);
//   TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0); 
//     if (visitDt.isNotEmpty) {
//       errorVisitTime = "";
//       final TimeOfDay? newTime = await showTimePicker(
//         context: context,
//         initialTime: timee,
//          builder: (context,child){
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(
//               alwaysUse24HourFormat: false
//             ),
//             child: child!,
//           );
//         }
//       );

//       if (newTime != null) {
//         timee = newTime;
//         // if (timee.hour < startTime.hour ||
//         //       timee.hour > endTime.hour || (timee.hour == endTime.hour && timee.minute > endTime.minute)) {
//         //         VisitTime = "";
 
//         //     nextVisitTime = 'Visit Time:*'; 
//         //     notifyListeners();
//         //       }else{
//         if (visitDt == DateFormat('dd-MM-yyyy').format(DateTime.now())) {
//           if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
//             setState(() {
//                errorVisitTime = "Please Choose Correct Time";
//             VisitTime = "";
//             });
           
            
//             print("error");
//           } else {
//              setState(() {
//                errorVisitTime = "";
//             print("correct11");
//             VisitTime = formatTimeOfDay(timee,context);;
//             });
          
//           }
//         } else {
//           setState(() {
//                 errorVisitTime = "";
//           print("correct22");
//           timee = newTime;
//           VisitTime = formatTimeOfDay(timee,context);;
//             });
         
//         }
// nextVisitTime = 'Visit Time:';
//               // }
//       }
     
//     } else {
//       setState(() {
//         VisitTime = "";
//       errorVisitTime = "Please Choose First Date";
       
//       });
     
//     }
//     // });
   
//   }
//   clearbool() {
//     setState(() {
//      visitDt = '';
//      nextFD='';
//      nextFDTime='';
//     VisitTime = '';
//     errorVisitTime = '';
//     forwaVisitTime = '';
//     forwardnextWonFD = '';
//     iscorectime2=false;  
//     });
   
    
//   }
//    checksitevisit(bool val) {
//     setState(() {
//       if (val == true) {
//       log("DONE");
//       setState(() {
//           clearbool();
//       });
    
      
//     }
//     sitevisitreq = val;
//     log("message::" + sitevisitreq.toString());
   
//     });
//   }
//   void showFollowupDate(BuildContext context) {
//    setState(() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2050),
//     ).then((value) {
//       if (value == null) {
//         return;
//       }
//       setState((){
// String chooseddate = value.toString();
//       var date = DateTime.parse(chooseddate);
//       chooseddate = "";
//       chooseddate =
//           "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
//       apiFDate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//       print(apiFDate);

//       nextFD = chooseddate;
//       });
      
     
//     }); 
//    });
//   }

//   void showVisitDate(BuildContext context) {
//     setState(() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2050),
//     ).then((value) {
//       if (value == null) {
//         return;
//       }

//       setState((){
// String chooseddate = value.toString();
//       VisitTime='';
//       var date = DateTime.parse(chooseddate);
//       chooseddate = "";
//       chooseddate =
//           "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
//       apivisitate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//       print(apiFDate);
// setState(() {
//       visitDt = chooseddate;
  
// });
//       });
      
      
//     });  
//     });
//   }
  
//   choosedReason(String val) {
//     setState(() {
//        valueChosedReason = val;
//     });
   
   
//   }
//   void showFollowupWonDate(BuildContext context) {
//     setState(() {
//       showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2050),
//     ).then((value) {
//       if (value == null) {
//         return;
//       }
//       setState((){
// String chooseddate = value.toString();
//       var date = DateTime.parse(chooseddate);
//       chooseddate = "";
//       chooseddate =
//           "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
//       apiWonFDate =
//           "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//       print(apiWonFDate);
// setState(() {
//     nextWonFD = chooseddate;
     
// });
//       });
      
    
//     });
//     });
//   }
// String apiWonFDate = '';
//   String get getnextWonFD => nextWonFD;
//   caseStatusSelectBtn(String val, String code) {
//     caseStatusSelected = val;
//     caseStatusSelectedcode = code;
// if(caseStatusSelected =="Open"){
//  isopenstatus=true;
// }
   
//     log("caseStatusSelected::" + caseStatusSelected.toString());
//     log("caseStatusSelectedcode::" + caseStatusSelectedcode.toString());
    
//   }
//   clickLeadSaveBtn(String followDocEntry, String leadDocEntry) {
//     if (caseStatusSelected == 'Open') {
//       leadOpenSaveClicked = true;
//       leadWonSaveClicked = false;
//       leadLostSaveClicked = false;

//       callRequiredOpen(followDocEntry, leadDocEntry);
//     } else if (caseStatusSelected == 'Won') {
//       leadWonSaveClicked = true;
//       leadOpenSaveClicked = false;
//       leadLostSaveClicked = false;
//       callRequiredWon(followDocEntry, leadDocEntry);
//     } else if (caseStatusSelected == 'Lost') {
//       leadLostSaveClicked = true;
//       leadOpenSaveClicked = false;
//       leadWonSaveClicked = false;
//       callRequiredLost(followDocEntry, leadDocEntry);
//     }
//   }

//   callRequiredOpen(String followDocEntry, String leadDocEntry) {
//     int i = 0;
//     if (valueChosedStatus == null) {
//       i = i + 1;
//       hinttextforOpenLead = "Select Status: *";
//     } else {
//       hinttextforOpenLead = "Select Status:*";
//     }
//     if (mycontroller[31].text.isEmpty) {
//       i = i + 1;
//       feedbackLead = 'Give your feedback *';
//     } else {
//       feedbackLead = 'Give your feedback*';
//     }
//     if (nextFD == '') {
//       i = i + 1;
//       nextFollowupDate = 'Next Follow up: *';
//     } else {
//       nextFollowupDate = 'Next Follow up:*';
//     }
//    if(nextFDTime ==''){
//     nextFollowupTime = 'Follow up Time: *';
//    } else{
//      nextFollowupTime = 'Follow up Time:*';
//    }

//     if(sitevisitreq ==true){
//       if(visitDt ==''){
// nextVisitDate = 'Visit Date: *';
//       }else{
//         nextVisitDate = 'Visit Date:*';
//       }
      
//  if (VisitTime == '') {
//       i = i + 1;
//       nextVisitTime = 'Visit Time: *';
//     } else {
//       nextVisitTime = 'Visit Time:*';
//     }
//     }
   
//     if (isSelectedFollowUp == '') {
//       print("4");

//       i = i + 1;
//       followup = 'How you made the follow up? *';
//     } else {
//       followup = 'How you made the follow up?*';
//     }
//     hinttextforWonLead = "Select Status:*";
//     orderBillRefer = 'Order/Bill Reference*';
//     orderBillDate = 'Order/Bill Date*';
//     hinttextforLostLead = 'Select Reason:*';
//     if (i < 1) {
//       print("ssssss");
//       Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[31].text,
//           apiFDate, "", "", "", "");

//       }
//   }
//   List<GetLeadStatusData> leadStatusOpen = [];
//   List<GetLeadStatusData> secondleadStatusOpen = [];
//   List<GetLeadStatusData> leadStatusLost = [];
//   List<GetLeadStatusData> leadStatusWon = [];
//   List<GetLeadStatusData> get getleadStatusOpen => leadStatusOpen;
//   List<GetLeadStatusData> get getleadStatusLost => leadStatusLost;
//   List<GetLeadStatusData> get getleadStatusWon => leadStatusWon;
  
  
  
//   getDataOnLoad() async {
//     leadStatusOpen.clear();
//     leadStatusWon.clear();
//     leadStatusLost.clear();
//     final Database db = (await DBHelper.getInstance())!;
// // setState(() {
//   leadStatusOpen = await DBOperation.getLeadStatusOpen(db);
//     leadStatusLost = await DBOperation.getLeadStatusLost(db);
//     leadStatusWon = await DBOperation.getLeadStatusWon(db);
//     // userLtData = await DBOperation.getUserList(db);
//     // filteruserLtData = userLtData;
// // secondleadStatusOpen=leadStatusOpen;
//     log("leadStatusOpen222::"+leadStatusOpen.length.toString());
// // });
    
//     // setForwardDataList();
//     //  openlea();
//     // wonlea();
//     // lostlea();
//     // notifyListeners();
//   }
// String? forwardDialogSuccessMsg='';
// bool isLodingDialog=false;
// void showtoastforscanning(String msg) {
//     Fluttertoast.showToast(
//         msg: "$msg",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.black,
//         textColor: Colors.white,
//         fontSize: 14.0);
//   }
//   clearenqdata(){
//     mycontroller[21].clear();
//     mycontroller[25].clear();
//     mycontroller[26].clear();
//     mycontroller[24].clear();
//     mycontroller[22].clear();
//     isloadingBtn=false;
//     enqerror='';

//   }
  
// final formkey = GlobalKey<FormState>();
//   clearfollowdata(){
//      clearbool();
//       valueChosedStatus=null;
//   errorVisitTime = "";
//  errorTime = "";
//   mycontroller[31].clear();
//  caseStatusSelectedcode = "";
//     caseStatusSelected = "";
//     isSelectedFollowUp = '';
//     isSelectedFollowUpcode = '';
//     assignVisitTime = "Followup Time:*";
    
// forwarderrorVisitTime = "";
//   visitDt = '';
//     VisitTime = '';
//     errorVisitTime = '';
//     forwaVisitTime = '';
//     forwardnextWonFD = '';
//     nextWonFD='';
//     iscorectime2=false;
//     isSelectedFollowUpcode = '';
//     caseStatusSelected='';
//     caseStatusSelectedcode = "";
//   }
// bool  isloadingBtn = false;
// String? enqerror='';
//    validate(String mobile,String name,String lookingfor,String assignto,String Description){
//     if( formkey.currentState!.validate()){
//      setState((){
//       isloadingBtn=true;
//      });
     
//        qenqcolumns enqcolumn=qenqcolumns();

// enqcolumn.mobile=mobile;
// enqcolumn.name=name;
// enqcolumn.lookingfor=lookingfor;
// enqcolumn.assignto= context.read<CallNotificationController>(). usercode;
// enqcolumn.Description=Description;

// quickEnqPostApi.getData(enqcolumn).then((value) {
//    if (value.stcode! >= 200 && value.stcode! <= 210) {
//     log("successenq");
//     setState(() {
//           //  enqerror = '${value.error!}..!!';
//            log("forwardDialogSuccessMsg::"+enqerror.toString());
//         isloadingBtn = false;
//        SnackBar  snackBar = SnackBar(
//   content: Text("Successfully Enquiry Added..!!"),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// clearenqdata();
//         // showtoastforscanning(forwardDialogSuccessMsg.toString());
//         });
        
       
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//          log("successenq400");
//         setState(() {
//            enqerror = '${value.stcode!}..!!${value.exception!}';
//            log("forwardDialogSuccessMsg::"+enqerror.toString());
//         isloadingBtn = false;
//        SnackBar  snackBar = SnackBar(
//   content: Text("$enqerror"),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// // clearenqdata();
//         // showtoastforscanning(forwardDialogSuccessMsg.toString());
//         });  } else {
//              log("successenq500");
//              setState(() {
//            enqerror = '${value.stcode!}..!!${value.exception!}';
//            log("forwardDialogSuccessMsg::"+enqerror.toString());
//         isloadingBtn = false;
//        SnackBar  snackBar = SnackBar(
//   content: Text("$enqerror"),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// // clearenqdata();
//         // showtoastforscanning(forwardDialogSuccessMsg.toString());
//         }); 
//         // isloadingBtn = false;
//         // notifyListeners();
//         // callAlertDialog2(context,
//         //     '${value.stcode!}..!!Network Issue..\nTry again Later..!!');
//       }

// });
//     }
//   }
// Allfollowupupdate(
//       String followDocEntry,
//       String leadDocEntry,
//       feedback,
//       nextFPdate,
//       billwonDate,
//       billreference,
//       String salesPersonEmpId,
//       String checkstatus) async {
//         setState(() {
//           forwardDialogSuccessMsg = '';
//     isLodingDialog = true;
//         });
    
//     // viewDetailsClicked = false;
//     // updateFrowardDialog = false;
//     // forwardDialogClicked = false;
//     String? reasondetails;
//     forwardDialogSuccessMsg='';
//     ForwardLeadUserDataOpen forwardLeadUserDataOpen =
//         new ForwardLeadUserDataOpen();
//     log("valueChosedStatus::" + valueChosedStatus.toString());
//     if (caseStatusSelected == "Open") {
//       for (int i = 0; i < leadStatusOpen.length; i++) {
//         if (leadStatusOpen[i].code == valueChosedStatus) {
//           reasondetails = leadStatusOpen[i].name;
//           log("reasondetails::" + reasondetails.toString());
//         }
       
//       }
//       if (nextFDTime != '') {
//         Config config = Config();

//         forwardLeadUserDataOpen.nextFD =
//             config.alignDateforFollow(nextFDTime, nextFPdate);
//       } else {
//         forwardLeadUserDataOpen.nextFD = nextFPdate;
//       }

//       if (visitDt != '') {
//         Config config = Config();
//  forwardLeadUserDataOpen.visitreq=1;
//         forwardLeadUserDataOpen.visitdate =
//             config.alignDateforFollow(VisitTime, apivisitate);
//       } else {
//         forwardLeadUserDataOpen.visitreq=0;
//         forwardLeadUserDataOpen.visitdate = null;
//       }
//       forwardLeadUserDataOpen.curentDate = config.currentDate();
//       forwardLeadUserDataOpen.ReasonCode = valueChosedStatus;
//       forwardLeadUserDataOpen.Reasoname = reasondetails;
//       forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;

//       forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
//       forwardLeadUserDataOpen.feedback = feedback;
//       forwardLeadUserDataOpen.status = caseStatusSelectedcode;
//       // notifyListeners();
//     } else if (caseStatusSelected == "Won") {
//       for (int i = 0; i < leadStatusWon.length; i++) {
//         if (leadStatusWon[i].code == valueChosedStatusWon) {
//           reasondetails = leadStatusWon[i].name;
//           log("reasondetails::" + reasondetails.toString());
//         }
//         // notifyListeners();
//       }

//       forwardLeadUserDataOpen.ReasonCode = valueChosedStatusWon;
//       forwardLeadUserDataOpen.Reasoname = reasondetails;
//       forwardLeadUserDataOpen.billDate = billwonDate;
//       forwardLeadUserDataOpen.billRef = billreference;
//       forwardLeadUserDataOpen.curentDate = config.currentDate();
//       forwardLeadUserDataOpen.feedback = feedback;
//       forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
//       forwardLeadUserDataOpen.nextFD = null;
//       forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
//       forwardLeadUserDataOpen.status = caseStatusSelectedcode;
//       // notifyListeners();
//     } else if (caseStatusSelected == "Lost") {
//       for (int i = 0; i <leadStatusLost.length; i++) {
//         if (leadStatusLost[i].code == valueChosedReason) {
//           reasondetails = leadStatusLost[i].code;
//           log("reasondetails::" + reasondetails.toString());
//         }
//         // notifyListeners();
//       }
//       forwardLeadUserDataOpen.ReasonCode = valueChosedReason;
//       forwardLeadUserDataOpen.Reasoname = reasondetails;
//       forwardLeadUserDataOpen.curentDate = config.currentDate();
//       forwardLeadUserDataOpen.feedback = feedback;
//       forwardLeadUserDataOpen.followupMode = isSelectedFollowUpcode;
//       forwardLeadUserDataOpen.nextFD = null;
//       forwardLeadUserDataOpen.updatedBy = ConstantValues.slpcode;
//       forwardLeadUserDataOpen.status = caseStatusSelectedcode;
//       // notifyListeners();
//     } else {
//       for (int i = 0; i < leadStatusOpen.length; i++) {
//         if (leadStatusOpen[i].name == checkstatus) {
//           reasondetails = leadStatusOpen[i].code;
//           log("reasondetails::" + reasondetails.toString());
//         }

//         // notifyListeners();
//       }
//       Config config = Config();

//       forwardLeadUserDataOpen.nextFD =
//           config.alignDateforFollow(forwaVisitTime, "");
//       forwardLeadUserDataOpen.ReasonCode =
//           reasondetails == null || reasondetails.isEmpty
//               ? leadStatusOpen[0].code
//               : reasondetails;
//       forwardLeadUserDataOpen.Reasoname =
//           reasondetails == null || reasondetails.isEmpty
//               ? leadStatusOpen[0].name
//               : checkstatus;
//       forwardLeadUserDataOpen.status = "01";
//       forwardLeadUserDataOpen.curentDate = config.currentDate();

//       forwardLeadUserDataOpen.nextUser = salesPersonEmpId;
//       // notifyListeners();
//     }

//     await AllSaveLeadApi.getData(leadDocEntry, forwardLeadUserDataOpen)
//         .then((value) {
//       if (value.stCode >= 200 && value.stCode <= 210) {
//         setState(() {
//            forwardDialogSuccessMsg = '${value.error!}..!!';
//            log("forwardDialogSuccessMsg::"+forwardDialogSuccessMsg.toString());
//         isLodingDialog = false;
//        SnackBar  snackBar = SnackBar(
//   content: Text("Successfully Updated"),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
// clearfollowdata();
//         // showtoastforscanning(forwardDialogSuccessMsg.toString());
//         });
       
//         // notifyListeners();

//         // notifyListeners();
//       } else if (value.stCode >= 400 && value.stCode <= 410) {
//         setState(() {
//           forwardDialogSuccessMsg = '${value.error!}..!!${value.stCode}...!!';
          
//         isLodingDialog = false;
//          SnackBar  snackBar = SnackBar(
//   content: Text(forwardDialogSuccessMsg.toString()),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         });
        
//         // notifyListeners();
//         // notifyListeners();
//       } else if (value.stCode == 500) {
//         setState(() {
//          forwardDialogSuccessMsg = '${value.stCode!}..!!Network Issue..\nTry again Later..!!';
//         isLodingDialog = false;
//         SnackBar  snackBar = SnackBar(
//   content: Text(forwardDialogSuccessMsg.toString()),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         });
        
//         // notifyListeners();
//       }
//     });
//     // checkValues();
//   }
//   callRequiredWon(String followDocEntry, String leadDocEntry) {
//     int i = 0;
//     if (valueChosedStatusWon == null) {
//       print("1a");
//       i = i + 1;
//       hinttextforWonLead = "Select Status: *";
//     } else {
//       hinttextforWonLead = "Select Status:*";
//     }
//     if (mycontroller[32].text.isEmpty) {
//       i = i + 1;
//       print("2");

//       orderBillRefer = 'Order/Bill Reference *';
//     } else {
//       orderBillRefer = 'Order/Bill Reference*';
//     }
//     if (nextWonFD == '') {
//       print("3");

//       i = i + 1;
//       orderBillDate = 'Order/Bill Date *';
//     } else {
//       orderBillDate = 'Order/Bill Date*';
//     }
//     if (isSelectedFollowUp == '') {
//       print("4");

//       i = i + 1;
//       followup = 'ow you made the follow up? *';
//     } else {
//       followup = 'ow you made the follow up?*';
//     }
//     feedbackLead = 'Give your feedback *';
//     nextFollowupDate = 'Next Follow up:*';
//     hinttextforLostLead = 'Select Reason:*';
//     hinttextforOpenLead = "Select Status:*";
//     print(i);
//     if (i < 1) {
//       print("ssssss");
//       // Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[1].text, "",
//       //     apiWonFDate, mycontroller[0].text, '', "");

//       // WonSave(
//       //     followDocEntry,
//       //     leadDocEntry,
//       //     valueChosedStatusWon,
//       //     mycontroller[1].text,
//       //     isSelectedFollowUp,
//       //     apiWonFDate,
//       //     mycontroller[0].text);
//     }
   
//   }

//   callRequiredLost(String followDocEntry, String leadDocEntry) {
//     int i = 0;
//     if (mycontroller[31].text.isEmpty) {
//       i = i + 1;
//       feedbackLead = 'Give your feedback *';
//     } else {
//       feedbackLead = 'Give your feedback*';
//     }
//     if (valueChosedReason == null) {
//       i = i + 1;
//       hinttextforLostLead = 'Select Reason: *';
//     } else {
//       hinttextforLostLead = 'Select Reason:*';
//     }
//     if (isSelectedFollowUp == '') {
//       i = i + 1;
//       followup = 'How you made the follow up? *';
//     } else {
//       followup = 'How you made the follow up?*';
//     }
//     hinttextforWonLead = "Select Status:*";
//     orderBillRefer = 'Order/Bill Reference*';
//     orderBillDate = 'Order/Bill Date*';
//     nextFollowupDate = 'Next Follow up:*';
//     hinttextforOpenLead = "Select Status:*";
//     if (i < 1) {
//       // Allfollowupupdate(followDocEntry, leadDocEntry, mycontroller[1].text, "",
//       //     "", "", "", "");

//       // lostSave(followDocEntry, leadDocEntry, valueChosedReason,
//       //     mycontroller[1].text, isSelectedFollowUp);
//     }
//   }
   
  
// clearall()async{
//   clearbool();
//   isopenstatus=false;
// isclosedstatus=false;
//   isloststatus=false;
//  isLodingDialog=false;
//   valueChosedStatus=null;
//   errorVisitTime = "";
//  errorTime = "";
//  caseStatusSelectedcode = "";
//     caseStatusSelected = "";
//     isSelectedFollowUp = '';
//     isSelectedFollowUpcode = '';
//     assignVisitTime = "Followup Time:*";
    
// forwarderrorVisitTime = "";
//   visitDt = '';
//     VisitTime = '';
//     errorVisitTime = '';
//     forwaVisitTime = '';
//     forwardnextWonFD = '';
//     nextWonFD='';
//     iscorectime2=false;
//     isSelectedFollowUpcode = '';
//     caseStatusSelected='';
//     caseStatusSelectedcode = "";
// mycontroller[21].clear();
//    context.read<CallNotificationController>(). getslpID=null;
//   context.read<CallNotificationController>().  managerSlpCode=null;
//     mycontroller[22].clear();
//    context.read<CallNotificationController>(). selectedIdxFUser = null;
//     mycontroller[23].clear();
//   //   userLtData.clear();
//   //   filteruserLtData.clear();
//   //   catagorydata = [];
//   //  filtercatagorydata = [];
//     mycontroller[24].clear();
//      mycontroller[25].clear();
//     mycontroller[26].clear();
//      mycontroller[31].clear();
   
// }


// String apiFdate = '';
//   bool checkdata = false;
//   int? reyear;
//   int? remonth;
//   int? reday;
//   int? rehours;
//   int? reminutes;
//   String? apiNdate = '';
  
//   getDate2(BuildContext context) async {
//     setState(()async {
//       errorTime = "";
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2100));
// //  firstDate: DateTime.now().subtract(Duration(days: 1)),
// //   lastDate: DateTime(2100),
//     if (pickedDate != null) {
//       mycontroller[17].text = "";
//       apiFdate = pickedDate.toString();
//       var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);

//       if (mycontroller[14].text.isNotEmpty) {
//         DateTime planPurDate;
//         DateTime nextfdate;

//         planPurDate = DateTime.parse(apiNdate!);
//         nextfdate = DateTime.parse(pickedDate.toString());

//         if (nextfdate.isAfter(planPurDate)) {
//           mycontroller[16].text = '';
//           checkdata = true;
          
//         } else {
//           checkdata = false;
//           mycontroller[16].text = datetype;
//           reyear = pickedDate.year;
//           remonth = pickedDate.month;
//           reday = pickedDate.day;
//           log("::" + reyear.toString());
        
//         }
//       } else {
//         mycontroller[16].text = datetype;
//         reyear = pickedDate.year;
//         remonth = pickedDate.month;
//         reday = pickedDate.day;
       
//       }
//     }
   
//     });
//   }
//   List<outstandingDBModel> valueDBmodel = [];
//   List<outstandinglineDBModel> valueDBmodelchild = [];
//   @override
//   bool _isDisposed = false;
//   void initState() {
//     super.initState();
//     geturlnew='';
//     // setState(() {
//     // WidgetsBinding.instance.addObserver(this);
//     // });
//     // focusNode.addListener(_handleCustomKeyboard);
//     //  _controller = controller ?? TextEditingController();
//     // _focusNode = focusNode ?? FocusNode();
    
// WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //   // context.read<CallNotificationController>().clearall();
//    SystemAlertWindow.overlayListener.listen((event) async {
//       log("$event in overlay");
//        setState(() {
//         isshowEnq=false;
//         isshowfollowup=false;
//         isshowothers=false;
//     // context.read<CallNotificationController>().isquickEnq=false;
//     log("hi this");
      
//     });
// //       String? getUrl = await HelperFunctions.getHostDSP();
// //         log("getUrlgetUrl222::"+getUrl.toString());
// //         Utils.queryApi = 'http://${getUrl.toString()}/api/';
// //         Url.queryApi='http://${getUrl.toString()}/api/';
        
// // String? tokendata=await HelperFunctions. getTokenSharedPreference();
// //  ConstantValues.token =tokendata.toString();
//       await calllog();
    
//       if (event is bool) {
//         setState(() {
//           update = event;
//         });
//       }
//     });    
// });
   
//   }
// onfocus(){
//   if(!_isDisposed){
// KeyboardHelper.showKeyboard();
//   }
   
   
// }
//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   @override
//   void dispose() {
//     //don't forget to dispose of it when not needed anymore
//     // focusNode.dispose();
//     // _isDisposed = true;
//     WidgetsBinding.instance.removeObserver(this);

//     super.dispose();
//   }

//   void callBackFunction(String tag) {
//     mainAppPort ??= IsolateNameServer.lookupPortByName(
//       _mainAppPort,
//     );
//     mainAppPort?.send('Date: ${DateTime.now()}');
//     mainAppPort?.send(tag);
//   }
//   // callBackFunction("Close");
//   // callBackFunction("Action");

//   List<Callloginfo> callsInfo = [];
//   bool addenqVisible = false;
//   static bool callented = false;
//   bool? ontapvisi=false; 
//   List<GetenquiryData>? customerDatalist = [];
// FocusNode focusNode = FocusNode();
// String Docentryfinal='';
// checkfollowup(String mobile){
//   Docentryfinal='';
// setState(() {
//   for(int i=0;i<context.read<CallNotificationController>().leadOpenAllData.length;i++){
// if(context.read<CallNotificationController>().leadOpenAllData[i].customermob ==mobile){
// Docentryfinal=context.read<CallNotificationController>().leadOpenAllData[i].LeadDocEntry.toString();
// isshowEnq=false;
//          isshowfollowup=true;
//         isshowothers=false;
//         selectFollowUp("Phone Call","01");
//         break;
// }
// }
// });

// }
//   calllog() async {
//  await  clearall();
//     log("jhsdsdshdhshdh:::"+context.read<CallNotificationController>().isquickEnq.toString());
//     await getdbmodel();
//      String? getUrl = await HelperFunctions.getHostDSP()??geturlnew;
//            log("getUrlgetUrl222::"+getUrl.toString());
//         Utils.queryApi = 'http://${getUrl.toString()}/api/';
//         Url.queryApi='http://${getUrl.toString()}/api/';
     
// String? tokendata=await HelperFunctions. getTokenSharedPreference();
//  ConstantValues.token =tokendata.toString();
//         log("Utils.queryApi32222::::+"+Utils.queryApi.toString());
//     callsInfo = [];
//     customerDatalist = [];
//     await  context.read<CallNotificationController>().apicalling();
//    await getDataOnLoad();
//     // if (callented == false) return;
//     String mobileno = '';
//     // String? getToken = await HelperFunctions.getTokenSharedPreference();
//     // Utils.token = getToken;

//     // getPermissionUser();
//     if (token.isEmpty) {
//       if (Platform.isAndroid) {
//         Iterable<CallLogEntry> entries = await CallLog.get();
//         setState(() {
//           for (var item in entries) {
//             // if (item.callType.toString().contains('incoming')) {
//             callsInfo.add(Callloginfo(
//                 name: item.callType.toString(),
//                 number: item.number,
//                 duration: item.name.toString()));
//             break;
//             // log(item.callType.toString()+item.number.toString());
//             // }
//           }
//           mobileno = callsInfo[0].number!.replaceAll('+91', '');
//         });

//         String? getUrl = await HelperFunctions.getHostDSP()??geturlnew;
//         log("getUrlgetUrl::"+getUrl.toString());
//         Utils.queryApi = 'http://${getUrl.toString()}/api/';
//         Url.queryApi= 'http://${getUrl.toString()}/api/';
//         log("Utils.queryApi::::+"+Utils.queryApi.toString());
        
// String? tokendata=await HelperFunctions. getTokenSharedPreference();
//  ConstantValues.token =tokendata.toString();
//         // String meth = '${ConstantApiUrl.getCustomerApi}';
      
//         // GetCutomerpost reqpost = GetCutomerpost(customermobile: mobileno);
//         await GetCutomerDetailsApi.getData(mobileno,'').then((value) {
//           if (value.stcode! <= 210 && value.stcode! >= 200) {
//             setState(() {
//               GetCustomerDataHeadertwo? itemdata;
//               itemdata = value.itemdata;
//               customerDatalist = [];
//               // List<EnqOrderList>? enqOrderlist = [];
//               if (itemdata!.enquirydetails != null) {
//                 for (int i = 0; i < itemdata.enquirydetails!.length; i++) {
//                   if ((itemdata.enquirydetails![i].DocType == 'Order' ||
//                           itemdata.enquirydetails![i].DocType ==
//                               'Outstanding' ||
//                           itemdata.enquirydetails![i].DocType == 'Lead') &&
//                       value.itemdata!.enquirydetails![i].Status!
//                           .contains('Open')) {
//                     customerDatalist!.add(GetenquiryData(
//                         DocType: itemdata.enquirydetails![i].DocType,
//                         AssignedTo: itemdata.enquirydetails![i].AssignedTo,
//                         BusinessValue:
//                             itemdata.enquirydetails![i].BusinessValue,
//                         CurrentStatus:
//                             itemdata.enquirydetails![i].CurrentStatus,
//                         DocDate: itemdata.enquirydetails![i].DocDate,
//                         DocNum: itemdata.enquirydetails![i].DocNum,
//                         Status: itemdata.enquirydetails![i].Status,
//                         Store: itemdata.enquirydetails![i].Store));
//                     // enqOrderlist.add(EnqOrderList(
//                     //     doctype: itemdata.enquirydetails![i].DocType,
//                     //     docnum: itemdata.enquirydetails![i].DocNum.toString(),
//                     //     lastorder: itemdata.enquirydetails![i].DocDate,
//                     //     product: '----',
//                     //     assignto: itemdata.enquirydetails![i].AssignedTo));
//                   }
//                 }
//                  isshowEnq=false;
//          isshowfollowup=false;
//         isshowothers=true;
//               }
//               if (itemdata.customerdetails!.isNotEmpty) {
//                 callerList = GetCallerData(
//                   name: itemdata.customerdetails![0].customerName,
//                   mobile: itemdata.customerdetails![0].mobileNo,
//                   tag: itemdata.customerdetails![0].customerGroup,
//                   // datalist: enqOrderlist,
//                 );
//               } else {
//                 setState(() {
//                   callerList = GetCallerData(
//                       name: 'Unknown Number', mobile: mobileno, tag: 'new');
//                         isshowEnq=true;
//          isshowfollowup=false;
//         isshowothers=false;
//                 });
//               }
//             });
//           } else {
//             setState(() {
//               callerList = GetCallerData(
//                   name: 'Unknown Number', mobile: mobileno, tag: 'new');
//                    isshowEnq=true;
//          isshowfollowup=false;
//         isshowothers=false;
//             });
//           }
//         });
//         callerList ??=
//             GetCallerData(name: 'Unknown Number', mobile: mobileno, tag: 'new');
     
//      await checkfollowup(mobileno);
     
//       } else {
//         List<Object?> result = await CallLogService.getCallLog();
//         List<dynamic> listWithoutNulls =
//             result.where((element) => element != null).toList();
//         List<Contact> contacts = listWithoutNulls
//             .map((item) => Contact(
//                   firstName: item['firstName'],
//                   lastName: item['lastName'],
//                   phoneNumbers: List<String>.from(item['phoneNumbers']),
//                 ))
//             .toList();
//         for (int i = 0; i < contacts.length; i++) {
//           callsInfo.add(Callloginfo(
//               name: contacts[i].firstName.toString(),
//               number: contacts[i].phoneNumbers.toString(),
//               duration: ''));
//         }

//         isshowEnq=true;
//          isshowfollowup=false;
//         isshowothers=false;
//       }

//       if (valueDBmodel.isNotEmpty) {
//         for (int i = 0; i < valueDBmodel.length; i++) {
//           if (valueDBmodel[i].customerCode == mobileno) {
//             customerDatalist!.add(GetenquiryData(
//                 DocType: 'Outstanding',
//                 AssignedTo: valueDBmodel[i].assignedTo,
//                 BusinessValue: valueDBmodel[i].amountPaid,
//                 CurrentStatus: 'Open',
//                 DocDate: '',
//                 DocNum: valueDBmodel[i].customerCode != null
//                     ? int.parse(valueDBmodel[i].customerCode.toString())
//                     : 0,
//                 Status: 'Open',
//                 Store: valueDBmodel[i].storeCode));
//           }
//         }
    
     
//       }
//     }
//   }

//   getdbmodel() async {
//     valueDBmodel = [];
//     final Database db = (await DBHelper.getInstance())!;
//     valueDBmodel = await DBOperation.getoutstandingMaster(db);
//   }

//   bool _inforeground = true;
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         setState(() {
//           _inforeground = true;
//         });
//         break;
//       case AppLifecycleState.inactive:
//         setState(() {
//           _inforeground = true;
//         });
//         break;
//       case AppLifecycleState.paused:
//         setState(() {
//           _inforeground = false;
//         });
//         break;

//       default:
//         setState(() {
//           _inforeground = false;
//         });
//         break;
//     }
//   }
//  void _handleCustomKeyboard() {
//     // if (widget.isUseCustomKeyBoard) {
//       focusNode.addListener(() {
//         CustomKeyboardHandler.onFocusChangeHandler(
//           CustomKeyboardHandlerData(
//             isKeyboardShowing: focusNode.hasFocus,
//             controller: _controller,
//           ),
//         );
//       });
//     // }
//   }


//   SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
//   @override
//   Widget build(BuildContext context) {
//     final theme =Theme.of(context);
//     return ChangeNotifierProvider<CallNotificationController>(
//         create: (context) => CallNotificationController(),
//         builder: (context, child) {
//           return Consumer<CallNotificationController>(
//               builder: (BuildContext context, callCon, Widget? child) {
//             // callCon.init();
//             return Scaffold(
//               body: apiFdate == '' ?
              
//               //  overlay(callCon) 
//               Stack(
//       children: [
//         callerList == null
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: theme.primaryColor,
//                 ),
//               )
//             :
//             //  callerList!.name!.contains('Unknown')
//             //     ? 
//                 Container(
//                     color: theme.primaryColor,
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 height: Screens.bodyheight(context) * 0.2,
//                                 decoration: BoxDecoration(
//                                     // borderRadius: BorderRadius.circular(100),
//                                     color: theme.primaryColor),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                   "${callerList!.name!.capitalize} ",
//                                                   style: theme
//                                                       .textTheme.bodyLarge!
//                                                       .copyWith(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                               Container(
//                                                 alignment: Alignment.topCenter,
//                                                 // padding: EdgeInsets.all(
//                                                 //     Screens.bodyheight(context) * 0.01),
//                                                 // height:
//                                                 //     Screens.bodyheight(context) * 0.07,
//                                                 // width: Screens.width(context) * 0.2,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.yellow[100],
//                                                     borderRadius:
//                                                         BorderRadius.circular(4)),
//                                                 child: Text(
//                                                   '${callerList!.tag}',
//                                                   textAlign: TextAlign.center,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Text(
//                                             "+91 ${callerList!.mobile}",
//                                             style: const TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     IconButton(
//                                         padding: EdgeInsets.only(
//                                             right: Screens.bodyheight(context) *
//                                                 0.08),
//                                         onPressed: () {
//                                           // callBackFunction("Close");
//                                           SystemAlertWindow.closeSystemWindow(
//                                               prefMode: prefMode);
//                                         },
//                                         icon: Icon(
//                                           Icons.close,
//                                           color: Colors.white,
//                                           size:
//                                               Screens.bodyheight(context) * 0.06,
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                    SizedBox(
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     width: Screens.width(context) * 0.3,
//                                     child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor:isshowEnq == true
//                                             ?Colors.grey: Colors.white,
//                                             // side: BorderSide(color: Colors.yellow, width: 5),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10))),
//                                         onPressed: () async {
//                                          setState(() {
//                                         // context.read<CallNotificationController>().isquickEnq = true;
//         isshowEnq=true;
//          isshowfollowup=false;
//         isshowothers=false;
//        mycontroller[21].text=callerList!.mobile!;
//                                          });
//                                         },
//                                         child: Text(
//                                           'New Enquiry',
//                                           style: theme.textTheme.bodySmall!
//                                               .copyWith(
//                                                   color: theme.primaryColor),
//                                         )),
//                                   ),

//  SizedBox(
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     width: Screens.width(context) * 0.3,
//                                     child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor:isshowfollowup == true
//                                             ?Colors.grey: Colors.white,
//                                             // side: BorderSide(color: Colors.yellow, width: 5),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10))),
//                                         onPressed: () async {
//                                          setState(() {
//                                           isshowEnq=false;
//                                            isshowfollowup=true;
//         isshowothers=false;
//                                         // context.read<CallNotificationController>().isquickEnq = true;
        
//         mycontroller[21].text=callerList!.mobile!;
//                                 // context.read<CallNotificationController>().getDataOnLoad();
//                           //  log(context.read<CallNotificationController>().leadStatusOpen.length.toString());     
//                                          });
//                                         },
//                                         child: Text(
//                                           'Followup',
//                                           style: theme.textTheme.bodySmall!
//                                               .copyWith(
//                                                   color: theme.primaryColor),
//                                         )),
//                                   ),
//                                    SizedBox(
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     width: Screens.width(context) * 0.3,
//                                     child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor:isshowothers == true
//                                             ?Colors.grey: Colors.white,
//                                             // side: BorderSide(color: Colors.yellow, width: 5),
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10))),
//                                         onPressed: () async {
//                                          setState(() {
//                                         // context.read<CallNotificationController>().isquickEnq = false;
        
//          isshowEnq=false;
//           isshowfollowup=false;
//         isshowothers=true;
//         // CustomTextFieldState.dispose();
//         // context.read<CallNotificationController>() .mycontroller[21].text=callerList!.mobile!;
//                                          });
//                                         },
//                                         child: Text(
//                                           'History',
//                                           style: theme.textTheme.bodySmall!
//                                               .copyWith(
//                                                   color: theme.primaryColor),
//                                         )),
//                                   ),


//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: Screens.padingHeight(context)*0.01,
//                           ),
//                          Container(
//                             width: Screens.width(context),
//                             height: Screens.bodyheight(context) * 0.8,
//                             padding: EdgeInsets.all(
//                                 Screens.bodyheight(context) * 0.03),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20)),
//                             ),
//                             child: SingleChildScrollView(
//                               child: 
//                        isshowEnq==true? 
                         
//                           Form(
//                           key:    formkey,

//                             child: Column(
//                                   children: [
//                                     // Container(
//                                     //   alignment: Alignment.center,
//                                     //   child: Text("Quick Enquiry"),
//                                     // ),
//                                     SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                     Row( 
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
//                                       children: [ 
//                                         Container(
//                                           width: Screens.width(context)*0.2,
//                                           child: Row(
//                                             children: [
//                                               Text("Mobile",textAlign: TextAlign.center,
//                                               ),
//                                            Text(":",textAlign: TextAlign.center,
//                                             )
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                            width: Screens.width(context)*0.6,
//                                            height: Screens.padingHeight(context) * 0.09,
//                                           child: CustomTextField(
//                                             controller:mycontroller[21],
//                                       hintText: '',
//                                       isUseCustomKeyBoard: true,
//                                         inputType:TextInputType.number,
//                                       validator: (value){
//                              if (value!.isEmpty) {
//                                                 return "Enter Mobile Number";
//                                               } else if (value.length > 10 ||
//                                                   value.length < 10) {
//                                                 return "Enter a valid Mobile Number";
//                                               }
//                                               return null;
//                                       },
//                                     ),
//                                           // TextFormField(
//                                           //   focusNode: focusNode,
//                                           //   keyboardType: TextInputType.none,
//                                           //   decoration: InputDecoration(
//                                           //     contentPadding: EdgeInsets.symmetric(
//                                           //       horizontal: 10,
//                                           //       vertical: 10,
                                                
//                                           //     )
//                                           //   ),
//                                           // ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context)*0.2,
//                                           child: Row(
//                                             children: [
//                                               Text("Name",textAlign: TextAlign.start,
//                                               ),
//                                            Text(":",textAlign: TextAlign.center,
//                                             )
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                            width: Screens.width(context)*0.6,
//                                              height: Screens.bodyheight(context) * 0.1,
//                                           //  height: Screens.bodyheight(context) * 0.1,
//                                           child: CustomTextField(
//                                             controller: mycontroller[22],
//                                       hintText: '',
//                                       isUseCustomKeyBoard: true,
//                                      validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Enter Customer";
//                                               }
//                                               return null;
//                                             },
//                                       // onChanged: ,
//                                     ),
//                                                   //                   TextFormField(
//                                                   //                     keyboardType: TextInputType.name,
//                                                   //  textCapitalization: TextCapitalization.words,
//                                                   //  textInputAction: TextInputAction.next,
//                                                   //                     decoration: InputDecoration(
//                                                   //                       contentPadding: EdgeInsets.symmetric(
//                                                   //                         horizontal: 10,
//                                                   //                         vertical: 10
//                                                   //                       )
//                                                   //                     ),
//                                                   //                   ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                       Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
//                                       children: [
//                                         Container(
//                                           width: MediaQuery.of(context).size.width*0.25,
//                                           child: Row(
//                                             children: [
//                                               Text("Looking For",textAlign: TextAlign.center,
//                                               ),
//                                            Text(":",textAlign: TextAlign.center,
//                                             )
//                                             ],
//                                           ),
//                                         ),
//                                          SizedBox(
//                                            width: Screens.width(context)*0.6,
//                                             //  height: Screens.bodyheight(context) * 0.06,
//                                              height: Screens.bodyheight(context) * 0.1,
//                                           //  height: Screens.bodyheight(context) * 0.1,
//                                           child: CustomTextField(
//                                             controller: mycontroller[25],
//                                       hintText: '',
//                                       isreadonly:true,
//                                       // // focusNode:focusNode2
//                                       islookingfor: true,
//                                       isUseCustomKeyBoard: true,
                                      
//                                       validator: (value) {
//                                                             if (value!.isEmpty) {
//                                                               return "Enter Looking for";
//                                                             }
//                                                             return null;
//                                                           },
//                                       // onChanged: ,
//                                     ),
                                                 
//                                         ),
//                                         // Stack(
//                                         //   children: [
//                                         //     SizedBox(
//                                         //        width: Screens.width(context)*0.6,
//                                         //       //  height: Screens.bodyheight(context) * 0.1,
//                                         //       child: TextFormField(
//                                         //         readOnly: true,
//                                         //         controller: context.read<CallNotificationController>(). mycontroller[25],
//                                         //         decoration: InputDecoration(
//                                         //           contentPadding: EdgeInsets.symmetric(
//                                         //             horizontal: 10,
//                                         //             vertical: 10
//                                         //           )
//                                         //         ),
//                                         //         onTap: (){
//                                         //            showDialog<dynamic>(
//                                         //                         context: context,
//                                         //                         builder: (_) {
//                                         //                           return ShowSearchDialog(
//                                         //                           );
//                                         //                         }).then((value) {
//                                         //                          context.read<CallNotificationController>()
//                                         //                           .setcatagorydata();    
//                                         //                           });
//                                         //         },
//                                         //          validator: (value) {
//                                         //                     if (value!.isEmpty) {
//                                         //                       return "Enter Looking for";
//                                         //                     }
//                                         //                     return null;
//                                         //                   },
                                                          
//                                         //       ),
//                                         //     ),
//                                         //    Positioned(
//                                         //               top: 0,
//                                         //               left: Screens.width(context) *
//                                         //                   0.5,
//                                         //               child: InkWell(
//                                         //                   onTap: () {
//                                         //                      showDialog<dynamic>(
//                                         //                         context: context,
//                                         //                         builder: (_) {
//                                         //                           return ShowSearchDialog(
//                                         //                           );
//                                         //                         }).then((value) {
//                                         //                          callCon
//                                         //                           .setcatagorydata();    
//                                         //                           });
//                                         //                   },
//                                         //                   child: Container(
//                                         //                       width: Screens.width(
//                                         //                               context) *
//                                         //                           0.1,
//                                         //                       padding: EdgeInsets
//                                         //                           .symmetric(
//                                         //                               vertical: 11,
//                                         //                               horizontal:
//                                         //                                   10),
//                                         //                       //  height: Screens.bodyheight(
//                                         //                       //           context) *
//                                         //                       //       0.08,
//                                         //                       decoration:
//                                         //                           BoxDecoration(
//                                         //                               color: theme
//                                         //                                   .primaryColor,
//                                         //                               borderRadius:
//                                         //                                   BorderRadius
//                                         //                                       .only(
//                                         //                                 topRight: Radius
//                                         //                                     .circular(
//                                         //                                         8),
//                                         //                                 bottomRight:
//                                         //                                     Radius.circular(
//                                         //                                         8),
//                                         //                               )),
//                                         //                       child: Icon(
//                                         //                           Icons.search))))
//                                         //   ],
//                                         // ),
                                     
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                       Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context)*0.25,
//                                           child: Row(
//                                             children: [
//                                               Text("Assigned to",textAlign: TextAlign.start,
//                                               ),
//                                             Text(":",textAlign: TextAlign.center,
//                                             )
//                                             ],
//                                           ),
//                                         ),
                            
//                                         SizedBox(
//                                            width: Screens.width(context)*0.6,
//                                             //  height: Screens.bodyheight(context) * 0.06,
//                                            height: Screens.bodyheight(context) * 0.1,
//                                           child: CustomTextField(
//                                             controller: mycontroller[26],
//                                       hintText: '',
//                                       isreadonly:true,
//                                       isassignto: true,
//                                       isUseCustomKeyBoard: true,
                                      
//                                         validator: (value) {
//                                                             if (value!.isEmpty) {
//                                                               return "Enter Assigned To";
//                                                             }
//                                                             return null;
//                                                           },
//                                       // onChanged: ,
//                                     ),
                                                 
//                                         ),
//                                         //  Stack(
//                                         //    children: [
//                                         //      SizedBox(
//                                         //            width: Screens.width(context)*0.6,
//                                         //           //  height: Screens.bodyheight(context) * 0.1,
//                                         //           child: TextFormField(
//                                         //             controller: callCon. mycontroller[25],
//                                         //             decoration: InputDecoration(
//                                         //               contentPadding: EdgeInsets.symmetric(
//                                         //                 horizontal: 10,
//                                         //                 vertical: 10
//                                         //               )
//                                         //             ),
//                                         //             readOnly: true,
//                                         //             onTap: (){
//                                         //                showDialog<dynamic>(
//                                         //                         context: context,
//                                         //                         builder: (_) {
//                                         //                           return EnqAssignUserDialog(
//                                         //                           );
//                                         //                         }).then((value) {
//                                         //                       callCon.setUserdata();
//                                         //                     });
//                                         //             },
//                                         //               validator: (value) {
//                                         //                     if (value!.isEmpty) {
//                                         //                       return "Enter Assigned To";
//                                         //                     }
//                                         //                     return null;
//                                         //                   },
                                                              
//                                         //           ),
//                                         //         ),
//                                         //  Positioned(
//                                         //               top: 0,
//                                         //               left: Screens.width(context) *
//                                         //                   0.5,
//                                         //               child: InkWell(
//                                         //                   onTap: () {
//                                         //                      showDialog<dynamic>(
//                                         //                         context: context,
//                                         //                         builder: (_) {
//                                         //                           return EnqAssignUserDialog(
//                                         //                         //   callCon2:callCon,
//                                         //                         //  filteruserLtData:  callCon.getfiltergetuserLtData 
//                                         //                           );
//                                         //                         }).then((value) {
//                                         //                       context.read<CallNotificationController>().setUserdata();
//                                         //                     });
//                                         //                   },
//                                         //                   child: Container(
//                                         //                       width: Screens.width(
//                                         //                               context) *
//                                         //                           0.1,
//                                         //                       padding: EdgeInsets
//                                         //                           .symmetric(
//                                         //                               vertical: 11,
//                                         //                               horizontal:
//                                         //                                   10),
//                                         //                       // height: Screens.bodyheight(
//                                         //                       //         context) *
//                                         //                       //     0.08,
//                                         //                       decoration:
//                                         //                           BoxDecoration(
//                                         //                               color: theme
//                                         //                                   .primaryColor,
//                                         //                               borderRadius:
//                                         //                                   BorderRadius
//                                         //                                       .only(
//                                         //                                 topRight: Radius
//                                         //                                     .circular(
//                                         //                                         8),
//                                         //                                 bottomRight:
//                                         //                                     Radius.circular(
//                                         //                                         8),
//                                         //                               )),
//                                         //                       child: Icon(
//                                         //                           Icons.search))))
//                                         //    ],
//                                         //  ),
                                    
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                       Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context)*0.25,
//                                           child: Row(
//                                             children: [
//                                               Text("Description",textAlign: TextAlign.center,
                                             
//                                               ),
//                                             Text(":",textAlign: TextAlign.center,
//                                             )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                            width: Screens.width(context)*0.6,
//                                            height: Screens.bodyheight(context) * 0.1,
//                                           //  color: const Color.fromRGBO(244, 67, 54, 1),
//                                           child: CustomTextField(
//                                             // maxlines: 6,
//                                             controller:mycontroller[24],
//                                       hintText: '',
//                                       isUseCustomKeyBoard: true,
//                                       validator: (value) {
//                                                             if (value!.isEmpty) {
//                                                               return "Enter Description";
//                                                             }
//                                                             return null;
//                                                           },
//                                     ),
//                                           // TextFormField(
//                                           //   maxLines: 6,
//                                           //   decoration: InputDecoration(
//                                           //     // contentPadding: EdgeInsets.symmetric(
//                                           //     //   horizontal: 10,
//                                           //     //   vertical: 10
//                                           //     // )
//                                           //   ),
//                                           // ),
//                                         ),
//                                       ],
//                                     ),
//                                  SizedBox(
//                                       height: Screens.padingHeight(context)*0.01,
//                                     ),
//                                     Container(
                                     
//                                       alignment: Alignment.centerRight,
//                                       child: SizedBox(
//                                          width: Screens.width(context)*0.3,
//                                         child: ElevatedButton(onPressed: (){
//                                           setState(() {
//                                             log("mycontroller[25]::"+ mycontroller[21].text.toString());
//                                           //  focusNode.requestFocus(); 
//                                       validate(mycontroller[21].text,
//                                    mycontroller[22].text,mycontroller[25].text,context.read<CallNotificationController>(). getslpID.toString(),
//                                    mycontroller[24].text
//                                    );
//                                           });
                                          
                                        
//                                         }, child:isloadingBtn==true?Center(child:SizedBox(
//                                           width: Screens.width(context)*0.04,
//                                           height:Screens.padingHeight(context)*0.05,
//                                           child: CircularProgressIndicator(color:Colors.white))): Text("Submit")),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                           ):isshowfollowup==true?
// //second page
// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Container(
//                         child: Text(
//                           followup!,
//                           style: theme.textTheme.bodyText2?.copyWith(
//                             color: getfollowup!.contains(" *")
//                                 ? Colors.red
//                                 : theme.primaryColor,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),

//                         Center(
//                             child: Wrap(
//                                 spacing: 5.0, // width
//                                 runSpacing: 10.0, // height
//                                 children: listContainersphoneTag(
//                                   theme,callCon
//                                 )),
//                           ),
//                            SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                       Container(
//                         child: Text(
//                           "What is the case status now?",
//                           style: theme.textTheme.bodyText2
//                               ?.copyWith(color: theme.primaryColor),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                             Center(
//                             child: Wrap(
//                                 spacing: 7.0, // width
//                                 runSpacing: 10.0, // height
//                                 children: listContainersOpenTag(
//                                   theme,
//                                 )),
//                           ),
//   ],
// ),
// // Text("${context.read<CallNotificationController>().secondleadStatusOpen.length.toString()}"),

// // Text("${callCon.secondleadStatusOpen.length.toString()}"),
//  SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                       // Visibility(
//                       //   visible: context.read<CallNotificationController>().caseStatusSelected == 'Open'
//                       //       ? true
//                       //       : false,
//                       //   child:
//                     isopenstatus ==true?     Column(
//                           children: [
//                             Container(
//                               width: Screens.width(context),
//                               // height: Screens.,
//                               padding:
//                                   EdgeInsets.only(top: 1, left: 10, right: 10),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: DropdownButton(
//                                 hint: Text(
//                                   gethinttextforOpenLead!,
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                       color: gethinttextforOpenLead!
//                                               .contains(" *")
//                                           ? Colors.red
//                                           : Colors.black),
//                                 ),
//                                 value: getvalueChosedStatus,
//                                 //dropdownColor:Colors.green,
//                                 icon: Icon(Icons.arrow_drop_down),
//                                 iconSize: 30,
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 16),
//                                 isExpanded: true,
//                                 onChanged: (val) {
//                                   choosedStatus(val.toString());
//                                 },
//                                 items: leadStatusOpen.map((e) {
//                                   return DropdownMenuItem(
//                                       // ignore: unnecessary_brace_in_string_interps
//                                       value: "${e.code}",
//                                       child: Container(
//                                           // height: Screens.bodyheight(context)*0.1,
//                                           child: Text(e.name.toString())));
//                                 }).toList(),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                           ],
//                         ):
//                       // ),
//                       // Visibility(
//                       //   visible: context.read<CallNotificationController>().caseStatusSelected == 'Won'
//                       //       ? true
//                       //       : false,
//                       //   child:
//                     isclosedstatus ==true?     Column(
//                           children: [
//                             Container(
//                               width: Screens.width(context),
//                               padding:
//                                   EdgeInsets.only(top: 1, left: 10, right: 10),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: DropdownButton(
//                                 hint: Text(
//                                   gethinttextforWonLead!,
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                       color:gethinttextforWonLead!
//                                               .contains(" *")
//                                           ? Colors.red
//                                           : Colors.black),
//                                 ),
//                                 value: valueChosedStatusWon,
//                                 //dropdownColor:Colors.green,
//                                 icon: Icon(Icons.arrow_drop_down),
//                                 iconSize: 30,
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 16),
//                                 isExpanded: true,
//                                 onChanged: (val) {
//                                   choosedStatusWon(val.toString());
//                                 },
//                                 items: leadStatusWon.map((e) {
//                                   return DropdownMenuItem(
//                                       // ignore: unnecessary_brace_in_string_interps
//                                       value: "${e.code}",
//                                       child: Text(e.name.toString()));
//                                 }).toList(),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             CustomTextField(
//                                             // maxlines: 3,
//                                             controller: mycontroller[32],
//                                       hintText: getorderBillRefer!,
//                                       isUseCustomKeyBoard: true,
//                                       // validator: (value) {
//                                       //                       if (value!.isEmpty) {
//                                       //                         return "Enter Description";
//                                       //                       }
//                                       //                       return null;
//                                       //                     },
//                                     ),
                           
//                             // TextFormField(
//                             //   controller: context.read<CallNotificationController>().mycontroller[0],
//                             //   decoration: InputDecoration(
//                             //       enabledBorder: OutlineInputBorder(
//                             //         borderSide:
//                             //             BorderSide(color: Colors.grey[400]!),
//                             //         borderRadius: BorderRadius.circular(6),
//                             //       ),
//                             //       focusedBorder: OutlineInputBorder(
//                             //         borderSide: BorderSide(
//                             //             color: Colors.grey[400]!, width: 2.0),
//                             //         borderRadius: BorderRadius.circular(6),
//                             //       ),
//                             //       hintText: callCon.getorderBillRefer!,
//                             //       hintStyle:
//                             //           theme.textTheme.bodyText2?.copyWith(
//                             //         color:
//                             //             callCon.getorderBillRefer!.contains(" *")
//                             //                 ? Colors.red
//                             //                 : Colors.black,
//                             //         // fontSize: 14
//                             //       ),
//                             //       contentPadding: EdgeInsets.symmetric(
//                             //           vertical: 10, horizontal: 10)),
//                             // ),
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     child: Text(
//                                  getorderBillDate!, // "Next Follow up",
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                     color:
//                                         getorderBillDate!.contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                   ), // fontSize: 12
//                                 )),
//                                 InkWell(
//                                   onTap: getcaseStatusSelected == 'Won'
//                                       ? () {
//                                           showFollowupWonDate(context);
//                                         }
//                                       : null,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Screens.width(context) * 0.015),
//                                     width: Screens.width(context) * 0.5,
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context) * 0.3,
//                                           // color: Colors.red,
//                                           child: Text(
//                                             getnextWonFD,
//                                             //callCon.getnextFD,
//                                             style: theme.textTheme.bodyText2
//                                                 ?.copyWith(), //fontSize: 12
//                                           ),
//                                         ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           width: Screens.width(context) * 0.15,
//                                           // color: Colors.red,
//                                           child: Icon(
//                                             Icons.calendar_month,
//                                             // size: Screens.,
//                                             color: theme.primaryColor,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                           ],
//                         )
//                       :
//                       // Visibility(
//                       //   visible: context.read<CallNotificationController>().getcaseStatusSelected == 'Lost'
//                       //       ? true
//                       //       : false,
//                       //   child: 
//                    isloststatus ==true?         Column(
//                           children: [
//                             Container(
//                               width: Screens.width(context),
//                               padding:
//                                   EdgeInsets.only(top: 1, left: 10, right: 10),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: DropdownButton(
//                                 hint: Text(
//                                   gethinttextforLostLead!,
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                       color:gethinttextforLostLead!
//                                               .contains(" *")
//                                           ? Colors.red
//                                           : Colors.black),
//                                 ),
//                                 value: valueChosedReason,
//                                 //dropdownColor:Colors.green,
//                                 icon: Icon(Icons.arrow_drop_down),
//                                 iconSize: 30,
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 16),
//                                 isExpanded: true,
//                                 onChanged: (val) {
//                                   setState(() {
//                                     choosedReason(val.toString());
//                                   });
//                                 },
//                                 items: leadStatusLost.map((e) {
//                                   return DropdownMenuItem(
//                                       // ignore: unnecessary_brace_in_string_interps
//                                       value: "${e.code}",
//                                       child: Text(e.name.toString()));
//                                 }).toList(),
//                               ),
//                             ),
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                           ],
//                         ):Container()
//                       // ),
 
//  ,Container(
//                         child: Text(
//                           getfeedbackLead!, // "Feedback",
//                           style: theme.textTheme.bodyText2?.copyWith(
//                             color: getfeedbackLead!.contains(" *")
//                                 ? Colors.red
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),

//                       CustomTextField(
//                                             maxlines: 3,
//                                             controller: mycontroller[31],
//                                       hintText: '',
//                                       isUseCustomKeyBoard: true,
//                                       // validator: (value) {
//                                       //                       if (value!.isEmpty) {
//                                       //                         return "Enter Description";
//                                       //                       }
//                                       //                       return null;
//                                       //                     },
//                                     ),
                      
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),


//                       isopenstatus != true
//                           ? Container()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     child: Text(
//                                  getnextFollowupDate!, // "Next Follow up",
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                     color: getnextFollowupDate!
//                                             .contains(" *")
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ), // fontSize: 12
//                                 )),
//                                 InkWell(
//                                   onTap: isopenstatus == true
//                                       ? () {
//                                           showFollowupDate(context);
//                                         }
//                                       : null,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Screens.width(context) * 0.015),
//                                     width: Screens.width(context) * 0.5,
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context) * 0.3,
//                                           // color: Colors.red,
//                                           child: Text(
//                                            getnextFD,
//                                             //fUPCon.getnextFD,
//                                             style: theme.textTheme.bodyText2
//                                                 ?.copyWith(), //fontSize: 12
//                                           ),
//                                         ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           width: Screens.width(context) * 0.15,
//                                           // color: Colors.red,
//                                           child: Icon(
//                                             Icons.calendar_month,
//                                             // size: Screens.,
//                                             color: theme.primaryColor,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),

//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                       isopenstatus != true
//                           ? Container()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     child: Text(
//                                   getnextFollowupTime!, // "Next Follow up",
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                     color: getnextFollowupTime!
//                                             .contains(" *")
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ), // fontSize: 12
//                                 )),
//                                 InkWell(
//                                   onTap: isopenstatus == true
//                                       ? () {
//                                           setState(() {
//                                             selectTime(context);
//                                           });
//                                         }
//                                       : null,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Screens.width(context) * 0.015),
//                                     width: Screens.width(context) * 0.5,
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context) * 0.3,
//                                           // color: Colors.red,
//                                           child: Text(
//                                             getnextFDTime,
//                                             //fUPCon.getnextFD,
//                                             style: theme.textTheme.bodyText2
//                                                 ?.copyWith(), //fontSize: 12
//                                           ),
//                                         ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           width: Screens.width(context) * 0.15,
//                                           // color: Colors.red,
//                                           child: Icon(
//                                             Icons.timer,
//                                             // size: Screens.,
//                                             color: theme.primaryColor,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                              isopenstatus != true
//                           ? Container()
//                           :errorTime.isEmpty?Container():  Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text("${errorTime}",style: theme.textTheme.bodyText2!.copyWith(
//                                 color: Colors.red
//                               ) ,),
//                             ],
//                           ),
//                       // SizedBox(
//                       //   height: Screens.bodyheight(context) * 0.02,
//                       // ),
//                       isopenstatus != true
//                           ? Container()
//                           : Container(
//                               // width: Screens.width(context),
//                               // alignment: Alignment.centerRight,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text('Required Site Visit',
//                                  style:  theme.textTheme.bodyText2?.copyWith(
//                                     color:  Colors.grey,
//                                   ), // fontSize: 12
//                                 ),
//                                   Checkbox(
//                                       value: getsitevisitreq,
//                                       onChanged: ((value) {
//                                         checksitevisit(value!);
//                                       })),
//                                 ],
//                               ),
//                             ),
                            
//                       // SizedBox(
//                       //   height: Screens.bodyheight(context) * 0.01,
//                       // ),
//                       getsitevisitreq==false?Container():
//                       isopenstatus != true
//                           ? Container()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     child: Text(
//                                   getnextVisitDate!, // "Next Follow up",
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                     color:
//                                         getnextVisitDate!.contains(" *")
//                                             ? Colors.red
//                                             : Colors.grey,
//                                   ), // fontSize: 12
//                                 )),
//                                 InkWell(
//                                   onTap: isopenstatus == true
//                                       ? () {
//                                           showVisitDate(context);
//                                         }
//                                       : null,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Screens.width(context) * 0.015),
//                                     width: Screens.width(context) * 0.5,
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context) * 0.3,
//                                           // color: Colors.red,
//                                           child: Text(
//                                             visitDt,
//                                             //fUPCon.getnextFD,
//                                             style: theme.textTheme.bodyText2
//                                                 ?.copyWith(), //fontSize: 12
//                                           ),
//                                         ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           width: Screens.width(context) * 0.15,
//                                           // color: Colors.red,
//                                           child: Icon(
//                                             Icons.calendar_month,
//                                             // size: Screens.,
//                                             color: theme.primaryColor,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),

//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                      getsitevisitreq==false?Container(): isopenstatus != true
//                           ? Container()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                     child: Text(
//                                  nextVisitTime!, // "Next Follow up",
//                                   style: theme.textTheme.bodyText2?.copyWith(
//                                     color: nextVisitTime!.contains(" *")
//                                         ? Colors.red
//                                         : Colors.grey,
//                                   ), // fontSize: 12
//                                 )),
//                                 InkWell(
//                                   onTap: isopenstatus == true
//                                       ? () {
//                                           setState(() {
//                                             selectVisitTime(context);
//                                           });
//                                         }
//                                       : null,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Screens.width(context) * 0.015),
//                                     width: Screens.width(context) * 0.5,
//                                     height: Screens.bodyheight(context) * 0.1,
//                                     decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(4)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           width: Screens.width(context) * 0.3,
//                                           // color: Colors.red,
//                                           child: Text(
//                                             VisitTime,
//                                             //fUPCon.getnextFD,
//                                             style: theme.textTheme.bodyText2
//                                                 ?.copyWith(), //fontSize: 12
//                                           ),
//                                         ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           width: Screens.width(context) * 0.15,
//                                           // color: Colors.red,
//                                           child: Icon(
//                                             Icons.timer,
//                                             // size: Screens.,
//                                             color: theme.primaryColor,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             //
//                             getsitevisitreq==false?Container():  
//                             isopenstatus != true
//                           ? Container()
//                           :errorVisitTime.isEmpty?Text(''):  Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text("${errorVisitTime}",style: theme.textTheme.bodyText2!.copyWith(
//                                 color: Colors.red
//                               ) ,),
//                             ],
//                           ),
//                           //
//                     getsitevisitreq==false?Container():  isopenstatus != true
//                           ? Container()
//                           : SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                               Container(
                                     
//                                       alignment: Alignment.centerRight,
//                                       child: SizedBox(
//                                          width: Screens.width(context)*0.3,
//                                         child: ElevatedButton(onPressed:isLodingDialog==true?
//                                         (){}:
//                                          (){
//                                           setState(() {
//                                             // log("mycontroller[25]::"+context.read<CallNotificationController>(). mycontroller[21].text.toString());
//                                           //  focusNode.requestFocus(); 
//                                       clickLeadSaveBtn(Docentryfinal,Docentryfinal);
//                                           });
                                          
                                        
//                                         }, child:isLodingDialog==true?Center(child: SizedBox(
//                                           height: Screens.padingHeight(context)*0.04,
//                                           width: Screens.width(context)*0.04,
//                                           child: CircularProgressIndicator(color: Colors.white,))): Text("Submit")),
//                                       ),
//                               )
//   ]      
//                             ):
//                             // ListView(
//                             //   children: const [],
//                             // ),
//                       isshowothers ==true?
//                       SingleChildScrollView(
//                         child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       customerDatalist == null
//                                           ? Container()
//                                           : SizedBox(
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.7,
//                                               width:
//                                                   Screens.width(context) * 0.85,
//                                               // color: Colors.grey[300]!,
//                                               child: ListView.builder(
//                                                   itemCount:
//                                                       customerDatalist!.length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int index) {
//                                                     var data =
//                                                         customerDatalist![index];
//                                                     return Container(
//                                                       padding: EdgeInsets.symmetric(
//                                                           horizontal:
//                                                               Screens.width(
//                                                                       context) *
//                                                                   0.01,
//                                                           vertical: Screens
//                                                                   .padingHeight(
//                                                                       context) *
//                                                               0.002),
//                                                       child: Container(
//                                                         width: Screens.width(
//                                                             context),
//                                                         padding: EdgeInsets.symmetric(
//                                                             horizontal:
//                                                                 Screens.width(
//                                                                         context) *
//                                                                     0.02,
//                                                             vertical: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.01),
//                                                         decoration: BoxDecoration(
//                                                             color:
//                                                                 Colors.grey[200],
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(5),
//                                                             border: Border.all(
//                                                                 color: Colors
//                                                                     .black26)),
//                                                         child: Column(children: [
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "Doc Number",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                               Text(
//                                                                 "Doc Date",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "${data.DocNum}",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                               Text(
//                                                                 data.DocDate!
//                                                                         .isEmpty
//                                                                     ? '-'
//                                                                     : config.alignDate(
//                                                                         data.DocDate
//                                                                             .toString()),
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           SizedBox(
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.002,
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "Doc Type",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                               Text(
//                                                                 "Status",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "${data.DocType}",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                               Text(
//                                                                 "${data.Status}",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           SizedBox(
//                                                             height: Screens
//                                                                     .padingHeight(
//                                                                         context) *
//                                                                 0.002,
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 "Assigned To",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                               Text(
//                                                                 "Business Value",
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: Colors
//                                                                             .grey),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                 data.AssignedTo
//                                                                     .toString(),
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                               Text(
//                                                                 config.slpitCurrency22(
//                                                                     data.BusinessValue
//                                                                         .toString()),
//                                                                 style: theme
//                                                                     .textTheme
//                                                                     .bodyMedium!
//                                                                     .copyWith(
//                                                                         color: theme
//                                                                             .primaryColor),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ]),
//                                                       ),
//                                                     );
//                                                   }),
//                                             ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           // SizedBox(
//                                           //   height:
//                                           //       Screens.bodyheight(context) * 0.1,
//                                           //   width: Screens.width(context) * 0.4,
//                                           //   child: ElevatedButton(
//                                           //       style: ElevatedButton.styleFrom(
//                                           //           backgroundColor:
//                                           //               theme.primaryColor,
//                                           //           // side: BorderSide(color: Colors.yellow, width: 5),
//                                           //           shape: RoundedRectangleBorder(
//                                           //               borderRadius:
//                                           //                   BorderRadius.circular(
//                                           //                       10))),
//                                           //       onPressed: () async {
//                                           //         Config config = Config();
//                                           //         String? fcmtoken =
//                                           //             await config.getToken();
//                                           //         await LaunchApp.openApp(
//                                           //           androidPackageName:
//                                           //               'com.example.sellerkitcallerdashboard',
//                                           //           iosUrlScheme:
//                                           //               'pulsesecure://',
//                                           //           appStoreLink:
//                                           //               'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                                           //           // openStore: false
//                                           //         );
//                                           //         // if (_inforeground) {
//                                           //         SelfNotificationSendApi.getData(
//                                           //                 'Add Enquiry',
//                                           //                 fcmtoken!,
//                                           //                 'CallerApp',
//                                           //                 callerList!.mobile!)
//                                           //             .then((value) async {
//                                           //           if (value.sucesscode == 1) {
//                                           //             print('sucess-afterApi');
//                                           //           } else {
//                                           //             print('failure');
//                                           //           }
//                                           //         });
                        
//                                           //         SystemAlertWindow
//                                           //             .closeSystemWindow(
//                                           //                 prefMode: prefMode);
//                                           //       },
//                                           //       child: Text(
//                                           //         'Add Enquiry',
//                                           //         style: theme
//                                           //             .textTheme.bodySmall!
//                                           //             .copyWith(
//                                           //                 color: Colors.white),
//                                           //       )),
//                                           // ),
//                                             Container(
                                     
//                                       alignment: Alignment.centerRight,
//                                       child: SizedBox(
//                                          width: Screens.width(context)*0.3,
//                                         child: ElevatedButton(
//                                           onPressed:() async {
//                                                   Config config = Config();
//                                                   String? fcmtoken =
//                                                       await config.getToken();
//                                                   setState(() {
//                                                     // GetAppAvailabilityStatus
//                                                     //     .isAppInstalled("com.example.sellerkitcallerdashboard");
//                                                   });
//                                                   // await Future.delayed(const Duration(seconds: 2));
//                                                   await LaunchApp.openApp(
//                                                     androidPackageName:
//                                                         'com.example.sellerkitcallerdashboard',
//                                                     iosUrlScheme:
//                                                         'pulsesecure://',
//                                                     appStoreLink:
//                                                         'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                                                     // openStore: false
//                                                   );
                        
//                                                   // if (_inforeground) {
//                                                   SelfNotificationSendApi.getData(
//                                                           'Analyse',
//                                                           fcmtoken!,
//                                                           'CallerApp',
//                                                           callerList!.mobile!)
//                                                       .then((value) async {
//                                                     setState(() {
//                                                       // DashboardPageState.test =
//                                                       //     'asasd';
//                                                     });
                        
//                                                     if (value.sucesscode == 1) {
//                                                     } else {}
//                                                   });
                        
//                                                   SystemAlertWindow
//                                                       .closeSystemWindow(
//                                                           prefMode: prefMode);
//                                                 },
//                                                  child: Text("Analyse")),
//                                       ),
//                               )
//                                           // SizedBox(
//                                           //   height:
//                                           //       Screens.bodyheight(context) * 0.1,
//                                           //   width: Screens.width(context) * 0.8,
//                                           //   child: ElevatedButton(
//                                           //       style: ElevatedButton.styleFrom(
//                                           //           backgroundColor:
//                                           //               theme.primaryColor,
//                                           //           // side: BorderSide(color: Colors.yellow, width: 5),
//                                           //           shape: RoundedRectangleBorder(
//                                           //               borderRadius:
//                                           //                   BorderRadius.circular(
//                                           //                       10))),
//                                           //       onPressed: () async {
//                                           //         Config config = Config();
//                                           //         String? fcmtoken =
//                                           //             await config.getToken();
//                                           //         setState(() {
//                                           //           // GetAppAvailabilityStatus
//                                           //           //     .isAppInstalled("com.example.sellerkitcallerdashboard");
//                                           //         });
//                                           //         // await Future.delayed(const Duration(seconds: 2));
//                                           //         await LaunchApp.openApp(
//                                           //           androidPackageName:
//                                           //               'com.example.sellerkitcallerdashboard',
//                                           //           iosUrlScheme:
//                                           //               'pulsesecure://',
//                                           //           appStoreLink:
//                                           //               'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                                           //           // openStore: false
//                                           //         );
                        
//                                           //         // if (_inforeground) {
//                                           //         SelfNotificationSendApi.getData(
//                                           //                 'Analyse',
//                                           //                 fcmtoken!,
//                                           //                 'CallerApp',
//                                           //                 callerList!.mobile!)
//                                           //             .then((value) async {
//                                           //           setState(() {
//                                           //             // DashboardPageState.test =
//                                           //             //     'asasd';
//                                           //           });
                        
//                                           //           if (value.sucesscode == 1) {
//                                           //           } else {}
//                                           //         });
                        
//                                           //         SystemAlertWindow
//                                           //             .closeSystemWindow(
//                                           //                 prefMode: prefMode);
//                                           //       },
//                                           //       child: Text(
//                                           //         'Analyse',
//                                           //         style: theme
//                                           //             .textTheme.bodySmall!
//                                           //             .copyWith(
//                                           //                 color: Colors.white),
//                                           //       )),
//                                           // ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                       ):Container()
                             
                      
//                           )
//                          )
//                         ],
//                       ),
//                     ),
//                   )
//                 // : Container(
//                 //     color: theme.primaryColor,
//                 //     height: MediaQuery.of(context).size.height,
//                 //     width: MediaQuery.of(context).size.width,
//                 //     child: callerList == null
//                 //         ? const Center(
//                 //             child: CircularProgressIndicator(
//                 //               color: Colors.white,
//                 //             ),
//                 //           )
//                 //         // Column(
//                 //         //     mainAxisAlignment: MainAxisAlignment.center,
//                 //         //     children: [
//                 //         //       InkWell(
//                 //         //         onTap: () {
//                 //         //           // calllog();

//                 //         //           // SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
//                 //         //         },
//                 //         //         child: Icon(Icons.open_in_browser),
//                 //         //       ),
//                 //         //       SizedBox(
//                 //         //         height: 20,
//                 //         //       ),
//                 //         //       InkWell(
//                 //         //         onTap: () {
//                 //         //           // calllog();

//                 //         //           SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
//                 //         //         },
//                 //         //         child: const Center(child: Icon(Icons.close)),
//                 //         //       ),
//                 //         //     ],
//                 //         //   )
//                 //         : Column(
//                 //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               Container(
//                 //                 height: Screens.bodyheight(context) * 0.2,
//                 //                 decoration: BoxDecoration(
//                 //                     // borderRadius: BorderRadius.circular(100),
//                 //                     color: theme.primaryColor),
//                 //                 child: Row(
//                 //                   mainAxisAlignment:
//                 //                       MainAxisAlignment.spaceBetween,
//                 //                   crossAxisAlignment: CrossAxisAlignment.start,
//                 //                   children: [
//                 //                     Padding(
//                 //                       padding: const EdgeInsets.all(10.0),
//                 //                       child: Column(
//                 //                         crossAxisAlignment:
//                 //                             CrossAxisAlignment.start,
//                 //                         children: [
//                 //                           Row(
//                 //                             children: [
//                 //                               Text(
//                 //                                   "${callerList!.name!.capitalize} ",
//                 //                                   style: theme
//                 //                                       .textTheme.bodyLarge!
//                 //                                       .copyWith(
//                 //                                           color: Colors.white,
//                 //                                           fontWeight:
//                 //                                               FontWeight.bold)),
//                 //                               Container(
//                 //                                 alignment: Alignment.topCenter,
//                 //                                 // padding: EdgeInsets.all(
//                 //                                 //     Screens.bodyheight(context) * 0.01),
//                 //                                 // height:
//                 //                                 //     Screens.bodyheight(context) * 0.07,
//                 //                                 // width: Screens.width(context) * 0.2,
//                 //                                 decoration: BoxDecoration(
//                 //                                     color: Colors.yellow[100],
//                 //                                     borderRadius:
//                 //                                         BorderRadius.circular(
//                 //                                             4)),
//                 //                                 child: Text(
//                 //                                   '${callerList!.tag}',
//                 //                                   textAlign: TextAlign.center,
//                 //                                 ),
//                 //                               )
//                 //                             ],
//                 //                           ),
//                 //                           GestureDetector(
//                 //                             onTap: () async {
//                 //                             //  DynamicLinkSelfCreateApi
//                 //                             //           .getDynamicLinkCreateApiData(
//                 //                             //               'Add enquiry')
//                 //                             //       .then((value) async {
//                 //                             //     if (value.dynamiclinkData != null &&
//                 //                             //         value.dynamiclinkData!.shortlink!
//                 //                             //             .isNotEmpty) {
//                 //                             //       if (value.dynamiclinkData!
//                 //                             //           .shortlink!.isNotEmpty) {
//                 //                             //         if (!await launchUrl(
//                 //                             //             Uri.parse(value
//                 //                             //                 .dynamiclinkData!
//                 //                             //                 .shortlink!),
//                 //                             //             mode: LaunchMode
//                 //                             //                 .externalNonBrowserApplication)) {
//                 //                             //           throw 'Could not launch ${value.dynamiclinkData!.shortlink!}';
//                 //                             //         }
//                 //                             //       }
//                 //                             //     }
//                 //                             //   }).then((value) {});
//                 //                               // await LaunchApp.openApp(

//                 //                               //   androidPackageName:
//                 //                               //       'com.example.sellerkitcallerdashboard',
//                 //                               //   iosUrlScheme: 'pulsesecure://',
//                 //                               //   appStoreLink:
//                 //                               //       'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                 //                               //   openStore: false
//                 //                               // );
//                 //                               GetAppAvailabilityStatus
//                 //                                   .openAppInBackground(); //3
//                 //                             },
//                 //                             child: Text(
//                 //                               "+91 ${callerList!.mobile}",
//                 //                               style: const TextStyle(
//                 //                                   fontSize: 14,
//                 //                                   color: Colors.white,
//                 //                                   fontWeight: FontWeight.bold),
//                 //                             ),
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                     IconButton(
//                 //                         padding: EdgeInsets.only(
//                 //                             right: Screens.bodyheight(context) *
//                 //                                 0.08),
//                 //                         onPressed: () {
//                 //                           // callBackFunction("Close");
//                 //                           SystemAlertWindow.closeSystemWindow(
//                 //                               prefMode: prefMode);
//                 //                         },
//                 //                         icon: Icon(
//                 //                           Icons.close,
//                 //                           color: Colors.white,
//                 //                           size: Screens.bodyheight(context) *
//                 //                               0.06,
//                 //                         ))
//                 //                   ],
//                 //                 ),
//                 //               ),
//                 //               Container(
//                 //                 height: Screens.bodyheight(context) * 0.95,
//                 //                 width: MediaQuery.of(context).size.width,
//                 //                 decoration: BoxDecoration(
//                 //                     borderRadius: const BorderRadius.only(
//                 //                         topLeft: Radius.circular(20),
//                 //                         topRight: Radius.circular(20)),
//                 //                     color: Colors.grey[300]!),
//                 //                 child: Column(
//                 //                   mainAxisAlignment:
//                 //                       MainAxisAlignment.spaceEvenly,
//                 //                   children: [
//                 //                     customerDatalist == null
//                 //                         ? Container()
//                 //                         : SizedBox(
//                 //                             height:
//                 //                                 Screens.bodyheight(context) *
//                 //                                     0.7,
//                 //                             width:
//                 //                                 Screens.width(context) * 0.85,
//                 //                             // color: Colors.grey[300]!,
//                 //                             child: ListView.builder(
//                 //                                 itemCount:
//                 //                                     customerDatalist!.length,
//                 //                                 itemBuilder:
//                 //                                     (BuildContext context,
//                 //                                         int index) {
//                 //                                   var data =
//                 //                                       customerDatalist![index];
//                 //                                   return Container(
//                 //                                     padding: EdgeInsets.symmetric(
//                 //                                         horizontal:
//                 //                                             Screens.width(
//                 //                                                     context) *
//                 //                                                 0.01,
//                 //                                         vertical: Screens
//                 //                                                 .padingHeight(
//                 //                                                     context) *
//                 //                                             0.002),
//                 //                                     child: Container(
//                 //                                       width: Screens.width(
//                 //                                           context),
//                 //                                       padding: EdgeInsets.symmetric(
//                 //                                           horizontal:
//                 //                                               Screens.width(
//                 //                                                       context) *
//                 //                                                   0.02,
//                 //                                           vertical: Screens
//                 //                                                   .padingHeight(
//                 //                                                       context) *
//                 //                                               0.01),
//                 //                                       decoration: BoxDecoration(
//                 //                                           color:
//                 //                                               Colors.grey[200],
//                 //                                           borderRadius:
//                 //                                               BorderRadius
//                 //                                                   .circular(5),
//                 //                                           border: Border.all(
//                 //                                               color: Colors
//                 //                                                   .black26)),
//                 //                                       child: Column(children: [
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               "Doc Number",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               "Doc Date",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               "${data.DocNum}",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               data.DocDate!
//                 //                                                       .isEmpty
//                 //                                                   ? '-'
//                 //                                                   : config.alignDate(
//                 //                                                       data.DocDate
//                 //                                                           .toString()),
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                         SizedBox(
//                 //                                           height: Screens
//                 //                                                   .padingHeight(
//                 //                                                       context) *
//                 //                                               0.002,
//                 //                                         ),
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               "Doc Type",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               "Status",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               "${data.DocType}",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               "${data.Status}",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                         SizedBox(
//                 //                                           height: Screens
//                 //                                                   .padingHeight(
//                 //                                                       context) *
//                 //                                               0.002,
//                 //                                         ),
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               "Assigned To",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               "Business Value",
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: Colors
//                 //                                                           .grey),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                         Row(
//                 //                                           mainAxisAlignment:
//                 //                                               MainAxisAlignment
//                 //                                                   .spaceBetween,
//                 //                                           children: [
//                 //                                             Text(
//                 //                                               data.AssignedTo
//                 //                                                   .toString(),
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                             Text(
//                 //                                               config.slpitCurrency22(
//                 //                                                   data.BusinessValue
//                 //                                                       .toString()),
//                 //                                               style: theme
//                 //                                                   .textTheme
//                 //                                                   .bodyMedium!
//                 //                                                   .copyWith(
//                 //                                                       color: theme
//                 //                                                           .primaryColor),
//                 //                                             ),
//                 //                                           ],
//                 //                                         ),
//                 //                                       ]),
//                 //                                     ),
//                 //                                   );
//                 //                                 }),
//                 //                           ),
//                 //                     Row(
//                 //                       mainAxisAlignment:
//                 //                           MainAxisAlignment.spaceEvenly,
//                 //                       children: [
//                 //                         // SizedBox(
//                 //                         //   height:
//                 //                         //       Screens.bodyheight(context) * 0.1,
//                 //                         //   width: Screens.width(context) * 0.4,
//                 //                         //   child: ElevatedButton(
//                 //                         //       style: ElevatedButton.styleFrom(
//                 //                         //           backgroundColor:
//                 //                         //               theme.primaryColor,
//                 //                         //           // side: BorderSide(color: Colors.yellow, width: 5),
//                 //                         //           shape: RoundedRectangleBorder(
//                 //                         //               borderRadius:
//                 //                         //                   BorderRadius.circular(
//                 //                         //                       10))),
//                 //                         //       onPressed: () async {
//                 //                         //         Config config = Config();
//                 //                         //         String? fcmtoken =
//                 //                         //             await config.getToken();
//                 //                         //         await LaunchApp.openApp(
//                 //                         //           androidPackageName:
//                 //                         //               'com.example.sellerkitcallerdashboard',
//                 //                         //           iosUrlScheme:
//                 //                         //               'pulsesecure://',
//                 //                         //           appStoreLink:
//                 //                         //               'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                 //                         //           // openStore: false
//                 //                         //         );
//                 //                         //         // if (_inforeground) {
//                 //                         //         SelfNotificationSendApi.getData(
//                 //                         //                 'Add Enquiry',
//                 //                         //                 fcmtoken!,
//                 //                         //                 'CallerApp',
//                 //                         //                 callerList!.mobile!)
//                 //                         //             .then((value) async {
//                 //                         //           if (value.sucesscode == 1) {
//                 //                         //             print('sucess-afterApi');
//                 //                         //           } else {
//                 //                         //             print('failure');
//                 //                         //           }
//                 //                         //         });

//                 //                         //         SystemAlertWindow
//                 //                         //             .closeSystemWindow(
//                 //                         //                 prefMode: prefMode);
//                 //                         //       },
//                 //                         //       child: Text(
//                 //                         //         'Add Enquiry',
//                 //                         //         style: theme
//                 //                         //             .textTheme.bodySmall!
//                 //                         //             .copyWith(
//                 //                         //                 color: Colors.white),
//                 //                         //       )),
//                 //                         // ),
//                 //                         SizedBox(
//                 //                           height:
//                 //                               Screens.bodyheight(context) * 0.1,
//                 //                           width: Screens.width(context) * 0.8,
//                 //                           child: ElevatedButton(
//                 //                               style: ElevatedButton.styleFrom(
//                 //                                   backgroundColor:
//                 //                                       theme.primaryColor,
//                 //                                   // side: BorderSide(color: Colors.yellow, width: 5),
//                 //                                   shape: RoundedRectangleBorder(
//                 //                                       borderRadius:
//                 //                                           BorderRadius.circular(
//                 //                                               10))),
//                 //                               onPressed: () async {
//                 //                                 Config config = Config();
//                 //                                 String? fcmtoken =
//                 //                                     await config.getToken();
//                 //                                 setState(() {
//                 //                                   // GetAppAvailabilityStatus
//                 //                                   //     .isAppInstalled("com.example.sellerkitcallerdashboard");
//                 //                                 });
//                 //                                 // await Future.delayed(const Duration(seconds: 2));
//                 //                                 await LaunchApp.openApp(
//                 //                                   androidPackageName:
//                 //                                       'com.example.sellerkitcallerdashboard',
//                 //                                   iosUrlScheme:
//                 //                                       'pulsesecure://',
//                 //                                   appStoreLink:
//                 //                                       'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                 //                                   // openStore: false
//                 //                                 );

//                 //                                 // if (_inforeground) {
//                 //                                 SelfNotificationSendApi.getData(
//                 //                                         'Analyse',
//                 //                                         fcmtoken!,
//                 //                                         'CallerApp',
//                 //                                         callerList!.mobile!)
//                 //                                     .then((value) async {
//                 //                                   setState(() {
//                 //                                     // DashboardPageState.test =
//                 //                                     //     'asasd';
//                 //                                   });

//                 //                                   if (value.sucesscode == 1) {
//                 //                                   } else {}
//                 //                                 });

//                 //                                 SystemAlertWindow
//                 //                                     .closeSystemWindow(
//                 //                                         prefMode: prefMode);
//                 //                               },
//                 //                               child: Text(
//                 //                                 'Analyse',
//                 //                                 style: theme
//                 //                                     .textTheme.bodySmall!
//                 //                                     .copyWith(
//                 //                                         color: Colors.white),
//                 //                               )),
//                 //                         ),
//                 //                       ],
//                 //                     )
//                 //                   ],
//                 //                 ),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //   ),
     
//       ],
//     )
 
//                : Container(),
//             );
//           });
//         });
//   }
// List<Widget> listContainersOpenTag(
//     ThemeData theme,
//   ) {
//     return List.generate(
//       context.read<CallNotificationController>().getleadopendata.length,
//       (index) => InkWell(
//         onTap: () {
         
// setState(() {
//   caseStatusSelected = context.read<CallNotificationController>()
//                           .getleadopendata[index]
//                           .name.toString();
//     caseStatusSelectedcode = context.read<CallNotificationController>()
//                           .getleadopendata[index]
//                           .code
//                           .toString();
//                           // log(context.read<CallNotificationController>()
//                           // .caseStatusSelected.toString());

//                           if(caseStatusSelected =="Open"){
//  isopenstatus=true;
// isclosedstatus=false;
//                             isloststatus=false;
// }else if(caseStatusSelected =="Won"){
//                             isopenstatus=false;
//                             isclosedstatus=true;
//                             isloststatus=false;

// }else if(caseStatusSelected =="Lost"){
//  isopenstatus=false;
//                             isclosedstatus=false;
//                             isloststatus=true;
// }
// });

//           //  context.read<CallNotificationController>()
//           //                             .caseStatusSelectBtn( context.read<CallNotificationController>()
//           //                 .getleadopendata[index]
//           //                 .name
//           //                 .toString(), context.read<CallNotificationController>()
//           //                 .getleadopendata[index]
//           //                 .code
//           //                 .toString());
//                                   validatebtnChanged();
        
//         },
//         child: Container(
//          width: Screens.width(context) * 0.26,
//                             height: Screens.bodyheight(context) * 0.1,
//            padding: EdgeInsets.all(7),
//           decoration: BoxDecoration(
//               color: getcaseStatusSelected ==
//                      context.read<CallNotificationController>()
//                           .getleadopendata[index]
//                           .name
//                           .toString()
//                   ?Color(0xffFCF752)//theme.primaryColor.withOpacity(0.5)
//                   : theme.primaryColor,
//               border: Border.all(color: theme.primaryColor, ),
//               borderRadius: BorderRadius.circular(4)),
//           child: Text(
//               context.read<CallNotificationController>()
//                   .getleadopendata[index]
//                   .name
//                   .toString(),
//               maxLines: 10,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//               style: theme.textTheme.bodySmall?.copyWith(
//                 fontSize: 13,
//                 color:
//                     getcaseStatusSelected ==
//                             context.read<CallNotificationController>()
//                                 .getleadopendata[index]
//                                 .name
//                                 .toString()
//                         ? Colors.black //,Colors.white
//                         : Colors.white,
//               )),
          
          
//         ),
//       ),
//     );
//   }

// List<Widget> listContainersphoneTag(
//     ThemeData theme,CallNotificationController callCon
//   ) {
//     return List.generate(
//       context.read<CallNotificationController>().getleadphonedata.length,
//       (index) => InkWell(
//         onTap: () {
//           // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
//           // .getenqReffList[index].Name.toString();
//           selectFollowUp(context.read<CallNotificationController>().getleadphonedata[index]
//               .name
//               .toString(),context.read<CallNotificationController>()
//               .getleadphonedata[index]
//               .code
//               .toString());
//           // log(context.read<LeadNewController>().getisSelectedCsTag.toString());
//           // log(context
//           //     .read<LeadNewController>()
//           //     .getCusTagList[index]
//           //     .Name
//           //     .toString());
//         },
//         child: Container(
//           width: Screens.width(context) * 0.4,
//           height: Screens.bodyheight(context) * 0.1,
//           //  padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               color: getisSelectedFollowUpcode ==
//                      context.watch<CallNotificationController>()
//                           .getleadphonedata[index]
//                           .code
//                           .toString()
//                   ? theme.primaryColor //theme.primaryColor.withOpacity(0.5)
//                   : Colors.white,
//               border: Border.all(color: theme.primaryColor, width: 1),
//               borderRadius: BorderRadius.circular(4)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                   context.read<CallNotificationController>()
//                       .getleadphonedata[index]
//                       .name
//                       .toString(),
//                   maxLines: 8,
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     fontSize: 13,
//                     color:
//                        getisSelectedFollowUpcode ==
//                                context.watch<CallNotificationController>()
//                                     .getleadphonedata[index]
//                                     .code
//                                     .toString()
//                             ? Colors.white //,Colors.white
//                             : theme.primaryColor,
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   List<Widget> listContainersCustomerTag(
//       ThemeData theme, CallNotificationController callCont) {
//     return List.generate(
//       context.read<CallNotificationController>().getCusTagList.length,
//       (index) => InkWell(
//         onTap: () {
//           context.read<CallNotificationController>().selectCsTag(context.read<CallNotificationController>().getCusTagList[index].Code.toString());
//         },
//         child: Container(
//           width: Screens.width(context) * 0.3,
//           height: Screens.bodyheight(context) * 0.045,
//           //  padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               color: context.read<CallNotificationController>().getisSelectedCsTag ==
//                       context.read<CallNotificationController>().getCusTagList[index].Code.toString()
//                   ? const Color(
//                       0xffB299A5) //theme.primaryColor.withOpacity(0.5)
//                   : Colors.white,
//               border: Border.all(color: theme.primaryColor, width: 1),
//               borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(context.read<CallNotificationController>().getCusTagList[index].Name.toString(),
//                   textAlign: TextAlign.center,
//                   maxLines: 8,
//                   overflow: TextOverflow.ellipsis,
//                   style: theme.textTheme.bodySmall?.copyWith(
//                     fontSize: 10,
//                     color: context.read<CallNotificationController>().getisSelectedCsTag ==
//                             context.read<CallNotificationController>().getCusTagList[index].Code.toString()
//                         ? theme.primaryColor //,Colors.white
//                         : theme.primaryColor,
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class GetCallerData {
//   String? name;
//   String? mobile;
//   String? tag;
//   // List<EnqOrderList>? datalist = [];
//   GetCallerData({
//     this.name,
//     this.mobile,
//     this.tag,
//     // this.datalist,
//   });
// }

// // class EnqOrderList {
// //   String? doctype;
// //   String? lastorder;
// //   String? docnum;
// //   String? product;
// //   String? assignto;
// //   String? currentStatus;
// //   String? status;
// //   EnqOrderList({
// //     this.doctype,
// //     this.lastorder,
// //     this.docnum,
// //     this.product,
// //     this.assignto,
// //     this.currentStatus,
// //     this.status,
// //   });
// // }
