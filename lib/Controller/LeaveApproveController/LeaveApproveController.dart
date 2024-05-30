// import 'package:flutter/cupertino.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Models/LeaveAprovalModel/LeaveAproval.dart';
import 'package:sellerkit/Services/LeaveAproval/leaveappdetailsApi.dart';
import 'package:sellerkit/Services/LeaveAproval/leaveaprovepostApi.dart';
import 'package:sellerkit/Widgets/AlertDilog.dart';
import '../../Constant/Configuration.dart';
import 'package:intl/intl.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Widgets/SucessDialagBox.dart';

class LeaveApproveContoller extends ChangeNotifier {
  Config config = Config();
  init(BuildContext context) {
    clearData();
    getuserdetails(context);
    // setvalue();
  }
String? Errormsg='';
  clearData() {
    leaveid=null;
    Errormsg='';
     leaveapprovedetails.clear();
  leaveopendetails.clear();
  leaveRejectsdetails.clear();
    radioLeavetype = null;
    radioHalfLeavetype = null;
    leaveMode = null;
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    mycontroller[6].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    isapiloading=false;
    notifyListeners();
  }

  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(debugLabel: "leave approve");
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  String? radioLeavetype;
  String? radioHalfLeavetype;

  String? leaveMode;
  resonChoosed(String val) {
    leaveMode = val;
    notifyListeners();
  }
  bool isapiloading=false;
  List<leaveApprovedetails> leaveopendetails=[];
   List<leaveApprovedetails> leaveapprovedetails=[];
    List<leaveApprovedetails> leaveRejectsdetails=[];
setvalues( List<leaveApprovedetails>  leaveaprovedata){
  for(int i=0;i<leaveaprovedata.length;i++){
    if(leaveaprovedata[i].status ==0){
      leaveopendetails.add(leaveApprovedetails(
        endDate: leaveaprovedata[i].endDate, 
        halfDay: leaveaprovedata[i].halfDay, 
        id: leaveaprovedata[i].id, 
        leaveRequestType: leaveaprovedata[i].leaveRequestType, 
        leavetype: leaveaprovedata[i].leavetype, 
        noOfleaveReqDays: leaveaprovedata[i].noOfleaveReqDays, 
        reason: leaveaprovedata[i].reason, 
        reportingTo: leaveaprovedata[i].reportingTo, 
        slpCode: leaveaprovedata[i].slpCode, 
        startDate: leaveaprovedata[i].startDate, 
        status: leaveaprovedata[i].status, 
        userCode: leaveaprovedata[i].userCode, 
        userName: leaveaprovedata[i].userName
        ));
    }else if(leaveaprovedata[i].status ==1){
     leaveapprovedetails.add(leaveApprovedetails(
        endDate: leaveaprovedata[i].endDate, 
        halfDay: leaveaprovedata[i].halfDay, 
        id: leaveaprovedata[i].id, 
        leaveRequestType: leaveaprovedata[i].leaveRequestType, 
        leavetype: leaveaprovedata[i].leavetype, 
        noOfleaveReqDays: leaveaprovedata[i].noOfleaveReqDays, 
        reason: leaveaprovedata[i].reason, 
        reportingTo: leaveaprovedata[i].reportingTo, 
        slpCode: leaveaprovedata[i].slpCode, 
        startDate: leaveaprovedata[i].startDate, 
        status: leaveaprovedata[i].status, 
        userCode: leaveaprovedata[i].userCode, 
        userName: leaveaprovedata[i].userName
        )); 
    }else if(leaveaprovedata[i].status == -1){
     leaveRejectsdetails.add(leaveApprovedetails(
        endDate: leaveaprovedata[i].endDate, 
        halfDay: leaveaprovedata[i].halfDay, 
        id: leaveaprovedata[i].id, 
        leaveRequestType: leaveaprovedata[i].leaveRequestType, 
        leavetype: leaveaprovedata[i].leavetype, 
        noOfleaveReqDays: leaveaprovedata[i].noOfleaveReqDays, 
        reason: leaveaprovedata[i].reason, 
        reportingTo: leaveaprovedata[i].reportingTo, 
        slpCode: leaveaprovedata[i].slpCode, 
        startDate: leaveaprovedata[i].startDate, 
        status: leaveaprovedata[i].status, 
        userCode: leaveaprovedata[i].userCode, 
        userName: leaveaprovedata[i].userName
        )); 
    }
  }

}

String lottie='';
getuserdetails(BuildContext context) async {
  leaveapprovedetails.clear();
  leaveopendetails.clear();
  leaveRejectsdetails.clear();
 Errormsg='';
 lottie='';
  isapiloading=true;
  
  notifyListeners();
    await LeaveApprovedetailApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.leaveapprovedetails != null) {
          // leaveapprovedetails = value.leaveapprovedetails!;
         
          isapiloading=false;
          Errormsg='';
           setvalues(value.leaveapprovedetails!);
  notifyListeners();
          // setvalue(value.leaveapprovedetails!);
        } else if (value.leaveapprovedetails == null) {
          lottie='Assets/no-data.png';
         Errormsg='No Data';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // isloadingBtn = false;
        notifyListeners();
        lottie='';
        callAlertDialog3(context, 'Some thing wrong..!!\n..!!');
      } else if (value.stcode! >= 500) {
        // isloadingBtn = false;
        notifyListeners();
          lottie='Assets/NetworkAnimation.json';
        callAlertDialog3(context, 'Network Issue..\nTry again Later..!!');
      }
    });
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
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
  }
  void StartAndEndDate(BuildContext context, String dayType) {
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
      // apiFDate =
      //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiFDate);
      if (dayType == "Start Date") {
        mycontroller[1].text = chooseddate;
      } else if (dayType == "End Date") {
        mycontroller[2].text = chooseddate;
      } else if (dayType == "Half Day") {
        mycontroller[3].text = chooseddate;
      } else if (dayType == "Permission") {
        mycontroller[4].text = chooseddate;
      }
      notifyListeners();
    });
  }

  // postorder(int? status,BuildContext context)async{
  //    await LeavepostApproveApi.getData( leaveid,status).then((value) {
  //      if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       log("Success");
  //        callAlertDialog3(context, 'Leave Request Submited');
  //      }
  //      else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       // isloadingBtn = false;
  //       notifyListeners();
  //       callAlertDialog3(context, '${value.exception}');
  //     } else if (value.stcode! >= 500) {
  //       // isloadingBtn = false;
  //       notifyListeners();
  //       callAlertDialog3(context, 'Some thing wrong..!!\nTry again..!!');
  //     }

  //   });
  // }
int? leaveid;
  setReqData(leaveApprovedetails? reqDataList) {
    clearData();
    mycontroller[0].text = reqDataList!.userName.toString();
    leaveid=reqDataList!.id;
    radioLeavetype = reqDataList.leaveRequestType;
    mycontroller[7].text = reqDataList.reason.toString();
    mycontroller[8].text = reqDataList.reportingTo.toString();

    if (reqDataList.leaveRequestType == "Permission") {
      mycontroller[4].text =config.alignTimeleave(reqDataList.startDate.toString());
      mycontroller[5].text = config.alignTimeforleavepermission(reqDataList.startDate.toString());
      mycontroller[6].text = config.alignTimeforleavepermission(reqDataList.endDate.toString());
    } else if (reqDataList.leaveRequestType == "Half Day") {
      mycontroller[3].text =config.alignTimeleave(reqDataList.startDate.toString());
      radioHalfLeavetype = reqDataList.halfDay!.isNotEmpty
          ? reqDataList.halfDay.toString()
          : reqDataList.halfDay.toString();
    } else if (reqDataList.leaveRequestType == "Full Day") {
      leaveMode = reqDataList.leaveRequestType.toString();
      mycontroller[1].text =config.alignTimeleave(reqDataList.startDate.toString()) ;
      mycontroller[2].text =config.alignTimeleave(reqDataList.endDate.toString()) ;
    }
  }
// Config config=Config();
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
        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              timee.minute < TimeOfDay.now().minute) {
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
    } else if (timeType == "End Time") {
      if (mycontroller[5].text.isEmpty) {
        errorTime = "Please Choose Start Time";
        mycontroller[6].text = "";
        notifyListeners();
      } else {
        errorTime = "";
        TimeOfDay timee = TimeOfDay.now();
        final TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: timee,
        );

        if (mycontroller[4].text ==
            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
          if (timee.hour < TimeOfDay.now().hour ||
              timee.minute < TimeOfDay.now().minute) {
            errorTime = "Please Choose Correct Time";
            mycontroller[6].text = "";
            notifyListeners();
          } else {
            errorTime = "";
            mycontroller[6].text = timee.format(context).toString();
          }
        } else {
          errorTime = "";
          mycontroller[6].text = timee.format(context).toString();
        }
      }
    } else {
      mycontroller[11].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }

  setvalue() {
    mycontroller[0].text = "Arun Kumar";
    mycontroller[8].text = "D.Karthik";
    filterListOfReq = listOfReq;
    notifyListeners();
  }

  List<LeaveReqListData> filterListOfReq = [];
  List<LeaveReqListData> listOfReq = [
    LeaveReqListData(
        empId: "A0001",
        empName: "Ram Kumar P",
        leaveType: "Permission",
        fullDayLeaveMode: "",
        startDate: "",
        endDate: "",
        halfDayDate: "",
        firstHalf: "",
        secondHalf: "",
        permissionDate: "23-07-2023",
        startTime: "6:40 PM",
        createdDate: "21-Jul-2023 10:12 PM",
        endTime: "7:40 PM",
        reason: "I Going To Marriage Function So Give Permission",
        managerName: "D Karthik"),
    LeaveReqListData(
        empId: "A0002",
        empName: "Lokesh Kumar P",
        leaveType: "Full Day",
        fullDayLeaveMode: "Casual Leave",
        startDate: "01-08-2023",
        endDate: "03-08-2023",
        halfDayDate: "",
        firstHalf: "",
        secondHalf: "",
        permissionDate: "",
        startTime: "",
        createdDate: "30-Jul-2023 08:12 AM",
        endTime: "",
        reason: "I Going To OutSide So Give Permission",
        managerName: "D Karthik"),
    LeaveReqListData(
        empId: "A0003",
        empName: "Vigneshwaran",
        leaveType: "Half Day",
        fullDayLeaveMode: "",
        startDate: "",
        endDate: "",
        halfDayDate: "03-08-2023",
        firstHalf: "First Half",
        secondHalf: "",
        permissionDate: "",
        startTime: "",
        createdDate: "30-Jul-2023 08:12 AM",
        endTime: "",
        reason: "I Have Personal Issue Today So Give Permission Half Day",
        managerName: "D Karthik"),
  ];

  int noOfDays() {
    if (mycontroller[1].text.isNotEmpty && mycontroller[2].text.isNotEmpty) {
      // int difference = DateTime.parse(mycontroller[1].text).difference(DateTime.parse(mycontroller[2].text)).inDays;
      // final date2 = DateTime.parse(mycontroller[2].text);
      String dateString =mycontroller[1].text ;
log("dateString::"+dateString.toString());
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
  bool isloadingRej=false;
  validateLeaveReq(BuildContext context, String confirmType,int? status)async {
   if(status ==1){
     isloadingAppro=true;
    
    errorTime = "";
  notifyListeners();
   }else {
   isloadingRej=true;
    notifyListeners();
   }
     await LeavepostApproveApi.getData( leaveid,status).then((value) {
       if (value >= 200 && value! <= 210) {
        log("Success");
        if(status ==1){
 isloadingAppro=false;
 notifyListeners();
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Approved ..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
        }else{
 isloadingRej=false;
 notifyListeners();
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Rejected ..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
        }
       

       
       }
       else if (value! >= 400 && value! <= 410) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, '$value..Error');
      } else if (value! >= 500) {
        // isloadingBtn = false;
        notifyListeners();
        callAlertDialog3(context, '$value..No Network..!!\nTry again Later..!!');
      }

    });
    // await Future.delayed(Duration(seconds: 10));
    // if (formkey.currentState!.validate()) {
    // if (confirmType == "Approved") {
      
    // } else {
          
    // }
    // isloadingRej=false;
    // notifyListeners();
  }
  //
  bool isloadingAppro=false;
  validateLeaveAppro(BuildContext contex, String confirmType) async{
    isloadingAppro=true;
    // await Future.delayed(Duration(seconds: 10));

    // errorTime = "";
    // if (formkey.currentState!.validate()) {
    if (confirmType == "Approved") {
      isloadingAppro=false;
      showDialog<dynamic>(
          context: contex,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Approved Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
    } else {
            isloadingAppro=false;
      showDialog<dynamic>(
          context: contex,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Leave Rejected Registered..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.leaveApprList);
      });
    }
    isloadingAppro=false;
    notifyListeners();
  }
}

class LeaveReqListData {
  String? empId;
  String? empName;
  String? leaveType;
  String? fullDayLeaveMode;
  String? startDate;
  String? endDate;
  String? halfDayDate;
  String? firstHalf;
  String? secondHalf;
  String? permissionDate;
  String? startTime;
  String? endTime;
  String? reason;
  String? managerName;
  String? createdDate;

  LeaveReqListData({
    required this.empId,
    required this.empName,
    required this.leaveType,
    required this.fullDayLeaveMode,
    required this.startDate,
    required this.endDate,
    required this.halfDayDate,
    required this.firstHalf,
    required this.secondHalf,
    required this.permissionDate,
    required this.startTime,
    required this.endTime,
    required this.createdDate,
    required this.reason,
    required this.managerName,
  });
}
