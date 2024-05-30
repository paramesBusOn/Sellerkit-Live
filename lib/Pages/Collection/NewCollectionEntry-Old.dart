// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// // import 'package:sellerkit/Pages/Mycustomer/widgets/ShowSearchDialog.dart';
// import '../../Constant/ConstantRoutes.dart';
// import '../../Controller/CollectionController/NewCollectionEntryCotroller.dart';
// import '../../Widgets/Appbar.dart';
// import '../../Widgets/Navi3.dart';

// class NewCollectionEntry extends StatefulWidget {
//   NewCollectionEntry({Key? key}) : super(key: key);

//   @override
//   State<NewCollectionEntry> createState() => NewCollectionEntryState();
// }

// class NewCollectionEntryState extends State<NewCollectionEntry> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         context.read<NewCollectionContoller>().init();
//       });
//       // context.read<NewCollectionContoller>().getDataMethod();

//       // print("sap user id: "+ConstantValues.sapUserID);

//       // log("page on: "+context.read<NewCollectionContoller>().pageChanged.toString());
//       // log("showItemList"+context.read<NewCollectionContoller>().showItemList.toString());
//       //  log("oldcutomer: "+context.read<NewCollectionContoller>().oldcutomer.toString());
//     });
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> onbackpress() {
//     DateTime now = DateTime.now();

//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       Get.offAllNamed(ConstantRoutes.dashboard);
//       return Future.value(true);
//     } else {
//       return Future.value(true);
//     }
//   }
//   // @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   super.dispose();
//   //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

//   //  // });
//   // }
//   final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return WillPopScope(
//       onWillPop: onbackpress,
//       child: Scaffold(
//           drawerEnableOpenDragGesture: false,
//           // backgroundColor: Colors.grey[200],
//           /// resizeToAvoidBottomInset: true,
//           key: scaffoldKey1,
//           appBar: appbar("New Collection Entry", scaffoldKey1, theme, context),
//           drawer: drawer3(context),
//           body: PageView(
//             physics: new NeverScrollableScrollPhysics(),
//             controller: context.read<NewCollectionContoller>().pageController,
//             onPageChanged: (index) {
//               log("index: ${index}");
//               setState(() {
//                 context.read<NewCollectionContoller>().pageChanged = index;
//               });
//               print(context.read<NewCollectionContoller>().pageChanged);
//             },
//             children: [
//               GestureDetector(onHorizontalDragUpdate: (details) {
//                     // Check if the user is swiping from left to right
//                     print(details.primaryDelta);
//                     if (details.primaryDelta! > ConstantValues.slidevalue!) {
//                       setState(() {
//                         Get.offAllNamed(ConstantRoutes.collectionlist);
//                       });
//                     }
//                   },
//                 child: FirstPage(
//                   context,
//                   theme,
//                 ),
//               ),
//               SecondPage(context, theme),
//               Container(
//                   // color: Colors.blue,
//                   width: Screens.width(context),
//                   height: Screens.bodyheight(context),
//                   padding: EdgeInsets.only(
//                       left: Screens.width(context) * 0.01,
//                       right: Screens.width(context) * 0.01,
//                       bottom: Screens.bodyheight(context) * 0.01,
//                       top: Screens.bodyheight(context) * 0.02),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: Screens.width(context) * 0.03,
//                               vertical: Screens.bodyheight(context) * 0.008),
//                           width: Screens.width(context),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: theme.primaryColor)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: Screens.width(context),
//                                 child: Text(
//                                   "Payment Mode",
//                                   style: theme.textTheme.headline6
//                                       ?.copyWith(color: theme.primaryColor),
//                                 ),
//                               ),
//                               Container(
//                                 width: Screens.width(context),
//                                 child: DropdownButton(
//                                   hint: Text("Select Mode"),
//                                   // value: context.read<EnquiryUserContoller>(). valueChosedReason,
//                                   //dropdownColor:Colors.green,
//                                   icon: Icon(Icons.arrow_drop_down),
//                                   iconSize: 30,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16),
//                                   isExpanded: true,
//                                   value: context
//                                       .read<NewCollectionContoller>()
//                                       .paymentmode,
//                                   onChanged: (val) {
//                                     // setState(() {
//                                     //   valueChosedReason = val.toString();
//                                     //   print(val.toString());
//                                     //   print("valavalaa: .........." +
//                                     //       valueChosedReason.toString());
//                                     // });
//                                     context
//                                         .read<NewCollectionContoller>()
//                                         .resonChoosed(val.toString());
//                                   },
//                                   items: <String>[
//                                     "Cash",
//                                     "Cheque",
//                                     "Card",
//                                     "UPI",
//                                     "DD"
//                                   ].map((String value) {
//                                     return DropdownMenuItem(
//                                         value: value,
//                                         child: Text(value.toString()));
//                                   }).toList(),
//                                 ),
//                               ),
//                               context
//                                       .read<NewCollectionContoller>()
//                                       .paymentmodeErro
//                                       .isEmpty
//                                   ? Container()
//                                   : Container(
//                                       width: Screens.width(context),
//                                       child: Text(
//                                         "${context.watch<NewCollectionContoller>().paymentmodeErro}",
//                                         style: theme.textTheme.bodyText1!
//                                             .copyWith(color: Colors.red),
//                                       ),
//                                     ),
//                               TextFormField(
//                                   controller: context
//                                       .read<NewCollectionContoller>()
//                                       .mycontroller[5],
//                                   readOnly: true,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Enter Amount";
//                                     } else
//                                       return null;
//                                   },
//                                   onChanged: (v) {},
//                                   inputFormatters: [
//                                     new LengthLimitingTextInputFormatter(10),
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     labelText: 'Amount',
//                                     labelStyle: theme.textTheme.bodyText1!
//                                         .copyWith(color: Colors.grey),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.grey),
//                                       //  when the TextFormField in unfocused
//                                     ),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.grey),
//                                       //  when the TextFormField in focused
//                                     ),
//                                     border: UnderlineInputBorder(),
//                                     // enabledBorder: UnderlineInputBorder(),
//                                     // focusedBorder: UnderlineInputBorder(),
//                                     errorBorder: UnderlineInputBorder(),
//                                     focusedErrorBorder: UnderlineInputBorder(),
//                                   )),
//                               TextFormField(
//                                   controller: context
//                                       .read<NewCollectionContoller>()
//                                       .mycontroller[6],
//                                   // validator: (value) {
//                                   //   if (value!.isEmpty) {
//                                   //     return "Enter Reference";
//                                   //   }
//                                   //   return null;
//                                   // },
//                                   decoration: InputDecoration(
//                                     labelText: 'Reference',
//                                     labelStyle: theme.textTheme.bodyText1!
//                                         .copyWith(color: Colors.grey),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.grey),
//                                       //  when the TextFormField in unfocused
//                                     ),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: Colors.grey),
//                                       //  when the TextFormField in focused
//                                     ),
//                                     border: UnderlineInputBorder(),
//                                     // enabledBorder: UnderlineInputBorder(),
//                                     // focusedBorder: UnderlineInputBorder(),
//                                     errorBorder: UnderlineInputBorder(),
//                                     focusedErrorBorder: UnderlineInputBorder(),
//                                   )),
//                               SizedBox(
//                                 height: Screens.bodyheight(context) * 0.01,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               width: Screens.width(context) * 0.3,
//                               height: Screens.bodyheight(context) * 0.07,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     context
//                                         .read<NewCollectionContoller>()
//                                         .pageController
//                                         .animateToPage(
//                                             --context
//                                                 .read<NewCollectionContoller>()
//                                                 .pageChanged,
//                                             duration:
//                                                 Duration(milliseconds: 250),
//                                             curve: Curves.bounceIn);
//                                   },
//                                   child: Icon(Icons.keyboard_arrow_left)),
//                             ),
//                             SizedBox(
//                               width: Screens.width(context) * 0.3,
//                               height: Screens.bodyheight(context) * 0.07,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     FocusScopeNode focus =
//                                         FocusScope.of(context);
//                                     if (!focus.hasPrimaryFocus) {
//                                       focus.unfocus();
//                                     }
//                                     // provi.pageController.animateToPage(++provi.pageChanged,
//                                     //     duration: Duration(milliseconds: 250),
//                                     //     curve: Curves.bounceIn);

//                                     context
//                                         .read<NewCollectionContoller>()
//                                         .validateFinal(
//                                           context,
//                                         );
//                                     // log("oldcutomer: " +
//                                     //     context
//                                     //         .read<NewCollectionContoller>()
//                                     //         .oldcutomer
//                                     //         .toString());
//                                   },
//                                   child: Icon(Icons.save)),
//                             ),
//                           ],
//                         )
//                       ])),
//             ],
//           )),
//     );
//   }

//   Container SecondPage(
//     BuildContext context,
//     ThemeData theme,
//   ) {
//     //  return ChangeNotifierProvider<NewCollectionContoller>(
//     //       create: (context) => NewCollectionContoller(),
//     //       builder: (context, child) {
//     //         return Consumer<NewCollectionContoller>(
//     //           builder: (BuildContext context, provi, Widget? child) {
//     return Container(
//       // color: Colors.blue,
//       width: Screens.width(context),
//       height: Screens.bodyheight(context),
//       padding: EdgeInsets.only(
//           left: Screens.width(context) * 0.01,
//           right: Screens.width(context) * 0.01,
//           bottom: Screens.bodyheight(context) * 0.01,
//           top: Screens.bodyheight(context) * 0.02),
//       child: Column(
//         children: [
//           Container(
//             height: Screens.bodyheight(context) * 0.06,
//             decoration: BoxDecoration(
//               color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
//               borderRadius:
//                   BorderRadius.circular(Screens.width(context) * 0.02),
//             ),
//             child: TextField(
//               autocorrect: false,
//               onChanged: (val) {
//                 context.read<NewCollectionContoller>().filterList(val);
//               },
//               controller:
//                   context.read<NewCollectionContoller>().mycontroller[12],
//               decoration: InputDecoration(
//                 filled: false,
//                 hintText: 'Search Here!!..',
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () {
//                     FocusScopeNode focus = FocusScope.of(context);
//                     if (!focus.hasPrimaryFocus) {
//                       focus.unfocus();
//                     }
//                     context.read<NewCollectionContoller>().changeVisible();
//                   }, //
//                   color: theme.primaryColor,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 11,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           context.read<NewCollectionContoller>().showItemList == true
//               ? Expanded(
//                   child: ListView.builder(
//                     itemCount: context
//                         .watch<NewCollectionContoller>()
//                         .allProductDetails
//                         .length,
//                     itemBuilder: (BuildContext context, int i) {
//                       return InkWell(
//                         onTap: () {
//                           context.read<NewCollectionContoller>().resetItems(i);
//                           context
//                               .read<NewCollectionContoller>()
//                               .isUpdateClicked = false;
//                           // context
//                           //     .read<NewCollectionContoller>()
//                           //     .showBottomSheetInsert(context, i);
//                           context
//                               .read<NewCollectionContoller>()
//                               .showBottomSheetInsert(context, i);
//                         },
//                         child: Card(
//                           elevation: 5,
//                           child: Container(
//                             width: Screens.width(context),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: Screens.bodyheight(context) * 0.01,
//                                 horizontal: Screens.width(context) * 0.02),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: Text(
//                                           "Invoice #${context.read<NewCollectionContoller>().allProductDetails[i].invoice}",
//                                           style: theme.textTheme.bodyText1
//                                               ?.copyWith(
//                                                   color: theme.primaryColor)),
//                                     ),
//                                     Container(
//                                       alignment: Alignment.centerRight,
//                                       width: Screens.width(context) * 0.4,
//                                       child: Text(
//                                         "Date On " +
//                                             context
//                                                 .read<NewCollectionContoller>()
//                                                 .config
//                                                 .alignDate(context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .allProductDetails[i]
//                                                     .date),
//                                         // context
//                                         //     .watch<NewCollectionContoller>()
//                                         //     .config
//                                         //     .alignDate(context
//                                         //         .read<NewCollectionContoller>()
//                                         //         .allProductDetails[i]
//                                         //         .refreshedRecordDate!),
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           Screens.width(context) * 0.05),
//                                   child: Divider(
//                                     color: Colors.grey[400],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: Screens.width(context) * 0.6,
//                                   child: Text(
//                                       "${context.read<NewCollectionContoller>().allProductDetails[i].purpose}",
//                                       style:
//                                           theme.textTheme.bodyText1?.copyWith(
//                                               //color: theme.primaryColor
//                                               )),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       // alignment: Alignment.centerRight,
//                                       //width: Screens.width(context) * 0.2,
//                                       child: Text(
//                                         "Rs.${context.read<NewCollectionContoller>().allProductDetails[i].amount}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(
//                                                 color: theme.primaryColor),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 )
//               : Expanded(
//                   child: ListView.builder(
//                     itemCount: context
//                         .read<NewCollectionContoller>()
//                         .getProduct
//                         .length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: Screens.width(context) * 0.4,
//                                         child: Text(
//                                             "Invoice #${context.read<NewCollectionContoller>().getProduct[index].invoice}",
//                                             style: theme.textTheme.bodyText1
//                                                 ?.copyWith(
//                                                     color: theme.primaryColor)),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.centerRight,
//                                         width: Screens.width(context) * 0.4,
//                                         child: Text(
//                                           "Date On " +
//                                               context
//                                                   .read<
//                                                       NewCollectionContoller>()
//                                                   .config
//                                                   .alignDate(context
//                                                       .read<
//                                                           NewCollectionContoller>()
//                                                       .getProduct[index]
//                                                       .date),
//                                           // context
//                                           //     .watch<NewCollectionContoller>()
//                                           //     .config
//                                           //     .alignDate(context
//                                           //         .read<NewCollectionContoller>()
//                                           //         .allProductDetails[i]
//                                           //         .refreshedRecordDate!),
//                                           style: theme.textTheme.bodyText1
//                                               ?.copyWith(color: Colors.grey),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Row(
//                                     children: [
//                                       Text(
//                                           context
//                                               .read<NewCollectionContoller>()
//                                               .getProduct[index]
//                                               .purpose,
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 15.0,
//                                           )),
//                                     ],
//                                   ),
//                                   // SizedBox(height: 10.0),
//                                   // Container(
//                                   //   // width: Screens.width(context)*0.8,
//                                   //   ///  color: Colors.red,
//                                   //   child: Text(
//                                   //       context
//                                   //           .read<NewCollectionContoller>()
//                                   //           .getProduct[index]
//                                   //           .date,
//                                   //       style: TextStyle(
//                                   //         color: Colors.black,
//                                   //         fontSize: 15.0,
//                                   //       )),
//                                   // ),
//                                   // SizedBox(height: 10.0),
//                                   // Row(
//                                   //   mainAxisAlignment:
//                                   //       MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     Text(
//                                   //         "Qty: " +
//                                   //             context
//                                   //                 .read<
//                                   //                     NewCollectionContoller>()
//                                   //                 .getProduct[index]
//                                   //                 .amount
//                                   //                 .toString(),
//                                   //         style: TextStyle(
//                                   //           color: Colors.black,
//                                   //           fontSize: 15.0,
//                                   //         )),
//                                   //     // SizedBox(
//                                   //     //     width: Screens.bodyheight(context) /
//                                   //     //         2.9),
//                                   //     Text(
//                                   //         "Price: " +
//                                   //             context
//                                   //                 .read<
//                                   //                     NewCollectionContoller>()
//                                   //                 .getProduct[index]
//                                   //                 .amount
//                                   //                 .toString(),
//                                   //         style: TextStyle(
//                                   //           color: Colors.black,
//                                   //           fontSize: 15.0,
//                                   //         )),
//                                   //   ],
//                                   // ),
//                                   SizedBox(height: 10),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.only(left: 40, right: 40),
//                                     child: Divider(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Text("Amount Rs." +
//                                                   context
//                                                       .read<
//                                                           NewCollectionContoller>()
//                                                       .getProduct[index]
//                                                       .amount
//                                                       .toStringAsFixed(2)
//                                                       .toString())
//                                             ]),
//                                         Row(
//                                           children: [
//                                             GestureDetector(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     print(index);
//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .RemoveandAdd(context
//                                                             .read<
//                                                                 NewCollectionContoller>()
//                                                             .getProduct[index]);
// // showItemList

//                                                     if (context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .getProduct
//                                                         .isEmpty) {
//                                                       context
//                                                           .read<
//                                                               NewCollectionContoller>()
//                                                           .showItemList = true;
//                                                     }
//                                                     for (int i = 0;
//                                                         i <
//                                                             context
//                                                                 .read<
//                                                                     NewCollectionContoller>()
//                                                                 .productDetails
//                                                                 .length;
//                                                         i++) {
//                                                       //  provi.productDetails[i].lineId =
//                                                       //     (i + 1).toString();
//                                                     }
//                                                   });
//                                                 },
//                                                 child: Icon(
//                                                   Icons.close,
//                                                   color: Colors.red,
//                                                 )),
//                                             SizedBox(width: 10.0),
//                                             GestureDetector(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     context
//                                                             .read<
//                                                                 NewCollectionContoller>()
//                                                             .mycontroller[0]
//                                                             .text =
//                                                         context
//                                                             .read<
//                                                                 NewCollectionContoller>()
//                                                             .getProduct[index]
//                                                             .amount
//                                                             .toStringAsFixed(2);

//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .isUpdateClicked = true;

//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .UpdateshowBottomSheetInsert(
//                                                             context, index);
//                                                   });
//                                                 },
//                                                 child: Icon(
//                                                   Icons.edit,
//                                                   color: Colors.blue,
//                                                 )),
//                                           ],
//                                         ),
//                                       ]),
//                                 ]),
//                           ));
//                     },
//                   ),
//                 ),
//           //

//           Column(
//             children: [
//               context.read<NewCollectionContoller>().showItemList == true
//                   ? Container()
//                   : Container(
//                       width: Screens.width(context),
//                       height: Screens.bodyheight(context) * 0.07,
//                       //  padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: Color(
//                               0xffB299A5) //theme.primaryColor.withOpacity(0.5)
//                           ,
//                           border:
//                               Border.all(color: theme.primaryColor, width: 1),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                               "Total Collection Value Rs.${context.read<NewCollectionContoller>().colletionTotal()}",
//                               maxLines: 8,
//                               overflow: TextOverflow.ellipsis,
//                               style: theme.textTheme.bodyText1?.copyWith(
//                                 color: theme.primaryColor,
//                               ))
//                         ],
//                       ),
//                     ),
//               context.read<NewCollectionContoller>().showItemList == true
//                   ? Container()
//                   : SizedBox(
//                       height: Screens.bodyheight(context) * 0.02,
//                     ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: Screens.width(context) * 0.3,
//                     height: Screens.bodyheight(context) * 0.07,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           context
//                               .read<NewCollectionContoller>()
//                               .pageController
//                               .animateToPage(
//                                   --context
//                                       .read<NewCollectionContoller>()
//                                       .pageChanged,
//                                   duration: Duration(milliseconds: 250),
//                                   curve: Curves.bounceIn);
//                         },
//                         child: Icon(Icons.keyboard_arrow_left)),
//                   ),
//                   SizedBox(
//                     width: Screens.width(context) * 0.3,
//                     height: Screens.bodyheight(context) * 0.07,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           context
//                               .read<NewCollectionContoller>()
//                               .pageController
//                               .animateToPage(
//                                   ++context
//                                       .read<NewCollectionContoller>()
//                                       .pageChanged,
//                                   duration: Duration(milliseconds: 250),
//                                   curve: Curves.bounceIn);
//                           // provi.pageController.animateToPage(++provi.pageChanged,
//                           //     duration: Duration(milliseconds: 250),
//                           //     curve: Curves.bounceIn);
//                           // setState(() {
//                           //   context
//                           //       .read<NewCollectionContoller>()
//                           //       .validateFirst(context);
//                           // });

//                           // log("oldcutomer: " +
//                           //     context
//                           //         .read<NewCollectionContoller>()
//                           //         .oldcutomer
//                           //         .toString());
//                         },
//                         child: Icon(Icons.navigate_next)),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//     //       }
//     //     );
//     //   }
//     // );
//   }

//   bool switched = false;
//   bool switched2 = false;

//   InkWell FirstPage(
//     BuildContext context,
//     ThemeData theme,
//   ) {
//     // return ChangeNotifierProvider<NewCollectionContoller>(
//     //       create: (context) => NewCollectionContoller(),
//     //       builder: (context, child) {
//     //         return Consumer<NewCollectionContoller>(
//     //           builder: (BuildContext context, provi, Widget? child) {
//     return InkWell(
//       onTap: () {
//         FocusScopeNode focus = FocusScope.of(context);
//         if (!focus.hasPrimaryFocus) {
//           focus.unfocus();
//         }
//       },
//       child: Container(
//         //  color: Colors.red,
//         width: Screens.width(context),
//         height: Screens.bodyheight(context),
//         padding: EdgeInsets.symmetric(
//             horizontal: Screens.width(context) * 0.03,
//             vertical: Screens.bodyheight(context) * 0.01),
//         child: SingleChildScrollView(
//           child: Form(
//             key: context.read<NewCollectionContoller>().formkey[0],
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: Screens.width(context) * 0.03,
//                       vertical: Screens.bodyheight(context) * 0.008),
//                   width: Screens.width(context),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: theme.primaryColor)),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: Screens.width(context),
//                         child: Text(
//                           "Customer Information",
//                           style: theme.textTheme.headline6
//                               ?.copyWith(color: theme.primaryColor),
//                         ),
//                       ),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[1],
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter Customer";
//                             } else if (context
//                                     .read<NewCollectionContoller>()
//                                     .validateCustomer(value) !=
//                                 value) {
//                               return "Enter Valid Customer";
//                             }

//                             return null;
//                           },
//                           onTap: () {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .clearbool();
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .filterCollectionCuslist(v);
//                               if (v.isEmpty) {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .customerbool = false;
//                               } else {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .customerbool = true;
//                               }
//                             });
//                             // filterCollectionCuslist
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Customer',
//                             border: UnderlineInputBorder(),
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       Visibility(
//                         visible:
//                             context.read<NewCollectionContoller>().customerbool,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             context
//                                     .read<NewCollectionContoller>()
//                                     .filterCustomerlist
//                                     .isEmpty
//                                 ? Container()
//                                 : Container(

//                                     // color: Colors.amber,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             color: theme.primaryColor)),
//                                     width: Screens.width(context),
//                                     height: Screens.bodyheight(context) * 0.2,
//                                     child: ListView.builder(
//                                         scrollDirection: Axis.vertical,
//                                         itemCount: context
//                                             .read<NewCollectionContoller>()
//                                             .filterCustomerlist
//                                             .length,
//                                         itemBuilder:
//                                             (BuildContext context, int i) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .customerbool = false;
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .getExiCustomerData(context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .customer
//                                                         .toString());
//                                                 context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .mycontroller[1]
//                                                         .text =
//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .customer
//                                                         .toString();
//                                               });
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.all(
//                                                       Screens.bodyheight(
//                                                               context) *
//                                                           0.008),
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   // color: Colors.red,
//                                                   height: Screens.bodyheight(
//                                                           context) *
//                                                       0.05,
//                                                   width: Screens.width(context),
//                                                   child: Text(
//                                                     "${context.watch<NewCollectionContoller>().filterCustomerlist[i].customer}",
//                                                     style: theme
//                                                         .textTheme.bodyText1
//                                                         ?.copyWith(
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 ),
//                                                 Divider()
//                                               ],
//                                             ),
//                                           );
//                                         })),
//                           ],
//                         ),
//                       ),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[2],
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter CardCode";
//                             } else if (context
//                                     .read<NewCollectionContoller>()
//                                     .validateCustomerCode(value) !=
//                                 value) {
//                               return "Enter Valid CardCode";
//                             }

//                             return null;
//                           },
//                           onTap: () {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .clearbool();
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .filterCollectionCusCardCode(v);
//                               if (v.isEmpty) {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .custCodebool = false;
//                               } else {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .custCodebool = true;
//                               }
//                             });
//                             // filterCollectionCuslist
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Cardcode',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       Visibility(
//                         visible:
//                             context.read<NewCollectionContoller>().custCodebool,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             context
//                                     .read<NewCollectionContoller>()
//                                     .filterCustomerlist
//                                     .isEmpty
//                                 ? Container()
//                                 : Container(

//                                     // color: Colors.amber,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             color: theme.primaryColor)),
//                                     width: Screens.width(context),
//                                     height: Screens.bodyheight(context) * 0.2,
//                                     child: ListView.builder(
//                                         scrollDirection: Axis.vertical,
//                                         itemCount: context
//                                             .read<NewCollectionContoller>()
//                                             .filterCustomerlist
//                                             .length,
//                                         itemBuilder:
//                                             (BuildContext context, int i) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .custCodebool = false;
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .getExiCustomerCodeData(context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .cuscode
//                                                         .toString());
//                                                 context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .mycontroller[2]
//                                                         .text =
//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .cuscode
//                                                         .toString();
//                                               });
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.all(
//                                                       Screens.bodyheight(
//                                                               context) *
//                                                           0.008),
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   // color: Colors.red,
//                                                   height: Screens.bodyheight(
//                                                           context) *
//                                                       0.05,
//                                                   width: Screens.width(context),
//                                                   child: Text(
//                                                     "${context.watch<NewCollectionContoller>().filterCustomerlist[i].cuscode}",
//                                                     style: theme
//                                                         .textTheme.bodyText1
//                                                         ?.copyWith(
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 ),
//                                                 Divider()
//                                               ],
//                                             ),
//                                           );
//                                         })),
//                           ],
//                         ),
//                       ),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[3],
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter Cantact Name";
//                             } else if (context
//                                     .read<NewCollectionContoller>()
//                                     .validateCustomerCantact(value) !=
//                                 value) {
//                               return "Enter Valid Cantact Name";
//                             }

//                             return null;
//                           },
//                           onTap: () {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .clearbool();
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .filterCollectionCusCantact(v);
//                               if (v.isEmpty) {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .contactbool = false;
//                               } else {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .contactbool = true;
//                               }
//                             });
//                             // filterCollectionCuslist
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Contact Name',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       //
//                       Visibility(
//                         visible:
//                             context.read<NewCollectionContoller>().contactbool,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             context
//                                     .read<NewCollectionContoller>()
//                                     .filterCustomerlist
//                                     .isEmpty
//                                 ? Container()
//                                 : Container(

//                                     // color: Colors.amber,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             color: theme.primaryColor)),
//                                     width: Screens.width(context),
//                                     height: Screens.bodyheight(context) * 0.2,
//                                     child: ListView.builder(
//                                         scrollDirection: Axis.vertical,
//                                         itemCount: context
//                                             .read<NewCollectionContoller>()
//                                             .filterCustomerlist
//                                             .length,
//                                         itemBuilder:
//                                             (BuildContext context, int i) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .contactbool = false;
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .getExiCustomerCantactData(
//                                                         context
//                                                             .read<
//                                                                 NewCollectionContoller>()
//                                                             .filterCustomerlist[
//                                                                 i]
//                                                             .contactname
//                                                             .toString());
//                                                 context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .mycontroller[3]
//                                                         .text =
//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .contactname
//                                                         .toString();
//                                               });
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.all(
//                                                       Screens.bodyheight(
//                                                               context) *
//                                                           0.008),
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   // color: Colors.red,
//                                                   height: Screens.bodyheight(
//                                                           context) *
//                                                       0.05,
//                                                   width: Screens.width(context),
//                                                   child: Text(
//                                                     "${context.watch<NewCollectionContoller>().filterCustomerlist[i].contactname}",
//                                                     style: theme
//                                                         .textTheme.bodyText1
//                                                         ?.copyWith(
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 ),
//                                                 Divider()
//                                               ],
//                                             ),
//                                           );
//                                         })),
//                           ],
//                         ),
//                       ),
//                       //
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[4],
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Enter Mobile No";
//                             } else if (context
//                                     .read<NewCollectionContoller>()
//                                     .validateCustomerMobile(value) !=
//                                 value) {
//                               return "Enter Valid Mobile No";
//                             }

//                             return null;
//                           },
//                           onTap: () {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .clearbool();
//                             });
//                           },
//                           onChanged: (v) {
//                             setState(() {
//                               context
//                                   .read<NewCollectionContoller>()
//                                   .filterCollectionCusMobile(v);
//                               if (v.isEmpty) {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .mobilebool = false;
//                               } else {
//                                 context
//                                     .read<NewCollectionContoller>()
//                                     .mobilebool = true;
//                               }
//                             });
//                             // filterCollectionCuslist
//                           },
//                           inputFormatters: [
//                             new LengthLimitingTextInputFormatter(10),
//                           ],
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'Mobile',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       Visibility(
//                         visible:
//                             context.read<NewCollectionContoller>().mobilebool,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: Screens.bodyheight(context) * 0.01,
//                             ),
//                             context
//                                     .read<NewCollectionContoller>()
//                                     .filterCustomerlist
//                                     .isEmpty
//                                 ? Container()
//                                 : Container(

//                                     // color: Colors.amber,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             color: theme.primaryColor)),
//                                     width: Screens.width(context),
//                                     height: Screens.bodyheight(context) * 0.2,
//                                     child: ListView.builder(
//                                         scrollDirection: Axis.vertical,
//                                         itemCount: context
//                                             .read<NewCollectionContoller>()
//                                             .filterCustomerlist
//                                             .length,
//                                         itemBuilder:
//                                             (BuildContext context, int i) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .mobilebool = false;
//                                                 context
//                                                     .read<
//                                                         NewCollectionContoller>()
//                                                     .getExiCustomerMobileData(
//                                                         context
//                                                             .read<
//                                                                 NewCollectionContoller>()
//                                                             .filterCustomerlist[
//                                                                 i]
//                                                             .mobile
//                                                             .toString());
//                                                 context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .mycontroller[4]
//                                                         .text =
//                                                     context
//                                                         .read<
//                                                             NewCollectionContoller>()
//                                                         .filterCustomerlist[i]
//                                                         .mobile
//                                                         .toString();
//                                               });
//                                             },
//                                             child: Column(
//                                               children: [
//                                                 Container(
//                                                   padding: EdgeInsets.all(
//                                                       Screens.bodyheight(
//                                                               context) *
//                                                           0.008),
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   // color: Colors.red,
//                                                   height: Screens.bodyheight(
//                                                           context) *
//                                                       0.05,
//                                                   width: Screens.width(context),
//                                                   child: Text(
//                                                     "${context.watch<NewCollectionContoller>().filterCustomerlist[i].mobile}",
//                                                     style: theme
//                                                         .textTheme.bodyText1
//                                                         ?.copyWith(
//                                                             color:
//                                                                 Colors.black),
//                                                   ),
//                                                 ),
//                                                 Divider()
//                                               ],
//                                             ),
//                                           );
//                                         })),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Screens.bodyheight(context) * 0.015,
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: Screens.width(context) * 0.03,
//                       vertical: Screens.bodyheight(context) * 0.008),
//                   width: Screens.width(context),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: theme.primaryColor)),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: Screens.width(context),
//                         child: Text(
//                           "Balance Info",
//                           style: theme.textTheme.headline6
//                               ?.copyWith(color: theme.primaryColor),
//                         ),
//                       ),
//                       // Container(
//                       //   width: Screens.width(context),
//                       //   child: DropdownButton(
//                       //     hint: Text("Select Mode"),
//                       //     // value: context.read<EnquiryUserContoller>(). valueChosedReason,
//                       //     //dropdownColor:Colors.green,
//                       //     icon: Icon(Icons.arrow_drop_down),
//                       //     iconSize: 30,
//                       //     style: TextStyle(color: Colors.black, fontSize: 16),
//                       //     isExpanded: true,
//                       //     value: context
//                       //         .read<NewCollectionContoller>()
//                       //         .paymentmode,
//                       //     onChanged: (val) {
//                       //       // setState(() {
//                       //       //   valueChosedReason = val.toString();
//                       //       //   print(val.toString());
//                       //       //   print("valavalaa: .........." +
//                       //       //       valueChosedReason.toString());
//                       //       // });
//                       //       context
//                       //           .read<NewCollectionContoller>()
//                       //           .resonChoosed(val.toString());
//                       //     },
//                       //     items: <String>["Cash", "Cheque", "Card", "UPI", "DD"]
//                       //         .map((String value) {
//                       //       return DropdownMenuItem(
//                       //           value: value, child: Text(value.toString()));
//                       //     }).toList(),
//                       //   ),
//                       // ),
//                       // context
//                       //         .read<NewCollectionContoller>()
//                       //         .paymentmodeErro
//                       //         .isEmpty
//                       //     ? Container()
//                       //     : Container(
//                       //         width: Screens.width(context),
//                       //         child: Text(
//                       //           "${context.watch<NewCollectionContoller>().paymentmodeErro}",
//                       //           style: theme.textTheme.bodyText1!
//                       //               .copyWith(color: Colors.red),
//                       //         ),
//                       //       ),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[7],
//                           readOnly: true,
//                           // validator: (value) {
//                           //   if (value!.isEmpty) {
//                           //     return "Enter Amount";
//                           //   } else
//                           //     return null;
//                           // },
//                           onChanged: (v) {},
//                           inputFormatters: [
//                             new LengthLimitingTextInputFormatter(10),
//                           ],
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'Total Balance',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[8],
//                           readOnly: true,

//                           // validator: (value) {
//                           //   if (value!.isEmpty) {
//                           //     return "Enter Reference";
//                           //   }
//                           //   return null;
//                           // },
//                           decoration: InputDecoration(
//                             labelText: 'Total Advance Balance',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       TextFormField(
//                           controller: context
//                               .read<NewCollectionContoller>()
//                               .mycontroller[9],
//                           readOnly: true,

//                           // validator: (value) {
//                           //   if (value!.isEmpty) {
//                           //     return "Enter Reference";
//                           //   }
//                           //   return null;
//                           // },
//                           decoration: InputDecoration(
//                             labelText: 'Total Paid',
//                             labelStyle: theme.textTheme.bodyText1!
//                                 .copyWith(color: Colors.grey),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in unfocused
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey),
//                               //  when the TextFormField in focused
//                             ),
//                             border: UnderlineInputBorder(),
//                             // enabledBorder: UnderlineInputBorder(),
//                             // focusedBorder: UnderlineInputBorder(),
//                             errorBorder: UnderlineInputBorder(),
//                             focusedErrorBorder: UnderlineInputBorder(),
//                           )),
//                       SizedBox(
//                         height: Screens.bodyheight(context) * 0.01,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Screens.bodyheight(context) * 0.101,
//                 ), //Office
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: SizedBox(
//                     width: Screens.width(context) * 0.3,
//                     height: Screens.bodyheight(context) * 0.07,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           // provi.pageController.animateToPage(++provi.pageChanged,
//                           //     duration: Duration(milliseconds: 250),
//                           //     curve: Curves.bounceIn);
//                           setState(() {
//                             context
//                                 .read<NewCollectionContoller>()
//                                 .validateFirst(context);
//                           });

//                           // log("oldcutomer: " +
//                           //     context
//                           //         .read<NewCollectionContoller>()
//                           //         .oldcutomer
//                           //         .toString());
//                         },
//                         child: Icon(Icons.navigate_next)),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//     //       }
//     //     );
//     //   }
//     // );
//   }
// }
