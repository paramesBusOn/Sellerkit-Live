// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/callNotificationController/callnotification_controller.dart';
import '../../../../Constant/Screen.dart';


class EnqAssignUserDialog extends StatefulWidget {
  EnqAssignUserDialog({Key? key,}) : super(key: key);
  @override
  // List<UserListData> filteruserLtData;
  // CallNotificationController callCon2;
  State<EnqAssignUserDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<EnqAssignUserDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
      width: Screens.width(context),
       height: Screens.bodyheight(context) * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.11,
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Assigned to",
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context)*0.42,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              // top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //           height: Screens.bodyheight(context) * 0.06,
                  //           decoration: BoxDecoration(
                  //               color: Colors.grey[200],
                  //               borderRadius: BorderRadius.circular(
                  //                   Screens.width(context) * 0.01),
                  //               // boxShadow: [
                  //               //   BoxShadow(
                  //               //     color: Colors.grey.withOpacity(0.7),
                  //               //     spreadRadius: 3,
                  //               //     blurRadius: 4,
                  //               //     offset: Offset(
                  //               //         0, 3), // changes position of shadow
                  //               //   ),
                  //               // ]
                  //               ),
                  //           child: TextField(
                  //             // controller:context.read<NewEnqController>().mycontroller[5] ,
                  //             onTap: () {

                  //               // Get.toNamed(ConstantRoutes.screenshot);
                  //             },
                  //             autocorrect: false,
                  //             onChanged: (v) {
                  //               setState(() {
                  //                                             context.read<CallNotificationController>().filterListAssignData(v);
                  //               });
                  //             },
                  //             decoration: InputDecoration(
                  //               filled: false,
                  //               hintText: 'Search',
                  //               enabledBorder: InputBorder.none,
                  //               focusedBorder: InputBorder.none,
                  //               suffixIcon: Icon(
                  //                 Icons.search,
                  //                 color: theme.primaryColor,
                  //               ),
                  //               contentPadding: const EdgeInsets.symmetric(
                  //                 vertical: 12,
                  //                 horizontal: 5,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),
                  Wrap(
                      spacing: 5.0, // gap between adjacent chips
                      runSpacing: 5.0, // gap between lines
                      children: listContainersProduct(
                        theme,
                      )),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  
                ],
              ),
            ),
          ),

        Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.1,
            child: ElevatedButton(
              onPressed: () {
                 context.read<CallNotificationController>().selectedAssignedUser();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Select",
              ),
            ),
          ),
        ],
      ),
    ),
     );
  }

  //   Container assignedTOPage(BuildContext context, ThemeData theme) {
  //   return 
  // }


  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
    context.watch<CallNotificationController>(). filteruserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<CallNotificationController>().selectedIdxFUser = ind;
          context.read<CallNotificationController>().selectUser(ind);
        },
        child: Container(
          // alignment: Alignment.center,
          // width: Screens.width(context) * 0.2,
          // height: Screens.bodyheight(context) * 0.06,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color:context.watch<CallNotificationController>().filteruserLtData[ind]
                          .color ==
                      1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
             context.watch<CallNotificationController>().filteruserLtData[ind]
                  .UserName!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:context.watch<CallNotificationController>().filteruserLtData[ind]
                            .color ==
                        1
                    ? Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}