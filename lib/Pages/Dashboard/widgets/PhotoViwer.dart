// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/Profile/Screen/Newprofile.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/NewProfileController/NewProfileController.dart';

class PhotoViewer extends StatefulWidget {
  @override
  State<PhotoViewer> createState() => PhotoViewState();
}

class PhotoViewState extends State<PhotoViewer> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress1,
      child: Scaffold(
          backgroundColor: Colors.black,
          key: scaffoldKey,
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.toNamed(ConstantRoutes.newprofile);
                  },
                  icon: Icon(Icons.arrow_back, color: theme.primaryColor)),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Profile Photo",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headline6?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.normal),
                      )),
                
                  IconButton(
                      onPressed: () {
                        context
                            .read<NewProfileController>()
                            .sheetbottom(context);
                      },
                      icon: Icon(Icons.edit, color: theme.primaryColor))
                ],
              )),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            child: Stack(
              children: [
                InteractiveViewer(
                    scaleEnabled: true,
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4,
                    child: ConstantValues.profilepic!.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${ConstantValues.profilepic}"),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("Assets/avatar.png"),
                                    fit: BoxFit.cover)))),
                Visibility(
                  visible: context.watch<NewProfileController>().isprogress,
                  child: Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context),
                    color: Colors.white54,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
