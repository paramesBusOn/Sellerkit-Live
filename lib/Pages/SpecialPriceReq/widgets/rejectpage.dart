
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/specialpricecontroller/tabcontroller.dart';
import 'package:sellerkit/Models/specialpriceModel/GetAllSPModel.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/widgets/Followdialog.dart';

class Rejectpage extends StatefulWidget {
   Rejectpage({Key? key, required this.theme,
    required this. filtertabdata,
     required this. provi
   }) : super(key: key);
final ThemeData theme;

List<GetAllSPData> filtertabdata;
tabpriceController provi;
  @override
  State<Rejectpage> createState() => _RejectpageState();
}

class _RejectpageState extends State<Rejectpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       width: Screens.width(context),
        height: Screens.bodyheight(context),
        padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
          child:Column(
            children: [
                Expanded(
               
                 child:RefreshIndicator(
                   onRefresh: (){
                     return context.read<tabpriceController>().swipeRefreshIndiactor();
                    },
                  child: widget.filtertabdata.isEmpty?Center(child: Column(
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
                      Text("No data..!!",textAlign: TextAlign.center,),
                    ],
                  ),): ListView.builder(
                    itemCount:widget. filtertabdata.length,
                    itemBuilder: (context,ind){
                      return InkWell(
                  //       onDoubleTap: (){
                  //         showDialog(
                  //           context: context, 
                  //         builder: (_){
                  //           return Followdialog();
                  
                  //         }
                  //         ).then((value) {
                  //           setState(() {
                  //               context
                  //                       .read<tabpriceController>()
                  //                       .refershAfterClosedialog();
                  //           });
                  //         } 
                          
                          
                  //         );
                  
                  //       },
                  //       onLongPress: (){
                  // showDialog(
                  //           context: context, 
                  //         builder: (_){
                  //           return const Followdialog();
                  
                  //         }
                  //         ).then((value) {
                  //           setState(() {
                  //               context
                  //                       .read<tabpriceController>()
                  //                       .refershAfterClosedialog();
                  //           });
                  //         } 
                          
                          
                  //         );
                  //       },
                        child: Container(
                          // color: Colors.amber,
                          padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context)*0.02,
                            vertical: Screens.padingHeight(context)*0.006
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Screens.width(context)*0.02,
                                    vertical: Screens.padingHeight(context)*0.006
                                  ),
                                    width: Screens.width(context),
                                  decoration: BoxDecoration(
                                     color: Colors.grey[200],
                                     
                                     borderRadius: BorderRadius.circular(8),
                                     border: Border.all(color: Colors.black26)
                                  ),
                                 
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Container(
                                        child: Text("UserName",style:widget. theme.textTheme.bodyText2!.copyWith(color: Colors.grey),),
                                      ),
                                       Container(
                                        child: Text("StoreCode",style:widget. theme.textTheme.bodyText2!.copyWith(color: Colors.grey),),
                                      )
                                    ],),
                                    Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Container(
                                        child: Text("${ConstantValues.firstName}",style:widget. theme.textTheme.bodyText2!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                                       Container(
                                        child: Text("${widget.filtertabdata[ind].StoreCode}",style:widget. theme.textTheme.bodyText1!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                               
                                    ],),
                                    SizedBox(
                                      height: Screens.padingHeight(context)*0.01,
                                    ),
                              
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Container(
                                        child: Text("Customer Name",style:widget. theme.textTheme.bodyText2!.copyWith(color: Colors.grey)),
                                      ),
                                      Container(
                                        child: Text("SP Price",style:widget. theme.textTheme.bodyText2!.copyWith(color: Colors.grey)),
                                      ),
                                     
                                    ],),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Container(
                                        child: Text("${widget.filtertabdata[ind].CustomerName}",style:widget. theme.textTheme.bodyText2!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                                       
                                     Container(
                                        child: Text("${context
                                                      .read<tabpriceController>()
                                                      .config.slpitCurrency22(widget.filtertabdata[ind].SP.toString())}",style:widget. theme.textTheme.bodyText2!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                                    ],),
                                     SizedBox(
                                      height: Screens.padingHeight(context)*0.01,
                                    ),
                                    Row(
                                      
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Container(
                                                    // width: Screens.width(context),
                                                    child: Text(
                                                      "Customer Mobile",
                                                      style: widget
                                                          .theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              color: Colors.grey),
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: Screens.width(context),
                                                    child: Text(
                                                      "Requested Price",
                                                      style: widget
                                                          .theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              color: Colors.grey),
                                                    ),
                                                  ),
                                     
                                      
                                       
                                    ],),
                              
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                               Container(
                                width: Screens.width(context)*0.5,
                                        child: Text("${widget.filtertabdata[ind].CustomerCode}",style:widget. theme.textTheme.bodyText1!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                                       Container(
                                        child: Text("${
                                          context
                                                      .read<tabpriceController>()
                                                      .config.slpitCurrency22(widget.filtertabdata[ind].RP.toString())
                                          }",style:widget. theme.textTheme.bodyText2!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                                    ],),
                                     SizedBox(
                                      height: Screens.padingHeight(context)*0.01,
                                    ),
                                    Row(
                                      
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Container(
                                                    // width: Screens.width(context),
                                                    child: Text(
                                                      "Product",
                                                      style: widget
                                                          .theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              color: Colors.grey),
                                                    ),
                                                  ),
                                                  Container(
                                                    // width: Screens.width(context),
                                                    child: Text(
                                                      "Percentage",
                                                      style: widget
                                                          .theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              color: Colors.grey),
                                                    ),
                                                  ),
                                     
                                      
                                       
                                    ],),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Container(
                                width: Screens.width(context)*0.5,
                                        child: Text("${widget.filtertabdata[ind].ItemName}",style:widget. theme.textTheme.bodyText1!.copyWith(color: widget.theme.primaryColor)),
                                      ),
                  Container(
                                        alignment: Alignment.centerRight,
                                        child: Text("${context
                            .read<tabpriceController>().Discountcalculation(widget.filtertabdata[ind].RP, widget.filtertabdata[ind].SP)} ",style:widget. theme.textTheme.bodyText1!.copyWith(color: widget.theme.primaryColor)),
                                      )
                                    ],),
                              //       Column(
                              //         crossAxisAlignment: CrossAxisAlignment.end,
                              //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //  Container(
                              //   alignment: Alignment.centerRight,
                               
                              //           child: Text("",style:widget. theme.textTheme.bodyText1!.copyWith(color: widget.theme.primaryColor)),
                              //         ),
                                      
                              //       ],),
                                     SizedBox(
                                      height: Screens.padingHeight(context)*0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Container(
                                        child: Text("Requested Date: ${context
                                                      .read<tabpriceController>()
                                                      .config.alignDate(widget.filtertabdata[ind].RequestDate.toString())} ${context
                                                      .read<tabpriceController>()
                                                      .config.alignTimenew(widget.filtertabdata[ind].RequestDate.toString())}" , style: widget
                                                          .theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              color: Colors.grey),),
                                      ),
                                       
                                    ],),
                                  ],),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                                
                  }),
                ),
              ),
            ],
          ),
    ); }
}