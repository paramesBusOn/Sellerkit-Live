 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/AccountsController/AccountsController.dart';

class SearchbarWidget extends StatelessWidget {
  const SearchbarWidget({
    Key? key,
    required this.theme,
    required this.accountsContoller
  }) : super(key: key);

  final ThemeData theme;
  final  AccountsContoller accountsContoller  ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          Screens.bodyheight(context) *
              0.06,
      decoration: BoxDecoration(
        color: theme.primaryColor
            .withOpacity(
                0.1), //Colors.grey[200],
        borderRadius:
            BorderRadius.circular(
                Screens.width(context) *
                    0.02),
      ),
      child: TextField(
        autocorrect: false,
        onChanged: (v) {
          print(v);
          accountsContoller.SearchFilter(v);
        },
        decoration: InputDecoration(
          filled: false,
          hintText: 'Search Here!!..',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: IconButton(
            icon:
                const Icon(Icons.search),
            onPressed: () {
              FocusScopeNode focus =
                  FocusScope.of(context);
              if (!focus
                  .hasPrimaryFocus) {
                focus.unfocus();
              }
              accountsContoller.boolmethod();
              // Get.offAllNamed(ConstantRoutes.cartLoading);
              // setState(() {
              // prdACC.boolmethod();
              // });
            }, //
            color: theme.primaryColor,
          ),
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 5,
          ),
        ),
      ),
    );
  }
}
