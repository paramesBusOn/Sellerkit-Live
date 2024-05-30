// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sellerkit/Controller/FeedCreationcontroller/VideoPlayer.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/FeedCreationcontroller/FeedCrtController.dart';
import '../../../Controller/FeedCreationcontroller/ThumnailPage.dart';

class FeedCreationPage extends StatelessWidget {
   FeedCreationPage({
    Key? key,
    required this.theme,
    required this.fdp,
  }) : super(key: key);

  final ThemeData theme;
  final FeedCreationProv fdp;
 StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
    //  height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.bodyheight(context) * 0.02),
      child: SingleChildScrollView(
        child: Form(
          key: fdp.formkey,
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
                child: TextFormField(
                  controller: fdp.mycontroller[0],
                  validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Title";
                            }
                            return null;
                          },
                  autocorrect: false,
                  onChanged: (v) {},
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Title',
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
                decoration: BoxDecoration(
                  color: theme.primaryColor
                      .withOpacity(0.02), //Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                      Screens.width(context) * 0.02),
                ),
                child: TextFormField(
                  validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Description";
                            }
                            return null;
                          },
                  controller: fdp.mycontroller[1],
                  autocorrect: false,
                  onChanged: (v) {},
                  maxLines: 8,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Description',
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
                width: Screens.width(context),
                // height: Screens.bodyheight(context)*0.3,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.02,
                    vertical: Screens.bodyheight(context) * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(fdp.getchooseFileType,
                      style: theme.textTheme.bodyText2?.
                      copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height:fdp.getchooseFileType.isNotEmpty?
                     Screens.bodyheight(context)*0.01: 0,),
                    Wrap(
                        spacing: 10.0, // width
                        runSpacing: 08.0, // height
                        children: listMdeia(theme, fdp,context)
                       ),
                  ],
                ),
              ),
              SizedBox(height:FeedCreationProv.files.isEmpty ? 0: Screens.bodyheight(context)*0.01,),
              Visibility(visible: FeedCreationProv.files.isEmpty ? false: true ,
                           // child:
                           //  Expanded(
                      // height: Screens.padingHeight(context) * 0.3,
                      // padding: EdgeInsets.only(
                      //   top: Screens.padingHeight(context) * 0.001,
                      //   right: Screens.padingHeight(context) * 0.015,
                      //   left: Screens.padingHeight(context) * 0.015,
                      //   bottom: Screens.padingHeight(context) * 0.001,
                      // ),
                      child: ListView.builder(
                        shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                            itemCount: FeedCreationProv.files.length,
                            itemBuilder: (BuildContext context, int i) {
                              if (FeedCreationProv.files[i].path
                                  .split('/')
                                  .last
                                  .contains("png")) {
                                return InkWell(
                                  onTap: (){
                                     final remoteImages =  fdp.selectedImgClicked(i);              
                                      SwipeImageGallery(
                                                          context: context,
                                                        children: remoteImages,
                                                          onSwipe: (index) {
                                                          },
                                                          overlayController:
                                                              overlayController,
                                                        ).show();
                                  },
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                     decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.09,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: Center(
                                                  child: Image.file( FeedCreationProv.files[i]))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Text(
                                                FeedCreationProv.files[i].path
                                                    .split('/')
                                                    .last,
                                                // overflow: TextOverflow.ellipsis,
                                              )),
                                          Container(
                                              width:
                                                  Screens.width(context) *
                                                      0.1,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: IconButton(
                                                  onPressed: () {
                                                 fdp. removeselectedImg(i);
                                                      // fdp.files
                                                      //     .removeAt(i);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ])
                                      // )
                                      ),
                                );
                              }
                               else if (FeedCreationProv.files[i].path
                                  .split('/')
                                  .last
                                  .contains("jp")) {
                                return InkWell(
                                    onTap: (){
                                     final remoteImages =  fdp.selectedImgClicked(i);              
                                      SwipeImageGallery(
                                                          context: context,
                                                        children: remoteImages,
                                                          onSwipe: (index) {
                                                          },
                                                          overlayController:
                                                              overlayController,
                                                        ).show();
                                  },
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                     decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.09,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: Center(
                                                  child: Image.file(FeedCreationProv.files[i]))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Text(
                                                FeedCreationProv.files[i].path
                                                    .split('/')
                                                    .last,
                                                // overflow: TextOverflow.ellipsis,
                                              )),
                                          Container(
                                              width:
                                                  Screens.width(context) *
                                                      0.1,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: IconButton(
                                                  onPressed: () {
                                                 fdp. removeselectedImg(i);
                                                      // fdp.files
                                                      //     .removeAt(i);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ])
                                      // )
                                      ),
                                );
                              }
                               else if (FeedCreationProv.files[i].path
                                  .split('/')
                                  .last
                                  .contains("mp4")) {
                                return InkWell(
                                  onTap: (){
                                     Get.to(()=> VideoPlayerPage(filePath: FeedCreationProv.files[i].path));
                                  },
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                     decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width:
                                                  Screens.width(context) *
                                                      0.09,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: ThumnailPage(filePath: FeedCreationProv.files[i].path,)
                                                  ),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                               //  color: Colors.red,
                                              ),
                                              width:
                                                  Screens.width(context) *
                                                      0.6,
                                              alignment:
                                                  Alignment.centerLeft,
                                              child: Text(
                                                FeedCreationProv.files[i].path
                                                    .split('/')
                                                    .last,
                                              )),
                                          Container(
                                              width:
                                                  Screens.width(context) *
                                                      0.1,
                                              height:
                                                  Screens.padingHeight(
                                                          context) *
                                                      0.06,
                                              child: IconButton(
                                                  onPressed: () {
                                                 fdp. removeselectedImg(i);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ])
                                      ),
                                );
                              }
                              return InkWell(
                                onTap: (){
                                  fdp.openPDF(FeedCreationProv.files[i]);
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                   decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                      children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(),
                                            width:
                                                Screens.width(context) *
                                                    0.09,
                                            height: Screens.padingHeight(
                                                    context) *
                                                0.06,
                                            child: Center(
                                                child: Image.asset("Assets/pdfimg.png"))),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(),
                                            width:
                                                Screens.width(context) *
                                                    0.6,
                                            // height: Screens.padingHeight(context) * 0.06,
                                            alignment:
                                                Alignment.centerLeft,
                                            child: Text(
                                              FeedCreationProv.files[i].path
                                                  .split('/')
                                                  .last,
                                            )),
                                        Container(
                                            width:
                                                Screens.width(context) *
                                                    0.1,
                                            height: Screens.padingHeight(
                                                    context) *
                                                0.06,
                                            child: IconButton(
                                                onPressed: () {
                                                      fdp. removeselectedImg(i);
                                                },
                                                icon: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.grey,
                                                )))
                                      ])
                                ])
                                    ),
                              );
                            })),
              SizedBox(height:  fdp.linkfile.isEmpty ? 0: Screens.bodyheight(context)*0.01,),
              Visibility(
                            visible: fdp.linkfile.isEmpty ? false: true ,
                           // child: Expanded(
                      // height: Screens.padingHeight(context) * 0.3,
                      // padding: EdgeInsets.only(
                      //   top: Screens.padingHeight(context) * 0.001,
                      //   right: Screens.padingHeight(context) * 0.01,
                      //   left: Screens.padingHeight(context) * 0.01,
                      //   bottom: Screens.padingHeight(context) * 0.001,
                      // ),
                      child: ListView.builder(
                    physics:    BouncingScrollPhysics(),
                        shrinkWrap: true,
                            itemCount:  fdp.linkfile.length,
                            itemBuilder: (BuildContext context, int i) {
                              
                              return InkWell(
                                onTap: (){
                                 fdp.launchUrlInBrowser(fdp.linkfile[i].toString());
                                },
                                child: Container(
                                   padding: EdgeInsets.only(
                                      right: Screens.width(context) * 0.01,
                                      left: Screens.width(context) * 0.01,
                                      bottom: Screens.bodyheight(context) * 0.01,
                                      top: Screens.bodyheight(context) * 0.01,
                                    ),
                                   decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                    children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(),
                                            width:
                                                Screens.width(context) *
                                                    0.09,
                                            height: Screens.padingHeight(
                                                    context) *
                                                0.06,
                                            child: Center(
                                                child: Image.asset("Assets/web.png")
                                                )),
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(),
                                            width:
                                                Screens.width(context) *
                                                    0.6,
                                            // height: Screens.padingHeight(context) * 0.06,
                                            alignment:
                                                Alignment.centerLeft,
                                            child: Text(
                                             fdp.linkfile[i],
                                            )),
                                        Container(
                                            width:
                                                Screens.width(context) *
                                                    0.1,
                                            height: Screens.padingHeight(
                                                    context) *
                                                0.06,
                                            child: IconButton(
                                                onPressed: () {
                                                      fdp. removeRerdVid(i);
                                                    
                                                },
                                                icon: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.grey,
                                                )))
                                      ])
                                ])
                                    ),
                              );
                            })),
               SizedBox(height: Screens.bodyheight(context)*0.01,),
              Container(
                width: Screens.width(context),
                child: ElevatedButton(onPressed: (){
                  fdp.validatePost();
                }, child: Text("Post")))       
            ],
          ),
        ),
      ),
    );
  }

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

  List<Widget> listMdeia(ThemeData theme, FeedCreationProv fdp,BuildContext context) {
    return List.generate(
      fdp.getmediatype.length,
      (index) => InkWell(
        onTap: () {
          fdp.selectMeida(fdp.getmediatype[index].type.toString(), context,fdp);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: fdp.getselectedMedia ==
                      fdp.getmediatype[index].type.toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(fdp.getmediatype[index].type.toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: fdp.getselectedMedia ==
                            fdp.getmediatype[index].type.toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

    //  String selected = fdp.getmediatype[index].type.toString();
    //       fdp.selectedMedia = selected;
    // if(selected == "Image"){
    //   fdp.sheetbottom(context);
    // }
    // else if(selected == "Video")
    // {
    
    // }