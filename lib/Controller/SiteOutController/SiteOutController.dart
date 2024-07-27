// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, avoid_init_to_null, use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/Models/getvisitmodel/getvisitmodel.dart';
import 'package:sellerkit/Models/stateModel/stateModel.dart';
import 'package:sellerkit/Pages/OrderBooking/NewOrder.dart';
import 'package:sellerkit/Services/PostQueryApi/ItemMasterApi/ItemCatagoryApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import 'package:sellerkit/Services/getvisitscheduleAPi/getvistitApi.dart';
import 'package:sellerkit/Services/purposeofvisitApi/purposeofvisit.dart';
import 'package:sellerkit/Services/siteOutApi/postsiteoutApi.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../DBHelper/DBHelper.dart';
import '../../DBHelper/DBOperation.dart';
import '../../DBModel/ItemMasertDBModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetCustomerDetailsModel.dart';
import '../../Models/PostQueryModel/EnquiriesModel/GetUserModel.dart';
import '../../Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
import '../../Models/purposeofvistModel/purposeofvisitmodel.dart';
import '../../Models/siteinModel/getsiteinmodel.dart';
import '../../Models/siteoutmodel/siteoutmodel.dart';
import '../../Pages/SiteOut/Widgets/SiteOutCardSuccessBox .dart';
import '../../Pages/SiteOut/Widgets/successbox.dart';
import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Services/PostQueryApi/EnquiriesApi/GetCustomerDetails.dart';
import '../../Services/PostQueryApi/OrdersApi/OrderCheckListApi.dart';
import '../../Services/siteinApi/getsiteinApi.dart';
import '../../Widgets/AlertDilog.dart';
// import '../DayStartEndController/DayStartEndController.dart';
import '../VisitplanController/NewVisitController.dart';

class SiteOutController extends ChangeNotifier {
  Config config = new Config();
  List<TextEditingController> mycontroller =
      List.generate(25, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<File> files = [];
  bool? fileValidation = false;
  List<FilesData> filedata = [];
  List<ItemMasterDBModel> category = [];
  List<ItemMasterDBModel> get getcategory => category;
  bool value = false;
  bool valueOrder = false;
  bool valueLead = false;
  bool valueReceipt = false;
  bool assignTo = false;
  String? selectedRadioValue;

   init(BuildContext context) async {
    clearAll(context);
   await callLeadCheckApi();
  await  getUserAssingData();
    // getData();
   await catagoryApi();
   await getDivisionValues();
   await getvisitpurpose();
    
    // gesiteindata(context);
    determinePosition(context);
  }
bool remswitch = false;
  switchremainder(bool val,String? title) {
    remswitch = val;
    if(remswitch ==true){
      addgoogle(title);
      notifyListeners();
    }
    notifyListeners();
  }
  int? reyear;
int? remonth;
int? reday;
int? rehours;
int? reminutes;
addgoogle(String? title){
   Config config2 = Config();
    tz.TZDateTime? tzChosenDate;
  final DateTime chosenDate = DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
 final tz.Location indian = tz.getLocation('Asia/Kolkata');
         tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
          config2.  addEventToCalendar(tzChosenDate!,"$title","Lead");
}
  iscateSeleted2(BuildContext context, String select) {
    mycontroller[7].text = select;
    Navigator.pop(context);
    notifyListeners();
  }
  List<UserListData> userLtData = [];
  List<UserListData> get getuserLtData => userLtData;
  List<UserListData> filteruserLtData = [];
  List<UserListData> get getfiltergetuserLtData => filteruserLtData;
filterListAssignData(String v) {
    for (int i = 0; i < filteruserLtData.length; i++) {
      filteruserLtData[i].color = 0;
    }
    if (v.isNotEmpty) {
      filteruserLtData = userLtData
          .where((e) => e.UserName!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.s!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteruserLtData = userLtData;
      notifyListeners();
    }
  }
  setUserdata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filteruserLtData = userLtData;

    notifyListeners();
  }
  setdefaultUserName() async {
    mycontroller[16].text = ConstantValues.firstName.toString();
    for (int i = 0; i < filteruserLtData.length; i++) {
      print(
          "object::${filteruserLtData[i].UserName.toString()}==${ConstantValues.firstName.toString()}");
      if (filteruserLtData[i].UserName.toString() ==
          ConstantValues.firstName.toString()) {
        // selectedIdxFUser = i;
        mycontroller[16].text = filteruserLtData[i].UserName.toString();
        selectedIdxFUser = i;
        await selectUser(i);
        notifyListeners();
      }
    }
    notifyListeners();

// selectedIdxFUser = ind;
//           context.read<NewEnqController>().selectUser(ind);
  }
   getUserAssingData() async {
    final Database db = (await DBHelper.getInstance())!;

    userLtData = await DBOperation.getUserList(db);
    filteruserLtData = userLtData;

    notifyListeners();
  }
  List<String> catagorydata = [];
  List<String> filtercatagorydata = [];
  catagoryApi() async {
    catagorydata.clear();
    filtercatagorydata.clear();
    await ItemMasterCatagoryApiNew.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        catagorydata = value.itemdata!;
        filtercatagorydata=catagorydata;
        log("catagorydata::" + catagorydata.length.toString());
      } else {
        log("ANBBBUUUU");
      }
    });
  }
filterListcatagoryData(String v) {
    // for (int i = 0; i < catagorydata.length; i++) {
    //   catagorydata[i].color = 0;
    // }
    if (v.isNotEmpty) {
      filtercatagorydata = catagorydata
          .where((e) => e!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.s!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercatagorydata = catagorydata;
      notifyListeners();
    }
  }
  setcatagorydata() {
//   for(int i=0;i<userLtData.length;i++){
// userLtData[i].color=0;
//   }
    filtercatagorydata = catagorydata;

    notifyListeners();
  }
//Current Loction
  String? longi;
  String? lati;
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
              mycontroller[3].text = adrress!;
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
            mycontroller[3].text = adrress!;
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

  getvisitpurpose() async {
    await purposeofvisitApi.getOfferZone().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.purposevisit != null) {
          purposevisit = value.purposevisit;
          filterpurposeofVisitList = purposevisit!;
          notifyListeners();
        } else if (value.purposevisit == null) {
          log("NONONDATA");
          notifyListeners();
        }
      }
    });
  }

  mapValuestoLead2(
    String? mobile,
  ) {
    
    // log("AAAAA" + docen.toString());
    LeadNewController.datasiteout.clear();
     LeadNewController.datasiteout.add(siteoutDataDetails![0].visitplanid.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].CustomerCode.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].CustomerName.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].CustomerMobile.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].CustomerEmail.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].ContactPerson.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].Address1.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].Address2.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].Area.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].City.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].State.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].Country.toString());
     LeadNewController.datasiteout.add(siteoutDataDetails![0].Pincode.toString());
     

 Get.toNamed(ConstantRoutes.leads);
 notifyListeners();
//     GetCutomerDetailsApi.getData(mobile, "${ConstantValues.slpcode}")
//         .then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.itemdata != null) {
//           //  itemdata = value.itemdata!;

//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.mobileNo==null?'':value.itemdata!.mobileNo.toString());
//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.customerName==null?'':value.itemdata!.customerName.toString());
//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.alternateMobileNo=="null"||value.itemdata!.alternateMobileNo ==null?"": value.itemdata!.alternateMobileNo.toString());
//           // LeadNewController.datasiteout.add(value.itemdata!.email==null?"":value.itemdata!.email.toString());
//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.address1==null?"":value.itemdata!.address1.toString());
//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.address2==null?'':value.itemdata!.address2.toString());
//           // LeadNewController.datasiteout.add(value.itemdata!.city==null?'':value.itemdata!.city.toString());
//           // LeadNewController.datasiteout.add(value.itemdata!.state==null?'':value.itemdata!.state.toString());
//           // LeadNewController.datasiteout
//           //     .add(value.itemdata!.pinCode==null?'':value.itemdata!.pinCode.toString());
//           // LeadNewController.datasiteout.add(value.itemdata!.customerGroup.toString());
//           // // LeadNewController.datasiteout
//           // //     .add(docen.toString());
//           //     LeadNewController.datasiteout
//           //     .add(value.itemdata!.area==null?'':value.itemdata!.area.toString());
//           //  Get.toNamed(ConstantRoutes.ordernew);

//           // log("datataa" + docen.toString());
//           notifyListeners();
//           // LeadNewController.iscomfromLead=true;
         
//         } else if (value.itemdata == null) {
//           //  leadLoadingdialog = false;
// //  excepMsg = 'No Data found...!!';
//           //   forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//           notifyListeners();
//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         // leadLoadingdialog = false;
//         //  excepMsg = 'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
//         // forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//         notifyListeners();
//       } else if (value.stcode == 500) {
//         //  leadLoadingdialog = false;
//         //  excepMsg = 'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
//         //    forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//         notifyListeners();
//       }
//     });
  }
  bool valuecollection = false;

  checkboxselectCollection(bool val, String mobile) {
    isconvertload = true;
    notifyListeners();
    valuecollection = val;

    if (val == true) {
      isconvertload = false;
      mapValuestoCollection(mobile);
      // Get.offAllNamed(ConstantRoutes.ordernew);
    }
    notifyListeners();
  }
mapValuestoCollection(String? mobile) {
    // log("AAAAA" + docen.toString());
    NewCollectionContoller.comefromSiteOut.clear();
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].visitplanid.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].CustomerCode.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].CustomerName.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].CustomerMobile.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].CustomerEmail.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].ContactPerson.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].Address1.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].Address2.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].Area.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].City.toString());
    NewCollectionContoller.comefromSiteOut
        .add(statename.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].Country.toString());
    NewCollectionContoller.comefromSiteOut
        .add(siteoutDataDetails![0].Pincode.toString());

    Get.offAllNamed(ConstantRoutes.newcollection);
    notifyListeners();
  }
  mapValuestoorder2(String? mobile) {
    // log("AAAAA" + docen.toString());
    OrderNewController.datafromsiteout.clear();
 OrderNewController.datafromsiteout.clear();
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].visitplanid.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].CustomerCode.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].CustomerName.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].CustomerMobile.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].CustomerEmail.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].ContactPerson.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].Address1.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].Address2.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].Area.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].City.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].State.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].Country.toString());
     OrderNewController.datafromsiteout.add(siteoutDataDetails![0].Pincode.toString());
     
OrderBookNewState.iscomfromLead = true;

   Get.toNamed(ConstantRoutes.ordernew);
   notifyListeners();
//     GetCutomerDetailsApi.getData(mobile, "${ConstantValues.slpcode}")
//         .then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.itemdata != null) {
//           //  itemdata = value.itemdata!;

//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.mobileNo==null?'':value.itemdata!.mobileNo.toString());
//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.customerName==null?'':value.itemdata!.customerName.toString());
//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.alternateMobileNo=="null"||value.itemdata!.alternateMobileNo ==null?"": value.itemdata!.alternateMobileNo.toString());
//           // OrderNewController.datafromsiteout.add(value.itemdata!.email==null?"":value.itemdata!.email.toString());
//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.address1==null?"":value.itemdata!.address1.toString());
//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.address2==null?'':value.itemdata!.address2.toString());
//           // OrderNewController.datafromsiteout.add(value.itemdata!.city==null?'':value.itemdata!.city.toString());
//           // OrderNewController.datafromsiteout.add(value.itemdata!.state==null?'':value.itemdata!.state.toString());
//           // OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.pinCode==null?'':value.itemdata!.pinCode.toString());
//           // OrderNewController.datafromsiteout.add(value.itemdata!.customerGroup.toString());
//           // // OrderNewController.datafromsiteout
//           // //     .add(docen.toString());
//           //     OrderNewController.datafromsiteout
//           //     .add(value.itemdata!.area==null?'':value.itemdata!.area.toString());
//           //  Get.toNamed(ConstantRoutes.ordernew);

//           // log("datataa" + docen.toString());
//           notifyListeners();
//           OrderBookNewState.iscomfromLead = true;
        
//         } else if (value.itemdata == null) {
//           //  leadLoadingdialog = false;
// //  excepMsg = 'No Data found...!!';
//           //   forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//           notifyListeners();
//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         // leadLoadingdialog = false;
//         //  excepMsg = 'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
//         // forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//         notifyListeners();
//       } else if (value.stcode == 500) {
//         //  leadLoadingdialog = false;
//         //  excepMsg = 'Something went wrong try again\n${value.stcode} ${value.exception}...!!';
//         //    forwardSuccessMsg = 'Some thing wrong \n${value.stcode} ${value.exception}..!!';

//         notifyListeners();
//       }
//     });
  }

  List<OrderCheckData> leadcheckdatas = [];
  List<OrderCheckData> get getleadcheckdatas => leadcheckdatas;
// List<LeadCheckData> leadcheckdatas = [];

  int? customerid;
  List<getsiteInModelData>? getsiteInData;
  bool isloadingmainPage = false;
  List<getvisitdetails> openVisitData = [];
  getallvisitdata(BuildContext context) async {
   await  clearAll(context);
   await  stateApicallfromDB();
   await getUserAssingData();
   await setdefaultUserName();
   
    notifyListeners();
     isloadingmainPage = true;
     log("isloadingmainPage::"+isloadingmainPage.toString());
     notifyListeners();
    await getvisitApi.getdata().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getvisitheaddata!.getvisitdetailsdata != null &&
            value.getvisitheaddata!.getvisitdetailsdata!.isNotEmpty) {
          spilitDatafirst(
              value.getvisitheaddata!.getvisitdetailsdata!, context);
          // isloading = false;
          // Get.toNamed(ConstantRoutes.siteOut);
          notifyListeners();
        } else if (value.getvisitheaddata!.getvisitdetailsdata == null ||
            value.getvisitheaddata!.getvisitdetailsdata!.isEmpty) {
          isloadingmainPage = false;
         await  validateCheckIn(context);
          // val
          // errortabMsg = 'No data..!!';
          // exception = true;
          //       errorMsg = 'No data found..!!';
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingmainPage = false;
        // errortabMsg = '${value.exception}..${value.message}..!!';
        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isloadingmainPage = false;
        // errortabMsg = '${value.exception}..${value.stcode!}..!!';
        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<getvisitdetails> visitdetailsdata = [];
  bool issitein = false;
  spilitDatafirst(
      List<getvisitdetails> getvisitdetailsdata, BuildContext context)async {
    openVisitData.clear();
    for (int i = 0; i < getvisitdetailsdata.length; i++) {
      if (getvisitdetailsdata[i].visitstatus == 'Open') {
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
        log("openVisitData::" + openVisitData.length.toString());
       
        issitein = true;

        notifyListeners();
      }
      
    }
    log("openVisitData::" + issitein.toString());
    if (issitein == true) {
      
      await init(context);
      mapValues(openVisitData[0]);
      isloadingmainPage = false;
     
      notifyListeners();
    } else {
      isloadingmainPage = false;
    await  validateCheckIn(context);
      notifyListeners();
    }
   
    notifyListeners();
  }

  gesiteindata(BuildContext context) async {
    isloadingmainPage = true;
    await GetsiteinApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.getsiteInDetail != null) {
          log("SIteINN");
          customerid = value.getsiteInDetail![0].visitplan;
          getsiteInData = value.getsiteInDetail;
          log("value.getsiteInDetail![0].purposeofvisit!::" +
              value.getsiteInDetail![0].visitplan.toString());
          mycontroller[9].text = value.getsiteInDetail![0].purposeofvisit!;
          callApi(context, value.getsiteInDetail![0].customercode!);
          isloadingmainPage = false;
          Get.toNamed(ConstantRoutes.siteOut);
        } else if (value.getsiteInDetail == null) {
          log("GETVISITDATA");
          isloadingmainPage = false;

          validateCheckIn(context);

          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloadingmainPage = false;

        // exception = true;
        //       errorMsg = 'Some thing went wrong.!';
        notifyListeners();
      } else if (value.stcode == 500) {
        isloadingmainPage = false;

        // datagotByApi = false;
        // exception = true;
        // errorMsg = 'Some thing went wrong..!';
        notifyListeners();
      }
    });
    isloadingmainPage = false;
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
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
  }
List<siteInModelDetailsData>? siteoutDataDetails=[];
  postsiteout(BuildContext context, siteoutpatc siteoutp) async {
    // isloading=true;
    Config config = Config();
    siteout siteoutdata = siteout();
    //
    List<String> filename = [];
    List<String>? fileError = [];
log("filedata::"+filedata.length.toString());
    if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              log("message");
              siteoutdata.attachmenturl1 = value;
            } else if (i == 1) {
              log("message");
              siteoutdata.attachmenturl2 = value;
            } else if (i == 2) {
              siteoutdata.attachmenturl3 = value;
            } else if (i == 3) {
              siteoutdata.attachmenturl4 = value;
            }
            // if (i == 0) {
            //   log("message");
            //   siteoutdata.attachmenturl1 = value;
            // }
          }
        });
      }
    }
    log("filename:::${filedata.length}");

    String errorFiles = "";
    if (fileError != null) {
      for (int i = 0; i < fileError.length; i++) {
        errorFiles += errorFiles + "/";
      }
    }
    //
    String nextvisitdate = '';
    // config.aligndateforsiteout(mycontroller[13].text);
    String nextfollowupdate = '';
      tz.TZDateTime? tzChosenDate;
    // mycontroller[14].text==''?"":config.aligndateforsiteout(mycontroller[14].text);
    siteoutdata.visitid = customerid;
    siteoutdata.lookingFor = mycontroller[7].text;
    siteoutdata.siteoutaddress=mycontroller[3].text.replaceAll("'", "''");
    siteoutdata.nextFollowupDate =
        nextfollowupdate.isEmpty ? '' : nextfollowupdate;
    siteoutdata.nextVisit = nextvisitdate;
    siteoutdata.siteChekOutTime = config.currentDate();
    siteoutdata.visitOutComes = mycontroller[18].text;
    siteoutdata.convertToEnquiry = value == true ? 1 : 0;
    siteoutdata.u_AssignedTo = getslpID == null ? "" : getslpID.toString();
    if (sitevisitreq == true && mycontroller[14].text.isNotEmpty && mycontroller[15].text.isNotEmpty) {
      siteoutdata.revisitby = getslpID;
      String newdateformat = config.alignDatevisit(mycontroller[14].text);
      String newdate = config.alignDateforvisit(mycontroller[15].text);
       rehours=  int.parse(newdate.split(':')[0]);
    reminutes=int.parse(newdate.split(':')[1]);
      siteoutdata.visitdate = newdateformat + "T" + newdate;
      final DateTime chosenDate = DateTime(reyear!, remonth!, reday!, rehours!, reminutes!);
 final tz.Location indian = tz.getLocation('Asia/Kolkata');
         tzChosenDate = tz.TZDateTime.from(chosenDate, indian);
      //  mycontroller[14].text,mycontroller[15].text
    } else {
      siteoutdata.revisitby = null;
      siteoutdata.visitdate = null;
    }
//     if(){
// // String newdateformat = config.remainderonalign(mycontroller[14].text);
// //       String newdate = config.remainderontime(mycontroller[15].text);
      
   
//     log("rehours::"+rehours.toString());
//     log("reminutes::"+reminutes.toString());
    
      
 
//     }

    // getslpID

    await siteOutApi.getData(siteoutdata, siteoutp).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        siteoutDataDetails=value.siteInModelDetail;
        SiteOutSuccessCardState.mobileno = siteoutp.customercode;
        if(sitevisitreq == true){
 config.  addEventToCalendar(tzChosenDate!,"Remainder For VisitPlan on ${mycontroller[14].text} for ${customerName}","${value.message}");
        
        }
         
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SiteOutSuccessCard(),
            ));
        isloading = false;
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // customerapicLoading = false;
        isloading = false;
        callAlertDialog3(context, "${value.message}..!!${value.exception}..!!");
        notifyListeners();
      } else if (value.stcode == 500) {
        // customerapicLoading = false;
        isloading = false;
        callAlertDialog3(context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
        notifyListeners();
      }
    });
  }

  callApi(BuildContext context, String mob) async {
    //
    //fs
    // customerapicLoading = true;
    await GetCutomerDetailsApi.getData(mob, "${ConstantValues.slpcode}")
        .then((value) {
      //

      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          // mapValues(value.itemdata!);

          // oldcutomer = true;
        } else if (value.itemdata == null) {
          // oldcutomer = false;
          // customerapicLoading = false;
          callAlertDialog3(context, "Customer Does Not Exist..!!");
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // customerapicLoading = false;
        callAlertDialog3(context, "Some thing went wrong try again!!");
        // exceptionOnApiCall = 'Some thing went wrong try again!!';
        notifyListeners();
      } else if (value.stcode == 500) {
        // customerapicLoading = false;
        callAlertDialog3(context, "${value.stcode!}..!!Network Issue..\nTry again Later..!!");
        notifyListeners();
      }
    });
  }
  List<stateHeaderData> stateData = [];
  stateApicallfromDB() async {
    stateData.clear();
    // filterstateData.clear();

    final Database db = (await DBHelper.getInstance())!;
    stateData = await DBOperation.getstateData(db);
    // filterstateData = stateData;
    // log("getCustomerListFromDB length::" + filterstateData.length.toString());
    notifyListeners();
  }
  String statecode = '';
  String countrycode = '';
  String statename = '';
methidstate(String name) {
    log("ANBU");
    statecode = '';
    statename = '';
    countrycode = '';
    for (int i = 0; i < stateData.length; i++) {
      if (stateData[i].stateName.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        statecode = stateData[i].statecode.toString();
        statename = stateData[i].stateName.toString();
        countrycode = stateData[i].countrycode.toString();

        log("statecode:::" + statecode.toString());
      }
    }
    if (statecode.isEmpty) {
      print("testing");
    }
    //  notifyListeners();
  }
  String? purposecode = '';
  mapValues(getvisitdetails itemdata) {
    log("LookingFor::"+itemdata.LookingFor.toString());
    log("purposeofvisit::"+itemdata.purposeofvisit.toString());
    // PatchExCus patch = new PatchExCus();
    //  forid=itemdata.id!;itemdata.mobileNo!;
    //  forcustcode=itemdata.customerCode!;
    log("itemdata.customercode::" + itemdata.customercode.toString());
    customerName =
        itemdata.customername == 'null' ? '' : itemdata.customername!;
    // mycontroller[0].text = itemdata.customerName!;
    mycontroller[1].text = itemdata.customercode!;
    mycontroller[7].text =
        itemdata.LookingFor == null || itemdata.LookingFor!.isEmpty
            ? ''
            : itemdata.LookingFor!;
             mycontroller[21].text =
        itemdata.PotentialBusinessValue == null
            ? ''
            : itemdata.PotentialBusinessValue!.toString();
            
    mycontroller[2].text =
        itemdata.contactname == 'null' ? '' : itemdata.contactname!;

    for (int i = 0; i < filterpurposeofVisitList!.length; i++) {
      if (filterpurposeofVisitList![i].description == itemdata.purposeofvisit) {
        mycontroller[9].text = filterpurposeofVisitList![i].description.toString();
        purposecode = filterpurposeofVisitList![i].code.toString();
        notifyListeners();
      }
    }
    methidstate(itemdata.state.toString());
   
    notifyListeners();
  }

  String? customerName;
  int? checkInId;
  validateCheckIn(BuildContext context) async {
    // final Database db = (await DBHelper.getInstance())!;
    // List<Map<String, Object?>> serailbatchCheck =
    //     await DBOperation.getValidateCheckIn(db);
    // if (serailbatchCheck.isEmpty) {
    showDialog<dynamic>(
        context: context,
        builder: (_) {
          return SuccessDialogPG(
            heading: 'Response',
            msg: 'Please Check-In Customer..!!',
          );
        }).then((value) {
      clearAll(context);
      Get.offAllNamed(ConstantRoutes.dashboard);
    });
    // } else {
    //   Get.toNamed(ConstantRoutes.siteOut);
    // }
    notifyListeners();
  }

  clearAll(BuildContext context) async {
    mycontroller[14].clear();
     errorTime = "";
    mycontroller[15].clear();
     sitevisitreq = false;
     valuecollection = false;
     remswitch=false;
      reyear=null;
 remonth=null;
 reday=null;
 rehours=null;
 reminutes=null;
    isconvertload = false;
    purposecode = '';
    siteoutDataDetails!.clear();
    filedata.clear();
    mycontroller[2].text = ""; //cantactname
    mycontroller[1].text = ""; //mobile
    mycontroller[9].text = ""; //purposeOfVisit
    mycontroller[7].text = ""; //looking for
    mycontroller[13].text = ""; //Next Visit On
    mycontroller[14].text = ""; //Next Followup Date
    mycontroller[8].text = ""; //Assign To
    mycontroller[3].text = ""; //Location
    files.clear();
    issitein=false;
    mycontroller[18].text = '';
     catagorydata.clear();
    filtercatagorydata.clear();
    value = false;
    valueOrder = false;
    valueLead = false;
    valueReceipt = false;
    assignTo = false;
    longi = '';
    lati = '';
    latitude = '';
    langitude = '';
    url = '';
    adrress = '';
    userLtData.clear();
    // await determinePosition(context);
  }

  checkboxselect(bool val) {
    value = val;
    notifyListeners();
  }

  bool isconvertload = false;
  checkboxselectLead(bool val, String? mobile) {
    isconvertload = true;
    notifyListeners();
    valueLead = val;
    if (val == true) {
      isconvertload = false;
      mapValuestoLead2(mobile);
      // Get.offAllNamed(ConstantRoutes.ordernew);
    }
    notifyListeners();
  }

  checkboxselect2() {
    value = !value;
    notifyListeners();
  }

  checkboxselectLead2() {
    valueLead = !valueLead;
    notifyListeners();
  }

  checkboxselectReceipt2() {
    valueReceipt = !valueReceipt;
    notifyListeners();
  }

  checkboxselectReceipt(bool val) {
    valueReceipt = val;
    notifyListeners();
  }

  checkboxselectOrder2() {
    valueOrder = !valueOrder;
    notifyListeners();
  }

  checkboxselectOrder(bool val, String mobile) {
    isconvertload = true;
    notifyListeners();
    valueOrder = val;

    if (val == true) {
      isconvertload = false;
      mapValuestoorder2(mobile);
      // Get.offAllNamed(ConstantRoutes.ordernew);
    }
    notifyListeners();
  }

  checkboxAssignTo(bool val) {
    assignTo = val;
    notifyListeners();
  }

  // List<UserListData> userLtData = [];
  // List<UserListData> get getuserLtData => userLtData;
  int? selectedIdxFUser = null;
  String? getslpID;

  selectedAssignedUser() {
    mycontroller[16].text = userLtData[selectedIdxFUser!].UserName!;
    notifyListeners();
  }

  // getUserAssingData() async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   userLtData = await DBOperation.getUserList(db);
  //   notifyListeners();
  // }

  //
  //

  selectUser(int ij) {
    for (int i = 0; i < userLtData.length; i++) {
      if (userLtData[i].slpcode == userLtData[ij].slpcode) {
        userLtData[i].color = 1;
        getslpID = userLtData[ij].slpcode;
        selectedIdxFUser = ij;
      } else {
        userLtData[i].color = 0;
      }
    }
    notifyListeners();
  }

  getDivisionValues() async {
    final Database db = (await DBHelper.getInstance())!;

    category = await DBOperation.getFavData("category", db);
    filterLookingforList = category;
    log("category:::" + category.length.toString());
    notifyListeners();
  }

  // getDivisionValue() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   category = await DBOperation.getFavData("category", db);
  //   filterLookingforList = category;
  //   notifyListeners();
  // }

  iscateSeletedPurpose(BuildContext context, String select, String code) {
    mycontroller[9].text = select;
    purposecode = code;
    Navigator.pop(context);
    notifyListeners();
  }

  iscateSeletedLooking(BuildContext context, String select) {
    mycontroller[7].text = select;
    Navigator.pop(context);
    notifyListeners();
  }

  List<purposeofVisitData> purposeofVisitList = [];
  List<visitpurpose>? purposevisit = [];

  List<visitpurpose> filterpurposeofVisitList = [];
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

  List<ItemMasterDBModel> filterLookingforList = [];
  filterListLookingFor(String v) {
    if (v.isNotEmpty) {
      filterLookingforList = category
          .where((e) => e.category.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.name!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterLookingforList = category;
      notifyListeners();
    }
  }
  clearbool() {
    mycontroller[14].clear();
    mycontroller[15].clear();
    visittimebool = false;
    visitDatebool = false;
    // istimevalid = false;
    notifyListeners();
  }
  bool checkdata=false;
  String errorTime = "";
  String? apiNdate='';
 String? apiFdate='';
  getDate(BuildContext context) async {
    errorTime = "";

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
//  firstDate: DateTime.now().subtract(Duration(days: 1)),
//   lastDate: DateTime(2100),
    if (pickedDate != null) {
      mycontroller[15].text = "";
      //  var date = DateTime.parse(pickedDate);
      print("data::"+pickedDate.toString());
      apiNdate=pickedDate.toString();
      // apiNdate =
      //     "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiNdate);
      var datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[14].text = datetype;
      // if(mycontroller[16].text != null && mycontroller[16].text.isNotEmpty ){
 DateTime planPurDate;
DateTime Nextfdate;
log("apiNdate::"+apiNdate.toString());

log("pickedDate::"+pickedDate.toString());
// planPurDate=DateTime.parse(pickedDate.toString());
// Nextfdate=DateTime.parse(apiFdate.toString());
// log("Nextfdate::"+Nextfdate.toString());
// log("planPurDate::"+planPurDate.toString());
// if(Nextfdate.isAfter(planPurDate)){
//    mycontroller[16].text='';
//    checkdata=true;
//    notifyListeners();
// }else{
  checkdata=false;
   mycontroller[14].text = datetype;
   reyear=pickedDate.year;
   remonth=pickedDate.month;
   reday=pickedDate.day;
   notifyListeners();
// }
  notifyListeners();
      // }
    
      // mycontroller[44].text = datetype!;
      // print(datetype);
    } else {
       mycontroller[14].text='';
      print("Date is not selected");
    }
    notifyListeners();
  }
  //  String errorTime = "";
  void selectTime(BuildContext context) async {
    TimeOfDay timee = TimeOfDay.now();
    TimeOfDay startTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);
    if (mycontroller[14].text.isNotEmpty) {
      errorTime = "";
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: timee,
      );
      // if (mycontroller[10].text ==
      //     DateFormat('dd-MM-yyyy').format(DateTime.now())) {
      //   print(newTime!.hour);
      //   print(TimeOfDay.now().hour);
      //   print(newTime.minute);
      //   print(TimeOfDay.now().minute);
      //   if (timee.hour < TimeOfDay.now().hour ||
      //       timee.minute < TimeOfDay.now().minute) {
      //     print("error");
      //   } else if (timee.hour >= TimeOfDay.now().hour &&
      //       timee.minute >= TimeOfDay.now().minute) {
      //     print("correct");
      //   }
      // } else {

      if (newTime != null) {
        timee = newTime;
        // if (timee.hour < startTime.hour || timee.hour > endTime.hour) {
        //   istimevalid = true;
        //   mycontroller[15].text = "";
        //   errorTime = "Schedule Time between 7AM to 10PM*";

        //   notifyListeners();
        // } else {
          if (mycontroller[14].text ==
              DateFormat('dd-MM-yyyy').format(DateTime.now())) {
            if (timee.hour < TimeOfDay.now().hour ||(timee.hour == TimeOfDay.now().hour && timee.minute < TimeOfDay.now().minute)) {
              errorTime = "Please Choose Correct Time";
              mycontroller[15].text = "";
              notifyListeners();
              print("error");
            } else {
              errorTime = "";
              print("correct11");
              mycontroller[15].text = timee.format(context).toString();
            }
          } else {
            errorTime = "";
            print("correct22");
            timee = newTime;
            mycontroller[15].text = timee.format(context).toString();
          }
          istimevalid = false;
          notifyListeners();
        // }
      }
      notifyListeners();
    } else {
      mycontroller[15].text = "";
      errorTime = "Please Choose First Date";
      notifyListeners();
    }
    notifyListeners();
  }
  bool istimevalid = false;
bool? sitevisitreq = false;
  bool? get getsitevisitreq => sitevisitreq;
  bool visittimebool = false;
  bool visitDatebool = false;
   checksitevisit(bool val) {
    istimevalid = false;
    mycontroller[14].text='';
    mycontroller[15].text='';
    checkdata=false;
    notifyListeners();
    if (val == true) {
      log("DONE");
      clearbool();
      
      notifyListeners();
    }
    sitevisitreq = val;
    log("message::" + sitevisitreq.toString());
    notifyListeners();
  }
  setValmethod() {
    // mycontroller[2].text = "Anbu Raj"; //cantactname
    // mycontroller[1].text = "9876543210"; //mobile
    // mycontroller[9].text = "Routine Visit"; //purposeOfVisit
    // mycontroller[2].text = "";
  }
  bool isloading = false;
  validateCheckOut(BuildContext context, String number) async {
    // final Database db = (await DBHelper.getInstance())!;
    siteoutpatc siteoutp = siteoutpatc();
    siteoutp.customername = openVisitData[0].customername;
    siteoutp.add1 = openVisitData[0].address1 == null ||
            openVisitData[0].address1 == 'null' ||
            openVisitData[0].address1!.isEmpty
        ? null
        : openVisitData[0].address1.toString().replaceAll("'", "''");
    siteoutp.contactname = openVisitData[0].contactname == null ||
            openVisitData[0].contactname == 'null' ||
            openVisitData[0].contactname!.isEmpty
        ? null
        : openVisitData[0].contactname;
    siteoutp.add2 = openVisitData[0].address2 == null ||
            openVisitData[0].address2 == 'null' ||
            openVisitData[0].address2!.isEmpty
        ? null
        : openVisitData[0].address2.toString().replaceAll("'", "''");
    siteoutp.area = openVisitData[0].area == null ||
            openVisitData[0].area == 'null' ||
            openVisitData[0].area!.isEmpty
        ? null
        : openVisitData[0].area;
    siteoutp.city = openVisitData[0].city == null ||
            openVisitData[0].city == 'null' ||
            openVisitData[0].city!.isEmpty
        ? null
        : openVisitData[0].city;
    siteoutp.pincode = openVisitData[0].pincode == null
        ? null
        : int.parse(openVisitData[0].pincode.toString());
    siteoutp.state = statecode == null ||
            statecode == 'null' ||
            statecode.isEmpty
        ? null
        : statecode;
    siteoutp.country = countrycode == null ||
            countrycode == 'null' ||
            countrycode.isEmpty
        ? null
        : countrycode;
    siteoutp.email = openVisitData[0].cusemail == null ||
            openVisitData[0].cusemail == 'null' ||
            openVisitData[0].cusemail!.isEmpty
        ? null
        : openVisitData[0].cusemail;
    siteoutp.lookingfor = mycontroller[7].text;
    // siteoutp.altermobile = openVisitData[0].address1 == null ||
    //         openVisitData[0].address1 == 'null' ||
    //         openVisitData[0].address1!.isEmpty
    //     ? null
    //     : openVisitData[0].a;
    siteoutp.meetingtime = openVisitData[0].meetingtime == null ||
            openVisitData[0].meetingtime == 'null' ||
            openVisitData[0].meetingtime!.isEmpty
        ? null
        : openVisitData[0].meetingtime;
    siteoutp.baseid =
        openVisitData[0].BaseId == null ? null : openVisitData[0].BaseId;
    siteoutp.basetype =
        openVisitData[0].BaseType == null ? null : openVisitData[0].BaseType;
    siteoutp.potential = mycontroller[21].text == null ||
            mycontroller[21].text == 'null' ||
            mycontroller[21].text.isEmpty
        ? null
        : double.parse(mycontroller[21].text);
    siteoutp.customercode = mycontroller[1].text == null ||
            mycontroller[1].text == 'null' ||
            mycontroller[1].text.isEmpty
        ? null
        : mycontroller[1].text;
    siteoutp.purposeofvisit =
        purposecode == null || purposecode == 'null' || purposecode!.isEmpty
            ? null
            : purposecode;
    siteoutp.assignslpcode = ConstantValues.Usercode;
    // siteinpatchdata.meetingtime = newdateformat + "T" + newdate;
    siteoutp.createdby = int.parse(ConstantValues.UserId);

    siteoutp.visitid =
        openVisitData[0].visitplan == null ? null : openVisitData[0].visitplan;
    // log("DATTA" + siteinpatchdata.visitid.toString());
    siteoutp.time = config.currentDate();
    if (formkey.currentState!.validate()) {
      isloading = true;
      postsiteout(context, siteoutp);
      // await DBOperation.changeCheckIntoCheckOut(db, checkInId!);
      notifyListeners();
    }
  }

  // String? latitude;
  // String? langitude;
  // Future<void> determinePosition(BuildContext context) async {
  //   adrress = "";
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

  //         // if (permission == LocationPermission.deniedForever) {}
  //         var pos = await Geolocator.getCurrentPosition();
  //         latitude = pos.latitude.toString();
  //         langitude = pos.longitude.toString();
  //         print("Heading:::" + pos.heading.toString());
  //         // longi = langitude;
  //         // lati = latitude;

  //         // print('https://www.openstreetmap.org/#map=11/$latitude/$langitude');
  //         // print('longtitude: ' + pos.longitude.toString());
  //         // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
  //         // MapSampleState.lati1 = double.parse(latitude);
  //         // MapSampleState.lang2 = double.parse(langitude);
  //         var lat = double.parse(latitude!);
  //         var long = double.parse(langitude!);
  //         await AddressMasterApi.getData(lat.toString(), long.toString())
  //             .then((value) {
  //           log("value.stcode::" + value.stcode.toString());
  //           if (200 >= value.stcode! && 210 <= value.stcode!) {
  //             adrress = value.address2;
  //             mycontroller[3].text = adrress.toString();
  //             log("adress::" + adrress.toString());
  //             notifyListeners();
  //           } else {
  //             print("error:api");
  //           }
  //         });

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
  //       // print("Heading:::"+pos.toString());

  //       // longi = langitude;
  //       // lati = latitude;

  //       // url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

  //       var lat = double.parse(latitude!);
  //       var long = double.parse(langitude!);
  //       await AddressMasterApi.getData(lat.toString(), long.toString())
  //           .then((value) {
  //         log("value.stcode::" + value.stcode.toString());
  //         if (value.stcode! >= 200 && value.stcode! <= 210) {
  //           adrress = value.address2;
  //           mycontroller[3].text = adrress.toString();
  //           log("adress::" + adrress.toString());
  //           notifyListeners();
  //         } else {
  //           print("error:api");
  //         }
  //       });

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
  //   // log(DayStartEndPageState.lati1.toString());
  //   // log(DayStartEndPageState.lang2.toString());
  //   notifyListeners();
  // }

  // getData() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> serailbatchCheck =
  //       await DBOperation.getValidateCheckIn(db);
  //   if (serailbatchCheck.isNotEmpty) {
  //     checkInId = int.parse(serailbatchCheck[0]["CheckInId"].toString());
  //     customerName = serailbatchCheck[0]["Customer"].toString();
  //     mycontroller[2].text =
  //         serailbatchCheck[0]["CantactName"].toString(); //cantactname
  //     mycontroller[1].text = serailbatchCheck[0]["Mobile"].toString(); //mobile
  //     mycontroller[9].text =
  //         serailbatchCheck[0]["Purpose"].toString(); //purpose
  //     mycontroller[3].text =
  //         "${serailbatchCheck[0]["Area"].toString()},${serailbatchCheck[0]["City"].toString()}";
  //   }
  //   purposeofVisitList = [
  //     purposeofVisitData(purpose: "Courtesy Visit"),
  //     purposeofVisitData(purpose: "Enquiry Visit"),
  //     purposeofVisitData(purpose: "Routine Visit"),
  //     purposeofVisitData(purpose: "Collection"),
  //     purposeofVisitData(purpose: "Customer Appointment"),
  //     purposeofVisitData(purpose: "New Demo"),
  //     purposeofVisitData(purpose: "Complaint Call Visit")
  //   ];
  //   filterpurposeofVisitList = purposeofVisitList;
  // }
bool iscamera=false;
  Future imagetoBinary(ImageSource source) async {
     List<File> filesz=[];
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
     if(filedata.isEmpty){
 filedata.clear();
 filesz.clear();
    }
     filesz.add(File(image.path));
    // files.add(File(image.path));
    // filedata.clear();
    // iscamera=true;
    notifyListeners();
// await addattach(files);
    if (files.length <= 3) {
      for (int i = 0; i < filesz.length; i++) {
         files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
        String fileName = filesz[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
         String tempPath='';
           if(Platform.isAndroid){

         tempPath = (await getExternalStorageDirectory())!.path;
        
        }else if(Platform.isIOS){
 tempPath = (await getApplicationDocumentsDirectory())!.path;
        }
       
           String fullPath = '$tempPath/$fileName'; 
        await filesz[i].copy(fullPath);
         File(fullPath).writeAsBytesSync(intdata);
  final result = await ImageGallerySaver.saveFile(fullPath,isReturnPathOfIOS: true);
    
        // Directory tempDir = await getTemporaryDirectory();
        // String tempPath = tempDir.path;
        // String fullPath = '${tempDir.path}/$fileName';
          if(Platform.isAndroid){
filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: fullPath
            // files[i].path.split('/').last
            ));
             }else{
              filedata.add(FilesData(
            fileBytes: base64Encode(intdata),
            fileName: image.path
            // files[i].path.split('/').last
            ));
             }
        // filedata.add(
        //     FilesData(fileBytes: base64Encode(intdata), fileName: fullPath));
        notifyListeners();
      }
      log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      log("filesz lenghthhhhh::::::" + filedata.length.toString());
      // showtoast();
    }
    log("camera fileslength" + files.length.toString());
    // showtoast();

    notifyListeners();
  }

  FilePickerResult? result;
  addattach(List<File> file) async{
    
  if (file.length <= 3) {
      for (int i = 0; i < file.length; i++) {
        List<int> intdata = file[i].readAsBytesSync();
        String fileName = file[i].path.split('/').last;
        String fileBytes = base64Encode(intdata);
      if(iscamera==true){
Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String fullPath = '${tempDir.path}/$fileName';
        filedata.add(
            FilesData(fileBytes: base64Encode(intdata), fileName: fullPath));
            iscamera=false;
            notifyListeners();
    }else{
       filedata.add(FilesData(
                fileBytes: base64Encode(intdata),
                fileName: file[i].path));
    }
        
        notifyListeners();
      }
      log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
      showtoast();
      log("filesz lenghthhhhh::::::" + filedata.length.toString());
      // showtoast();
    }
  }

  selectattachment() async {
     List<File> filesz=[];
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    notifyListeners();

    if (result != null) {
       if(filedata.isEmpty){
   files.clear();
      filesz.clear();
  filedata.clear();
  notifyListeners();
    }



       filesz = result!.paths.map((path) => File(path!)).toList();
// await addattach(filesz);
      // if (filesz.length != 0) {
        int remainingSlots = 4 - files.length;
         if (filesz.length <= remainingSlots) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

         
            // showtoast();
            files.add(filesz[i]);
            // log("Files Lenght :::::" + files.length.toString());
            List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(FilesData(
                fileBytes: base64Encode(intdata), fileName: filesz[i].path));
            notifyListeners();

            // return null;
          } 
        // }
      }else {
            showtoast();
          }
      notifyListeners();
    }
    notifyListeners();
  }

  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Four Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  String apiFDate = '';
  void showNextVisitOn(BuildContext context) {
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
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      mycontroller[13].text = chooseddate;
      notifyListeners();
    });
  }

//  String apiFDate = '';
  void showNextFollowupDate(BuildContext context) {
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
      apiFDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      print(apiFDate);

      mycontroller[14].text = chooseddate;
      notifyListeners();
    });
  }

  //lead check list Api

  String LeadCheckDataExcep = '';
  String get getLeadCheckDataExcep => LeadCheckDataExcep;

  callLeadCheckApi() {
    GetOrderCheckListApi.getData('${ConstantValues.slpcode}').then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.Ordercheckdata != null) {
          leadcheckdatas = value.Ordercheckdata!;
        } else if (value.Ordercheckdata == null) {
          LeadCheckDataExcep = 'Lead check data not found..!!';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        LeadCheckDataExcep = 'Some thing went wrong..!!';
      } else if (value.stcode == 500) {
        LeadCheckDataExcep = '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
      }
    });
    notifyListeners();
  }

  LeadcheckListClicked(bool? v, int i) {
    leadcheckdatas[i].ischecked = v;
    notifyListeners();
  }

  resetListSelection() {
    for (int i = 0; i < leadcheckdatas.length; i++) {
      leadcheckdatas[i].ischecked = false;
    }
  }
}
class FilesData {
  String fileBytes;
  String fileName;
  // String filepath;

  FilesData({
    required this.fileBytes,
    required this.fileName,
  });
}
