// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/DashBoardController/dashboard_controller.dart';
import '../../Controller/DownLoadController/download_controller.dart';
import '../../Controller/NotificationController/notification_controller.dart';

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
     
context.read<DownLoadController>().  cartLoading = false;
cartLoading2 = false;
      Future.delayed(Duration(seconds:8), () {
    if(mounted){
      log("hhhhhiiii");
      setState(() {
      cartLoading2 = true;
        
      });
        // context.read<DownLoadController>().  cartLoading = true;
log("hhhhhiiii222");
    }
    
     
    });
    context.read<DownLoadController>().setURL();
   
      context.read<DownLoadController>().getDefaultValues().then((value) {
        context.read<DownLoadController>().callApiNew(context);
         context.read<NotificationContoller>().getUnSeenNotify();
      });
   
    
       
        
    });
  }
bool cartLoading2=false;
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
              children: [
               cartLoading2 == true? InkWell(
                  onTap: () async{
                     setState(() {
                  
                     context.read<DownLoadController>().islogoutclick =true;
                    });
                      await  context.read<DownLoadController>().
                                                      logOutMethod();
                   
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: Screens.padingHeight(context)*0.05,
                    width: Screens.width(context),
                    child: Icon(Icons.logout,color: theme.primaryColor,),
                  ),
                ):Container(),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Container(
                          alignment: Alignment.center,
                          width: Screens.width(context),
                          //color: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.03),
                            child: Text("Loading Initial Data Please wait..!!",
                            style: theme.textTheme.titleLarge,
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
                              height: Screens.padingHeight(context)*0.02,
                            ),
                  
                          context.watch<DownLoadController>().loadingApi!.isNotEmpty?   Container(
                            
                            child: Text("Loading ${context.watch<DownLoadController>().loadingApi} ${context.watch<DownLoadController>().progressPercentage.toStringAsFixed(0)} %"
                            ,style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13),
                            )
                            ):Container(),
                            // context.watch<DownLoadController>().loadingApi!.isNotEmpty?   Container(
                            
                            // child: Text("Loading ${context.watch<DownLoadController>().loadingApi} ${context.read<DownLoadController>().callpercent()} %"
                            // ,style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13),
                            // )
                            // ):Container(),
                            // Container(
                            
                            // child: Text("storeid..${ConstantValues.storeid}")),
                            // Container(
                            
                            // child: Text("storecode..${ConstantValues.Storecode}"))
                      ],
                    ),
                ),
              ],
            ),
      ),
    ));
  }
}
