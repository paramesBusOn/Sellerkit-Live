import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard1mode.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard2Model.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard3Model.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard4model.dart';
import 'package:sellerkit/Services/ScoreCardApi/ScoreCard1Api.dart';
import 'package:sellerkit/Services/ScoreCardApi/ScoreCard2Api.dart';
import 'package:sellerkit/Services/ScoreCardApi/ScoreCard3Api.dart';
import 'package:sellerkit/Services/ScoreCardApi/ScoreCard4Api.dart';

class ScoreCardController extends ChangeNotifier {
  ScoreCardController() {
    callScoreCard1MonthApi();
    // callScoreCardBranch2Api();
    // callScoreCardSpecial3Api();
    // callScoreCardListApi();
  }
  Config configg = Config();

  bool scoreloading = true;
  bool get getscoreloading => scoreloading;
  List<ScoreCard1Data> monthScore1Data = [];
  List<ScoreCard1Data> get getmonthScore1Data => monthScore1Data;

  List<ScoreCard2Data> branchScore2Data = [];
  List<ScoreCard2Data> get getbranchScore2Data => branchScore2Data;

  List<ScoreCard3Data> specialScore3Data = [];
  List<ScoreCard3Data> get getspecialScore3Data => specialScore3Data;
  List<ScoreCard4Data> listViewData = [];
  List<ScoreCard4Data> get getlistViewData => listViewData;

  String scorecardDataExcep = '';
  String get getscorecardDataExcep => scorecardDataExcep;

  callScoreCard1MonthApi() async {
    notifyListeners();
    await ScoreCardApi1.getScore1Data().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.scorecarddata1 != null) {
          monthScore1Data = value.scorecarddata1!;
        } else if (value.scorecarddata1 == null) {
          scorecardDataExcep = 'No  Data in Topper OF Month Api..!!';
          scoreloading = false;

          print(scorecardDataExcep);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        scorecardDataExcep = 'Something went wrong in Topper OF Month Api..!!';
        scoreloading = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          scorecardDataExcep = 'Check your Internet Connection...!!';
          scoreloading = false;
        } else {
          scorecardDataExcep = 'Something went wrong try again...!!';
          scoreloading = false;
        }
      }
      notifyListeners();
    });
    callScoreCardBranch2Api();
  }

  callScoreCardBranch2Api() async {
    notifyListeners();
    await ScoreCardApi2.getScore2Data().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.scorecarddata2 != null) {
          branchScore2Data = value.scorecarddata2!;
        } else if (value.scorecarddata2 == null) {
          scorecardDataExcep = 'No Data in Branch of Topper Api..!!';
          scoreloading = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        scorecardDataExcep = 'Something went wrong in Branch of Topper..!!';
        scoreloading = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          scorecardDataExcep = 'Check your Internet Connection...!!';
          scoreloading = false;
        } else {
          scorecardDataExcep = 'Something went wrong try again...!!';
          scoreloading = false;
        }
      }
      notifyListeners();
    });
    callScoreCardSpecial3Api();
  }

  callScoreCardSpecial3Api() async {
    notifyListeners();
    await ScoreCardApi3.getScore2Data().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.scorecarddata3 != null) {
          specialScore3Data = value.scorecarddata3!;
        } else if (value.scorecarddata3 == null) {
          scorecardDataExcep = 'No  Data in Special Performer Api..!!';
          scoreloading = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        scorecardDataExcep = 'Something went wrong Special Perfomer Api..!!';
        scoreloading = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          scorecardDataExcep = 'Check your Internet Connection...!!';
          scoreloading = false;
        } else {
          scorecardDataExcep = 'Something went wrong try again...!!';
          scoreloading = false;
        }
      }
      notifyListeners();
    });
    callScoreCardListApi();
  }

  callScoreCardListApi() async {
    notifyListeners();
    await ScoreCardApi4.getScore4Data().then((value) {
      scoreloading = false;
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.scorecarddata4 != null) {
          listViewData = value.scorecarddata4!;
          // scoreloading = false;
        } else if (value.scorecarddata4 == null) {
          scorecardDataExcep = 'No  Data in Position Api..!!';
          // scoreloading = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        scorecardDataExcep = 'Something went wrong in Position Api..!!';
        // scoreloading = false;
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          scorecardDataExcep = 'Check your Internet Connection...!!';
          // scoreloading = false;
        } else {
          scorecardDataExcep = 'Something went wrong try again...!!';
          // scoreloading = false;
        }
      }

      notifyListeners();
    });
  }

  clearvalues() {
    monthScore1Data.clear();
    branchScore2Data.clear();
    specialScore3Data.clear();
    listViewData.clear();
    scorecardDataExcep = '';
    scoreloading = false;
  }
}
