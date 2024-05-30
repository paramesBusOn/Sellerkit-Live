// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_import, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geocoder/model.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/DayStartEndApi/DayEndApi.dart';
import 'package:sellerkit/Services/DayStartEndApi/DayStartApi.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/AttachmentFileLinkApi.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/SharedPreference.dart';
import '../../Pages/DayStartEnd/Screens/DayEnd.dart';
import '../../Pages/DayStartEnd/Screens/DayStart.dart';
import '../../Services/AddressGetApi/AddressGetApi.dart';
import '../../Widgets/SucessDialagBox.dart';
import '../../Pages/SiteIn/Widgets/TestMapPage.dart';

class DayStartEndController extends ChangeNotifier {
  String? longi;
  String? lati;
  String latitude = '';
  String langitude = '';
  String? url;
//  String? host = await SharedPref.getHostDSP();
  //  await SharedPref.saveHostSP(mycontroller[2].text.trim());

  String? adrress;

  String? adrress1;
  
  String? adrress2;
  
  String? adrress3;
  String selectedCust = '';
  String selectedCustCode = '';
  int? selectedClgCode;
  Config config = Config();

  List<File> files = [];
  List<FilesData> filedata = [];
  DayStartList? postDayStartList;
  DayEndList? postDayEndList;

  // File? image;
  bool loadingImage = false;
  clearAll() {
    ima = null;
    files.clear();
    notifyListeners();
  }

  File? ima;
  Future imagetoBinary(ImageSource source) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();

    final image = await ImagePicker().pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );
    if (image == null) return;
    ima = File(image.path);
    log("image.path::"+image.path.toString());
    files.add(File(image.path));
    filedata.clear();
    notifyListeners();

    if (files.length <= 3) {
      for (int i = 0; i < files.length; i++) {
        List<int> intdata = files[i].readAsBytesSync();
         String fileName = files[i].path.split('/').last;
          String fileBytes = base64Encode(intdata);
           String tempPath='';
           if(Platform.isAndroid){

         tempPath = (await getExternalStorageDirectory())!.path;
        
        }else if(Platform.isIOS){
 tempPath = (await getApplicationDocumentsDirectory())!.path;
        }
       
           String fullPath = '$tempPath/$fileName'; 
        await files[i].copy(fullPath);
         File(fullPath).writeAsBytesSync(intdata);
  final result = await ImageGallerySaver.saveFile(fullPath,isReturnPathOfIOS: true);
    
        //  Directory tempDir = await getTemporaryDirectory();
        //   String tempPath = tempDir.path;
        //     String fullPath = '${tempDir.path}/$fileName';
            log("fullPath::"+fullPath.toString());
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
        // filedata.add(FilesData(
        //     fileBytes: base64Encode(intdata),
        //     fileName: fullPath
        //     // files[i].path.split('/').last
        //     ));
        notifyListeners();
      }
      log("filesz lenghthhhhh1111111::::::" + filedata.length.toString());
      
      log("filesz lenghthhhhh1111111::::::" + filedata[0].fileName.toString());
      

      // return null;
    } else {
      log("filesz lenghthhhhh::::::" + filedata.length.toString());
      // showtoast();
    }
    log("camera fileslength" + files.length.toString());
    // showtoast();

    notifyListeners();
  }

  String timeString = "";

  void getTime() async {
    final String formattedDateTime =
        DateFormat('hh:mm:ss:a').format(DateTime.now()).toString();
    timeString = formattedDateTime;

    TimeOfDay timee = TimeOfDay.now();
    String? nextFDTime;
    // final TimeOfDay? newTime = await showTimePicker(
    //     context: context,
    //     initialTime: timee,
    //   );
    //    nextFDTime = timee.format(context).toString();
    // String apiDATE=config.alignDateforFollow(nextFDTime,config.currentDate());
    print("Time::" + config.currentDate().toString());
    notifyListeners();
  }

  checkDayStart() async {
    await SharedPref.saveDayStart("DayStart");
  }

  checkDayEnd() async {
    await SharedPref.saveDayStart("DayEnd");
  }
   checkclear() async {
    await SharedPref.clearDayStart();
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

  Showdialog() async {
    await Get.defaultDialog(
            title: "Success",
            // content: Icon(Icons.thumb_up,color: Colors.green,),
            middleText: "Register Successfully..",
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.green),
            middleTextStyle: TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Get.toNamed(ConstantRoutes.dashboard);
                    },
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {});
    notifyListeners();
  }

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
          // longi = langitude;
          // lati = latitude;
          DayStartEndPageState.lati1 = double.parse(
              ConstantValues.latitude == '' || ConstantValues.latitude == 'null'
                  ? '0.0'
                  : ConstantValues.latitude.toString());
          DayStartEndPageState.lang2 = double.parse(
              ConstantValues.langtitude == '' ||
                      ConstantValues.langtitude == 'null'
                  ? '0.0'
                  : ConstantValues.langtitude.toString());
          DayEndPageState.lati1 = double.parse(latitude);
          DayEndPageState.lang2 = double.parse(langitude);

          url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';
          MapSampleState.lati1 = double.parse(latitude);
          MapSampleState.lang2 = double.parse(langitude);
          var lat = double.parse(latitude);
          var long = double.parse(langitude);
          await AddressMasterApi.getData(lat.toString(), long.toString())
              .then((value) {
            log("value.stcode::" + value!.stcode.toString());
            if (200 >= value.stcode! && 210 <= value.stcode!) {
              adrress = value.results[1].formattedAddress;
              
   adrress2=value.results[1].formattedAddress;
   adrress3=value.results[1].formattedAddress;

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
        DayStartEndPageState.lati1 = double.parse(
            ConstantValues.latitude == '' || ConstantValues.latitude == 'null'
                ? '0.0'
                : ConstantValues.latitude.toString());
        DayStartEndPageState.lang2 = double.parse(
            ConstantValues.langtitude == '' ||
                    ConstantValues.langtitude == 'null'
                ? '0.0'
                : ConstantValues.langtitude.toString());
        DayEndPageState.lati1 = double.parse(
            ConstantValues.latitude == '' || ConstantValues.latitude == 'null'
                ? '0.0'
                : ConstantValues.latitude.toString());
        DayEndPageState.lang2 = double.parse(ConstantValues.langtitude == '' ||
                ConstantValues.langtitude == 'null'
            ? '0.0'
            : ConstantValues.langtitude.toString());
        url = 'https://www.openstreetmap.org/#map=11/$latitude/$langitude';

        var lat = double.parse(latitude);
        var long = double.parse(langitude);
        await AddressMasterApi.getData(lat.toString(), long.toString())
            .then((value) {
          log("value.stcode::" + value.stcode.toString());
          if (value.stcode! >= 200 && value.stcode! <= 210) {
            adrress =value.results[1].formattedAddress;
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
      // Future.delayed(
      //     const Duration(seconds: 2),
      //     () => Get.back<dynamic>(),
      //   );
    }

    notifyListeners();
  }

  bool isloading = false;
  String errorMsg = '';

  validateDayStart(BuildContext context) async {
    isloading = true;
    List<String> filename = [];
    List<String>? fileError = [];
    String URLforattach='';
    // postDayStartList = null;
    //
    //  final stopwatch = Stopwatch()..start();
    if (files.isNotEmpty) {
     if (filedata != null || filedata.isNotEmpty) {
      for (int i = 0; i < filedata.length; i++) {
        await OrderAttachmentApiApi.getData(
          filedata[i].fileName,
        ).then((value) {
          //  stopwatch.stop();
          //   log('API call took ${stopwatch.elapsedMilliseconds} milliseconds');
          // log("OrderAttachmentApiApi::" + value.toString());
          if (value == 'No Data Found..!!') {
            fileError.add(filedata[i].fileName);
            // filename.add("");
          } else {
            // filename.add(value);
            if (i == 0) {
              // log("message");
              URLforattach = value;
            } 
          }
        });
      }
    }
    String address4="1, Perundurai Rd, EB Officer's Colony, Palayapalayam, Erode, Tamil Nadu 638011, India";
    DayStartList postDayStartList2 = DayStartList(
        userId: int.parse(ConstantValues.UserId.toString()),
        slpCode: '${ConstantValues.slpcode.toString()}',
        startAddress: adrress!.replaceAll("'", "''"),
        address2:adrress2==null||adrress2!.isEmpty?adrress2: adrress2!.replaceAll("'", "''"),
        address3:adrress3==null||adrress3!.isEmpty?adrress3: adrress3!.replaceAll("'", "''"),
        startDate: config.currentDate(),
        latititudeST: DayStartEndPageState.lati1.toString(),
        longitudeST: DayStartEndPageState.lang2.toString(),
        startPointImgurl: '$URLforattach');
    postDayStartList = postDayStartList2;

    
      //  final stopwatch = Stopwatch()..start();
      await DayStartApi.getDayStartApiData(postDayStartList).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          isloading = false;
          // checkDayStart();
          showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Day Started Successfully..!!',
            );
          }).then((value) {
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
           
          isloading = false;
          errorMsg =
              '${value.message}..!! ${value.exception}..!!';
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${errorMsg}',
                );
              }).then((value) {
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
          notifyListeners();
        } else if (value.stcode == 500) {
           
          isloading = false;
          errorMsg =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${errorMsg}',
                );
              }).then((value) {
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
          notifyListeners();
        }
      });

    
    } 
    else {
      isloading = false;
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please take Photo..!!',
            );
          });
    }
   
    isloading = false;
    notifyListeners();
  }

  validateDayEnd(BuildContext context) async {
     isloading = true;
      List<String> filename = [];
    List<String>? fileError = [];
    String URLforattach='';
    if (files.isNotEmpty) {
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
              URLforattach = value;
            } 
          }
        });
      }
    }
    DayEndList? postDayEndList2 = DayEndList(
       userId: int.parse(ConstantValues.UserId.toString()),
        endAddress: adrress!.replaceAll("'", "''"),
        address2:adrress2==null||adrress2!.isEmpty?adrress2: adrress2!.replaceAll("'", "''"),
        address3:adrress3==null||adrress3!.isEmpty?adrress3: adrress3!.replaceAll("'", "''"),
       
       
        startPointImgurl: '$URLforattach',
        endDate: config.currentDate(),
        latititudeET: DayEndPageState.lati1.toString(),
        longitudeET: DayStartEndPageState.lang2.toString());

    postDayEndList = postDayEndList2;
   
await DayEndApi.getDayEndApiData(postDayEndList).then((value) {
        if (value.stcode! <= 210 && value.stcode! >= 200) {
          //  checkDayEnd();
          isloading = false;
         
          showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Day Ended Successfully..!!',
            );
          }).then((value) {
            checkclear();
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
           
          isloading = false;
          errorMsg =
              '${value.message}..!! ${value.exception}..!!';
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${errorMsg}',
                );
              }).then((value) {
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
          notifyListeners();
        } else if (value.stcode == 500) {
           
          isloading = false;
          errorMsg =
              '${value.stcode!}..!!Network Issue..\nTry again Later..!!';
          showDialog<dynamic>(
              context: context,
              builder: (_) {
                return SuccessDialogPG(
                  heading: 'Response',
                  msg: '${errorMsg}',
                );
              }).then((value) {
            Get.offAllNamed(ConstantRoutes.dashboard);
          });
          notifyListeners();
        }
      });
    }  else {
      isloading = false;
      showDialog<dynamic>(
          context: context,
          builder: (_) {
            return SuccessDialogPG(
              heading: 'Response',
              msg: 'Please take Photo..!!',
            );
          });
    }
   
    isloading = false;
    notifyListeners();
    // await DayEndApi.getDayEndApiData(postDayEndList);
    // showDialog<dynamic>(
    //     context: context,
    //     builder: (_) {
    //       return SuccessDialogPG(
    //         heading: 'Response',
    //         msg: 'Attendance Successfully Registered..!!',
    //       );
    //     }).then((value) {
    //   Get.offAllNamed(ConstantRoutes.dashboard);
    // });
  }
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});
}

// callApi() async {
//   int initial = 1;
//   String url =
//       "Items?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment,Properties1,ItemPrices,ItemWarehouseInfoCollection";

//   await HelperFunctions.getDownloadedSharedPreference().then((value) {
//     if (value == true) {
//       // await dbHelper.truncareItemMaster();
//       //  await dbHelper.truncareItemMasterPrice();
//     }
//   });
//   List<ItemMasterDBModel> valuesInserMaster = [];
//   List<ItemMasterPriceDBModel> valuesInsertMasterPrice = [];
//   for (int i = 0; i < initial; i++) {
//     log(url);
//     log("initaial: " + initial.toString());
//     await ItemMasterApi.getData(url).then((value) {
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         exception = false;
//         if (value.nextLink != 'null') {
//           print("nexturl: ${value.nextLink}");
//           initial = initial + 1;
//           url = value.nextLink!.replaceAll("/b1s/v1/", "");
//           print("nexturl22: $url");
//           for (int ij = 0; ij < value.itemValueValue!.length; ij++) {
//             valuesInserMaster.add(ItemMasterDBModel(
//                 itemCode: value.itemValueValue![ij].itemCode,
//                 brand: value.itemValueValue![ij].brand!,
//                 division: value.itemValueValue![ij].division!,
//                 category: value.itemValueValue![ij].category!,
//                 itemName: value.itemValueValue![ij].itemName!,
//                 segment: value.itemValueValue![ij].segement!,
//                 isselected: 0,
//                 favorite: value.itemValueValue![ij].properties1!,
//                 mgrPrice: null,
//                 slpPrice: null,
//                 storeStock: null,
//                 whsStock: null

//                 ));
//             for (int ijk = 0;
//                 ijk < value.itemValueValue![ij].itemPrices!.length;
//                 ijk++) {
//               if (value.itemValueValue![ij].itemPrices![ijk].PriceList == 1 ||
//                   value.itemValueValue![ij].itemPrices![ijk].PriceList == 2) {
//                 valuesInsertMasterPrice.add(ItemMasterPriceDBModel(
//                     priceList: value
//                         .itemValueValue![ij].itemPrices![ijk].PriceList
//                         .toString(),
//                     price: value.itemValueValue![ij].itemPrices![ijk].price!,
//                     foriegnKey: (valuesInserMaster.length).toString()));
//               }
//             }//next
//           }

//           log("valuesInserMaster: " + valuesInserMaster.length.toString());
//           log("valuesInsertMasterPrice: " +
//               valuesInsertMasterPrice.length.toString());
//         } else if (value.nextLink == 'null') {
//           //print("no nexturl: ${value.nextLink}");
//           initial = -1;
//         }
//         notifyListeners();
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         exception = true;
//         errorMsg = '${value.error!.message!.value}';
//         notifyListeners();
//       } else if (value.stcode == 500) {
//         exception = true;
//         errorMsg = '${value.exception}';
//         notifyListeners();
//       }
//     });
//     // print("i: ${i}");
//     // print("initial: ${initial}");
//     if (initial == -1) {
//       await dbHelper.insertItemMaster(valuesInserMaster).then((value) {
//         dbHelper.insertItemMasterPrice(valuesInsertMasterPrice).then((value) {
//           HelperFunctions.saveDonloadednSharedPreference(true).then((value) {
//             Get.offAllNamed(ConstantRoutes.dashboard);
//           });
//         });
//       });
//       break;
//     }
//   }
// }

    //    await HelperFunctions.getDownloadedSharedPreference().then((value) async{
    //   if (value == true) {
    //     log("data cleared");
    //   }
    // });
    // String dataIpadd = (await HelperFunctions.getHostDSP())!;