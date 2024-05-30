// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/GetFilePath.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate1Model.dart';
import 'package:sellerkit/Services/PostQueryApi/ProfileApi/ProfileApi.dart';
import 'package:sellerkit/Services/ProfileImageApi/ProfileUpdate1Api.dart';
import 'package:sellerkit/Services/ProfileImageApi/SaveProfileApi.dart';
import 'package:sellerkit/Services/ProfileImageApi/ProfileUpdate2Api.dart';
import 'package:sellerkit/Widgets/AlertDilog.dart';

import '../../Models/PostQueryModel/ProfileModel.dart/ProfileModel.dart';
import '../../Services/PostQueryApi/ProfileApi/updateApi.dart';

class NewProfileController extends ChangeNotifier {
   ProfileApi profileApi = ProfileApi();
  File? imageeFile;
  File? get getimageeFile => imageeFile;

  bool isprogress = false;
  bool get getisprogress => isprogress;

  String? data1;
  String? get getdata => data1;

  String successmsg = '';
  String get getsuccessmsg => successmsg;

  List<ProfileUpdateModel1Data> newProData = [];
  List<ProfileUpdateModel1Data> get getprofileData => newProData;

  String? newprofileexmsg = '';
  String? filePathh;
   FilePickerResult? result;
  //  filesz = [];
  List<File> files = [];
  bool? fileValidation = false;

  List<FilesData> filedata = [];
  List<String> filelink = [];
  List<String> fileException = [];
selectattachment(BuildContext context) async {
    List<File> filesz=[];
    log(files.length.toString());

    result = await FilePicker.platform.pickFiles(allowMultiple: false);
    notifyListeners();

    if (result != null) {
      log("image::"+result.toString());
     log("image22::"+result!.names.remove.toString());
     

     String? urlimage=result!.names[0];
     log("urlimage::"+urlimage.toString());
    // if(filedata.isEmpty){
   files.clear();
      filesz.clear();
  filedata.clear();
  notifyListeners();
    // }
    
    
    
      log("filedata::"+filedata.length.toString());

       filesz = result!.paths.map((path) => File(path!)).toList();



      // if (filesz.length != 0) {
        //  int remainingSlots = 1 - files.length;
         if (filesz.length <= 1) {
        for (int i = 0; i < filesz.length; i++) {
          // createAString();

         
            // showtoast();
            files.add(filesz[i]);
            log("Files Lenght :::::" + files.length.toString());
            List<int> intdata = filesz[i].readAsBytesSync();
            filedata.add(FilesData(
                fileBytes: base64Encode(intdata), fileName: filesz[i].path));

        //New
        // XFile? photoCompressedFile =await testCompressAndGetFile(filesz[i],filesz[i].path);
        // await FileStorage.writeCounter('${photoCompressedFile!.name}_1', photoCompressedFile);
      //


            notifyListeners();
            callProfileUpdateApi1(filedata[i].fileName,urlimage.toString(),context);
log("filedata222::"+filedata.length.toString());
            // return null;
          } 
        }else {
            showtoast();
          }
      
      notifyListeners();
    }
    
    notifyListeners();
  }
  Future<XFile?> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 180,
      );

    print(file.lengthSync());

    return result;
  }
  void showtoast() {
    Fluttertoast.showToast(
        msg: "More than Five Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }
  Future imagetoBinary2(ImageSource source,BuildContext context) async {
    List<File> filesz=[];
    // await LocationTrack.checkcamlocation();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    log("image::"+image.toString());
     log("image22::"+image.name.toString());
    // files.add(File());
    // if(filedata.isEmpty){
 filedata.clear();
 filesz.clear();
    // }
      filesz.add(File(image.path));
    
   
    notifyListeners();
 log("filesz lenghthhhhh::::::" + filedata.length.toString());
    if (files.length <= 4) {
      for (int i = 0; i < filesz.length; i++) {
        files.add(filesz[i]);
        List<int> intdata = filesz[i].readAsBytesSync();
         String fileName = filesz[i].path.split('/').last;
          String fileBytes = base64Encode(intdata);
         Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
            String fullPath = '${tempDir.path}/$fileName';
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
        //     fileName: fullPath));
        notifyListeners();
        log("filename::"+fullPath.toString());
        log("filename::"+filedata[i].fileName.toString());

        callProfileUpdateApi1(filedata[i].fileName,image.name,context);
      }
      // log("filesz lenghthhhhh::::::" + filedata.length.toString());

      // return null;
    } else {
     
      showtoast();
    }
    log("camera fileslength" + files.length.toString());
    log("camera filesdatalength" + filedata.length.toString());
    // showtoast();

    notifyListeners();
  }
 
  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    imageeFile = File(image.path);
    List<int> imageBytes = imageeFile!.readAsBytesSync();
    String Data = base64Encode(imageBytes);
    data1 = Data;
    // log("data1::"+data1.toString());
    notifyListeners();
    // callProfileUpdateApi1();
  }

  callProfileUpdateApi1(dynamic image,String urlname,BuildContext context) async {
    isprogress = true;
    notifyListeners();
    await ProfileUpdateApi1.getData(image,urlname).then((value) {
       if (value == 'No Data Found..!!') {
        log("NO DDDDDD");
            // fileError.add(filedata[i].fileName);
            // filename.add("");
          }
      else{// if (value >= 200 && value.stcode! <= 210) {
        // if (value.attachpath != null) {
          // newProData = value!;
          filePathh = value.toString();
          
          log("filePathh::"+filePathh.toString());
        // } 
        // else if (value.profiledata == null) {
        //   isprogress = false;
        //   newprofileexmsg = 'No Data in UP1Image1 Api..!!';
        // }
      } 
      // else if (value.stcode! >= 400 && value.stcode! <= 410) {
      //   newprofileexmsg = 'Something went wrong in UP1Image1 Api..!!';
      //   isprogress = false;

      //   print(newprofileexmsg);
      // } else if (value.stcode == 500) {
      //   if (value.exception == 'No route to host') {
      //     newprofileexmsg = 'Check your Internet Connection...!!';
      //     isprogress = false;
      //   } else {
      //     newprofileexmsg = 'Something went wrong try again...!!';
      //     isprogress = false;
      //   }
      // }
    });
    
  await ProfileUpdateApi.getData(filePathh).then((value) {
    if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.profileData != null) {
          
          isprogress = false;
          callAlertDialog3(context,"${value.message}${value.exception.toString()}");
          // print("ConstantValues.profilepic:${ConstantValues.profilepic}");
          notifyListeners();
        } else if (value.profileData == null) {
          isprogress = false;
          newprofileexmsg = '${value.exception}';
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isprogress = false;
        newprofileexmsg = '${value.exception}';
      } else if (value.stcode == 500) {
        if (value.exception == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
        } else {
          isprogress = false;
          newprofileexmsg = '${value.exception}';
        }
      }
  });
  
  
   ProfileModel profileModel = await profileApi.getData(ConstantValues.slpcode);
      if (profileModel.stcode! >= 200 && profileModel.stcode! <= 210) {
        if (profileModel.profileData != null) {
          evictImage(ConstantValues.profilepic!);
          ConstantValues.profilepic = profileModel.profileData!.ProfilePic!;
          isprogress = false;
          print("ConstantValues.profilepic:${ConstantValues.profilepic}");
          notifyListeners();
        } else if (profileModel.profileData == null) {
          isprogress = false;
          newprofileexmsg = '${profileModel.exception}';
        }
      } else if (profileModel.stcode! >= 400 && profileModel.stcode! <= 410) {
        isprogress = false;
        newprofileexmsg = '${profileModel.exception}';
      } else if (profileModel.stcode == 500) {
        if (profileModel.exception == 'No route to host') {
          newprofileexmsg = 'Check your Internet Connection...!!';
        } else {
          isprogress = false;
          newprofileexmsg = '${profileModel.exception}';
        }
      }
    notifyListeners();
  }

  void evictImage(String url) {
    final NetworkImage provider = NetworkImage(url);
    provider.evict().then<void>((bool success) {
      if (success) debugPrint('removed image!');
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

  sheetbottom(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                  height: Screens.padingHeight(context) * 0.13,
                  width: Screens.width(context) * 0.35,
                  child: IconButton(
                    color: theme.primaryColor,
                    onPressed: () {
                      selectattachment(context);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.image,
                      size: 60,
                    ),
                  )),
              Container(
                  height: Screens.padingHeight(context) * 0.13,
                  width: Screens.width(context) * 0.4,
                  child: IconButton(
                    color: theme.primaryColor,
                    onPressed: () {
                      imagetoBinary2(ImageSource.camera,context);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 60,
                    ),
                  ))
            ],
          );
        },
      );
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
