// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../Constant/Helper.dart';
import '../../Controller/DownLoadController/DownloadController.dart';
import '../../Controller/NotificationController/NotificationController.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<DownLoadController>().setURL();
      // context.read<DownLoadController>().createDB().then((value) {
      context.read<DownLoadController>().getDefaultValues().then((value) {
        context.read<DownLoadController>().callApiNew(context);
         context.read<NotificationContoller>().getUnSeenNotify();
      });
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.03,
            vertical: Screens.bodyheight(context) * 0.02),
        child: 
        // context.watch<DownLoadController>().exception == true &&
        //         context.watch<DownLoadController>().getErrorMsg != ''
        //     ? Center(
        //         child: Text('${context.watch<DownLoadController>().errorMsg}'),
        //       )
        //     : 
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                    alignment: Alignment.center,
                    width: Screens.width(context),
                    //color: Colors.red,
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.03),
                      child: Text("Loading Initial Data Please wait..!!",
                      style: theme.textTheme.headline6,
                      )
                      ),
                  InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('Assets/20479-settings.json',
                        animate: true,
                        repeat: true,
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context) * 0.2),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.3),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                      )),
                      SizedBox(
                        height: Screens.padingHeight(context)*0.01,
                      ),

                      //  Container(
                      
                      // child: Text("Loading..${context.watch<DownLoadController>().loadingApi}")),
                      // Container(
                      
                      // child: Text("storeid..${ConstantValues.storeid}")),
                      // Container(
                      
                      // child: Text("storecode..${ConstantValues.Storecode}"))
                ],
              ),
      ),
    ));
  }
}
