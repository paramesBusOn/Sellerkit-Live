// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import '../../../../Constant/Screen.dart';

class WarningDialog extends StatefulWidget {
  WarningDialog({
    Key? key,
  }) : super(key: key);
  
  @override
  State<WarningDialog> createState() => AssignedToDialogUserState();
}

class AssignedToDialogUserState extends State<WarningDialog> {
static  String? typeOfDataCus;
static  String? LookingFor;
static  String? Store;
static  String? handledby;
static  String? currentstatus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
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
              // left: Screens.width(context) * 0.05,
              // right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.02,
              // bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  "This Customer has an open ${typeOfDataCus} ..!!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontSize: 15
                      //color:Colors.green
                      ),
                )), 
                
                Container(
                  width: Screens.width(context)*0.8,
                  child: Divider(color: theme.primaryColor,)),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                //
               
                Container(
                  // color: Colors.amber,
                  // width: Screens.width(context)*0.6,
                  padding: EdgeInsets.only(
                    left: Screens.width(context)*0.07,
                    right: Screens.width(context)*0.05,
                    ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Looking For",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Handled By",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            "${LookingFor}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              // fontSize: 12,
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            
                                 "${handledby}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              fontSize: 12,
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: Screens.padingHeight(context)*0.01,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Store",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Current Status",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                           width: Screens.width(context) * 0.4,
                        child: Text(
                            "${Store}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              fontSize: 12,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            
                                 "${currentstatus}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              fontSize: 12,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),

                    ],
                  ),
                ),
                 SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Container(
                  width: Screens.width(context)*0.8,
                  child: Divider(color: theme.primaryColor,)),
                 
                    
                Center(
                    child: Text("Do you want to Continue",
                  // "Click open to view this details",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
                    fontSize: 15,
                      color:theme.primaryColor
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                 Container(
                  width: Screens.width(context)*0.8,
                  child: Divider(height: 10,color: theme.primaryColor,)),
                   SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                     Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                  )),
                            ),
                           onPressed: () {
                            setState(() {
                               Navigator.pop(context);
                              context
                            .read<NewquoteController>()
                            .isAnother = false;
                             context.read<NewquoteController>().clearwarning();
                             
                        
                       
                            });
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                        
                         
                      },
                            child: Text(
                              "No",
                              style: theme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.47,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                  )),
                            ),
                           onPressed: () {
                       context
                            .read<NewquoteController>()
                            .isAnother = true;
                        Navigator.pop(context);
                       
                      },
                            child: Text(
                              "Yes",
                              style: theme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            )),
                      ),
                  
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
