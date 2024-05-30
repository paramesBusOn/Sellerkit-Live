// import 'package:flutter/cupertino.dart';
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Models/LeavereqModel/GetAllreqmodel.dart';
import 'package:sellerkit/Services/LeaveReqApi/GetAllleavereq.dart';
import 'package:sellerkit/Services/LeaveReqApi/LeavepostApi.dart';
import 'package:sellerkit/Services/LeaveReqApi/LeavereqgetApi.dart';
import '../../Constant/Configuration.dart';
import 'package:intl/intl.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/LeavereqModel/leavereqgetmodel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Widgets/AlertDilog.dart';
import '../../Widgets/SucessDialagBox.dart';

class LeaveReqContoller extends ChangeNotifier {
  Config config = Config();
  init(BuildContext context) {
    clearData();
    getuserdetails22(context);
  }

  clearData() {
    Errormsg='';
    getallleavereqdetails.clear();
    checkdata=false;
    startDate=false;
    radioLeavetype = null;
    radioHalfLeavetype = null;
    leaveMode = null;
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    notifyListeners();
  }

  clearRadio() {
    isapiloading=false;
    radioLeavetype = null;
    radioHalfLeavetype = null;
    leaveMode = null;
    
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    notifyListeners();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? radioLeavetype;
  String? radioHalfLeavetype;
String? codemanager;
  String? leaveMode;
  resonChoosed(String val) {
    leaveMode = val;
    notifyListeners();
  }

  leavereqgetdetails? leavereqdetails;
  leavereqgetdetails? get getleavereqdetails => leavereqdetails;
  callAlertDialog3(BuildContext context, String mesg) {
    showDialog<dynamic>(
        context: context,
        // barrierDismissible: false,
        builder: (_) {
          return AlertMsg(
            msg: '$mesg',
          );
        }).then((value) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
  }
String  Errormsg='';
bool isapiloading=false;

String lottie='';
List<Getallleavereqdetails> getallleavereqdetails=[];
getuserdetails22(BuildContext context) async {

  getallleavereqdetails.clear();
  isapiloading=true;
  lottie='';
  notifyListeners();
    await GetAllLeavereqApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leavereqdetails != null && value.leavereqdetails!.isNotEmpty) {
          // leavereqdetails = value.leavereqdetails;
          getallleavereqdetails=value.leavereqdetails!;
          Errormsg="";
          
          isapiloading=false;
          notifyListeners();
          // setvalue(value.leavereqdetails);
        } else if (value.leavereqdetails == null ||value.leavereqdetails!.isEmpty) {
          Errormsg="No Data..!!";
          lottie='Assets/no-data.png';
           isapiloading=false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // isloadingBtn = false;
         lottie='';
        notifyListeners();
         Errormsg="${value.stcode!} No Data";
           isapiloading=false;
      } else if (value.stcode! >= 500) {
        // isloadingBtn = false;
        notifyListeners();
         lottie='Assets/NetworkAnimation.json';
         Errormsg="${value.stcode!} Network issue ..Try again Later..!!";
           isapiloading=false;
      }
    });
  }
  getuserdetails(BuildContext context) async {
    await LeavereqgetApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leavereqdetails != null) {
          leavereqdetails = value.leavereqdetails;
          setvalue(value.leavereqdetails);
        } else if (value.leavereqdetails == null) {
          callAlertDialog3(context, "No Data..!!");
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, 'Some thing wrong..!!\n..!!');
      } else if (value.stcode! >= 500) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, 'Some thing wrong..!!\nTry again..!!');
      }
    });
  }
  bool startDate =false;

  postleavereqApi(BuildContext context) async {
    Config config2 =  Config();
    if(formkey.currentState!.validate()){
 log("leaveMode"+radioLeavetype.toString());
 
 log("yyyyy"+mycontroller[3].text.toString());
    leavereq leavereqdetails = leavereq();
    leavereqdetails.id=0;
    leavereqdetails.slpcode=ConstantValues.Usercode.toString();
    leavereqdetails.reportto=codemanager;
    leavereqdetails.leavereqtype=radioLeavetype;
    leavereqdetails.leavetype=leaveMode==null?"":leaveMode;
    leavereqdetails.halfDay=radioHalfLeavetype==null?"":radioHalfLeavetype;
    leavereqdetails.noofleavereq=noOfDays();
    leavereqdetails.reason=mycontroller[7].text;
    leavereqdetails.status=0;
    if(radioLeavetype ==null || radioLeavetype!.isEmpty){
      Fluttertoast.showToast(
        msg: "Choose Leave Type..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
// ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Choose Leave Type..!!'),
//             backgroundColor: Colors.red,
//             elevation: 10,
//             behavior: SnackBarBehavior.floating,
//             margin: EdgeInsets.all(5),
//             dismissDirection: DismissDirection.none,
//           ),
//         );
    }
    else if(radioLeavetype =="Half Day" && (radioHalfLeavetype ==null || radioHalfLeavetype!.isEmpty)){
   Fluttertoast.showToast(
        msg: "Choose First Half or Second Half..!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  
  //  ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Choose First Half or Second Half..!!'),
  //           backgroundColor: Colors.red,
  //           elevation: 10,
  //           behavior: SnackBarBehavior.floating,
  //           margin: EdgeInsets.all(5),
  //           dismissDirection: DismissDirection.up,
  //         ),
  //       );   
    }
    else{
 if(radioLeavetype =="Full Day"){
log("mycon1"+mycontroller[1].text);
    
    log("mycon2"+mycontroller[2].text);
    leavereqdetails.startdate=config2.aligndateleavereq(mycontroller[1].text);
    leavereqdetails.enddate=config2.aligndateleavereq(mycontroller[2].text);
    log("mycon1"+leavereqdetails.startdate.toString());
    
    log("mycon2"+leavereqdetails.startdate.toString());

    }else if(radioLeavetype =="Half Day"){
      leavereqdetails.startdate=config2.aligndateforsiteout(mycontroller[3].text);
    leavereqdetails.enddate=config2.aligndateforsiteout(mycontroller[3].text);
    }else if(radioLeavetype =="Permission"){
      leavereqdetails.startdate=config2.alignDateforleave(mycontroller[5].text,mycontroller[4].text);
    leavereqdetails.enddate=config2.alignDateforleave(mycontroller[6].text,mycontroller[4].text);
    }

    await LeavepostreqApi.getData(leavereqdetails).then((value) {
       if (value.stcode! >= 200 && value.stcode! <= 210) {
        log("Success");
         callAlertDialog3(context, 'Leave Request Submitted');
       }
       else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, '${value.exception}');
      } else if (value.stcode! >= 500) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, 'Some thing wrong..!!\nTry again..!!');
      }

    });
    }

    }
    
   

  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  int noOfDays() {
    if (mycontroller[1].text.isNotEmpty && mycontroller[2].text.isNotEmpty) {
      // int difference = DateTime.parse(mycontroller[1].text).difference(DateTime.parse(mycontroller[2].text)).inDays;
      // final date2 = DateTime.parse(mycontroller[2].text);
      String dateString = mycontroller[1].text;

      // Split the date string into day, month, and year parts
      List<String> dateParts = dateString.split("-");
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // Create a DateTime object by parsing the date string
      DateTime dateTime = DateTime(year, month, day);
      //
      String dateString2 = mycontroller[2].text;

      // Split the date string into day, month, and year parts
      List<String> dateParts2 = dateString2.split("-");
      int day2 = int.parse(dateParts2[0]);
      int month2 = int.parse(dateParts2[1]);
      int year2 = int.parse(dateParts2[2]);

      // Create a DateTime object by parsing the date string
      DateTime dateTime2 = DateTime(year2, month2, day2);
      log(dateTime.toString());
      log(dateTime2.toString());

      // int difference = daysBetween(dateTime, dateTime2);
      final difference = dateTime.difference(dateTime2).inDays;

      log("ppp" + difference.toString());
      return difference.abs() + 1;
    } else {
      return 0;
    }
  }
 bool checkdata=true;
String? pickedDate22;
  void StartAndEndDate(BuildContext context, String dayType)async {
    // showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2050),
    // ).then((value) {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
      if (pickedDate == null) {
        return;
      }
      log("pickedDate::"+pickedDate.toString());
      
      String chooseddate = pickedDate.toString();
      mycontroller[2].text='';
       if (dayType == "Start Date"){
 pickedDate22=pickedDate.toString();
       }
      
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      // apiFDate =
      //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiFDate);
      if (dayType == "Start Date") {
        mycontroller[1].text = chooseddate;
        startDate=false;
        notifyListeners();
        log(" mycontroller[1].text mycontroller[1].text mycontroller[1].text::::"+ mycontroller[1].text.toString());
      } else if (dayType == "End Date") {
        DateTime planPurDate;
DateTime Nextfdate;
log("apiNdate::"+pickedDate22.toString());

log("pickedDate::"+pickedDate.toString());
planPurDate=DateTime.parse(pickedDate.toString());
Nextfdate=DateTime.parse(pickedDate22.toString());
log("Nextfdate::"+Nextfdate.toString());
log("planPurDate::"+planPurDate.toString());
if(planPurDate.isBefore(Nextfdate)){
   mycontroller[2].text='';
   checkdata=true;
   notifyListeners();
}else{
  checkdata=false;
   mycontroller[2].text = chooseddate;
   notifyListeners();
}
        
      } else if (dayType == "Half Day") {
        mycontroller[3].text = chooseddate;
        log("mycontroller[3].text:::"+mycontroller[3].text.toString());
      } else if (dayType == "Permission") {
        mycontroller[5].text = "";
        mycontroller[6].text = "";
        mycontroller[4].text = chooseddate;
      }
      notifyListeners();
    // });
  }

  String errorTime = "";
  void selectTime(BuildContext context, String timeType) async {
    // if (mycontroller[10].text.isNotEmpty) {
    errorTime = "";
    if (timeType == "Start Time") {
      TimeOfDay timee = TimeOfDay.now();

      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
     
      if (newTime != null) {
        timee = newTime;
         mycontroller[6].text = "";
        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)
              ) {
            errorTime = "Please Choose Correct Time";
            mycontroller[5].text = "";
            notifyListeners();
            // print("error");
          } else {
            errorTime = "";
            // print("correct11");
            mycontroller[5].text = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          // print("correct22");
          timee = newTime;
          mycontroller[5].text = timee.format(context).toString();
        }

        notifyListeners();
      }
      notifyListeners();
    }
     else if (timeType == "End Time") {
      if (mycontroller[5].text.isEmpty) {
        errorTime = "Please Choose Start Time";
        mycontroller[6].text = "";
        notifyListeners();
      } else {
        log("message0");

        errorTime = "";
        TimeOfDay timee = TimeOfDay.now();
        final TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: timee,
        );
        timee = newTime!;
        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          log("${timee.hour}==${TimeOfDay.now().hour}");
          log("${timee.minute}==${TimeOfDay.now().minute}");

          if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour &&timee.minute < TimeOfDay.now().minute)
              ) {
            log("message1");
            errorTime = "Please Choose Correct Time";
            mycontroller[6].text = "";
            notifyListeners();
          } else {
            final parsedTime = DateFormat('h:mm a').parse(mycontroller[5].text);
            log("---");

            // Format the parsed time to 24-hour format
            final formattedTime = DateFormat('HH:mm').format(parsedTime);
            final hour = int.parse(formattedTime.split(':')[0]);
            final minute = int.parse(formattedTime.split(':')[1]);

            // Create a new TimeOfDay instance
            final timeOfDay = TimeOfDay(hour: hour, minute: minute);

            errorTime = "";
            log("vvvv"+timee.hour.toString() +"jjj"+ timeOfDay.hour.toString()+ "kk"+ timee.minute.toString()+"kk"+ timeOfDay.minute.toString());
            if (timee.hour > timeOfDay.hour ||(timee.hour== timeOfDay.hour &&timee.minute > timeOfDay.minute) ) {
              mycontroller[6].text = timee.format(context).toString();
            } else {
              errorTime = "Please Choose Correct Time";
              mycontroller[6].text = "";
              notifyListeners();
            }
          }
        } else {
          final parsedTime = DateFormat('h:mm a').parse(mycontroller[5].text);
          log("---");

          // Format the parsed time to 24-hour format
          final formattedTime = DateFormat('HH:mm').format(parsedTime);
          final hour = int.parse(formattedTime.split(':')[0]);
          final minute = int.parse(formattedTime.split(':')[1]);

          // Create a new TimeOfDay instance
          final timeOfDay = TimeOfDay(hour: hour, minute: minute);

          errorTime = "";
          if (timee.hour > timeOfDay.hour  ||(timee.hour== timeOfDay.hour &&timee.minute > timeOfDay.minute)) {
            mycontroller[6].text = timee.format(context).toString();
          } else {
            errorTime = "Please Choose Correct Time";
            mycontroller[6].text = "";
            notifyListeners();
          }
        }
      }
    } else {
      mycontroller[11].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  setvalue(leavereqgetdetails? leavereqdetails) {
    mycontroller[0].text = leavereqdetails!.username.toString();
    mycontroller[8].text = leavereqdetails.managername.toString();
    codemanager=leavereqdetails.managerslp.toString();
    log("leavereqdetails.managername.toString()" +
        leavereqdetails.managerslp.toString());
    notifyListeners();
  }

  validateLeaveReq(BuildContext contex) {
    errorTime = "";
    if (formkey.currentState!.validate()) {
      print("object");
      showDialog<dynamic>(
          context: contex,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Request Successfully Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    }
    notifyListeners();
  }
}
