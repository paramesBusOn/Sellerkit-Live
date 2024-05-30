// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/StockAvailabilityController/StockListController.dart';
import '../../../DBModel/ItemMasertDBModel.dart';
import '../../../Widgets/Navi3.dart';

class StockAvail extends StatefulWidget {
  const StockAvail({Key? key}) : super(key: key);

  @override
  State<StockAvail> createState() => StockAvailState();
}

class StockAvailState extends State<StockAvail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StockListController>().clearAllData();
      context.read<StockListController>(). getdataFromDb();
      context.read<StockListController>().getDataFromDB();
     
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
        appBar: appbar("Stock List", scaffoldKey, theme, context),
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
                        //           Container(
                        //    height: Screens.bodyheight(context) * 0.06,
                        //    decoration: BoxDecoration(
                        //      color: theme.primaryColor
                        //          .withOpacity(0.1), //Colors.grey[200],
                        //      borderRadius: BorderRadius.circular(
                        //          Screens.width(context) * 0.02),
                        //    ),
                        //    child: TextField(
                        //      autocorrect: false,
                        //    //  onChanged: (v) {
                        //     // context.read<StockListController>().filterList(v);
                        //      //},
                        //      controller: context.read<StockListController>().mycontroller[0] ,
                        //      decoration: InputDecoration(
                        //        filled: false,
                        //        hintText: 'Search Here!!..',
                        //        enabledBorder: InputBorder.none,
                        //        focusedBorder: InputBorder.none,
                        //        prefixIcon: IconButton(
                        //          icon: const Icon(Icons.search),
                        //          onPressed: () {
                        //            FocusScopeNode focus = FocusScope.of(context);
                        //            if (!focus.hasPrimaryFocus) {
                        //              focus.unfocus();
                        //            }
                        //          }, //
                        //          color: theme.primaryColor,
                        //        ),
                        //        contentPadding: const EdgeInsets.symmetric(
                        //          vertical: 12,
                        //          horizontal: 5,
                        //        ),
                        //      ),
                        //    ),
                        //  ),
                        //    SizedBox(height: Screens.bodyheight(context)*0.005,),
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
                                    InkWell(
                                      onLongPress: () async {
                                        context
                                                .read<StockListController>()
                                                .source1 =
                                            await context
                                                .read<StockListController>()
                                                .getPathOFDB();
                                        context
                                                .read<StockListController>()
                                                .copyTo =
                                            await context
                                                .read<StockListController>()
                                                .getDirectory();
    
                                        bool permission = await context
                                            .read<StockListController>()
                                            .getPermissionStorage();
                                        if (permission == true) {
                                          if ((await context
                                              .read<StockListController>()
                                              .copyTo!
                                              .exists())) {
                                            print("EXISTS");
                                            context
                                                .read<StockListController>()
                                                .createDBFile(context
                                                    .read<StockListController>()
                                                    .copyTo!
                                                    .path);
                                          } else {
                                            print("Not EXISTS");
                                            context
                                                .read<StockListController>()
                                                .createDirectory();
                                          }
                                        } else if (permission == false) {
                                          context
                                              .read<StockListController>()
                                              .showSnackBars(
                                                  'Please give stoage permission to continue!!..',
                                                  Colors.red);
                                        }
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Brand",
                                              style: theme.textTheme.subtitle1
                                                  ?.copyWith(
                                                      color: theme.primaryColor,
                                                      fontWeight: FontWeight.bold),
                                            ),
                                         
                                         
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Screens.width(context),
                                        // height: Screens.bodyheight(context)*0.2,
                                        //  color: Colors.red,
                                        child: Wrap(
                                            spacing:
                                                10.0, // gap between adjacent chips
                                            runSpacing: 10.0, // gap between lines
                                            children: listContainers(
                                                theme,
                                                context
                                                    .watch<StockListController>()
                                                    .getbrandList))),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.02,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print("object");
                                        context
                                            .read<StockListController>()
                                            .isselectedbrandViewAllPage();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context),
                                        child: InkWell(
                                          onTap: () {
                                            print("object");
                                            context
                                                .read<StockListController>()
                                                .isSelectedBrandViewAll2();
                                            context
                                                .read<StockListController>()
                                                .isselectedbrandViewAllPage();
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
                                    )
                                  ],
                                ))),
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
                                                    .read<StockListController>()
                                                    .getproductList))),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<StockListController>()
                                            .isSelectedProductViewAll2();
                                        context
                                            .read<StockListController>()
                                            .isselectedProductViewAllPage();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context),
                                        child: Text(
                                          "View All",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                        ),
                                      ),
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
                                        width: Screens.width(context),
                                        //  height: Screens.bodyheight(context)*0.2,
                                        //  color: Colors.red,
                                        child: Wrap(
                                            spacing: 10.0, // width
                                            runSpacing: 10.0, // height
                                            children: listContainersSegment(
                                                theme,
                                                context
                                                    .read<StockListController>()
                                                    .getsegmentList))),
                                    SizedBox(
                                      height: Screens.bodyheight(context) * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<StockListController>()
                                            .isSelectedSegmentViewAll2();
                                        context
                                            .read<StockListController>()
                                            .isselectedSegmentViewAllPage();
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context),
                                        child: Text(
                                          "View All",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                        ),
                                      ),
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
                        //                   context.watch<StockListController>().getrangevalue.start.toStringAsFixed(0),
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
                        //                           .read<StockListController>().getrangevalue,
                        //                     onChanged: (val){
                        //                        context
                        //                           .read<StockListController>().getrange(val);
                        //                     },
                        //                   //  divisions: 5,
                        //                      min:0,
                        //                      max: 200000,
                        //                      labels: RangeLabels(context.watch<StockListController>().getrangevalue.start.toStringAsFixed(0),
                        //                      context.watch<StockListController>().getrangevalue.end.toStringAsFixed(0)),
                        //                     )
                        //                 ),
                        //               ),
                        //               buildSlideLabel(
                        //                   context.watch<StockListController>().getrangevalue.end.toStringAsFixed(0),
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
                                .read<StockListController>()
                                .config
                                .showSearchDialogBox(context);
                          },
                          onLongPress: () {},
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
                   context.read<StockListController>().     scannerreset();
                   qrscannerState.stockscan=true;
                Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<StockListController>().scanneddataget(context);
//                 } 
//                  )
                 ;
                });
                          },
                          onLongPress: () {},
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
                            Get.toNamed(ConstantRoutes.listStockAvailability);
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
                            context.read<StockListController>().clearAllData();
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
        //      floatingActionButtonLocation: ExpandableFab.location,
        //     floatingActionButton: Padding(
        //       padding: const EdgeInsets.only(bottom: 50),
        //       child: ExpandableFab(
        //         type: ExpandableFabType.up,
        //   children: [
        //       FloatingActionButton.small(
        //         //key: ,
        //       child: const Icon(Icons.cancel_outlined),
        //       onPressed: () {
        //          context.read<StockListController>().clearAllData();
        //       //   Navigator.pop(context);
        //       },
        //       ),
        //       FloatingActionButton.small(
        //       child: const Icon(Icons.search),
        //       onPressed: () {
    
        //       },
        //       ),
        //   ],
        // ),
        //     ),
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
            context.read<StockListController>().isselectedBrand(index);
            context.read<StockListController>().isSelectedBPS();
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
            context.read<StockListController>().isselectedBrand(index);
            context.read<StockListController>().isSelectedBPS();
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
                    maxLines: 1,
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
            context.read<StockListController>().isselectedProduct(index);
            context.read<StockListController>().isSelectedBPS();
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
            context.read<StockListController>().isselectedProduct(index);
            context.read<StockListController>().isSelectedBPS();
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
            context.read<StockListController>().isselectedSegment(index);
            context.read<StockListController>().isSelectedBPS();
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
            context.read<StockListController>().isselectedSegment(index);
            context.read<StockListController>().isSelectedBPS();
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
//       .read<StockListController>()
//       .isselectedBrandString);

//   String filteredBrand = await context
//       .read<StockListController>()
//       .checkSelectedValuesBrand();

//   String filterProduct = await context
//       .read<StockListController>()
//       .checkSelectedValuesProduct();
//   String filteredSegement = await context
//       .read<StockListController>()
//       .checkSelectedValuesSegment();

//   print("filteredBrand: $filteredBrand");
//   print("filterProduct: $filterProduct");
//   print("filteredSegement: $filteredSegement");
// },
// onLongPress: () async {
//   context.read<StockListController>().source1 =
//       await context.read<StockListController>().getPathOFDB();
//   context.read<StockListController>().copyTo =
//       await context.read<StockListController>().getDirectory();

//   bool permission = await context
//       .read<StockListController>()
//       .getPermissionStorage();
//   if (permission == true) {
//     if ((await context
//         .read<StockListController>()
//         .copyTo!
//         .exists())) {
//       print("EXISTS");
//       context.read<StockListController>().createDBFile(
//           context.read<StockListController>().copyTo!.path);
//     } else {
//       print("Not EXISTS");
//       context.read<StockListController>().createDirectory();
//     }
//   } else if (permission == false) {
//     context.read<StockListController>().showSnackBars(
//         'Please give stoage permission to continue!!..',
//         Colors.red);
//   }
// },
