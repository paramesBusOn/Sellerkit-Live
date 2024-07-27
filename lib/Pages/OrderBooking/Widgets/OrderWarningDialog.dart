
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Controller/OrderController/OrderNewController.dart';

class OrderWarningDialog extends StatefulWidget {
  const OrderWarningDialog({
    super.key,
  });
  @override
  State<OrderWarningDialog> createState() => OrderWarningDialogState();
}

class OrderWarningDialogState extends State<OrderWarningDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: statusRespPage(context, theme));
  }

  SizedBox statusRespPage(BuildContext context, ThemeData theme) {
    return SizedBox(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      // fontSize: 12,
                      ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: const Text(
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
                  "This Customer has an open ${OrderNewController.typeOfLeadOrEnq} with ${OrderNewController.branchOfLeadOrEnq} branch..!!",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1?.copyWith(
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
                        context
                            .read<OrderNewController>()
                            .cancelDialog(context);
                        // context.read<EnquiryUserContoller>().checkDialogCon();
                        //Navigator.pop(context);
                        //  context.read<EnquiryUserContoller>(). isAnotherBranchEnq = false;
                        // context.read<EnquiryUserContoller>().resetAll(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                      child: Text(
                        "Cancel",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (OrderNewController.branchOfLeadOrEnq == 'this') {
                          context
                              .read<OrderNewController>()
                              .callLeadPageSB(context);
                        } else {
                          context
                              .read<OrderNewController>()
                              .callLeadPageNSB(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                      child: Text(
                        "Open",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
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
