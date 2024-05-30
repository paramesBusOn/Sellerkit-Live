// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Constant/Screen.dart';

class PermissionShowDialog extends StatefulWidget {
  PermissionShowDialog(
      {Key? key,
      required this.locationbool,
      this.camerabool,
      this.notificationbool})
      : super(key: key);

  bool? locationbool;
  bool? camerabool;
  bool? notificationbool;
  @override
  State<PermissionShowDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<PermissionShowDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      content: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: Screens.width(context) * 0.55,
                    // color: Colors.amber,
                    child: Text(
                      "Location Services is mandatory to verify that device is within the Location designated by your Organisation.",
                      style: theme.textTheme.bodySmall,
                    )),
                widget.locationbool == false
                    ? Container(
                        height: Screens.bodyheight(context) * 0.06,
                        width: Screens.width(context) * 0.1,
                        decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      )
                    : Container(
                        height: Screens.bodyheight(context) * 0.06,
                        width: Screens.width(context) * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            // borderRadius: BorderRadius.circular(5)
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
              ],
            ),
            // SizedBox(
            //   height: Screens.bodyheight(context) * 0.01,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //         width: Screens.width(context) * 0.55,
            //         // color: Colors.amber,
            //         child: Text(
            //           "Location Services is mandatory to verify that device is within the designated Location.",
            //           style: theme.textTheme.bodySmall,
            //         )),
            //     widget.camerabool == false
            //         ? Container(
            //             height: Screens.bodyheight(context) * 0.06,
            //             width: Screens.width(context) * 0.1,
            //             decoration: BoxDecoration(
            //                 color: theme.primaryColor.withOpacity(0.1),
            //                 borderRadius: BorderRadius.circular(5)),
            //             child: Icon(
            //               Icons.camera_alt,
            //               color: Colors.black,
            //             ),
            //           )
            //         : Container(
            //             height: Screens.bodyheight(context) * 0.06,
            //             width: Screens.width(context) * 0.1,
            //             decoration: BoxDecoration(
            //                 color: theme.primaryColor.withOpacity(0.1),
            //                 borderRadius: BorderRadius.circular(5)),
            //             child: Icon(
            //               Icons.verified_sharp,
            //               color: Colors.blue,
            //             ),
            //           )
            //   ],
            // ),
            // SizedBox(
            //   height: Screens.bodyheight(context) * 0.01,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //         width: Screens.width(context) * 0.55,
            //         // color: Colors.amber,
            //         child: Text(
            //           "Location Services is mandatory to verify that device is within the designated Location.",
            //           style: theme.textTheme.bodySmall,
            //         )),
            //     widget.notificationbool == false
            //         ? Container(
            //             height: Screens.bodyheight(context) * 0.06,
            //             width: Screens.width(context) * 0.1,
            //             decoration: BoxDecoration(
            //                 color: theme.primaryColor.withOpacity(0.1),
            //                 borderRadius: BorderRadius.circular(5)),
            //             child: Icon(
            //               Icons.notification_add,
            //               color: Colors.black,
            //             ),
            //           )
            //         : Container(
            //             height: Screens.bodyheight(context) * 0.06,
            //             width: Screens.width(context) * 0.1,
            //             decoration: BoxDecoration(
            //                 color: Colors.blue,
            //                 // borderRadius: BorderRadius.circular(5)
            //                 shape: BoxShape.circle
            //                 ),
            //             child: Icon(
            //               Icons.check,
            //               color: Colors.white,
            //             ),
            //           )
            //   ],
            // ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () async {
                      await Permission.locationWhenInUse.request();
                      Navigator.pop(context); // exit(0);
                    },
                    child: Text('Close')),
                // ElevatedButton(
                //     onPressed: () {
                //       Geolocator.openAppSettings().then((value) {
                //         exit(0);
                //       });
                //     },
                //     child: Text('Go to Settings')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
