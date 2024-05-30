// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/NotificationController/NotificationController.dart';
import '../../../Constant/Screen.dart';

class NotifyDeleteDialog extends StatefulWidget {
  NotifyDeleteDialog({Key? key, required this.docid, }) : super(key: key);
  int  docid;

  @override
  State<NotifyDeleteDialog> createState() => NotifyDeleteState();
}

class NotifyDeleteState extends State<NotifyDeleteDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
 
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: 
        notifyDialog(context, theme)
    );
  }

  Container notifyDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
    
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
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )), 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(),
                    Container(child: Text("Alert")),
                    Container(),
                  ],
                )),
          ),

      
          Container(
            width: Screens.width(context),
              padding: EdgeInsets.all(10),
            child: Column(
              children: [
                 SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.28,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                          )),
                    ),
                    SizedBox(width: Screens.width(context)*0.01,),
                       Container(
                      width: Screens.width(context) * 0.28,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                           context.read<NotificationContoller>().deleteNotify(widget.docid);
                            Navigator.pop(context);
                           
                          },
                          child: Text(
                            "Delete",
                          )),
                    ),
                    SizedBox(width: Screens.width(context)*0.01,),
                       Container(
                      width: Screens.width(context) * 0.28,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                           context.read<NotificationContoller>().deleteNotifyAll();
                            Navigator.pop(context);
                           
                          },
                          child: Text(
                            "Delete All",
                          )),
                    ),
                  ],
                )
              ],
            )
          ),
       
         
        ],
      ),
    );
  }

}
