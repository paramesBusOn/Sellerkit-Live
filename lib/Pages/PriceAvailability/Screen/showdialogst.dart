import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/PriceListController/PriceListController.dart';
import 'package:sellerkit/DBModel/ItemMasertDBModel.dart';
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
               createTable(theme)
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
