
import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    Key? key,
    required this.theme,
    required this.heading,
    required this.content,

  }) : super(key: key);

  final ThemeData theme;
  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(heading,//heading
            style: theme.textTheme.subtitle1?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: Screens.bodyheight(context)*0.005,),
           Container(
      child: Text(content,style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white60)),
    )
        ],
      ),
    );
  }
}