// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/DBHelper/DBOperation.dart';
import 'package:sellerkit/Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import 'package:sellerkit/Models/purposeofvistModel/purposeofvisitmodel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Services/AddressGetApi/AddressGetApi.dart';
import 'package:sellerkit/Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import 'package:sellerkit/Services/siteinApi/siteinApi.dart';
import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Models/getvisitmodel/getvisitmodel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Models/siteinModel/siteinmodel.dart';
import '../../Pages/SiteIn/Widgets/WarningDialog.dart';
import '../../Pages/SiteIn/Widgets/successbox.dart';
import '../../Widgets/AlertDilog.dart';

class createSiteInController extends ChangeNotifier {
  init(BuildContext context) async {
    // if(comefromsitein.isNotEmpty){
    // getdata();

//     }else{
// clearAll();
//     }
    clearAll();
    getvisitpurpose();
    
    await stateApicallfromDB();
    determinePosition(context);
  }
  String checkinaddres='';
  String latitude = '';
  String langitude = '';
  String? url;
  String? adrress;
Future<void> determinePosition(BuildContext context) async {
    bool? serviceEnabled;
    latitude = "";
    adrress = "";
    langitude = "";
    LocationPermission permission;
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        try {
          await Geolocator.getCurrentPosition();
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              //return Future.error('Location permissions are denied');
            }
          }
          // await config.getSetup();

          // if (permission == LocationPermission.deniedForever) {}
          // var pos = await Geolocator.getCurrentPosition();
          latitude =
              ConstantValues.latitude == '' || ConstantValues.latitude == 'null'
                  ? '0.0'
                  : ConstantValues.latitude.toString();
          langitude = ConstantValues.langtitude == '' ||
                  ConstantValues.langtitude == 'null'
              ? '0.0'
              : ConstantValues.langtitude.toString();

          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          // adrress=await Geocoder.local.
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value!.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrress = value.results[0].formattedAddress;
              checkinaddres = adrress!;
              log("adress::" + adrress.toString());
              notifyListeners();
            } else {
              print("error:api");
            }
          });

          notifyListeners();
        } catch (e) {
          const snackBar = SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
              content: Text('Please turn on the Location!!..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(
            const Duration(seconds: 2),
            () => Get.back<dynamic>(),
          );
        }
        notifyListeners();
      } else if (serviceEnabled == true) {
        // var pos = await Geolocator.getCurrentPosition();
        // print('lattitude: ' + pos.latitude.toString());
        // await config.getSetup();

        latitude =
            ConstantValues.latitude == '' || ConstantValues.latitude == 'null'
                ? '0.0'
                : ConstantValues.latitude.toString();
        langitude = ConstantValues.langtitude == '' ||
                ConstantValues.langtitude == 'null'
            ? '0.0'
            : ConstantValues.langtitude.toString();

        // longi = langitude;
        // lati = latitude;

        url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

        var lat = double.parse(latitude);
        var long = double.parse(langitude);
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log("value.stcode::" + value.stcode.toString());
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrress =value.results[1].formattedAddress;
            checkinaddres = adrress!;
            // mycontroller[3].text = adrress!;
            log("adress::" + adrress.toString());
            notifyListeners();
          } else {
            print("error:api");
          }
        });

        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      final snackBar =
          SnackBar(backgroundColor: Colors.red, content: Text('$e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    notifyListeners();
  }
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static List<String> comefromsitein = [];
  int? visitid;
  // getdata() {
  //   if (comefromsitein.isNotEmpty) {
  //     visitid = int.parse(comefromsitein[0].toString());
  //     mycontroller[0].text = comefromsitein[1];
  //     mycontroller[1].text = comefromsitein[2];
  //     mycontroller[2].text = comefromsitein[3];
  //     mycontroller[3].text = comefromsitein[4];
  //     mycontroller[4].text = comefromsitein[5];
  //     mycontroller[5].text = comefromsitein[6];
  //     mycontroller[6].text = comefromsitein[7];
  //     mycontroller[7].text = comefromsitein[8];
  //     mycontroller[8].text = comefromsitein[9];
  //     mycontroller[9].text = comefromsitein[10];
  //   }
  // }

  List<visitpurpose> filterpurposeofVisitList = [];
  List<visitpurpose>? purposevisit = [];

  filterListPurposeOfVisit(String v) {
    if (v.isNotEmpty) {
      filterpurposeofVisitList = purposevisit!
          .where((e) => e.description!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterpurposeofVisitList = purposevisit!;
      notifyListeners();
    }
  }

  String statecode = '';
  String countrycode = '';
  String statename = '';
  List<stateHeaderData> stateData = [];
  List<stateHeaderData> filterstateData = [];
  filterListState2(String v) {
    if (v.isNotEmpty) {
      filterstateData = stateData
          .where((e) => e.stateName!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterstateData = filterstateData;
      notifyListeners();
    }
  }

  FocusNode focusNode1 = FocusNode();
  bool isText1Correct = false;
  ontapvalid(BuildContext context) {
    methidstate(mycontroller[8].text);
    FocusScope.of(context).requestFocus(focusNode1);
    statebool = false;
    notifyListeners();
  }

  stateontap(int i) {
    log("AAAA::" + i.toString());
    statebool = false;
    mycontroller[8].text = filterstateData[i].stateName.toString();
    statecode = filterstateData[i].statecode.toString();
    statename = filterstateData[i].stateName.toString();
    countrycode = filterstateData[i].countrycode.toString();
    log("statecode::" + statecode.toString());
    log("statecode::" + countrycode.toString());
    notifyListeners();
  }

  methidstate(String name) {
    log("ANBU");
    statecode = '';
    statename = '';
    countrycode = '';
    for (int i = 0; i < filterstateData.length; i++) {
      if (filterstateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = filterstateData[i].statecode.toString();
        statename = filterstateData[i].stateName.toString();
        countrycode = filterstateData[i].countrycode.toString();

        log("statecode:::" + statecode.toString());
      }
    }
    if (statecode.isEmpty) {
      print("testing");
    }
    //  notifyListeners();
  }

  stateApicallfromDB() async {
    stateData.clear();
    filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    filterstateData = stateData;
    log("getCustomerListFromDB length::" + filterstateData.length.toString());
    notifyListeners();
  }

  bool customerapicalled = false;
  bool get getcustomerapicalled => customerapicalled;
  String? purposecode = '';
  clearAll() {
    basetype=null;
    potential=null;
    Baseid=null;
    meeting='';
    iscomeforupdate=false;
    purposecode = '';
    isText1Correct = false;
    statebool = false;
    customerapicalled = false;
    customerapicLoading = false;
    exceptionOnApiCall = '';
    oldcutomer = false;
    filterpurposeofVisitList.clear();
    purposevisit!.clear();
    // existCusDataList.clear();
    // filterexistCusDataList.clear();
    isAnother == true;
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    // mycontroller[0].clear();
    notifyListeners();
  }

  getvisitpurpose() async{
   await purposeofvisitApi.getOfferZone().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.purposevisit != null) {
          purposevisit = value.purposevisit;
          filterpurposeofVisitList = purposevisit!;
          log("purposevisit::"+purposevisit!.length.toString());
          log("filterpurposeofVisitList::"+filterpurposeofVisitList!.length.toString());
          notifyListeners();
        } else if (value.purposevisit == null) {
          log("NONONDATA");
          notifyListeners();
        }
      }
    });
  }

  iscateSeleted(BuildContext context, String select, String code) {
    mycontroller[9].text = select;
    purposecode = code;
    Navigator.pop(context);
    notifyListeners();
  }

  static List<String> datafrommodify = [];
  checkcomefrom(BuildContext context) async {
    clearAll();

    if (comefromsitein.length > 0) {
      customerapicLoading = true;
      mapvaluesfromvisit(context);
      notifyListeners();
    }
  }

  bool iscomeforupdate = false;
  int? Baseid;
  int? basetype;
  double? potential;
  String? meeting;
  // int? visitid;
  mapvaluesfromvisit(BuildContext context) async {
   await getvisitpurpose();
    await stateApicallfromDB();
    // await catagoryApi();
    notifyListeners();
    iscomeforupdate = true;
    notifyListeners();

    mycontroller[0].text = comefromsitein[2];
    mycontroller[1].text = comefromsitein[1];
    mycontroller[2].text = comefromsitein[3] == null ||
            comefromsitein[3] == "null" ||
            comefromsitein[3].isEmpty
        ? ""
        : comefromsitein[3];
    mycontroller[3].text = comefromsitein[4] == null ||
            comefromsitein[4] == "null" ||
            comefromsitein[4].isEmpty
        ? ""
        : comefromsitein[4];
    mycontroller[4].text = comefromsitein[5] == null ||
            comefromsitein[5] == "null" ||
            comefromsitein[5].isEmpty
        ? ""
        : comefromsitein[5];
    mycontroller[5].text = comefromsitein[6] == null ||
            comefromsitein[6] == "null" ||
            comefromsitein[6].isEmpty
        ? ""
        : comefromsitein[6];
    mycontroller[6].text = comefromsitein[7] == null ||
            comefromsitein[7] == "null" ||
            comefromsitein[7].isEmpty
        ? ""
        : comefromsitein[7];
    mycontroller[7].text = comefromsitein[8] == null ||
            comefromsitein[8] == "null" ||comefromsitein[8] == "0"||
            comefromsitein[8].isEmpty
        ? ""
        : comefromsitein[8];
    mycontroller[8].text = comefromsitein[9] == null ||
            comefromsitein[9] == "null" ||
            comefromsitein[9].isEmpty
        ? ""
        : comefromsitein[9];
    // mycontroller[9].text = datafrommodify[11] == null ||
    //         datafrommodify[11] == "null" ||
    //         datafrommodify[11].isEmpty
    //     ? ""
    //     : datafrommodify[11];
    // mycontroller[16].text = datafrommodify[3] == null ||
    //         datafrommodify[3] == "null" ||
    //         datafrommodify[3].isEmpty
    //     ? ""
    //     : datafrommodify[3];
    mycontroller[11].text = comefromsitein[12] == null ||
            comefromsitein[12] == "null" ||
            comefromsitein[12].isEmpty
        ? ""
        : comefromsitein[12];
    // mycontroller[18].text = comefromsitein[10] == null ||
    //         comefromsitein[10] == "null" ||
    //         comefromsitein[10].isEmpty
    //     ? ""
    //     : comefromsitein[10];
    Baseid = int.parse(comefromsitein[13].toString());
    basetype = int.parse(comefromsitein[14].toString());
    potential = double.parse(comefromsitein[15].toString());
    meeting = comefromsitein[16];

    visitid = int.parse(comefromsitein[0].toString());
    if(comefromsitein[11] != null &&
            comefromsitein[11].isNotEmpty
        ){
          log("comefromsitein[11]"+comefromsitein[11].toString());
for (int i = 0; i < filterpurposeofVisitList!.length; i++) {
      if (filterpurposeofVisitList![i].description == comefromsitein[11]) {
        mycontroller[9].text = filterpurposeofVisitList![i].description.toString();
        purposecode = filterpurposeofVisitList![i].code.toString();
        log(" mycontroller[9].text::"+ mycontroller[9].text.toString());
        notifyListeners();
      }
    }
        }
    
    customerapicLoading = false;
    //  iscateSeleted(context,datafrommodify[11]);
    comefromsitein.clear();

    // productDetails.clear();
    notifyListeners();
  }

  validateCheckIn(BuildContext context) async {
    // final Database db = (await DBHelper.getInstance())!;
    int customerName;
    if (siteInModelDetail != null) {
      log("ANBUDOT");
      customerName = siteInModelDetail!.visitplanid!;
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please Check-Out ${customerName}..!!',
            );
          }).then((value) {
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    } else {
      log("ANBUDOTDOTDOTDOT");
    }
    // List<Map<String, Object?>> serailbatchCheck =
    //     await DBOperation.getValidateCheckIn(db);
    // if (createSiteInController.siteInModelDetail!.visitplanid !=null) {

    // }
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
      Get.offAllNamed(ConstantRoutes.sitein);
    });
  }

  siteInModelDetailsData? siteInModelDetail;
  bool isloding = false;
  bool statebool = false;
  validateSchedule(
    BuildContext context,
  ) async {
    if (formkey.currentState!.validate()) {
      if (statecode.isEmpty && countrycode.isEmpty) {
        isText1Correct = true;
        notifyListeners();
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Select Correct State"),));
      } else {
        Config config = Config();

        isloding = true;
        await Future.delayed(Duration(seconds: 3));

        siteinpatch siteinpatchdata = siteinpatch();
     siteinpatchdata .  checkinaddress=checkinaddres.replaceAll("'", "''");
        siteinpatchdata.customername = mycontroller[0].text;
        siteinpatchdata.add1 =
            mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
        siteinpatchdata.contactname =
            mycontroller[2].text.isEmpty ? null : mycontroller[2].text;
        siteinpatchdata.add2 =
            mycontroller[4].text.isEmpty ? null : mycontroller[4].text;
        siteinpatchdata.area =
            mycontroller[5].text.isEmpty ? null : mycontroller[5].text;
        siteinpatchdata.city =
            mycontroller[6].text.isEmpty ? null : mycontroller[6].text;
        siteinpatchdata.pincode =
            mycontroller[7].text.isEmpty ? 0 : int.parse(mycontroller[7].text);
        siteinpatchdata.state = statecode;
        siteinpatchdata.country = countrycode;
        siteinpatchdata.email =
            mycontroller[11].text.isEmpty ? null : mycontroller[11].text;
        siteinpatchdata.altermobile =
            mycontroller[10].text.isEmpty ? null : mycontroller[10].text;
        // siteinpatchdata.lookingfor =
        //     mycontroller[18].text.isEmpty ? null : mycontroller[18].text;
        if (iscomeforupdate == true) {
          siteinpatchdata.meetingtime = meeting;
          siteinpatchdata.baseid = Baseid;
          siteinpatchdata.basetype = basetype;
          siteinpatchdata.potential=potential;
        } else {
          siteinpatchdata.meetingtime = config.currentDate();
          siteinpatchdata.baseid = 0;
          siteinpatchdata.basetype = -1;
          siteinpatchdata.potential=null;
        }
        siteinpatchdata.customercode = mycontroller[1].text;
        siteinpatchdata.purposeofvisit = purposecode;
        siteinpatchdata.assignslpcode = ConstantValues.Usercode;
        // siteinpatchdata.meetingtime = newdateformat + "T" + newdate;
        siteinpatchdata.createdby = int.parse(ConstantValues.UserId);

        siteinpatchdata;
        siteinpatchdata.visitid =
            visitid==null ? null : visitid;
        log("DATTA" + siteinpatchdata.visitid.toString());
        siteinpatchdata.time = config.currentDate();

        await siteinDetailsApi.getData(siteinpatchdata).then((value) {
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            log("INININ");
            if (value.siteInModelDetail != null) {
              siteInModelDetail = value.siteInModelDetail;
              showDialog<dynamic>(
                  context: context,
                  builder: (_) {
                    return SuccessDialogPG(
                      heading: 'Response',
                      msg: 'Site Checked-In Successfully..!!',
                    );
                  }).then((value) {
                Get.offAllNamed(ConstantRoutes.dashboard);
              });
              notifyListeners();
            } else if (value.siteInModelDetail == null) {
              callAlertDialog3(
                  context, "${value.stcode!} ${value.exception}..!!");
            }
          } else if (value.stcode! >= 400 && value.stcode! <= 410) {
            callAlertDialog3(
                context, "${value.message}..!!${value.exception}....!!");
            notifyListeners();
          } else if (value.stcode! >= 500) {
            callAlertDialog3(
                context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
            notifyListeners();
          }
        });
        isloding = false;
        notifyListeners();
      }
    }
  }

  bool customerapicLoading = false;
  bool get getcustomerapicLoading => customerapicLoading;
  String exceptionOnApiCall = '';
  String get getexceptionOnApiCall => exceptionOnApiCall;
  bool oldcutomer = false;
  bool get getoldcutomer => oldcutomer;

  List<GetCustomerData>? customerdetails;
  List<GetenquiryData>? enquirydetails;
  List<GetenquiryData>? leaddetails;
  List<GetenquiryData>? quotationdetails;
  List<GetenquiryData>? orderdetails;
  clearnum() {
    mycontroller[0].clear();

    mycontroller[2].clear();

    mycontroller[3].clear();

    mycontroller[4].clear();

    mycontroller[5].clear();

    mycontroller[6].clear();

    mycontroller[7].clear();

    mycontroller[8].clear();

    mycontroller[9].clear();

    notifyListeners();
  }
clearwarning() {
  
mycontroller[1].clear();
    mycontroller[0].clear();
    mycontroller[2].clear();
mycontroller[10].clear();
mycontroller[11].clear();
    mycontroller[3].clear();

    mycontroller[4].clear();

    mycontroller[5].clear();

    mycontroller[6].clear();

    mycontroller[7].clear();

    mycontroller[8].clear();

    mycontroller[9].clear();

    notifyListeners();
  }
  callApi(BuildContext context) {
    //
    //fs
    customerapicLoading = true;
    notifyListeners();
    GetCutomerDetailsApi.getData(
            mycontroller[1].text, "${ConstantValues.slpcode}")
        .then((value) {
      //
      // log("value" + value.itemdata.toString());
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          if (value.itemdata!.customerdetails!.isNotEmpty &&
              value.itemdata!.customerdetails != null) {
            customerdetails = value.itemdata!.customerdetails;
            mapValues(value.itemdata!.customerdetails![0]);
            oldcutomer = true;

            notifyListeners();
 if (
                value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;
              alertDialogOpenLeadOREnq(context, "enquiry");
            }
            //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            //             value.itemdata!.orderdetails != null) {
            //                log("Anbuenq");
            //           orderdetails = value.itemdata!.orderdetails;
            //           alertDialogOpenLeadOREnq(context,"Orders");
            //         }
            else if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
              log("Anbulead");
              for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                if(value.itemdata!.enquirydetails![i].DocType =="Lead"){
leaddetails!.add(GetenquiryData(
  DocType: value.itemdata!.enquirydetails![i].DocType, 
  AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
  BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
  CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
  DocDate: value.itemdata!.enquirydetails![i].DocDate, 
  DocNum: value.itemdata!.enquirydetails![i].DocNum, 
  Status: value.itemdata!.enquirydetails![i].Status, 
  Store: value.itemdata!.enquirydetails![i].Store
  ));
                }

              }
              
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                 value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq(context, "Lead");
            } else if (value.itemdata!.enquirydetails!.isNotEmpty &&
                value.itemdata!.enquirydetails != null) {
                  for(int i=0;i<value.itemdata!.enquirydetails!.length;i++){
                if(value.itemdata!.enquirydetails![i].DocType =="Enquiry"){
enquirydetails!.add(GetenquiryData(
  DocType: value.itemdata!.enquirydetails![i].DocType, 
  AssignedTo: value.itemdata!.enquirydetails![i].AssignedTo, 
  BusinessValue: value.itemdata!.enquirydetails![i].BusinessValue, 
  CurrentStatus: value.itemdata!.enquirydetails![i].CurrentStatus, 
  DocDate: value.itemdata!.enquirydetails![i].DocDate, 
  DocNum: value.itemdata!.enquirydetails![i].DocNum, 
  Status: value.itemdata!.enquirydetails![i].Status, 
  Store: value.itemdata!.enquirydetails![i].Store
  ));
                }

              }
              log("Anbuenq");
              enquirydetails = value.itemdata!.enquirydetails;
              AssignedToDialogUserState.LookingFor =
                  value.itemdata!.enquirydetails![0].DocType;
              AssignedToDialogUserState.Store =
                  value.itemdata!.enquirydetails![0].Store;
              AssignedToDialogUserState.handledby =
                  value.itemdata!.enquirydetails![0].AssignedTo;
              AssignedToDialogUserState.currentstatus =
                  value.itemdata!.enquirydetails![0].CurrentStatus;

              alertDialogOpenLeadOREnq(context, "enquiry");
            }
            // if (value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null &&
            //     value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null &&
            //     value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.enquirydetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.enquirydetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.enquirydetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.enquirydetails![0].currentStatus;
            //   alertDialogOpenLeadOREnq(context, "enquiry");
            // }
            // //  else       if (value.itemdata!.orderdetails!.isNotEmpty &&
            // //             value.itemdata!.orderdetails != null) {
            // //                log("Anbuenq");
            // //           orderdetails = value.itemdata!.orderdetails;
            // //           alertDialogOpenLeadOREnq(context,"Orders");
            // //         }
            // else if (value.itemdata!.leaddetails!.isNotEmpty &&
            //     value.itemdata!.leaddetails != null) {
            //   log("Anbulead");
            //   leaddetails = value.itemdata!.leaddetails;
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.leaddetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.leaddetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.leaddetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.leaddetails![0].currentStatus;

            //   alertDialogOpenLeadOREnq(context, "Lead");
            // } else if (value.itemdata!.enquirydetails!.isNotEmpty &&
            //     value.itemdata!.enquirydetails != null) {
            //   log("Anbuenq");
            //   enquirydetails = value.itemdata!.enquirydetails;
            //   AssignedToDialogUserState.LookingFor =
            //       value.itemdata!.enquirydetails![0].lookingfor;
            //   AssignedToDialogUserState.Store =
            //       value.itemdata!.enquirydetails![0].storeCode;
            //   AssignedToDialogUserState.handledby =
            //       value.itemdata!.enquirydetails![0].assignedTo;
            //   AssignedToDialogUserState.currentstatus =
            //       value.itemdata!.enquirydetails![0].currentStatus;

            //   alertDialogOpenLeadOREnq(context, "enquiry");
            // }
          } else {
            oldcutomer = false;
            customerapicLoading = false;
            notifyListeners();
          }
        } else if (value.itemdata == null) {
          oldcutomer = false;
          customerapicLoading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        customerapicLoading = false;
        exceptionOnApiCall = '${value.respCode!}..!! ${value.exception}.. ';
        notifyListeners();
      } else if (value.stcode == 500) {
        customerapicLoading = false;
        exceptionOnApiCall =
            '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
        notifyListeners();
      }
    });
  }

  bool isAnother = true;
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  void alertDialogOpenLeadOREnq(BuildContext context, typeOfDataCus) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          AssignedToDialogUserState.typeOfDataCus = typeOfDataCus;
          // assignto = false;
          return WarningDialog();
        }).then((value) {
      if (isAnother == false) {
        FocusScope.of(context).requestFocus(focusNode2);
      } else {}

      // clearAllData(context);
    });
  }

  mapValues(GetCustomerData itemdata) {
    mycontroller[0].text =
        itemdata.customerName == 'null' ? "" : itemdata.customerName!;
    mycontroller[1].text =
        itemdata.mobileNo == 'null' ? "" : itemdata.mobileNo!;
    mycontroller[2].text = itemdata.contactName.toString().isEmpty ||
            itemdata.contactName == null ||
            itemdata.contactName == "null"
        ? ''
        : itemdata.contactName!;
    mycontroller[3].text = itemdata.Address_Line_1.toString().isEmpty ||
            itemdata.Address_Line_1 == null ||
            itemdata.Address_Line_1 == "null"
        ? ''
        : itemdata.Address_Line_1!;
    mycontroller[4].text = itemdata.Address_Line_2.toString().isEmpty ||
            itemdata.Address_Line_2 == null ||
            itemdata.Address_Line_2 == "null"
        ? ''
        : itemdata.Address_Line_2!;
    mycontroller[7].text = itemdata.Pincode.toString().isEmpty ||
            itemdata.Pincode == null ||
            itemdata.Pincode == "null"
        ? ''
        : itemdata.Pincode!;
    mycontroller[6].text = itemdata.City.toString().isEmpty ||
            itemdata.City == null ||
            itemdata.City == "null"
        ? ''
        : itemdata.City!;
    mycontroller[5].text = itemdata.area.toString().isEmpty ||
            itemdata.area == null ||
            itemdata.area == "null"
        ? ''
        : itemdata.area!;
    mycontroller[8].text = itemdata.State.toString().isEmpty ||
            itemdata.State == null ||
            itemdata.State == "null"
        ? ''
        : itemdata.State!;
    mycontroller[10].text = itemdata.altermobileNo.toString().isEmpty ||
            itemdata.altermobileNo == null ||
            itemdata.altermobileNo == "null"
        ? ''
        : itemdata.altermobileNo!;
    mycontroller[11].text = itemdata.email.toString().isEmpty ||
            itemdata.email == null ||
            itemdata.email == "null"
        ? ''
        : itemdata.email!;
    customerapicLoading = false;
    // isSelectedCsTag = itemdata.tag!;
    notifyListeners();
  }
}
