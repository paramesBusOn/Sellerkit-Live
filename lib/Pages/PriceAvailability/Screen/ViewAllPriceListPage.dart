// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/PriceListController/pricelist_controller.dart';
import '../../../DBModel/itemmasertdb_model.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class PriceListOfDetails extends StatefulWidget {
  PriceListOfDetails({Key? key}) : super(key: key);

  @override
  State<PriceListOfDetails> createState() => ListOfDetailsState();
}

class ListOfDetailsState extends State<PriceListOfDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("are you sure");
      //if(context.read<PriceListController>().getviewAll[0].brand != 'null'){
      if (context.read<PriceListController>().getviewAllBrandSelected == true) {
        print("Brand");
        //context.read<PriceListController>().brandViewAllData().then((value) {
          //context.read<PriceListController>().clearViewAllData();
       // });
      } else if (context
              .read<PriceListController>()
              .getviewAllProductSelected ==
          true) {
        print("category");
        // context.read<PriceListController>().productViewAllData().then((value) {
        //  // context.read<PriceListController>().clearViewAllData();
        // });
      } else {
        print("segment");
        // context.read<PriceListController>().segmentViewAllData().then((value) {
        //  // context.read<PriceListController>().clearViewAllData();
        // });
      }
    }
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(        drawerEnableOpenDragGesture: false,
key: scaffoldKey,
          appBar: appbar("Price List", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            padding: paddings.padding3(context),
            child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.priceList);
                      });
                    }
                  },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                 height: Screens.bodyheight(context) * 0.06,
                 decoration: BoxDecoration(
                   color: theme.primaryColor
                       .withOpacity(0.1), //Colors.grey[200],
                   borderRadius: BorderRadius.circular(
                       Screens.width(context) * 0.02),
                 ),
                 child: TextField(
                   autocorrect: false,
                   onChanged: (v) {
                   context.read<PriceListController>().filterList2(v);
                   },
                   decoration: InputDecoration(
                     filled: false,
                     hintText: 'Search Here..',
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
                       color: theme.primaryColor,
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                       vertical: 12,
                       horizontal: 5,
                     ),
                   ),
                 ),
               ),
                 SizedBox(height: Screens.bodyheight(context)*0.005,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Wrap(
                              spacing: 10.0, // gap between adjacent chips
                              runSpacing: 15.0, // gap between lines
                              children: listContainersProduct(
                                  theme,
                                  context
                                      .read<PriceListController>()
                                      .searchviewAll)),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: Screens.width(context),
                    child: ElevatedButton(
                      onPressed: () {
                        if (context
                                .read<PriceListController>()
                                .getviewAllBrandSelected ==
                            true) {
                          print("Brand selectedd1: ");
                          context
                              .read<PriceListController>()
                              .brandViewAllData()
                              .then((value) {
                            context
                                .read<PriceListController>()
                                .clearViewAllData();
                          });
                        } else if (context
                                .read<PriceListController>()
                                .getviewAllProductSelected ==
                            true) {
                          print("category");
                          context
                              .read<PriceListController>()
                              .productViewAllData()
                              .then((value) {
                            context
                                .read<PriceListController>()
                                .clearViewAllData();
                          });
                        } else {
                          print("segment");
                          context
                              .read<PriceListController>()
                              .segmentViewAllData()
                              .then((value) {
                            context
                                .read<PriceListController>()
                                .clearViewAllData();
                          });
                        }
                      },
                      child: Text("Ok"),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  List<Widget> listContainersProduct(ThemeData theme,List<ItemMasterDBModel> content,) {
    // if(content[0].brand != 'null'){
    if (context.read<PriceListController>().getviewAllBrandSelected == true) {
      return List.generate(
        context.read<PriceListController>().searchviewAll.length,
        //    content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedBrandViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.28,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context
                            .watch<PriceListController>()
                            .searchviewAll[index]
                            .isselected ==
                        1
                    //     content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].brand,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 10,
                      color: context
                                  .watch<PriceListController>()
                                  .searchviewAll[index]
                                  .isselected ==
                              1
                          //content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    }
    // else if(content[0].category != 'null'){

    else if (context.read<PriceListController>().getviewAllProductSelected ==
        true) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedProductViewAll(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.28,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: context
                            .watch<PriceListController>()
                            .searchviewAll[index]
                            .isselected ==
                        1
                    // content[index].isselected == 1
                    ? theme.primaryColor
                    : Colors.white,
                border: Border.all(color: theme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(content[index].category,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 10,
                      color: context
                                  .watch<PriceListController>()
                                  .searchviewAll[index]
                                  .isselected ==
                              1
                          // content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    }

    /// ELSE
    ///
    return List.generate(
      content.length,
      (index) => GestureDetector(
        onTap: () {
          context.read<PriceListController>().isselectedSegmentViewAll(index);
        },
        child: Container(
          alignment: Alignment.center,
          width: Screens.width(context) * 0.28,
          height: Screens.bodyheight(context) * 0.06,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<PriceListController>()
                          .searchviewAll[index]
                          .isselected ==
                      1
                  //content[index].isselected == 1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content[index].segment,
                  maxLines: 2,
                    textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    color: context
                                .watch<PriceListController>()
                                .searchviewAll[index]
                                .isselected ==
                            1
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
