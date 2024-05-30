// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sellerkit/Constant/Screen.dart';

class warningDialog extends StatefulWidget {
  warningDialog({
    Key? key,
    required this.heading,
    required this.msg,
  }) : super(key: key);

  String? heading;
  String? msg;

  @override
  State<warningDialog> createState() => _FollowUPDialogPGState();
}

class _FollowUPDialogPGState extends State<warningDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: CallDialog(context, theme));
  }

  Container CallDialog(
    BuildContext context,
    ThemeData theme,
  ) {
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(),
                    // Container(
                    //   width: Screens.width(context) * 0.1,
                    //   height: Screens.bodyheight(context) * 0.05,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: Colors.white)),
                    //   child: Icon(
                    //     Icons.call,
                    //     size: Screens.bodyheight(context) * 0.02,
                    //   ),
                    // ),
                    Container(child: Text("${widget.heading}")),
                    // Container(),
                  ],
                )),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "${widget.msg}",
                            style: theme.textTheme.bodyText1?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        // Container(
                        //   child: Text(
                        //     "Click Here",
                        //     style: theme.textTheme.bodyText2
                        //         ?.copyWith(color: Colors.grey),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => SettlementSuccessCard()));
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
                "Close",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
