// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/callNotificationController/callNotificationController.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/custom_text_field.dart';
import '../../../../Constant/Screen.dart';


class ShowSearchDialog extends StatefulWidget {
  ShowSearchDialog({Key? key,}) : super(key: key);
  @override
  // CallNotificationController? callCon;
  // List<String> filtercatagorydata;
  State<ShowSearchDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<ShowSearchDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
            content:  Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context)*0.7,
              child: Column(
                children: [
                  //  TextFormField(
                  //          // controller:  context.read<PriceListController>().mycontroller[0],
                  //           validator: (value) {
                  //             if (value!.isEmpty) {
                  //               return "Required *";
                  //             }
                  //             return null;
                  //           },
                  //            onChanged: (v) {
                  //               setState(() {
                  //    context.read<CallNotificationController>().filterListcatagoryData(v);
                  //               });
                  //             },
                  //           decoration: InputDecoration(
                  //             hintText: 'Search here',
                  //             border: UnderlineInputBorder(),
                  //             enabledBorder: UnderlineInputBorder(),
                  //             focusedBorder: UnderlineInputBorder(),
                  //             errorBorder: UnderlineInputBorder(),
                  //             focusedErrorBorder: UnderlineInputBorder(),
                  //             suffixIcon:
                  //              InkWell(
                  //                onTap: (){
                                 
                  //                },
                  //                child: Icon(Icons.search,color: theme.primaryColor))
                  //           )),

                  Expanded(child: ListView.builder(
                    itemCount:  context.read<CallNotificationController>().filtercatagorydata.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          setState(() {
                          //   CustomTextFieldState cuatometext=CustomTextFieldState();
                          // cuatometext.controller.text=context.read<CallNotificationController>().filtercatagorydata[index];
                            context.read<CallNotificationController>().iscateSeleted(context,
                           context.read<CallNotificationController>().filtercatagorydata[index]
                           );    
                          });
                          
                        },
                        child: Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.all(5),
                          child: Container(
                            alignment: Alignment.centerLeft,
                          width: Screens.width(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.read<CallNotificationController>().filtercatagorydata[index]
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),)
                ],
              ),
            )
              ,
     );
  }
}


//old 
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../Constant/Screen.dart';
// import '../Controller/EnquiryController/NewEnqController.dart';


// class ShowSearchDialog extends StatefulWidget {
//   ShowSearchDialog({Key? key}) : super(key: key);
//   @override
//   State<ShowSearchDialog> createState() => ShowSearchDialogState();
// }

// class ShowSearchDialogState extends State<ShowSearchDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return AlertDialog(
//             content:  Container(
//               width: Screens.width(context),
//               height: Screens.bodyheight(context)*0.5,
//               child: Column(
//                 children: [
//                    TextFormField(
//                            // controller:  context.read<PriceListController>().mycontroller[0],
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Required *";
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               hintText: 'Search here',
//                               border: UnderlineInputBorder(),
//                               enabledBorder: UnderlineInputBorder(),
//                               focusedBorder: UnderlineInputBorder(),
//                               errorBorder: UnderlineInputBorder(),
//                               focusedErrorBorder: UnderlineInputBorder(),
//                               suffixIcon:
//                                InkWell(
//                                  onTap: (){
                                 
//                                  },
//                                  child: Icon(Icons.search,color: theme.primaryColor))
//                             )),

//                   Expanded(child: ListView.builder(
//                     itemCount:context.watch<NewEnqController>().getcategory.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: (){
//                            context.read<NewEnqController>().iscateSeleted(context,
//                            context.read<NewEnqController>().getcategory[index].category
//                            );  
//                         },
//                         child: Container(
//                           width: Screens.width(context),
//                           padding: EdgeInsets.all(5),
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                           width: Screens.width(context),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   context.watch<NewEnqController>().getcategory[index].category
//                                 ),
//                                 Divider()
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),)
//                 ],
//               ),
//             )
//               ,
//      );
//   }
// }