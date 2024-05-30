// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Screens {
  static double bodyheight(BuildContext context) {
    return MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top ;
  }
static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height ;
  }

  static double padingHeight(BuildContext context) {
    return MediaQuery.of(context).size.height  - MediaQuery.of(context).padding.top;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
    

}
