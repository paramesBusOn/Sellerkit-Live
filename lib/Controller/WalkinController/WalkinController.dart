// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/Configuration.dart';
import '../../Services/PostQueryApi/WalkinApi/WalkinApi.dart';

class WalkinController extends ChangeNotifier {
  Config config = new Config();
  String isSelectedPurposeOfVisit = '';

  String get getisSelectedPurposeOfVisit => isSelectedPurposeOfVisit;

  String isSelectedDivision = '';

  String get getisSelectedDivision => isSelectedDivision;

  String isSelectedHeadCount = '';

  String get getisSelectedHeadCount => isSelectedHeadCount;

  bool isloadingBtn = false;

  bool get getisloadingBtn => isloadingBtn;

  selectPurposeOfVisit(String selected) {
    isSelectedPurposeOfVisit = selected;
    notifyListeners();
  }

  selectDivision(String selected) {
    isSelectedDivision = selected;
    notifyListeners();
  }

  selectHeadcount(String selected) {
    isSelectedHeadCount = selected;
    notifyListeners();
  }
   List<ItemMasterDBModel> segmentList = [];
   List<ItemMasterDBModel> searchsegmentList = [];
    List<ItemMasterDBModel> get getsegmentList => segmentList;
 getDataFromDB() async {
   final Database db = (await DBHelper.getInstance())!;

   
    segmentList = await DBOperation.getFavData("Segment",db);
    searchsegmentList=segmentList;
    log("segmentList::"+segmentList[0].toString());
    notifyListeners();
  }
   List<ItemMasterDBModel> viewAll = [];
  List<ItemMasterDBModel> get getviewAll => viewAll;
   
  
   isselectedSegment(String selected) {
    if (isSelectedDivision==selected) {
      // segmentList[i].isselected = 1;
     isSelectedDivision='';
     log("isSelectedDivision::"+isSelectedDivision.toString());
     notifyListeners();
    } else {
      // segmentList[i].isselected = 0;
     
     isSelectedDivision=selected;
     notifyListeners();
    }
    // notifyListeners();
  }
  filterList2(String v) {
    if (v.isNotEmpty) {
      searchsegmentList = segmentList
          .where((e) =>
             e.segment.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      searchsegmentList = segmentList;
      notifyListeners();
    }
  }
  callWalkinApi(BuildContext context) {
    if (isSelectedPurposeOfVisit.isEmpty) {
    //  Future.delayed(Duration(seconds: 2), () {
       // config.msgDialog(context, "Field Empty", "Choose Purpose Of Visit");
       // Navigator.pop(context);
     //  config.showSnackBars("Field Empty","Choose Purpose Of Visit",Colors.red);
     // return;
     // });
 showScaffold(context, "Choose Purpose Of Visit");

    } else if (isSelectedDivision.isEmpty) {
      // Future.delayed(Duration(seconds: 2), () {
      //   config.msgDialog(context, "Field Empty", "Choose Division");
      //   Navigator.pop(context);
      // });
      // config.showSnackBars("Field Empty","Choose Division",Colors.red);
 showScaffold(context, "Choose Division");
      return;
    } else if (isSelectedHeadCount.isEmpty) {
      // Future.delayed(Duration(seconds: 2), () {
      //   config.msgDialog(context, "Field Empty", "Choose Head count");
      //   Navigator.pop(context);
      // });
      // config.showSnackBars("Field Empty","Choose Head count",Colors.red);
        showScaffold(context, "Choose Head count");
      return;
    } else {
      isloadingBtn = true;
      notifyListeners();
      //   Future.delayed(Duration(seconds: 5), () {
      //           isloadingBtn = false;
      // notifyListeners();
      //       });
      WalkinApi.getData("${ConstantValues.slpcode}", isSelectedPurposeOfVisit, isSelectedDivision,
              isSelectedHeadCount)
          .then((values) {
        if (values.stcode! >= 200 && values.stcode! <= 210) {
          if (values.userLtData != null) {
            isloadingBtn = false;
            notifyListeners();
            //  config.showSnackBars(values.userLtData![0].actionResponce.toString(),
            //   values.userLtData![0].actionResponseMessage.toString(),Colors.red);
            showScaffold(context, "Success..!");
            clearAllData();
          } else if (values.userLtData == null) {
            isloadingBtn = false;
            notifyListeners();
            //  config.showSnackBars("Some thing wrong",
            //  "Try again..!!",Colors.red);
 showScaffold(context, "Some thing wrong");

          }
          notifyListeners();
        } else if (values.stcode! >= 400 && values.stcode! <= 410) {
          isloadingBtn = false;
          notifyListeners();
            // config.showSnackBars("Some thing wrong",
            //  "Try again..!!",Colors.red);
 showScaffold(context, "Some thing wrong");

        } else if (values.stcode == 500) {
          isloadingBtn = false;
          notifyListeners();
            // config.showSnackBars("Some thing wrong",
            //  "Try again..!!",Colors.red);
 showScaffold(context, "${values.stcode!}..!!Network Issue..\nTry again Later..!!");

        }
      });
    }
  }

  clearAllData() {
    isSelectedPurposeOfVisit = '';
    isSelectedDivision = '';
    isSelectedHeadCount = '';
    notifyListeners();
  }

  showDialog() {}

 
  void showScaffold(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,style: TextStyle(color: Colors.white),),
      duration: Duration(seconds: 2),
    ));
}
}
