import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../Constant/Configuration.dart';
import '../../../Constant/Screen.dart';
import '../../../Models/ChallengeModel/challengemodel.dart';

class challengedesc extends StatefulWidget {
   challengedesc({Key? key,required this.pardata,}) : super(key: key);
 ChallengeData pardata;

  @override
  State<challengedesc> createState() => _challengedescState();
}

class _challengedescState extends State<challengedesc> {
//  int i;
  @override
  Widget build(BuildContext context) {
    
 Config config2 =  Config();
     final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: Colors.grey[300],
       insetPadding: EdgeInsets.all(10),
        // insetPadding: EdgeInsets.all(6),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.primaryColor)),
            content: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                   padding: EdgeInsets.only(
                    top: Screens.bodyheight(context) * 0.02,
                    left: Screens.bodyheight(context) * 0.02,
                    right: Screens.bodyheight(context) * 0.02,
                  ),
                  height:widget.pardata.challengeproductlist!.length >1? Screens.bodyheight(context)*0.4:Screens.bodyheight(context)*0.3,
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:  ListView.builder(
                    
                    shrinkWrap: true,
                          itemCount: widget.pardata.challengeproductlist!.length,
                          itemBuilder: (context,ind){
                          return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Challenge ID", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                    "${widget.pardata.challengeproductlist![ind].challengeid}",
                                    style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey),
                                  ),
                          ),
                          ],
                        ),
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Item code", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Container(
                            alignment: Alignment.topRight,
                            width: Screens.width(context)*0.3,
                            child: Text(
                                    "${widget.pardata.challengeproductlist![ind].itemcode}",
                                    style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey),
                                  ),
                          ),
                          ],
                        )
                      ],),
                      SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
                      //2nd row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Brand", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Text(
                                  "${widget.pardata.challengeproductlist![ind].brand}",
                                  style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                                ),
                          ],
                        ),
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Quantity", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Container(
                            alignment: Alignment.centerRight,
                            width: Screens.width(context)*0.5,
                            child: Text(
                                    "${widget.pardata.challengeproductlist![ind].quantity}",
                                    style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey),
                                  ),
                          ),
                          ],
                        )
                      ],),
            SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
                      //3rd Row
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Catagory", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Text(
                                  "${widget.pardata.challengeproductlist![ind].catagory}",
                                  style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                                ),
                          ],
                        ),
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("SubCatagory", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Container(
                            alignment: Alignment.centerRight,
                            width: Screens.width(context)*0.5,
                            child: Text(
                                    "${widget.pardata.challengeproductlist![ind].subcatagory}",
                                    style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey),
                                  ),
                          ),
                          ],
                        )
                      ],),
                      SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Incentive", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Text(
                                  "${widget.pardata.challengeproductlist![ind].incentive}",
                                  style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                                ),
                          ],
                        ),
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Challenge", style: theme.textTheme.bodyText1
                                      ?.copyWith(color: theme.primaryColor),),
                          Container(
                            // color: Colors.amber,
                            alignment: Alignment.centerRight,
                            width: Screens.width(context)*0.5,
                            child: Text(
                                    "${widget.pardata.challengeproductlist![ind].challenge}",
                                    style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.grey),
                                  ),
                          ),
                          ],
                        )
                      ],),
                
            widget.pardata.challengeproductlist!.length >1?     Divider(
                                                  color: theme.primaryColor,
                                                  thickness: 1,
                                                ):Container()
                    ],
                  );
                        })
                  
                  
                 
                ),
            SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Container(
                  height: Screens.bodyheight(context) * 0.05,
                  
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: theme.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.02),
                        width: Screens.width(context) * 0.5,
                        child: Text(
                          "${config2.alignmeetingdate333("${widget.pardata.createdon}")}",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: Screens.width(context) * 0.02),
                      //   width: Screens.width(context) * 0.2,
                      //   //color: Colors.green,
                      //   child: 
                      //   Text(
                      //     "${popvalues2[i].incentive}",
                      //     style: theme.textTheme.bodyText1
                      //         ?.copyWith(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  )),
              ],
            ),
    );
    // Container(
    //   child: Container(
    //     // color: Colors.amber,
    //     child:
    //      ListView.builder(
    //       itemCount: pardata.challengeproductlist!.length,
    //       itemBuilder: (context,ind){
    //       return Card(
    //         child: Text("${pardata.challengeproductlist![ind].brand}"

    //         ),

    //       );
    //     })
    //   ),
    // );
  }
}