import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/DownLoadController/DownloadController.dart';
import 'package:sellerkit/Controller/OfferZoneController/OfferZoneController.dart';

import '../../../Constant/Screen.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({
    Key? key,
    required this.themes,
  }) : super(key: key);

  final ThemeData themes;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screens.bodyheight(context) * 0.06,
      decoration: BoxDecoration(
        color: themes.primaryColor.withOpacity(0.1), //Colors.grey[200],
        borderRadius: BorderRadius.circular(Screens.width(context) * 0.02),
      ),
      child: TextField(
        autocorrect: false,
        onChanged: (val) {
          context.read<OfferZoneController>().offerfilterList(val);
        },
        decoration: InputDecoration(
          filled: false,
          hintText: 'Search Here!!..',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus) {
                focus.unfocus();
              }
            }, //
            color: themes.primaryColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 5,
          ),
        ),
      ),
    );
  }
}
