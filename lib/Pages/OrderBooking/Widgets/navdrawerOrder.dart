
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OrderController/taborder_controller.dart';

class navDrawerOrder extends StatefulWidget {
  const navDrawerOrder({Key? key}) : super(key: key);

  @override
  State<navDrawerOrder> createState() => _navDrawerOrderState();
}

class _navDrawerOrderState extends State<navDrawerOrder> {
//   String? dropdownValue;
//   String? assignvalue;
//    String? cusnamevalue;
//    String? Enquirystatusvalue;
//    String? lookingforvalue;
//      String? ordertypevalue;
//   selectcusname(String val) {
//     setState(() {
//        cusnamevalue = val;
//     });
   
    
//   }
//   selectordertype(String val) {
//     setState(() {
//        ordertypevalue = val;
//     });
   
    
//   }
//   selectlookingfor(String val) {
//     setState(() {
//        lookingforvalue = val;
//     });
   
    
//   }
//   selectEnqstatus(String val) {
//     setState(() {
//        Enquirystatusvalue = val;
//     });
   
    
//   }
//  List<String> assigncolumn=['684',"1053","622"];
//  List<String> customercolumn=['Kayal','pavi','Nirmala'];
//  List<String> Enquirystatuscolumn=['Open','Closed','Lost'];
//   List<String> lookingforcolumn=['AF','sellerkit','SAP'];
//    List<String> ordertypecolumn=['type1','type2','type3'];
//  void  selectassign(String val) {
//    setState(() {
//       assignvalue = val;
//    });
   
   
//   }
  // String? dropdownValue2;
  @override

  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Drawer(
      // backgroundColor: Colors.grey[300],
      child: ListView(
        children: [
           InkWell(
             onTap: (){
              setState(() {
                  FocusScope.of(context).unfocus();
                });
            },
             child: Container(
                 // color: Colors.amber,
                 // width: 50,
                 // height: Screens.bodyheight(context)*0.1,
                 // padding: EdgeInsets.symmetric(
                 //     horizontal: Screens.width(context) * 0.02,
                 //     vertical: Screens.padingHeight(context) * 0.004),
                 child: SingleChildScrollView(
                   child: Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
               Container(
                        alignment: Alignment.bottomCenter,
                        height: Screens.padingHeight(context)*0.1,
                       width: Screens.width(context),
                       padding: EdgeInsets.only(bottom: 10),
                       decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft:Radius.circular(Screens.padingHeight(context)*0.05),
                       bottomRight: Radius.circular(Screens.padingHeight(context)*0.05),
                        )
           
                       ),
                       child: Text("Order",style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),),
                      ),
              Container(
                width: Screens.width(context),
                 height: Screens.bodyheight(context)*0.85,
                  // height: Screens.bodyheight(context)*0.86,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                       Container(
                             width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<OrderTabController>().     ontapassignto();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Assigned to",
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              contentPadding: EdgeInsets.all(8.0),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<OrderTabController>(). isassignto ==true &&
                              context.watch<OrderTabController>(). assigncolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.15,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<OrderTabController>(). assigncolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<OrderTabController>().selectedassignto.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<OrderTabController>().itemselectassignto(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
                    //   Container(
                    //          width: Screens.width(context),
                    //         child: Padding(
                    //         padding:  EdgeInsets.only(
                    //   left: Screens.width(context)*0.02,
                    //   right: Screens.width(context)*0.02,
                    //   top: Screens.padingHeight(context)*0.01
                    // ),
                    //           child: Column(
                                
                    //             children: [
                    //             Container(
                    //               // color:Colors.amber,
                    //               decoration: BoxDecoration(
                    //                 border: Border(
                    //                   bottom: BorderSide(color: Colors.grey)
                    //                 )
                    //               ),
                    //               child: Column(
                    //                 children: [
                    //                   TextField(
                    //                           onTap: (){
                    //                             setState(() {
                    //                          context.read<OrderTabController>().     ontaplooking();
                    //                             });
                                           
                    //                           },
                                            
                    //                           readOnly: true,
                    //                         decoration: InputDecoration(
                    //                           hintText: "Customer Name",
                    //                           contentPadding: EdgeInsets.all(8.0),
                    //                            hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                    //                           border:OutlineInputBorder(borderSide: BorderSide.none),
                    //                           // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    //                           disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                    //                           // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    //                           enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                    //                           // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    //                           focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                    //                           // // UnderlineInputBorder(
                    //                           //   borderSide: BorderSide(color: Colors.grey)
                    //                           // ), 
                    //                           suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                    //                         ),
                                            
                    //                         ),
                    //            context.watch<OrderTabController>(). islookingfor ==true &&context.watch<OrderTabController>().filterlookingforcolumn.isNotEmpty?
                               
                    //               Container(
                    //                 height: Screens.padingHeight(context)*0.2,
                    //                 // color:Colors.amber,
                    //                 child:SingleChildScrollView(
                    //                   child: ListBody(
                    //                     children: context.watch<OrderTabController>().filterlookingforcolumn.
                    //                     map((item)
                    //                      => CheckboxListTile(
                    //                       value:context.watch<OrderTabController>().selectedlookingfor.contains(item.name) ,
                    //                       title: Text(item.name),
                    //                       controlAffinity: ListTileControlAffinity.leading,
                    //                       onChanged: (ischecked)=>
                    //                       context.read<OrderTabController>().itemselect(item.name,ischecked!)
                    //                        ,
                                    
                    //                      )
                    //                      ).toList()
                    //                   ),
                    //                 ) ,
                    //               ): Container()
                                   
                    //                 ],
                    //               ),
                    //             ),
                              
                    //           ],),
                    //         ),
                    //       ),
                      // Container(
                      //   width: Screens.width(context),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Container(
                      //             child: Text(
                      //           "Assigned to",
                      //           style: theme.textTheme.bodyMedium!.copyWith(
                      //               color: theme.primaryColor, fontSize: 15),
                      //         )),
                      //         SizedBox(
                      //           height: Screens.padingHeight(context) * 0.01,
                      //         ),
                      //         Container(
                      //           // color: Colors.amber,
                      //           width: Screens.width(context),
                      //           padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                      //           height: Screens.padingHeight(context) * 0.06,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(8),
                      //               border: Border.all(color: Colors.black26)),
                      //           child: DropdownButton(
                      //             isExpanded: true,
                      //             underline: SizedBox.shrink(),
                      //             value:  assignvalue,
                      //             icon: Icon(Icons.arrow_drop_down),
                      //             iconSize: 30,
                      //             onChanged: ( val) {
                      //               setState(() {
                      //               selectassign(val.toString()); 
                      //               //  context.read<Outstandingcontroller>(). assignvalue  = val!;
                      //               });
                      //             },
                      //             items:  assigncolumn.map((e) {
                      //               return DropdownMenuItem(
                      //                   value:e ,
                      //                   child: Text(e));
                      //             }).toList(),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                  //  Customer
                            Container(
                             width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<OrderTabController>().     ontapcusgroup();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Customer Group",
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              contentPadding: EdgeInsets.all(8.0),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<OrderTabController>(). iscusgroup ==true &&
                              context.watch<OrderTabController>().cusgroupcolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<OrderTabController>().cusgroupcolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<OrderTabController>().selectedcusgoup.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<OrderTabController>().itemselectCusgroup(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
           
           
           
                          //Trans Number
                          Container(
                  width: Screens.width(context),
                  // color: Colors.red,
                  child: Padding(
                    padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //     child: Text(
                        //   "From Date",
                        //   style: theme.textTheme.bodyMedium!.copyWith(
                        //       color: theme.primaryColor, fontSize: 15),
                        // )),
                        // SizedBox(
                        //   height: Screens.padingHeight(context) * 0.01,
                        // ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          // height: Screens.padingHeight(context) * 0.06,
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                              // borderRadius: BorderRadius.circular(8),
                              border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )),
                          child: TextField(
                            readOnly: true,
                            onTap: (){
                              context.read<OrderTabController>().showfromDate(context);
                             
                            },
                            controller: context.read<OrderTabController>().mycontroller[21],
                            decoration: InputDecoration(
                              hintText: "From Date",
                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                             
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: (){
                                  context.read<OrderTabController>().showfromDate(context);
                             
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: theme.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                          ),
                          //Loan number
                          Container(
                  width: Screens.width(context),
                  child: Padding(
                    padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //     child: Text(
                        //   "To Date",
                        //   style: theme.textTheme.bodyMedium!.copyWith(
                        //       color: theme.primaryColor, fontSize: 15),
                        // )),
                        // SizedBox(
                        //   height: Screens.padingHeight(context) * 0.01,
                        // ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          height: Screens.padingHeight(context) * 0.06,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                               border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )),
                          child: TextField(
                            readOnly: true,
                            onTap: (){
                              context.read<OrderTabController>().showToDate(context); 
                            },
                            controller: context.read<OrderTabController>().mycontroller[22],
                            decoration: InputDecoration(
                              hintText: "To Date",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                             
                              suffixIcon: IconButton(
                                onPressed: (){
                                  context.read<OrderTabController>().showToDate(context);
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: theme.primaryColor,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                          ),
                          //age Above
                          //status
                  //           Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Order Status",
                  //         style: theme.textTheme.bodyMedium!.copyWith(
                  //             color: theme.primaryColor, fontSize: 15),
                  //       )),
                  //       SizedBox(
                  //         height: Screens.padingHeight(context) * 0.01,
                  //       ),
                  //       Container(
                  //         // color: Colors.amber,
                  //         width: Screens.width(context),
                  //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                  //         height: Screens.padingHeight(context) * 0.06,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             border: Border.all(color: Colors.black26)),
                  //         child: DropdownButton(
                  //           isExpanded: true,
                  //           underline: SizedBox.shrink(),
                  //           value: Enquirystatusvalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //            selectEnqstatus(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:Enquirystatuscolumn. map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e}",
                  //                 child: Container(child: Text("${e.toString()}")));
                  //           }).toList(),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //         ),
                          //looking for 
           
                            Container(
                             width: Screens.width(context),
                            child: Padding(
                           padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                      top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<OrderTabController>().     onenqstatus();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Order Status",
                                              contentPadding: EdgeInsets.all(8.0),
                                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<OrderTabController>(). isenqstatus ==true &&
                               context.watch<OrderTabController>().enqstatuscolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children: context.watch<OrderTabController>(). enqstatuscolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<OrderTabController>().selectedenqstatus.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<OrderTabController>().itemselectenqstatus(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
           
           
           
                          Container(
                             width: Screens.width(context),
                            child: Padding(
                             padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                       top: Screens.padingHeight(context)*0.01
                    ),
                              child: Column(
                                
                                children: [
                                Container(
                                  // color:Colors.amber,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                              onTap: (){
                                                setState(() {
                                             context.read<OrderTabController>().     ontaporder();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Order Type",
                                              contentPadding: EdgeInsets.all(8.0),
                                              border:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                              focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
                                              hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                                              // // UnderlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.grey)
                                              // ), 
                                              suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
                                            ),
                                            
                                            ),
                               context.watch<OrderTabController>(). isorder ==true &&
                              context.watch<OrderTabController>().ordercolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:  context.watch<OrderTabController>().ordercolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<OrderTabController>().selectedorder.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<OrderTabController>().itemselectorder(item.name,ischecked!)
                                           ,
                                    
                                         )
                                         ).toList()
                                      ),
                                    ) ,
                                  ): Container()
                                   
                                    ],
                                  ),
                                ),
                              
                              ],),
                            ),
                          ),
                  //           Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Lookingfor",
                  //         style: theme.textTheme.bodyMedium!.copyWith(
                  //             color: theme.primaryColor, fontSize: 15),
                  //       )),
                  //       SizedBox(
                  //         height: Screens.padingHeight(context) * 0.01,
                  //       ),
                  //       Container(
                  //         // color: Colors.amber,
                  //         width: Screens.width(context),
                  //         padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                  //         height: Screens.padingHeight(context) * 0.06,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             border: Border.all(color: Colors.black26)),
                  //         child: DropdownButton(
                  //           isExpanded: true,
                  //           underline: SizedBox.shrink(),
                  //           value: lookingforvalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //            selectlookingfor(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:lookingforcolumn. map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e}",
                  //                 child: Container(child: Text("${e.toString()}")));
                  //           }).toList(),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //         ),
                  //         Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Age Above",
                  //         style: theme.textTheme.bodyMedium!.copyWith(
                  //             color: theme.primaryColor, fontSize: 15),
                  //       )),
                  //       SizedBox(
                  //         height: Screens.padingHeight(context) * 0.01,
                  //       ),
                  //       Container(
                  //         // color: Colors.amber,
                  //         width: Screens.width(context),
                    
                  //         height: Screens.padingHeight(context) * 0.06,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(8),
                  //             border: Border.all(color: Colors.black26)),
                  //         child: TextField(
                  //           // controller: context.read<Outstandingcontroller>().mycontroller[4],
                  //           keyboardType: TextInputType.number,
                  //           decoration: InputDecoration(
                  //             hintText: "Age",
                  //             enabledBorder: InputBorder.none,
                  //             focusedBorder: InputBorder.none,
                  //             // suffixIcon: Icon(
                  //             //   Icons.search,
                  //             //   color: theme.primaryColor,
                  //             // ),
                  //             contentPadding: const EdgeInsets.symmetric(
                  //               vertical: 10,
                  //               horizontal: 5,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //         ),
                          //Balance Above
                          Container(
                            // color:Colors.red,
                  width: Screens.width(context),
                  child: Padding(
                    padding:  EdgeInsets.only(
                      left: Screens.width(context)*0.02,
                      right: Screens.width(context)*0.02,
                       top: Screens.padingHeight(context)*0.01
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //     child: Text(
                        //   "Value Above",
                        //   style: theme.textTheme.bodyMedium!.copyWith(
                        //       color: theme.primaryColor, fontSize: 15),
                        // )),
                        // SizedBox(
                        //   height: Screens.padingHeight(context) * 0.01,
                        // ),
                        Container(
                          // color: Colors.amber,
                          width: Screens.width(context),
                    
                          // height: Screens.padingHeight(context) * 0.06,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              border: Border(
                                      bottom: BorderSide(color: Colors.grey)
                                    )
                              
                              ),
                          child: TextField(
                            controller: context.read<OrderTabController>().mycontroller[23],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Value Above",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // suffixIcon: Icon(
                              //   Icons.search,
                              //   color: theme.primaryColor,
                              // ),
                              hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                              // theme.textTheme.bodyMedium!.copyWith(
                              // color: theme.primaryColor, fontSize: 15),
                       
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                          ),
                  
                    ],
                  ),
                ),
              ),
              // SizedBox(height: Screens.padingHeight(context)*0.001,),
              
                    
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                     Container
                     
                     (
              width: Screens.width(context)*0.3,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
                 context.read<OrderTabController> (). clearfilterval();
              },
              
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                  )
                ),
               child: Text("Cancel"))),
              Container(
                width: Screens.width(context)*0.3,
                
                child: ElevatedButton(
                  onPressed: (){
                 setState(() {
                    Navigator.pop(context);
             context.read<OrderTabController>().  onfilterapply();
                  // context.read<Outstandingcontroller>().  onfilterapply();
                 });
                 
                },
                     
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                  )
                ),
                 child: Text("Apply")))
                    ],)
                     ],
                   ),
                 ),
               ),
           )
    
          ],
      ),

    );
  }
}