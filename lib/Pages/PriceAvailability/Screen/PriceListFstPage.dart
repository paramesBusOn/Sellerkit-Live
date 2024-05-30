// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/PriceListController/PriceListController.dart';
import '../../../DBModel/ItemMasertDBModel.dart';
import '../../../Widgets/Navi3.dart';

class PriceAvailability extends StatefulWidget {
  const PriceAvailability({Key? key}) : super(key: key);

  @override
  State<PriceAvailability> createState() => _PriceAvailabilityState();
}

class _PriceAvailabilityState extends State<PriceAvailability> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PriceListController>().clearAllData();
      context.read<PriceListController>().getDataFromDB();
      context.read<PriceListController>().getdataFromDb();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
       onWillPop: onbackpress,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
    
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        appBar: appbar("Price List", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: Container(
          padding: paddings.padding2(context),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              // Check if the user is swiping from left to right
              print(details.primaryDelta);
              if (details.primaryDelta! > ConstantValues.slidevalue!) {
                setState(() {
                  Get.offAllNamed(ConstantRoutes.dashboard);
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onLongPress: () async {
                            context.read<PriceListController>().source1 =
                                await context
                                    .read<PriceListController>()
                                    .getPathOFDB();
                            context.read<PriceListController>().copyTo =
                                await context
                                    .read<PriceListController>()
                                    .getDirectory();
    
                            bool permission = await context
                                .read<PriceListController>()
                                .getPermissionStorage();
                            if (permission == true) {
                              if ((await context
                                  .read<PriceListController>()
                                  .copyTo!
                                  .exists())) {
                                print("EXISTS");
                                context.read<PriceListController>().createDBFile(
                                    context
                                        .read<PriceListController>()
                                        .copyTo!
                                        .path);
                              } else {
                                print("Not EXISTS");
                                context
                                    .read<PriceListController>()
                                    .createDirectory();
                              }
                            } else if (permission == false) {
                              context.read<PriceListController>().showSnackBars(
                                  'Please give stoage permission to continue!!..',
                                  Colors.red);
                            }
                          },
                          child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: theme.primaryColor
                                              .withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(8)),
                                  width: Screens.width(context),
                                  //height: Screens.bodyheight(context) * 0.26,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Screens.width(context) * 0.015,
                                      vertical:
                                          Screens.bodyheight(context) * 0.005),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Brand",
                                          style: theme.textTheme.subtitle1
                                              ?.copyWith(
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          width: Screens.width(context),
                                          // height: Screens.bodyheight(context)*0.2,
                                          //  color: Colors.red,
                                          child: Wrap(
                                              spacing:
                                                  10.0, // gap between adjacent chips
                                              runSpacing:
                                                  10.0, // gap between lines
                                              children: listContainers(
                                                  theme,
                                                  context
                                                      .watch<
                                                          PriceListController>()
                                                      .getbrandList))),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print("object");
                                              context
                                                  .read<PriceListController>()
                                                  .isselectedbrandViewAllPage();
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: Screens.width(context) * 0.2,
                                              child: InkWell(
                                                onTap: () {
                                                  print("object");
                                                  context
                                                      .read<PriceListController>()
                                                      .isselectedbrandViewAllPage();
                                                  //  context
                                                  //     .read<PriceListController>().isSelectedBrandViewAll2();
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                        ),
                        //new ch
    
                        Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            theme.primaryColor.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(8)),
                                width: Screens.width(context),
                                // height: Screens.bodyheight(context) * 0.26,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context) * 0.015,
                                    vertical:
                                        Screens.bodyheight(context) * 0.005),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Product",
                                        style: theme.textTheme.subtitle1
                                            ?.copyWith(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   he
                                    // ),
                                    SizedBox(
                                        width: Screens.width(context),
                                        //  height: Screens.bodyheight(context)*0.2,
                                        //  color: Colors.red,
                                        child: Wrap(
                                            spacing: 10.0, // width
                                            runSpacing: 10.0, // height
                                            children: listContainersProduct(
                                                theme,
                                                context
                                                    .read<PriceListController>()
                                                    .getproductList))),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // context .read<PriceListController>().isSelectedProductViewAll2();
                                            context
                                                .read<PriceListController>()
                                                .isselectedProductViewAllPage();
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            width: Screens.width(context) * 0.2,
                                            child: Text(
                                              "View All",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                            //             }
                            //             return SizedBox();
                            //           })),
                            ),
                        Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            theme.primaryColor.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(8)),
                                width: Screens.width(context),
                                // height: Screens.bodyheight(context) * 0.26,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context) * 0.015,
                                    vertical:
                                        Screens.bodyheight(context) * 0.005),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Segment",
                                        style: theme.textTheme.subtitle1
                                            ?.copyWith(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.003,
                                    ),
                                    SizedBox(
                                        width: Screens.width(context),
                                        //  height: Screens.bodyheight(context)*0.2,
                                        //  color: Colors.red,
                                        child: Wrap(
                                            spacing: 10.0, // width
                                            runSpacing: 10.0, // height
                                            children: listContainersSegment(
                                                theme,
                                                context
                                                    .read<PriceListController>()
                                                    .getsegmentList))),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<PriceListController>()
                                                .isSelectedSegmentViewAll2();
                                            context
                                                .read<PriceListController>()
                                                .isselectedSegmentViewAllPage();
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            width: Screens.width(context) * 0.2,
                                            // color: Colors.amber,
                                            child: Text(
                                              "View All",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
    
                        // Card(
                        //     elevation: 3,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(
                        //               color: theme.primaryColor.withOpacity(0.3)),
                        //           borderRadius: BorderRadius.circular(8)),
                        //       width: Screens.width(context),
                        //       height: Screens.bodyheight(context) * 0.15,
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: Screens.width(context) * 0.02,
                        //           vertical: Screens.bodyheight(context) * 0.01),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Container(
                        //             child: Text(
                        //               "Budget",
                        //               style: theme.textTheme.subtitle1?.copyWith(
                        //                   color: theme.primaryColor,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //             children: [
                        //               buildSlideLabel(
                        //                   context.watch<PriceListController>().getrangevalue.start.toStringAsFixed(0),
                        //                   theme),
                        //               SliderTheme(
                        //                 data: SliderThemeData(
                        //                   activeTrackColor: theme.primaryColor,
                        //                   inactiveTrackColor:
                        //                       theme.primaryColor.withOpacity(0.3),
                        //                   valueIndicatorColor: theme.primaryColor,
                        //                   activeTickMarkColor: Colors.transparent,
                        //                   inactiveTickMarkColor: Colors.transparent,
                        //                 ),
                        //                 child: Expanded(
                        //                   child:
                        //                   RangeSlider(
                        //                     values:
                        //                      context
                        //                           .read<PriceListController>().getrangevalue,
                        //                     onChanged: (val){
                        //                        context
                        //                           .read<PriceListController>().getrange(val);
                        //                     },
                        //                   //  divisions: 5,
                        //                      min:0,
                        //                      max: 200000,
                        //                      labels: RangeLabels(context.watch<PriceListController>().getrangevalue.start.toStringAsFixed(0),
                        //                      context.watch<PriceListController>().getrangevalue.end.toStringAsFixed(0)),
                        //                     )
                        //                 ),
                        //               ),
                        //               buildSlideLabel(
                        //                   context.watch<PriceListController>().getrangevalue.end.toStringAsFixed(0),
                        //                   theme),
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        // ),
                      ],
                    ),
                  ),
                ),
    
                // Container(
                //   width: Screens.width(context),
                //   height: Screens.bodyheight(context) * 0.11,
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Screens.width(context) * 0.02,
                //       vertical: Screens.bodyheight(context) * 0.01),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         child: Text(
                //           "Spec",
                //           style: theme.textTheme.subtitle1?.copyWith(
                //               color: theme.primaryColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       //change
                //       // SizedBox(
                //       //     width: Screens.width(context),
                //       //     //  height: Screens.bodyheight(context)*0.2,
                //       //     //  color: Colors.red,
                //       //     child: Wrap(
                //       //         spacing: 10.0, // gap between adjacent chips
                //       //         runSpacing: 10.0, // gap between lines
                //       //         children: listContainers(
                //       //             theme, specValues, isSelectedSpec))),
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.065,
                      child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<PriceListController>()
                                .config
                                .showSearchDialogBoxPrice(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(Icons.search) //const Text('Search')
                          ),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.065,
                      child: ElevatedButton(
                          onPressed: () {
                             setState(() {
                   context.read<PriceListController>().     scannerreset();
                   qrscannerState.pricelistscan=true;
                Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<PriceListController>().scanneddataget(context);
//                 } 
//                  )
                 ;
                });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(Icons.qr_code_scanner_outlined) //const Text('Search')
                          ),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.bodyheight(context) * 0.065,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(ConstantRoutes.priceListViewData);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Search')),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.065,
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<PriceListController>().clearAllData();
                            //  Get.toNamed(ConstantRoutes.priceListViewData);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(Icons.filter_alt_off) //const Text('Clear')
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     context.read<PriceListController>().clearAllData();
        //   },
        //   child: Text("Clear"),
        // ),
      ),
    );
  }

  Widget buildSlideLabel(String value, ThemeData theme) => Text(
        value.toString(),
        style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
      );

  List<Widget> listContainers(
    ThemeData theme,
    List<ItemMasterDBModel> content,
  ) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedBrand(index);
            context.read<PriceListController>().isSelectedBPS();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedBrand(index);
            context.read<PriceListController>().isSelectedBPS();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
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

  List<Widget> listContainersProduct(
    ThemeData theme,
    List<ItemMasterDBModel> content,
  ) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedProduct(index);
            context.read<PriceListController>().isSelectedBPS();
            // context .read<PriceListController>().isSelectedProductViewAll2();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedProduct(index);
            context.read<PriceListController>().isSelectedBPS();
            // context .read<PriceListController>().isSelectedProductViewAll2();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,

            ///   padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
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

  List<Widget> listContainersSegment(
    ThemeData theme,
    List<ItemMasterDBModel> content,
  ) {
    if (content.length <= 9) {
      return List.generate(
        content.length,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedSegment(index);
            context.read<PriceListController>().isSelectedBPS();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
                          ? Colors.white
                          : theme.primaryColor,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return List.generate(
        9,
        (index) => GestureDetector(
          onTap: () {
            context.read<PriceListController>().isselectedSegment(index);
            context.read<PriceListController>().isSelectedBPS();
          },
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context) * 0.27,
            height: Screens.bodyheight(context) * 0.06,

            ///   padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: content[index].isselected == 1
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
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 10,
                      color: content[index].isselected == 1
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
}

//////

// onTap: () async {
//   print(context
//       .read<PriceListController>()
//       .isselectedBrandString);

//   String filteredBrand = await context
//       .read<PriceListController>()
//       .checkSelectedValuesBrand();

//   String filterProduct = await context
//       .read<PriceListController>()
//       .checkSelectedValuesProduct();
//   String filteredSegement = await context
//       .read<PriceListController>()
//       .checkSelectedValuesSegment();

//   print("filteredBrand: $filteredBrand");
//   print("filterProduct: $filterProduct");
//   print("filteredSegement: $filteredSegement");
// },
// onLongPress: () async {
//   context.read<PriceListController>().source1 =
//       await context.read<PriceListController>().getPathOFDB();
//   context.read<PriceListController>().copyTo =
//       await context.read<PriceListController>().getDirectory();

//   bool permission = await context
//       .read<PriceListController>()
//       .getPermissionStorage();
//   if (permission == true) {
//     if ((await context
//         .read<PriceListController>()
//         .copyTo!
//         .exists())) {
//       print("EXISTS");
//       context.read<PriceListController>().createDBFile(
//           context.read<PriceListController>().copyTo!.path);
//     } else {
//       print("Not EXISTS");
//       context.read<PriceListController>().createDirectory();
//     }
//   } else if (permission == false) {
//     context.read<PriceListController>().showSnackBars(
//         'Please give stoage permission to continue!!..',
//         Colors.red);
//   }
// },
