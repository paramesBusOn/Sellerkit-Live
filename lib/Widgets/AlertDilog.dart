// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, sort_child_properties_last
import 'package:flutter/material.dart';
import '../../../../Constant/Screen.dart';


class AlertMsg extends StatefulWidget {
  AlertMsg({
    Key? key,
    required this.msg
  }) : super(key: key);
  String msg;
  @override
  State<AlertMsg> createState() => AlertMsgState();
}

class AlertMsgState extends State<AlertMsg> {
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
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )), 
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
              bottom: Screens.bodyheight(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Text(
                  "${widget.msg}",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
                      //color:Colors.green
                      ),
                )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
               Center(
                child:  TextButton(
                      onPressed: () {
                       Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
               )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
