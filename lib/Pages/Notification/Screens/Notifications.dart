// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Controller/NotificationController/NotificationController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/DeleteDialog.dart';
import '../Widgets/NotifyDialog.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NotificationContoller>().clearData();
      context.read<NotificationContoller>().getNotification();
      context.read<NotificationContoller>().onReciveFCM();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("Notification", scaffoldKey, theme, context),
          body: SafeArea(
              child:
                  // ChangeNotifierProvider<NotificationContoller>(
                  //     create: (context) => NotificationContoller(),
                  //     builder: (context, child) {
                  //       return Consumer<NotificationContoller>(
                  //           builder: (BuildContext context, context.read<NotificationContoller>(), Widget? child) {
                  //         return
                  Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            child: (context.read<NotificationContoller>().getnotify.isEmpty &&
                    context.watch<NotificationContoller>().getunSeenNotify == 0)
                ? Center(child: Text('No Notification'))
                : (context.read<NotificationContoller>().getnotify.isEmpty &&
                        context.watch<NotificationContoller>().getunSeenNotify >
                            0)
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () {
                                return context
                                    .read<NotificationContoller>()
                                    .swipeRefreshIndiactor();
                              },
                              child: ListView.builder(
                                // reverse: true,
                                // shrinkWrap: true,
                                itemCount: context
                                    .read<NotificationContoller>()
                                    .getnotify
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                                                                
                                        context
                                            .read<NotificationContoller>()
                                            .updateApi(
                                                docEntry: int.parse(context
                                                    .read<
                                                        NotificationContoller>()
                                                    .getnotify[index]
                                                    .jobid.toString()),
                                                seenTime: context
                                                    .read<
                                                        NotificationContoller>()
                                                    .getnotify[index]
                                                    .seenTime, deliveryTime:context
                                                    .read<
                                                        NotificationContoller>()
                                                    .getnotify[index]
                                                    .receiveTime.toString());
                                        showDialog<dynamic>(
                                            context: context,
                                            builder: (_) {
                                              String time = context
                                                  .read<NotificationContoller>()
                                                  .config
                                                  .currentDate();
                                              context
                                                  .read<NotificationContoller>()
                                                  .updateSeenTime(
                                                      context
                                                          .read<
                                                              NotificationContoller>()
                                                          .getnotify[index]
                                                          .id!,
                                                      time);
                                              return NotifyDialog(
                                                descp:
                                                    '${context.read<NotificationContoller>().getnotify[index].description}',
                                                title:
                                                    '${context.read<NotificationContoller>().getnotify[index].titile}',
                                                imgUrl:
                                                    '${context.read<NotificationContoller>().getnotify[index].imgUrl}',
                                                     page:'${context.read<NotificationContoller>().getnotify[index].naviScn}',
                                              );
                                            }).then((value) {});
                                      },
                                     onLongPress: (){
                                         showDialog<dynamic>(
                                            context: context,
                                            builder: (_) {  
                                              return NotifyDeleteDialog(
                                                docid: context
                                                    .read<
                                                        NotificationContoller>()
                                                    .getnotify[index]
                                                    .docEntry!,
                                               );
                                            }).then((value) {});
                                     },
                                      child: DataContainer1(
                                          context, index, theme));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
          )
              //   });
              // }),
              )),
    );
  }

  Container DataContainer1(BuildContext context, int index, ThemeData theme) {
    return Container(
      //  color: Colors.red,
      width: Screens.width(context),
      padding: EdgeInsets.symmetric(
          vertical: Screens.bodyheight(context) * 0.01,
          horizontal: Screens.width(context) * 0.01),

      margin: EdgeInsets.symmetric(
        vertical: Screens.bodyheight(context) * 0.005,
      ),

      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Screens.bodyheight(context) * 0.01,
            horizontal: Screens.width(context) * 0.02),
        color:
            context.read<NotificationContoller>().getnotify[index].seenTime ==
                    '0'
                ? Colors.grey[300]
                : Colors.white,
        child: Column(children: [
          Container(
            width: Screens.width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.65,
                  // color: Colors.red,
                  child: Text(
                    "${context.read<NotificationContoller>().getnotify[index].titile}",
                    style: theme.textTheme.bodyText1,
                  ),
                ),
                Container(
                  width: Screens.width(context) * 0.25,
                  //    color: Colors.red,
                  child: Text(
                    context.read<NotificationContoller>().config.subtractDTWith2(
                        "${context.read<NotificationContoller>().getnotify[index].receiveTime}"),
                    style: theme.textTheme.bodyText2
                        ?.copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.02,
          ),
          Container(
            width: Screens.width(context),
            child: ExpandableText(
              "${context.read<NotificationContoller>().getnotify[index].description}",
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 2,
              linkColor: Colors.blue,
              style: theme.textTheme.bodyText2
                  ?.copyWith(fontSize: 12, color: Colors.grey),
            ),
          ),
         context.read<NotificationContoller>().getnotify[index].imgUrl ==
                  null||  context.read<NotificationContoller>().getnotify[index].imgUrl ==
                  'null'|| context.read<NotificationContoller>().getnotify[index].imgUrl.isEmpty
              ? Container()
              : Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.2,
                  child: Center(
                      child: Image(
                          image: NetworkImage(
                              '${context.read<NotificationContoller>().getnotify[index].imgUrl}'),
                          fit: BoxFit.cover)),
                ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.02,
          ),
          Divider(
            thickness: 2,
            endIndent: 0,
            height: 0,
            indent: 0,
          )
        ]),
      ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    context.read<NotificationContoller>().getUnSeenNotify();
    context.read<NotificationContoller>().clearData();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

}
 // onLongPress: () async {
                                      //   context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .source1 =
                                      //       await context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .getPathOFDB();
                                      //   context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .copyTo =
                                      //       await context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .getDirectory();

                                      //   bool permission = await context
                                      //       .read<NotificationContoller>()
                                      //       .getdb
                                      //       .getPermissionStorage();
                                      //   if (permission == true) {
                                      //     if ((await context
                                      //         .read<NotificationContoller>()
                                      //         .getdb
                                      //         .copyTo!
                                      //         .exists())) {
                                      //       print("EXISTS");
                                      //       context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .createDBFile(context
                                      //               .read<
                                      //                   NotificationContoller>()
                                      //               .getdb
                                      //               .copyTo!
                                      //               .path);
                                      //     } else {
                                      //       print("Not EXISTS");
                                      //       context
                                      //           .read<NotificationContoller>()
                                      //           .getdb
                                      //           .createDirectory();
                                      //     }
                                      //   } else if (permission == false) {
                                      //     context
                                      //         .read<NotificationContoller>()
                                      //         .getdb
                                      //         .showSnackBars(
                                      //             'Please give stoage permission to continue!!..',
                                      //             Colors.red);
                                      //   }
                                      // },


// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, use_build_context_synchronously

// import 'package:expandable_text/expandable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Models/newNotificationModel/newnotifyModel.dart';
// import '../../../Constant/ConstantRoutes.dart';
// import '../../../Controller/NotificationController/NotificationController.dart';
// import '../../../Widgets/Appbar.dart';
// import '../../../Widgets/Navi3.dart';
// import '../Widgets/DeleteDialog.dart';
// import '../Widgets/NotifyDialog.dart';

// class Testing extends StatefulWidget {
//   const Testing({Key? key});

//   @override
//   State<Testing> createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       context.read<NotificationContoller>().clearData();
//       context.read<NotificationContoller>().getNotification();
//       // context.read<NotificationContoller>(). getdatafromApi();
//       context.read<NotificationContoller>().onReciveFCM();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return WillPopScope(
//       onWillPop: onbackpress,
//       child: Scaffold(
//         key: scaffoldKey,
//           drawer: drawer3(context),
//           appBar: appbar("Notification", scaffoldKey, theme, context),
//           body: SafeArea(
//               child:
//                   // ChangeNotifierProvider<NotificationContoller>(
//                   //     create: (context) => NotificationContoller(),
//                   //     builder: (context, child) {
//                   //       return Consumer<NotificationContoller>(
//                   //           builder: (BuildContext context, context.read<NotificationContoller>(), Widget? child) {
//                   //         return
//                   Container(
//             width: Screens.width(context),
//             height: Screens.bodyheight(context),
//             child: 
//             (context.watch<NotificationContoller>().isloading==true)
//                     ? Center(child: CircularProgressIndicator())
//                     : (context.watch<NotificationContoller>().isloading==false
//                     &&context.read<NotificationContoller>().notifydatanew.isEmpty
//                     )
//                 ? Center(child: Text('No Notification'))
//                 : Column(
//                         children: [
//                           SizedBox(
//                             height: Screens.bodyheight(context) * 0.01,
//                           ),
//                           Expanded(
//                             child: RefreshIndicator(
//                               onRefresh: () {
//                                 return context
//                                     .read<NotificationContoller>()
//                                     .swipeRefreshIndiactor();
//                               },
//                               child: ListView.builder(
//                                 // reverse: true,
//                                 // shrinkWrap: true,
//                                 itemCount: context
//                                     .read<NotificationContoller>()
//                                     .notifydatanew
//                                     .length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return InkWell(
//                                       onTap: () {
                                                                                
//                                         // context
//                                         //     .read<NotificationContoller>()
//                                         //     .updateApi(
//                                         //         docEntry: int.parse(context
//                                         //             .read<
//                                         //                 NotificationContoller>()
//                                         //             .getnotify[index]
//                                         //             .jobid.toString()),
//                                         //         seenTime: context
//                                         //             .read<
//                                         //                 NotificationContoller>()
//                                         //             .getnotify[index]
//                                         //             .seenTime, deliveryTime:context
//                                         //             .read<
//                                         //                 NotificationContoller>()
//                                         //             .getnotify[index]
//                                         //             .receiveTime.toString());
//                                         showDialog<dynamic>(
//                                             context: context,
//                                             builder: (_) {
//                                               String time = context
//                                                   .read<NotificationContoller>()
//                                                   .config
//                                                   .currentDate();
//                                               // context
//                                               //     .read<NotificationContoller>()
//                                               //     .updateSeenTime(
//                                               //         context
//                                               //             .read<
//                                               //                 NotificationContoller>()
//                                               //             .getnotify[index]
//                                               //             .id!,
//                                               //         time);
//                                               return NotifyDialog(
//                                                 descp:
//                                                     '${context.read<NotificationContoller>().notifydatanew[index].body}',
//                                                 title:
//                                                     '${context.read<NotificationContoller>().notifydatanew[index].title}',
//                                                 imgUrl:
//                                                     '${context.read<NotificationContoller>().notifydatanew[index].notifyUrl}',
//                                                     //  page:'${context.read<NotificationContoller>().notifydatanew[index].naviScn
//                                                     //  }',
//                                               );
//                                             }).then((value) {});
//                                       },
//                                      onLongPress: (){
//                                         //  showDialog<dynamic>(
//                                         //     context: context,
//                                         //     builder: (_) {  
//                                         //       return NotifyDeleteDialog(
//                                         //         docid: context
//                                         //             .read<
//                                         //                 NotificationContoller>()
//                                         //             .getnotify[index]
//                                         //             .docEntry!,
//                                         //        );
//                                         //     }).then((value) {});
//                                      },
//                                       child: DataContainer1(
//                                           context, context
//                                     .read<NotificationContoller>()
//                                     .notifydatanew[index], theme));
//                                 },
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//           )
//               //   });
//               // }),
//               )),
//     );
//   }

//   Container DataContainer1(BuildContext context, NEWnotifyData notifydatanew, ThemeData theme) {
//     return Container(
//       //  color: Colors.red,
//       width: Screens.width(context),
//       padding: EdgeInsets.symmetric(
//           vertical: Screens.bodyheight(context) * 0.01,
//           horizontal: Screens.width(context) * 0.01),

//       margin: EdgeInsets.symmetric(
//         vertical: Screens.bodyheight(context) * 0.005,
//       ),

//       child: Container(
//         padding: EdgeInsets.symmetric(
//             vertical: Screens.bodyheight(context) * 0.01,
//             horizontal: Screens.width(context) * 0.02),
//         color:
//             // context.read<NotificationContoller>().notifydatanew[index].seenTime ==
//             //         '0'
//             //     ? Colors.grey[300]
//             //     :
//                  Colors.white,
//         child: Column(children: [
//           Container(
//             width: Screens.width(context),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: Screens.width(context) * 0.65,
//                   // color: Colors.red,
//                   child: Text(
//                     "${notifydatanew.title}",
//                     style: theme.textTheme.bodyText1,
//                   ),
//                 ),
//                 Container(
//                   width: Screens.width(context) * 0.25,
//                   //    color: Colors.red,
//                   child:notifydatanew.sendTime ==null || notifydatanew.sendTime==''?Text(""): Text(
//                     context.read<NotificationContoller>().config.alignmeetingdate(
//                         "${notifydatanew.sendTime}"),
//                     style: theme.textTheme.bodyText2
//                         ?.copyWith(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.02,
//           ),
//           Container(
//             width: Screens.width(context),
//             child: ExpandableText(
//               "${notifydatanew.body}",
//               expandText: 'show more',
//               collapseText: 'show less',
//               maxLines: 2,
//               linkColor: Colors.blue,
//               style: theme.textTheme.bodyText2
//                   ?.copyWith(fontSize: 12, color: Colors.grey),
//             ),
//           ),
//          notifydatanew.notifyUrl ==
//                   null||  notifydatanew.notifyUrl ==
//                   'null'|| notifydatanew.notifyUrl!.isEmpty
//               ? Container()
//               : Container(
//                   width: Screens.width(context),
//                   height: Screens.bodyheight(context) * 0.2,
//                   child: Center(
//                       child: Image(
//                           image: NetworkImage(
//                               '${notifydatanew.notifyUrl}'),
//                           fit: BoxFit.cover)),
//                 ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.02,
//           ),
//           Divider(
//             thickness: 2,
//             endIndent: 0,
//             height: 0,
//             indent: 0,
//           )
//         ]),
//       ),
//     );
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> onbackpress() {
//     DateTime now = DateTime.now();
//     context.read<NotificationContoller>().getUnSeenNotify();
//     context.read<NotificationContoller>().clearData();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       Get.toNamed(ConstantRoutes.dashboard);
//       return Future.value(true);
//     } else {
//       return Future.value(true);
//     }
//   }

// }
//  // onLongPress: () async {
//                                       //   context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .source1 =
//                                       //       await context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .getPathOFDB();
//                                       //   context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .copyTo =
//                                       //       await context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .getDirectory();

//                                       //   bool permission = await context
//                                       //       .read<NotificationContoller>()
//                                       //       .getdb
//                                       //       .getPermissionStorage();
//                                       //   if (permission == true) {
//                                       //     if ((await context
//                                       //         .read<NotificationContoller>()
//                                       //         .getdb
//                                       //         .copyTo!
//                                       //         .exists())) {
//                                       //       print("EXISTS");
//                                       //       context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .createDBFile(context
//                                       //               .read<
//                                       //                   NotificationContoller>()
//                                       //               .getdb
//                                       //               .copyTo!
//                                       //               .path);
//                                       //     } else {
//                                       //       print("Not EXISTS");
//                                       //       context
//                                       //           .read<NotificationContoller>()
//                                       //           .getdb
//                                       //           .createDirectory();
//                                       //     }
//                                       //   } else if (permission == false) {
//                                       //     context
//                                       //         .read<NotificationContoller>()
//                                       //         .getdb
//                                       //         .showSnackBars(
//                                       //             'Please give stoage permission to continue!!..',
//                                       //             Colors.red);
//                                       //   }
//                                       // },