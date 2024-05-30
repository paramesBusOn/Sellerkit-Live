// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/SiteOutController/SiteOutController.dart';
import '../../../../Constant/Screen.dart';


class AssignToMeDialog extends StatefulWidget {
  AssignToMeDialog({Key? key}) : super(key: key);
  @override
  State<AssignToMeDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<AssignToMeDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: assignedTOPage(context,theme),
     );
  }

    Container assignedTOPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
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
            height: Screens.padingHeight(context)*0.4,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
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
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                 context.read<SiteOutController>().selectedAssignedUser();
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
    );
  }


  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
     context.watch<SiteOutController>().getuserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<SiteOutController>().selectedIdxFUser = ind;
          context.read<SiteOutController>().selectUser(ind);
        },
        child: Container(
          // alignment: Alignment.center,
          // width: Screens.width(context) * 0.2,
          // height: Screens.bodyheight(context) * 0.06,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<SiteOutController>()
                          .getuserLtData[ind]
                          .color ==
                      1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context
                  .watch<SiteOutController>()
                  .getuserLtData[ind]
                  .UserName!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: context
                            .watch<SiteOutController>()
                            .getuserLtData[ind]
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