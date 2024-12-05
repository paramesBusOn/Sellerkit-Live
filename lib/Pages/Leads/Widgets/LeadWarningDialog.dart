// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Controller/LeadController/leadnew_controller.dart';

class LeadWarningDialog extends StatefulWidget {
  LeadWarningDialog({Key? key, }) : super(key: key);
  @override
  State<LeadWarningDialog> createState() => LeadWarningDialogState();
}

class LeadWarningDialogState extends State<LeadWarningDialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: statusRespPage(context, theme));
  }

  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
            width: Screens.width(context),

      child: Column(
              mainAxisSize: MainAxisSize.min,

        children: [
           Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
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
                  "Alert",
                )),
          ),
          Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               
                Center(
                    child: Text(
                  "This Customer has an open ${LeadNewController.typeOfLeadOrEnq} with ${LeadNewController.branchOfLeadOrEnq} branch..!!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Center(
                    child: Text(
                  "Click open to view this details",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<LeadNewController>().cancelDialog(context);
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                         //Navigator.pop(context);
                        //  context.read<EnquiryUserContoller>(). isAnotherBranchEnq = false;
                        // context.read<EnquiryUserContoller>().resetAll(context);
                      },
                      child: Text(
                        "Cancel",
                        style:
                            theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: () {
                       if(LeadNewController.branchOfLeadOrEnq == 'this'){
                        context.read<LeadNewController>().callLeadPageSB(context);
                       }
                       else{
                         context.read<LeadNewController>().callLeadPageNSB(context);
                       }
                      },
                      child: Text(
                        "Open",
                        style:
                            theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(theme.primaryColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
