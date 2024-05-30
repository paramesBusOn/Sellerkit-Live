// ignore_for_file: unnecessary_new, prefer_const_constructors, use_build_context_synchronously, unused_field, prefer_final_fields, prefer_const_declarations, unnecessary_brace_in_string_interps, prefer_is_empty, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Pages/FeedCreation/widgets/PDFViwer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constant/Configuration.dart' as Conf;
import '../../Constant/Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Pages/FeedCreation/widgets/RecordingPage.dart';

class FeedCreationProv extends ChangeNotifier {
  FeedCreationProv() {
    files.clear();
  }

  Conf.Config config = new Conf.Config();
  List<TextEditingController> mycontroller =
      List.generate(15, (i) => TextEditingController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> linkkey = GlobalKey<FormState>();

  List<Mediatype> mediatype = [
    Mediatype(selected: 0, type: "Video"),
    Mediatype(selected: 0, type: "Image"),
    Mediatype(selected: 0, type: "Text"),
    Mediatype(selected: 0, type: "Link"),
    Mediatype(selected: 0, type: "PDF"),
  ];

  List<Mediatype> get getmediatype => mediatype;
  String selectedMedia = "";
  String get getselectedMedia => selectedMedia;

  bool pdfSelected = false;
  static bool videoSelected = false;
  bool linkselected = false;

  selectMeida(String selected, BuildContext context, FeedCreationProv fdp) {
    selectedMedia = selected;
    chooseFileType = '';
    if (selected == "Image") {
      sheetbottom(context);
    } else if (selected == "Video") {
      if (videoSelected == false) {
        sheetbottomvideo(context);
      } else {
        showtoast("More than One Document Not Allowed..");
      }
    } else if (selected == "Link") {
      if (linkselected == false) {
        sheetbottomLink(context);
      } else {
        showtoast("More than One Document Not Allowed..");
      }
    } else if (selected == "PDF") {
      if (pdfSelected == false) {
        selectPdf(context);
      } else {
        showtoast("More than One Document Not Allowed..");
      }
    }
    notifyListeners();
  }

  File? imageeFile;
  File? get getimageeFile => imageeFile;
  String? data1;
  String? get getdata => data1;
  Future imagetoBinary(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    files.add(File(image.path));
    notifyListeners();
  }

  //

  static List<File> files = [];
  List<FilesData> filedata = [];
  FilePickerResult? result;
  selectattachment(BuildContext context) async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      print(files);

      for (int i = 0; i < filesz.length; i++) {
        if (files.length < 3) {
          files.add(filesz[i]);
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData(
              fileBytes: base64Encode(intdata),
              fileName: files[i].path.split('/').last));
        } else {
          showtoast(
            "More than Three Document Not Allowed..",
          );
        }
      }
    }
    notifyListeners();
  }

  selectPdf(BuildContext context) async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.any);

    if (result != null) {
      filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      print(files);

      for (int i = 0; i < filesz.length; i++) {
        if (pdfSelected == false) {
          files.add(filesz[i]);
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData(
              fileBytes: base64Encode(intdata),
              fileName: files[i].path.split('/').last));
          pdfSelected = true;
        } else {
          showtoast("More than One Document Not Allowed..");
        }
      }
    }
    notifyListeners();
  }

  selectvideo(BuildContext context) async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.video);

    if (result != null) {
      filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      print(files);

      for (int i = 0; i < filesz.length; i++) {
        if (videoSelected == false) {
          files.add(filesz[i]);
          List<int> intdata = filesz[i].readAsBytesSync();
          filedata.add(FilesData(
              fileBytes: base64Encode(intdata),
              fileName: files[i].path.split('/').last));
          videoSelected = true;
        } else {
          showtoast(
            "More than One Document Not Allowed..",
          );
        }
      }
    }
    notifyListeners();
  }

  void showtoast(String msgs) {
    Fluttertoast.showToast(
        msg: msgs, //"More than Three Document Not Allowed..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
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
                      if (files.length < 3) {
                        selectattachment(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        showtoast("More than Three Document Not Allowed..");
                      }
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
                      if (files.length < 3) {
                        imagetoBinary(ImageSource.camera);
                        Navigator.pop(context);
                      } else {
                        showtoast("More than Three Document Not Allowed..");
                      }
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

  sheetbottomvideo(BuildContext context) {
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
                      if (videoSelected == false) {
                        selectvideo(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        showtoast(
                          "More than One Document Not Allowed..",
                        );
                      }
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
                      if (videoSelected == false) {
                        Navigator.pop(context);
                        Get.to(() => CameraPage())!.then((value) {
                          notifyListeners();
                        });
                      } else {
                        showtoast("More than One Document Not Allowed..");
                      }
                    },
                    icon: Icon(
                      Icons.video_call,
                      size: 60,
                    ),
                  ))
            ],
          );
        },
      );
    }
  }

  sheetbottomLink(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    mycontroller[2].clear();
    {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, st) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                width: Screens.width(context),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor
                            .withOpacity(0.02), //Colors.grey[200],
                        borderRadius: BorderRadius.circular(
                            Screens.width(context) * 0.02),
                      ),
                      child: TextField(
                        controller: mycontroller[2],
                        autocorrect: false,
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Link',
                          enabledBorder: myinputborder(theme),
                          focusedBorder: myfocusborder(theme),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    Container(
                        height: Screens.bodyheight(context) * 0.065,
                        width: Screens.width(context),
                        child: ElevatedButton(
                            onPressed: () {
                              linkfile.add(mycontroller[2].text);
                              linkselected = true;
                              Navigator.pop(context);
                            },
                            child: Text("Ok")))
                  ],
                ),
              ),
            );
          });
        },
      );
    }
  }

  removeselectedImg(int ind) async {
    if (files[ind].path.split('/').last.contains("mp4")) {
      videoSelected = false;
    } else if (files[ind].path.split('/').last.toLowerCase().contains("pdf")) {
      pdfSelected = false;
    }
    files.removeAt(ind);
    notifyListeners();
  }

  removeRerdVid(int ind) async {
    linkselected = false;
    linkfile.removeAt(ind);
    notifyListeners();
  }

// video fnc

  static List<XFile> vidfile = [];

//link
  List<String> linkfile = [];

  /// File

//

  OutlineInputBorder myinputborder(ThemeData theme) {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(
          color: theme.primaryColor,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder(ThemeData theme) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(
          color: theme.primaryColor,
          width: 1,
        ));
  }

  // image view clicked

  List<Image> selectedImgClicked(int inde) {
    List<Image> img = [];
    img.add(Image.file(FeedCreationProv.files[inde]));
    for (int i = 0; i < FeedCreationProv.files.length; i++) {
      if (FeedCreationProv.files[i].path.split('/').last.contains("png") ||
          FeedCreationProv.files[i].path.split('/').last.contains("jp")) {
        if (FeedCreationProv.files[inde].path !=
            FeedCreationProv.files[i].path) {
          img.add(Image.file(FeedCreationProv.files[i]));
        }
      }
    }
    return img;
  }

  //

  openPDF(File file) async {
    PDFDocument doc = await PDFDocument.fromFile(file);
    Get.to(PDFViewePage(document: doc));
  }

  Future<void> launchUrlInBrowser(String url) async {
    log("url ${url}");
    String load = '';
    if (url.contains("http://")) {
      load = url;
    } else {
      load = "http://" + url;
    }
    if (!await launchUrl(Uri.parse(load),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // validate post
  String chooseFileType = '';
  String get getchooseFileType => chooseFileType;

  validatePost() {
    if (selectedMedia == '') {
      chooseFileType = 'Choose file type..!!';
      notifyListeners();
      return;
    }
    if (formkey.currentState!.validate()) {
      if (selectedMedia == "Image" && checkImg() == false) {
        log("checkImg() ${checkImg()}");
        // if () {
          chooseFileType = 'Choose Image..!!';
          notifyListeners();
          return;
       // }
      } else if (selectedMedia == "Video" && checkVideo() == false) {
        //if () {
          chooseFileType = 'Choose Video..!!';
          notifyListeners();
          return;
        //}
      } else if (selectedMedia == "Link" && linkfile.isEmpty) {
        //if () {
          chooseFileType = 'Enter the link..!!';
          notifyListeners();
          return;
        //}
      } else if (selectedMedia == "PDF"  && checkPdf() == false) {
        //if () {
          chooseFileType = 'Choose Pdf..!!';
          notifyListeners();
          return;
        //}
      } else {
        log("Success..!!");
      }
      notifyListeners();
    }
  }

  bool checkImg() {
    bool present = false;
    for (int i = 0; i < FeedCreationProv.files.length; i++) {
      if (FeedCreationProv.files[i].path.split('/').last.contains("png") ||
          FeedCreationProv.files[i].path.split('/').last.contains("jp")) {
        present = true;
      }
    }
    return present;
  }

  bool checkVideo() {
    bool present = false;
    for (int i = 0; i < FeedCreationProv.files.length; i++) {
      if (FeedCreationProv.files[i].path
          .split('/')
          .last
          .toLowerCase()
          .contains("mp4")) {
        present = true;
      }
    }
    return present;
  }

  bool checkPdf() {
    bool present = false;
    for (int i = 0; i < FeedCreationProv.files.length; i++) {
      if (FeedCreationProv.files[i].path
          .split('/')
          .last
          .toLowerCase()
          .contains("pdf")) {
        present = true;
      }
    }
    return present;
  }
}

class Mediatype {
  String type;
  int selected;

  Mediatype({required this.selected, required this.type});
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});
}



// // camer page func

//    bool isLoading = true;
//   late CameraController cameraController;
//   bool isRecording = false;

//   @override
//   void dispose() {
//     cameraController.dispose();
//     super.dispose();
//   }

//   _initCamera() async {
//   final cameras = await availableCameras();
//   final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
//   cameraController = CameraController(back, ResolutionPreset.max);
//   await cameraController.initialize();
//    isLoading = false;
//    notifyListeners();
// }

// bool videopause = false;
//  bool isbackCamera = true;
//  bool isfalseAvail = false;



//   pause(){
//      if (isRecording) {
//       if(videopause == false){
//          cameraController.pauseVideoRecording();
//          videopause = true;
//       }
//       else if(videopause == true){
//         cameraController.resumeVideoRecording();
//          videopause = false;
//       }
//      }
//      notifyListeners();
//   }

//   swipeCamera()async{
//     if(isbackCamera == true){
//          final cameras = await availableCameras();
//   final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
//   cameraController = CameraController(front, ResolutionPreset.max);
//     await cameraController.initialize();
 
//      isbackCamera = false;
//    notifyListeners();
//     }
//     else if(isbackCamera == false)
//     {
//            final cameras = await availableCameras();
//   final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
//   cameraController = CameraController(back, ResolutionPreset.max);
//     await cameraController.initialize();
   
//      isbackCamera = true;
//      notifyListeners();
//     }
//       notifyListeners();
//   }

//   flas()async{
//     if(isfalseAvail == false){
//       cameraController.setFlashMode(FlashMode.torch);
//       isfalseAvail = true;
//     }
//     else if(isfalseAvail == true){
//       cameraController.setFlashMode(FlashMode.off);
//       isfalseAvail = false;
//     }
//     notifyListeners();
//   }

//   recordVideo() async {
//   if (isRecording) {
//     final file = await cameraController.stopVideoRecording();
//     stopTimer();
//     isRecording = false;

//     // final route = MaterialPageRoute(
//     //   fullscreenDialog: true,
//     //   builder: (_) => VideoPage(filePath: file.path),
//     // );
//     // Navigator.push(context, route);
//   } else {
//     await cameraController.prepareForVideoRecording();
//     await cameraController.startVideoRecording();
//     startTimer();
//     isRecording = true;
//   }
//     notifyListeners();
// }

//   //trimer
//   Timer? countdownTimer;
//   Duration myDuration = Duration(days: 0);
//    void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//         notifyListeners();
//   }
//   // Step 4
//   void stopTimer() {
//     countdownTimer!.cancel();
//     notifyListeners();
//   }

//     void setCountDown() {
//     final reduceSecondsBy = 1;
//       final seconds = myDuration.inSeconds +  reduceSecondsBy;
//       if (seconds < 0) {
//         countdownTimer!.cancel();
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//       notifyListeners();
//   }


