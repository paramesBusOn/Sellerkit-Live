// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Controller/ConfigurationController/configuration_controller.dart';
import 'package:sellerkit/DBHelper/db_operation.dart';
import 'package:sellerkit/Pages/Configuration/ConfigurationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Constant/Screen.dart';
import '../../DBHelper/db_helper.dart';

class Upgraderdialogbox extends StatefulWidget {
  Upgraderdialogbox({
    super.key,
    required this.storeversion,
  });
  String? storeversion;

  @override
  State<Upgraderdialogbox> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<Upgraderdialogbox> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<ConfigurationContoller>().showVersion();
      String? storeversion = await context
          .read<ConfigurationContoller>()
          .getStoreVersion('com.busondigitalservice.sellerkit');
      if (ConstantValues.appversion == storeversion) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ConfigurationPage()),
          (route) => route.isFirst,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: SizedBox(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update available",
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Text(
              "There is a new version of the app",
              style: theme.textTheme.bodyMedium,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    height: Screens.bodyheight(context) * 0.08,
                    width: Screens.width(context) * 0.18,
                    padding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.008),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                    child: Image.asset(
                      'Assets/SellerSymbol.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.008),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   color: Colors.grey[200]
                    // ),
                    child: Text(
                      'Version : ${widget.storeversion}',
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // context
            // .read<ConfigurationContoller>()
            // .checkStartingPage(pagename, docEntry);
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.25,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () async {
                        await cleardatamethod();
                        if (Platform.isAndroid || Platform.isIOS) {
                          // final appId = Platform.isAndroid
                          //     ? 'com.busondigitalservice.sellerkit'
                          //     : 'com.busondigitalservice.sellerkit';
                          final url = Uri.parse(
                            Platform.isAndroid
                                ? "https://play.google.com/store/apps/details?id=com.busondigitalservice.sellerkit"
                                : "https://apps.apple.com/app/id6468899888",
                          );

                        //  await HelperFunctions.clearHost();
                          await DefaultCacheManager().emptyCache();
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          ).then((value) => Get.back());
                        }
                      },
                      child: Text('Update')),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.25,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop('Close');
                      },
                      child: Text('Close')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  

  cleardatamethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateQuotFilter(db);
    await DBOperation.truncustomerMaster(db);
    await DBOperation.truncareItemMaster(db);
    await DBOperation.truncareoutstandingmaste(db);
    await DBOperation.truncareoutstandingline(db);
    await DBOperation.truncareEnqType(db);
    await DBOperation.truncarelevelofType(db);
    await DBOperation.truncareparticularprice(db);

    await DBOperation.truncareorderType(db);

    await DBOperation.truncareCusTagType(db);
    await DBOperation.trunstateMaster(db);
    await DBOperation.truncareEnqReffers(db);
    await DBOperation.truncateUserList(db);
    await DBOperation.truncateLeadstatus(db);
    await DBOperation.truncateOfferZone(db);
    await DBOperation.truncateOfferZonechild1(db);
    await DBOperation.truncateOfferZonechild2(db);
    await DBOperation.truncatetableitemlist1(db);
    await DBOperation.truncatetableitemlist2(db);
  }
}
