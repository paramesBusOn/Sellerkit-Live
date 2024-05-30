import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/EarningModel/Earning2Model.dart';
import 'package:sellerkit/Services/EarningAPI/Earning2API.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Models/EarningModel/EarningNewModel.dart';
import '../../Models/TargetModel/TargetUsersModel.dart';
import '../../Services/EarningAPI/EarningAPI.dart';
import '../../Services/TargetApi/TargetApi/TargetUsersApi.dart';

class EarningController extends ChangeNotifier {
  init() {
    cleardata();
    defaultUserIncentive();
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(3, (i) => new GlobalKey<FormState>());
  List<TextEditingController> dateController =
      List.generate(5, (i) => TextEditingController());
  EarningNewData? earningnewData1;
  EarningNewData? get getearningData1 => earningnewData1;
  List<EarningLineData> earningtableData1 = [];
  List<EarningLineData> get getearningtableData1 => earningtableData1;
  EarningData2? earningData2;
  EarningData2? get getearningData2 => earningData2;

  List<EarningDetLineData> earningloadData = [];
  List<EarningDetLineData> get getearningloadData => earningloadData;

  bool fromerrortextfield = false;
  bool get getfrmerrortextfield => fromerrortextfield;
  bool toerrortextfield = false;
  bool get gettoerrortextfield => toerrortextfield;

  String dateRangeError = '';
  Config config = new Config();

  String apiFromDate = '';
  String apiToDate = '';
  String salesPerName = '';
  String earningexp = '';
  String kpilottie = '';
  String get getearningexp => earningexp;

  bool isloading = true;
  bool get getisloading => isloading;

  bool loaddata = false;
  bool get getloaddata => loaddata;

  bool btnLoadingProgress = false;
  bool get getbtnLoadingProgress => btnLoadingProgress;
  String apiToDate2 = '';
  defaultUserIncentive() {
    Earning1Api.userid = ConstantValues.UserId;
    callEarningApi();
    notifyListeners();
  }

  callEarningApi() async {
    earningexp = '';
    kpilottie = '';
    earningtableData1 = [];
    earningnewData1 = null;
    isloading = true;
    await Earning1Api.getEarningData().then((value) {
      if (value.stcode! >= 200 &&
          // value.stcode! <= 210
          value.exception == null) {
        isloading = false;
        if (value.earningNewData!.incentiveLineData.isNotEmpty) {
          earningnewData1 = value.earningNewData;
          earningtableData1 = earningnewData1!.incentiveLineData;
          log('earningtableData1 length::${earningtableData1.length}');
          notifyListeners();
        } else {
          isloading = false;

          kpilottie = 'Assets/no-data.png';

          log('earningtableData1 length22::${earningtableData1.length}');
          earningexp = "No Data Found..!!";
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
        kpilottie = 'Assets/no-data.png';

        earningexp = "No Data Found..!!";
        notifyListeners();
      } else if (value.stcode == 500) {
        isloading = false;
        kpilottie = 'Assets/NetworkAnimation.json';
        earningexp = "500..!!Network Issue..\nTry again Later..!!'";
        notifyListeners();

        // if (value.exception == 'No route to host') {
        //   earningexp = 'Check your Internet Connection...!!';
        //   isloading = false;
        // } else {
        //   earningexp = 'Something went wrong try again ...!!';
        //   isloading = false;
        // }
      } else {
        isloading = false;

        kpilottie = 'Assets/no-data.png';
        earningexp = "No Data Found..!!";
        notifyListeners();
      }
    });
    // notifyListeners();
    // Config config2 = Config();
    // apiFromDate = config2.currentDate();
    // apiToDate = config2.firstDate();

    // await EarningtableApi.getEarningtableData(apiFromDate, apiToDate)
    //     .then((value) => {
    //           if (value.stcode! >= 200 && value.stcode! <= 210)
    //             {
    //               if (value.earningtabledata != null)
    //                 {
    //                   earningtableData1 = value.earningtabledata!,
    //                   print(
    //                       "earningtableData1[0].transDetails:${earningtableData1[0].transDetails}"),
    //                   notifyListeners(),
    //                 }
    //               else if (value.earningtabledata == null)
    //                 {
    //                   earningexp = 'No  Data in Earning2 table Api..!!',
    //                   isloading = false,
    //                   notifyListeners(),
    //                 }
    //             }
    //           else if (value.stcode! >= 400 && value.stcode! <= 410)
    //             {
    //               isloading = false,
    //               earningexp = 'Some thing went wrong in Earning2 Api..!!',
    //               notifyListeners(),
    //             }
    //           else if (value.stcode == 500)
    //             {
    //               if (value.exception == 'No route to host')
    //                 {
    //                   earningexp = 'Check your Internet Connection...!!',
    //                   isloading = false,
    //                   notifyListeners(),
    //                 }
    //               else
    //                 {
    //                   earningexp = 'Something went wrong try again ...!!',
    //                   isloading = false,
    //                   notifyListeners(),
    //                 }
    //             }
    //         });
    notifyListeners();
  }

  callLoaddata() async {
    btnLoadingProgress = true;
    earningData2 = null;
    earningloadData = [];
    earningtableData1 = [];
    earningexp = '';
    kpilottie = '';
    String userCode = '';
    userCode = Earning1Api.userid;
    log('userCodeuserCode:$userCode');
    await EarningtableApi.getEarningtableData(userCode, apiFromDate, apiToDate)
        .then((value) {
      if (value.stcode == 200 &&
          // value.stcode! <= 210 &&
          value.exception == null) {
        btnLoadingProgress = false;
        earningData2 = value.earningData2;
        earningloadData = earningData2!.incentiveLineData;
        log("earningloadData qqqqqqs:${earningloadData[0].description}");

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        btnLoadingProgress = false;

        kpilottie = 'Assets/no-data.png';
        earningexp = "No Data Found..!!";
        notifyListeners();
      } else if (value.stcode == 500) {
        log('Assets/NetworkAnimation.json');
        kpilottie = 'Assets/NetworkAnimation.json';
        earningexp = "500..!!Network Issue..\nTry again Later..!!'";
        btnLoadingProgress = false;

        notifyListeners();
        // if (value.exception == 'No route to host') {
        //   earningexp = 'Check your Internet Connection...!!';
        //   isloading = false;
        //   notifyListeners();
        // } else {
        //   earningexp = 'Something went wrong try again ...!!';
        //   isloading = false;
        //   notifyListeners();
        // }
      } else {
        btnLoadingProgress = false;
        kpilottie = 'Assets/no-data.png';
        earningexp = "No Data Found..!!";

        notifyListeners();
      }
    });
  }

  dateValidation() {
    log('xxxxxxxyyyyyyy');
    dateRangeError = '';
    DateTime now = DateTime.now();

    String frmDt = config.aligndateleavereq(dateController[2].text.toString());
    String toDt = config.aligndateleavereq(dateController[3].text.toString());
    if (DateTime.parse(frmDt).isBefore(DateTime.parse(toDt)) == true ||
        frmDt == toDt) {
      dateRangeError = '';
    } else if (DateTime.parse(frmDt).isAfter(DateTime.parse(toDt)) == true) {
      kpilottie = '';
      earningexp = '';
      dateRangeError = 'Please choose the correct date';
    } else {
      kpilottie = '';
      earningexp = '';
      dateRangeError = 'Please choose the correct date';
    }
  }

  loadBtnClick() {
    btnLoadingProgress = true;
    String frmDt = config.aligndateleavereq(dateController[2].text.toString());
    String toDt = config.aligndateleavereq(dateController[3].text.toString());

    if (formkey[1].currentState!.validate()) {
      if (dateRangeError.isEmpty) {
        log('xxxx:::${DateTime.parse(frmDt).isBefore(DateTime.parse(toDt))}');
        // if (DateTime.parse(frmDt).isBefore(DateTime.parse(toDt)) == true ||
        //     frmDt == toDt) {
        //   btnLoadingProgress = true;
        //   fromerrortextfield = false;
        //   toerrortextfield = false;
        //   // Future.delayed(Duration(seconds: 1), () {
        //   btnLoadingProgress = false;
        callLoaddata();
      }
      //   notifyListeners();
      //   // });
      // } else {
      //   kpilottie = '';
      //   earningexp = '';
      //   dateRangeError = 'Please choose the correct date';
      // }

      notifyListeners();
    }
    notifyListeners();
  }

  cleardata() {
    targetUserList = [];
    btnLoadingProgress = false;
    salesPerName = '';
    selectedUserId = null;
    earningtableData1 = [];
    earningtableData1.clear();
    dateController = List.generate(5, (i) => TextEditingController());
    earningnewData1 = null;
    earningexp = '';
    dateRangeError = '';
    isloading = true;
    fromerrortextfield = false;
    toerrortextfield = false;
    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    }
    return Future.value(true);
  }

  DateTime? currentBackPressTime2;
  Future<bool> onbackpress2() {
    DateTime now = DateTime.now();
    if (currentBackPressTime2 == null ||
        now.difference(currentBackPressTime2!) > Duration(seconds: 2)) {
      currentBackPressTime2 = now;
      Get.offAllNamed(ConstantRoutes.earnings);
      return Future.value(true);
    }
    return Future.value(true);
  }

  Future<void> refreshData() async {
    earningtableData1.clear();
    earningloadData.clear();
    await callEarningApi();
    notifyListeners();
  }

  Future<void> refreshLoadData() async {
    earningtableData1.clear();
    earningloadData.clear();
    await loadBtnClick();
    notifyListeners();
  }

  datePassed() {
    dateController[2].text = config
        .alignDate(config.findFirstDateOfTheMonth(DateTime.now()).toString());
    dateController[3].text = config.currentPDFDateOnly();
    apiFromDate = config.aligndateleavereq(dateController[2].text);
    apiToDate = config.aligndateleavereq(dateController[3].text);
    callLoaddata();
    notifyListeners();
  }

  loadDataClear() {
    dateController[2].text = '';
    dateController[3].text = '';
    apiFromDate = '';
    apiToDate = '';
    dateRangeError = '';
    loaddata = false;
    earningloadData.clear();
    datePassed();

    log('cleared load data::${dateController[2].text}');
    notifyListeners();
  }

  void showFromDate(BuildContext context) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = dateController[3].text.isNotEmpty
        ? inputFormat.parse(dateController[3].text)
        : DateTime.now();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var date2 = outputFormat.format(date1);
    DateTime formateDate = DateTime.parse(date2);
    DateTime lstDate = formateDate;

    showDatePicker(
            context: context,
            initialDate: lstDate,
            firstDate: DateTime(2010),
            lastDate: lstDate)
        .then((value) {
      if (value == null) {
        return;
      }
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiFromDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      dateController[2].text = chooseddate;
      dateValidation();
      notifyListeners();
    });
  }

  // void dateConversion() {
  //   String originalDate = "01-05-2024";

  //   // Parse the original date string
  //   DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(originalDate);

  //   // Format the parsed date into the desired format
  //   String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

  //   print("Formatted Date: $formattedDate");
  // }

  void showToDate(BuildContext context) {
    String originalDate = dateController[2].text.toString();
    DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(originalDate);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    DateTime parsedDatexx = DateTime.parse(formattedDate);
    print("Formatted Date: $formattedDate");
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: parsedDatexx,
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      apiToDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      dateController[3].text = chooseddate;
      dateValidation();

      notifyListeners();
    });
  }

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    print("date: " + currentDateTime.toString());
    return currentDateTime;
  }

  String loadedDateOnly(String dateapi) {
    var now = DateTime.parse(dateapi);
    String loadDateTime =
        "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    print("datewwww: $loadDateTime");
    return loadDateTime;
  }

  TextEditingController searchcontroller = TextEditingController();
  bool apicall = false;
  List<TargetUserDataModel> targetUserList = [];
  // List<TargetUserDataModel> filterTargetUserList = [];
  String? selectedUserId;

  // filterSearchBoxList(String v) {
  //   log('filterTargetUserList22::${filterTargetUserList.length}');
  //   if (v.isNotEmpty) {
  //     filterTargetUserList = targetUserList
  //         .where((e) => e.name!.toLowerCase().contains(v.toLowerCase()))
  //         .toList();
  //     notifyListeners();
  //   } else if (v.isEmpty) {
  //     filterTargetUserList = targetUserList;
  //     notifyListeners();
  //   }
  // }

  Future callTargetUsersApi(BuildContext context) async {
    targetUserList = [];
    List<TargetUserDataModel> targetUserList2 = [];
    await GetTargetUsersApi.getData().then((value) async {
      isloading = false;
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log('targetUserList111::${value.targetuserDataList!.isEmpty}');

        if (value.targetuserDataList!.isNotEmpty) {
          apicall = true;

          targetUserList2 = value.targetuserDataList!;
          targetUserList2.sort(
              (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
          targetUserList = targetUserList2;

          // filterTargetUserList = targetUserList;
          log('message::${ConstantValues.firstName.toString()}:::${ConstantValues.UserId}');
          searchcontroller.text = ConstantValues.firstName.toString();
          selectedUserId = ConstantValues.UserId;
          // for (var i = 0; i < targetUserList.length; i++) {
          //   // filterTargetUserList[i].checklist = false;
          //   log('iname::::${targetUserList[i].name.toString()} :::${ConstantValues.firstName}');
          //   log('id::::${targetUserList[i].id.toString()} :::${ConstantValues.UserId}');

          // if (targetUserList[i].id.toString() ==
          //         ConstantValues.UserId ||
          //     targetUserList[i].name == ConstantValues.Usercode) {
          //   searchcontroller.text = targetUserList[i].name.toString();
          //   selectedUser = targetUserList[i].name;
          //   log('targetUserList22::${targetUserList.length}');
          // }
          // }
          log('targetUserList222::${targetUserList.length}');

          notifyListeners();
        } else {
          log('targetUserList:333:${targetUserList.length}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User Setup Not Initialised..!!'),
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
              dismissDirection: DismissDirection.up,
            ),
          );

          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong ..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
        isloading = false;
      } else if (value.stcode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Check your Internet Connection..!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );

        isloading = false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong try again ...!!'),
            backgroundColor: Colors.red,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
            dismissDirection: DismissDirection.up,
          ),
        );
        // targetCheckDataExcep = 'Something went wrong try again ...!!';
        isloading = false;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  clearEarningFilterData() {
    searchcontroller.text = '';
    // filterTargetUserList = [];
    targetUserList = [];
    selectedUserId = null;
    isloading = false;
    apicall = false;
    notifyListeners();
  }

  showbottombtn(BuildContext context) {
    if (targetUserList.isNotEmpty) {
      showUserBottomSheet(context);
      notifyListeners();
    }
    notifyListeners();
  }

  applyBtn(BuildContext context) async {
    earningexp = '';
    salesPerName = '';
    earningtableData1 = [];
    isloading = true;
    log('selectedUserId::$selectedUserId');
    for (var i = 0; i < targetUserList.length; i++) {
      if (selectedUserId.toString() == targetUserList[i].id.toString()) {
        salesPerName = targetUserList[i].name.toString();
        Earning1Api.userid = targetUserList[i].id.toString();
        await callEarningApi();
        log("earningexpearningexp::${earningexp}");
        Navigator.pop(context);
      }
    }
  }

  showUserBottomSheet(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, st) {
        return Container(
          color: Colors.white,
          width: Screens.width(context),
          padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.padingHeight(context) * 0.01,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   height: Screens.padingHeight(context) * 0.07,
              //   child: Form(
              //     key: formkey[2],
              //     child: DropdownButtonFormField(
              //       decoration: InputDecoration(
              //         hintText: 'Select User Name',
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.grey),
              //           gapPadding: 0,
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.grey),
              //           gapPadding: 0,
              //         ),
              //         errorBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.red),
              //           gapPadding: 0,
              //         ),
              //         focusedErrorBorder: OutlineInputBorder(
              //           gapPadding: 0,
              //           borderSide: BorderSide(color: Colors.red),
              //         ),
              //       ),
              //       validator: ((value) {
              //         if (value == null) {
              //           return 'Select User Name';
              //         }
              //         return null;
              //       }),
              //       value: selectedUser.toString(),
              //       icon: Icon(Icons.arrow_drop_down),
              //       iconSize: 30,
              //       style: TextStyle(color: Colors.black, fontSize: 16),
              //       isExpanded: true,
              //       onChanged: (val) {
              //         st(
              //           () {
              //             choosedStatus(val.toString());
              //           },
              //         );
              //       },
              //       items: targetUserList.map((e) {
              //         return DropdownMenuItem(
              //             value: '${e.id}', child: Text('${e.name}'));
              //       }).toList(),
              //     ),
              //   ),
              // ),

              Form(
                key: formkey[2],
                child: Container(
                  height: Screens.padingHeight(context) * 0.07,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {},
                    controller: searchcontroller,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Select User Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Select User Name',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.arrow_drop_down, size: 25),
                        onPressed: () {},
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  targetUserList.isEmpty
                      ? Container()
                      : Container(
                          alignment: Alignment.center,
                          height: Screens.bodyheight(context) * 0.25,
                          child: ListView.builder(
                              itemCount: targetUserList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                    onTap: () {
                                      st(
                                        () {
                                          selectedUserId =
                                              targetUserList[i].id.toString();
                                          searchcontroller.text =
                                              targetUserList[i]
                                                  .name!
                                                  .toString();
                                        },
                                      );
                                      disableKeyBoard(context);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.all(
                                              Screens.bodyheight(context) *
                                                  0.008),
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context),
                                          child: Text(
                                            "${targetUserList[i].name}",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ));
                              }),
                        ),
                ],
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: Text("Cancel")),
                  ),
                  Container(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formkey[2].currentState!.validate()) {
                            st(
                              () {
                                applyBtn(context);
                              },
                            );
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: Text("Apply")),
                  ),
                ],
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.04,
              ),
            ],
          ),
        );
      }),
    );
  }

  // showUserBottomSheet(
  //   BuildContext context,
  // ) {
  //   final theme = Theme.of(context);
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => StatefulBuilder(builder: (context, st) {
  //       return SingleChildScrollView(
  //         child: Container(
  //           height: Screens.padingHeight(context) * 0.5,
  //           color: Colors.white,
  //           padding: EdgeInsets.only(
  //               left: Screens.width(context) * 0.02,
  //               right: Screens.width(context) * 0.02,
  //               top: Screens.padingHeight(context) * 0.01,
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: Column(
  //             children: [
  //               Form(
  //                 key: formkey[2],
  //                 child: Container(
  //                   width: Screens.width(context),
  //                   height: Screens.padingHeight(context) * 0.07,
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.symmetric(
  //                       horizontal: Screens.width(context) * 0.005),
  //                   child: TextFormField(
  //                     controller: searchcontroller,
  // onTap: () {
  //   searchcontroller = searchcontroller;

  //   searchcontroller.selection = TextSelection(
  //     baseOffset: 0,
  //     extentOffset: searchcontroller.text.length,
  //   );
  // },
  //                     cursorColor: Colors.grey,
  //                     textDirection: TextDirection.ltr,
  //                     validator: (val) {
  //                       if (val!.isEmpty) {
  //                         return 'Select User Name';
  //                       }
  //                       return null;
  //                     },
  //                     onChanged: ((value) {
  //                       st(
  //                         () {
  //                           filterSearchBoxList(value);
  //                         },
  //                       );
  //                     }),
  //                     decoration: InputDecoration(
  //                       hintText: 'Select User Name',
  //                       suffixIcon: Icon(Icons.arrow_drop_down, size: 25),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey),
  //                       ),
  //                       errorBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.red),
  //                       ),
  //                       focusedErrorBorder: OutlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.red),
  //                       ),
  //                       contentPadding: EdgeInsets.symmetric(
  //                         vertical: 2,
  //                         horizontal: 5,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: Screens.padingHeight(context) * 0.02,
  //               ),
  //               // height: Screens.bodyheight(context) * 0.3,

  //               usernameerror.isNotEmpty
  //                   ? Container(
  //                       padding: EdgeInsets.only(
  //                           left: Screens.width(context) * 0.04),
  //                       alignment: Alignment.centerLeft,
  //                       child: Text(usernameerror,
  //                           style: theme.textTheme.bodyText1
  //                               ?.copyWith(color: theme.primaryColor)),
  //                     )
  //                   : Container(),
  //               SizedBox(
  //                 height: Screens.padingHeight(context) * 0.02,
  //               ),
  //               filterTargetUserList.isEmpty
  //                   ? Container()
  //                   : Expanded(
  //                       child: ListView.builder(
  //                           itemCount: filterTargetUserList.length,
  //                           itemBuilder: (BuildContext context, int i) {
  //                             return CheckboxListTile(
  //                               title: Text('${filterTargetUserList[i].name}'),
  //                               value: filterTargetUserList[i].checklist,

  //                               onChanged: (bool? value) {
  //                                 st(() {
  //                                   filterTargetUserList[i].checklist = value!;
  //                                 });
  //                               },

  //                             );
  //                           }),
  //                     ),

  //               SizedBox(
  //                 height: Screens.padingHeight(context) * 0.04,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: Screens.width(context) * 0.35,
  //                     child: ElevatedButton(
  //                         onPressed: () async {
  //                           Navigator.pop(context);
  //                         },
  //                         style: ButtonStyle(
  //                             shape: MaterialStateProperty.all<
  //                                     RoundedRectangleBorder>(
  //                                 RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(5)))),
  //                         child: Text("Cancel")),
  //                   ),
  //                   Container(
  //                     width: Screens.width(context) * 0.35,
  //                     child: ElevatedButton(
  //                         onPressed: () async {
  //                           if (formkey[2].currentState!.validate()) {
  //                             await applyBtn(context);
  //                           }
  //                           log('earningtableData1 length33::${earningtableData1.length}');
  //                         },
  //                         style: ButtonStyle(
  //                             shape: MaterialStateProperty.all<
  //                                     RoundedRectangleBorder>(
  //                                 RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(5)))),
  //                         child: Text("Apply")),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: Screens.padingHeight(context) * 0.04,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }
}
