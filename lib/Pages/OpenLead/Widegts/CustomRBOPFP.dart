import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/OpenLeadController/OpenLeadController.dart';
import '../../../Constant/Screen.dart';

class CustomRadioBtnOPLFUP extends StatelessWidget {
   CustomRadioBtnOPLFUP({
    Key? key,
    required this.theme,
    required this.onPressed1,
    required this.onPressed2,
    required this.text1,
    required this.text2, 
    // required this.fUPCon
  }) : super(key: key);

  final ThemeData theme;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final String text1;
  final String text2;
  // OpenLeadController fUPCon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onPressed1,
          child: Container(
            width: Screens.width(context) * 0.4,
            height: Screens.bodyheight(context) * 0.06,
            //  padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: 
              context.read<OpenLeadController>().getisSelectedFollowUp ==
                       text1
                    ? 
                    theme.primaryColor
                   : Colors.white,
                border:
                    Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text1,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: 
                       context.read<OpenLeadController>().getisSelectedFollowUp ==
                             text1
                          ?
                           Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
        InkWell(
          onTap: onPressed2,
          child: Container(
            width: Screens.width(context) * 0.4,
            height: Screens.bodyheight(context) * 0.06,
            //  padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: 
                context.read<OpenLeadController>().getisSelectedFollowUp ==
                       text2
                    ?
                     theme.primaryColor
                    : Colors.white,
                border:
                    Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text2,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1?.copyWith(
                      color: 
                      context.read<OpenLeadController>().getisSelectedFollowUp ==
                             text2
                          ? 
                          Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}