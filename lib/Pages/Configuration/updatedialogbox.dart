// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/ConfigurationController/ConfigurationController.dart';
import 'package:sellerkit/Pages/Configuration/ConfigurationPage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Constant/Screen.dart';

class Upgraderdialogbox extends StatefulWidget {
  Upgraderdialogbox({
    Key? key,
    required this.storeversion,
  }) : super(key: key);
  String? storeversion;

  @override
  State<Upgraderdialogbox> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<Upgraderdialogbox> {
  @override
  void initState() {
    // TODO: implement initState
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
              "To use this app, download the latest version, You can keep using this app while downloading the update",
              style: theme.textTheme.bodyText1,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Screens.width(context) * 0.25,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () async {
                        
                        if (Platform.isAndroid || Platform.isIOS) {
                          final appId = Platform.isAndroid
                              ? 'com.busondigitalservice.sellerkit'
                              : 'com.busondigitalservice.sellerkit';
                          final url = Uri.parse(
                            Platform.isAndroid
                                ? "https://play.google.com/store/apps/details?id=com.busondigitalservice.sellerkit"
                                : "https://apps.apple.com/app/id$appId",
                          );
                          launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          ).then((value) {
                            // exit(0);
                          });
                        }
                      },
                      child: Text('Update')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
