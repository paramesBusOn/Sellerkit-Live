import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/PriceListController/PriceListController.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
import 'package:sellerkit/main.dart';
class showdialogst extends StatefulWidget {
   showdialogst({super.key,required this.getalldata});
ItemMasterDBModel getalldata;
  @override
  State<showdialogst> createState() => _showdialogstState();
}

class _showdialogstState extends State<showdialogst> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: displayDialog(context, theme));
  }

  Container loadingDialog(BuildContext context) {
    return Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.4,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }

  Container displayDialog(BuildContext context, ThemeData theme) {
    return Container(
      
      width: Screens.width(context),
      child:context.watch<PriceListController>(). isloading==true?
      Center(
       child: CircularProgressIndicator())
      
      :(context.watch<PriceListController>(). isloading ==false &&
      context.read<PriceListController>().itemviewdata.isEmpty)
      ?Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('Assets/no-data.png',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.5
                        ),
                  ),
            Text('No data..!!',),
          ],
        )):SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Price Details",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white)),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Container(
               padding: EdgeInsets.only(
                         left: Screens.width(context) * 0.03,
                        right: Screens.width(context) * 0.03,
                        top: Screens.bodyheight(context) * 0.01,
                        bottom: Screens.bodyheight(context) * 0.01,
                      ),
                      //  height: Screens.bodyheight(context) * 0.7,
              child:
              //  ListView.builder(
              //    itemCount: context
              //                 .watch<PriceListController>()
              //                 .itemviewdata
              //                 .length,
              //   itemBuilder:(BuildContext context, int i){
              //  return Card(
              //    elevation: 5,
              //    child: Container(
              //     width: Screens.width(context),
              //                     padding: EdgeInsets.symmetric(
              //                         vertical:
              //                             Screens.bodyheight(context) * 0.01,
              //                         horizontal: Screens.width(context) * 0.02),
              //     child: Column(children: [
              // Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             SizedBox(
              //                               width: Screens.width(context) * 0.4,
              //                               child: Text(
              //                                   "Item code: ${context
              //                 .watch<PriceListController>()
              //                 .itemviewdata[i].itemcode}",
              //                                   style: theme.textTheme.bodyText1
              //                                       ?.copyWith(
              //                                           color:
              //                                               theme.primaryColor)),
              //                             ),
              //                             Container(
              //                               alignment: Alignment.centerRight,
              //                               width: Screens.width(context) * 0.4,
              //                               child: Column(
              //                                 children: [
              //                                    Text("Store code: ${context
              //                 .watch<PriceListController>()
              //                 .itemviewdata[i].storeCode}",
              //                                     style: theme.textTheme.bodyText1
              //                                         ?.copyWith( color:
              //                                               theme.primaryColor),),
              //                                   Text(
              //                                     context.watch<PriceListController>().subtractDateTime(context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate!),
              //                             // "Store code: ${context.watch<PriceListController>().getlistPriceAvail[i].storeCode}",
                                                 
              //                              //   " ${context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate}",
              //                                     style: theme.textTheme.bodyText1
              //                                         ?.copyWith(color: Colors.grey),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height:
              //                               Screens.bodyheight(context) * 0.01,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Container(
              //                             alignment: Alignment.centerRight,
              //                             child: Text(
              //                               ConstantValues.sapUserType.toLowerCase()=='manager'?
              //                               "${context.watch<PriceListController>().itemviewdata[i].MgrPrice}"
              //                            :'', 
              //                              style: theme.textTheme.bodyText1
              //                                   ?.copyWith(
              //                               color:
              //                                   theme.primaryColor),
              //                             ),
              //                             ),
                          
              //                                Container(
              //                                alignment: Alignment.centerRight,
              //                                child: Text(
              //                                  "${context.watch<PriceListController>().config.slpitCurrency22(context.watch<PriceListController>().itemviewdata[i].sp.toString())}",
              //                                  style: theme.textTheme.bodyText1
              //                                      ?.copyWith(
              //                                  color:
              //                                      theme.primaryColor),
              //                                ),
              //                             ),
                                      
              //                           ],
              //                         ),
              //     ],),
              //    ),
                 
              //  );
              // } )
              
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               Container(
              child: Text("Item Code",style:  theme.textTheme.bodyText2?.copyWith(color: Colors.grey),),
            ),
             SizedBox(
                          height: Screens.bodyheight(context) * 0.002,
                        ),
            Container(
              child: Text("${widget.getalldata.itemCode}",style:  theme.textTheme.bodyText2?.copyWith(color: theme.primaryColor)),
            ),


             SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                         Container(
              child: Text("Item Name",style:  theme.textTheme.bodyText2?.copyWith(color: Colors.grey),),
            ),
             SizedBox(
                          height: Screens.bodyheight(context) * 0.002,
                        ),
            Container(
              child: Text("${widget.getalldata.itemName}",style:  theme.textTheme.bodyText2?.copyWith(color: theme.primaryColor)),
            ),


             
             SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
     ConstantValues.showallslab!.toLowerCase() !='y'?Container():        createTable7(theme,widget.getalldata),
        ConstantValues.showallslab!.toLowerCase() !='y'?Container():     createTable2(theme,widget.getalldata),
            Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Store Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
            createTable5(theme,widget.getalldata),
            Container(
                        // width: Screens.width(context)*0.7,
                        // color: Colors.red,
                        child: Text("Whse Age Slab:",
                            style: theme.textTheme.bodyText1
                                ?.copyWith() //color: theme.primaryColor
                            ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
            createTable6(theme,widget.getalldata),
            
             ConstantValues.showallslab!.toLowerCase() !='y'?Container():  createTable(theme),
             
               if(ConstantValues.showallslab!.toLowerCase() =='y')...[
  Container()
]

else ...[
   if (context.read<PriceListController>().Particularprice.length <= 5) ...[
      createTableparticular(theme, widget.getalldata, context),
    ] else if (context.read<PriceListController>().Particularprice.length <= 10) ...[
      createTableparticular(theme, widget.getalldata, context),
      SizedBox(height: 5),
      createTableparticular2(theme, widget.getalldata, context),
    ] else if (context.read<PriceListController>().Particularprice.length <= 15) ...[
      createTableparticular(theme, widget.getalldata, context),
      SizedBox(height: 5),
      createTableparticular2(theme, widget.getalldata, context),
      SizedBox(height: 5),
      createTableparticular3(theme, widget.getalldata, context),
    ] else ...[
      Container(), // Fallback if none of the conditions are met
    ],
],  
                ])
        
            //           Container(
            //   child: Text("Store Code",style:  theme.textTheme.bodyText2?.copyWith(color: Colors.grey),),
            // ),
            //  SizedBox(
            //               height: Screens.bodyheight(context) * 0.01,
            //             ),
            //             Center(
            //               child: Wrap(
            //                   spacing: 5.0, // width
            //                   runSpacing: 10.0, // height
            //                   children: listContainersCustomerTag(
            //                     theme,
            //                   )),
            //             ),
            //   ],),
            ),
            
                         SizedBox(
                          height: Screens.bodyheight(context) * 0.03,
                        ),
          ],
        ),
      ),
    );
  }
Widget createTableparticular(ThemeData theme, ItemMasterDBModel getalldata,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 context.read<PriceListController>().Particularprice.length > 0 &&   context.read<PriceListController>().Particularprice[0] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().Particularprice[0].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 context.read<PriceListController>().Particularprice.length > 1 &&   context.read<PriceListController>().Particularprice[1] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().Particularprice[1].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
 context.read<PriceListController>(). Particularprice.length > 2 &&  context.read<PriceListController>().Particularprice[2] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().Particularprice[2].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
 context.read<PriceListController>().  Particularprice.length > 3 && context.read<PriceListController>(). Particularprice[3] !=null?  Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().Particularprice[3].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 4 &&  context.read<PriceListController>().  Particularprice[4] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[4].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  context.read<PriceListController>().  Particularprice.length > 0 &&  context.read<PriceListController>().  Particularprice[0].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[0].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 1 &&  context.read<PriceListController>().  Particularprice[1].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[1].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 2 &&  context.read<PriceListController>().  Particularprice[2].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[2].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 3 &&   context.read<PriceListController>().  Particularprice[3].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[3].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   context.read<PriceListController>().  Particularprice.length > 4 &&   context.read<PriceListController>().  Particularprice[4].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[4].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }


  Widget createTableparticular2(ThemeData theme, ItemMasterDBModel getalldata,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 context.read<PriceListController>().  Particularprice.length > 5 &&   context.read<PriceListController>().  Particularprice[5] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[5].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 context.read<PriceListController>().  Particularprice.length > 6 &&   context.read<PriceListController>().  Particularprice[6] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[6].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 7 &&  context.read<PriceListController>().  Particularprice[7] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[7].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
   context.read<PriceListController>().  Particularprice.length > 8 &&  context.read<PriceListController>().  Particularprice[8] !=null?  Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[8].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 9 &&  context.read<PriceListController>().  Particularprice[9] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[9].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  context.read<PriceListController>().  Particularprice.length > 5 &&  context.read<PriceListController>().  Particularprice[5].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[5].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 6 &&  context.read<PriceListController>().  Particularprice[6].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[6].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 7 &&  context.read<PriceListController>().  Particularprice[7].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[7].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 8 &&   context.read<PriceListController>().  Particularprice[8].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[8].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   context.read<PriceListController>().  Particularprice.length > 9 &&   context.read<PriceListController>().  Particularprice[9].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[9].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }

  Widget createTableparticular3(ThemeData theme, ItemMasterDBModel getalldata,BuildContext context) {
 
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
 context.read<PriceListController>().  Particularprice.length > 10 &&   context.read<PriceListController>().  Particularprice[10] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[10].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ):Container(),
 context.read<PriceListController>().  Particularprice.length > 11 &&   context.read<PriceListController>().  Particularprice[11] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[11].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 12 &&  context.read<PriceListController>().  Particularprice[12] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[12].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
   context.read<PriceListController>().  Particularprice.length > 13 &&  context.read<PriceListController>().  Particularprice[13] !=null?  Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[13].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 14 &&  context.read<PriceListController>().  Particularprice[14] !=null?   Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${context.read<PriceListController>().  Particularprice[14].PriceList}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ):Container(),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
  context.read<PriceListController>().  Particularprice.length > 10 &&  context.read<PriceListController>().  Particularprice[10].PriceList !=null?
     Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[10].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 11 &&  context.read<PriceListController>().  Particularprice[11].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
         context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[11].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 12 &&  context.read<PriceListController>().  Particularprice[12].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[12].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
  context.read<PriceListController>().  Particularprice.length > 13 &&   context.read<PriceListController>().  Particularprice[13].PriceList !=null?
       Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[13].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
   context.read<PriceListController>().  Particularprice.length > 14 &&   context.read<PriceListController>().  Particularprice[14].PriceList !=null? Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'mrp'?
        config.slpitCurrency22(getalldata.mgrPrice.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'sp'?
        config.slpitCurrency22(getalldata.sp.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'cost'?
        config.slpitCurrency22(getalldata.slpPrice.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp1'?
        config.slpitCurrency22(getalldata.ssp1.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp2'?
        config.slpitCurrency22(getalldata.ssp2.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp3'?
        config.slpitCurrency22(getalldata.ssp3.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp4'?
        config.slpitCurrency22(getalldata.ssp4.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp5'?
        config.slpitCurrency22(getalldata.ssp5.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp1_inc'?
        config.slpitCurrency22(getalldata.ssp1Inc.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp2_inc'?
        config.slpitCurrency22(getalldata.ssp2Inc.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp3_inc'?
        config.slpitCurrency22(getalldata.ssp3Inc.toString()):
        context.read<PriceListController>().  Particularprice[14].PriceList!.toLowerCase() == 'ssp4_inc'?
        config.slpitCurrency22(getalldata.ssp4Inc.toString()):
          '',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ):Container(),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }
  Widget createTable2(ThemeData theme, ItemMasterDBModel getalldata) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5_Inc}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp1Inc.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp2Inc.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp3Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp4Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp5Inc.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }
  

  Widget createTable5(ThemeData theme, ItemMasterDBModel getalldata) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.storeAgeSlab1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.storeAgeSlab2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.storeAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.storeAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
     
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
      
    }, children: rows);
  }
Widget createTable7(ThemeData theme,ItemMasterDBModel getalldata) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ssp5}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.ssp5.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.0),
      1: FlexColumnWidth(1.0),
      2: FlexColumnWidth(1.0),
      3: FlexColumnWidth(1.0),
      4: FlexColumnWidth(1.0),
    }, children: rows);
  }
  Widget createTable6(ThemeData theme, ItemMasterDBModel getalldata) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab1}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab2}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab3}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "${ConstantValues.ageslab4}",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
     
    ]));
    // for (int i = 0;
    //     i < allProductDetails.length;
    //     ++i) {
    rows.add(TableRow(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.whsAgeSlab1.toString()),
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.whsAgeSlab2.toString()),
          // '${context.watch<OrderTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.whsAgeSlab3.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          config.slpitCurrency22(getalldata.whsAgeSlab4.toString()),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyText1?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
     
    ]));
    // }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
      
    }, children: rows);
  }
  
   Widget createTable(ThemeData theme) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Store",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "MRP",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "SP",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    for (int i = 0; i < context.read<PriceListController>().itemviewdata.length; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Text(
            '${context.read<PriceListController>().itemviewdata[i].storeCode}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Text(
            "${context.watch<PriceListController>().config.slpitCurrency22(context.watch<PriceListController>().itemviewdata[i].MgrPrice.toString())}",
            // '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Text(
            '${context.watch<PriceListController>().config.slpitCurrency22(context.watch<PriceListController>().itemviewdata[i].sp.toString())}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(1.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
    }, children: rows);
  }
  List<Widget> listContainersCustomerTag(
    ThemeData theme,
  ) {
    return List.generate(
       context.watch<PriceListController>().itemviewdata.length,
        (index) => InkWell(
          child:  Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.05,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:
                 
                       theme.primaryColor //theme.primaryColor.withOpacity(0.5)
                     ,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context.watch<PriceListController>().itemviewdata[index].storeCode
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color:
                         Colors.white //,Colors.white
                       ,
                  ))
            ],
          ),
        ),
        )
    );
  }
}
