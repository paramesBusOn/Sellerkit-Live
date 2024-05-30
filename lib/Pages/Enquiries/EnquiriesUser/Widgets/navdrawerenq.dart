
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/EnquiryController/EnquiryUserContoller.dart';

class navDrawerEnq extends StatefulWidget {
  const navDrawerEnq({Key? key}) : super(key: key);

  @override
  State<navDrawerEnq> createState() => _navDrawerEnqState();
}

class _navDrawerEnqState extends State<navDrawerEnq> {
 
//  List<String> assigncolumn=['684',"1053","622"];
//  List<String> customercolumn=['Kayal','pavi','Nirmala'];
//  List<String> Enquirystatuscolumn=['Open','Closed','Lost'];
//   List<String> lookingforcolumn=['AF','sellerkit','SAP'];
//     List<String> interestcolumn=['AF','sellerkit','SAP'];
//      List<String> ordertypecolumn=['type1','type2','type3'];
 
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
                 // color: Colors.grey[300],
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
                       child: Text("Enquiry",style: theme.textTheme.bodyText2!.copyWith(color: Colors.white),),
                      ),
              Container(
                width: Screens.width(context),
                  height: Screens.bodyheight(context)*0.85,
                  // color: Colors.amber,
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
                                             context.read<EnquiryUserContoller>().     ontapassignto();
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
                               context.watch<EnquiryUserContoller>(). isassignto ==true &&
                              context.watch<EnquiryUserContoller>(). assigncolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.15,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<EnquiryUserContoller>(). assigncolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedassignto.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselectassignto(item.name,ischecked!)
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
           
           
           
           // Container(
           //                            width: Screens.width(context),
           //                           child: Padding(
           //                            padding:  EdgeInsets.only(
           //                     left: Screens.width(context)*0.02,
           //                     right: Screens.width(context)*0.02,
           //                     top: Screens.padingHeight(context)*0.01
           //                   ),
           //                             child: Column(
                                
           //                               children: [
           //                               Container(
           //                                 // color:Colors.amber,
           //                                 decoration: BoxDecoration(
           //                                   border: Border(
           //                                     bottom: BorderSide(color: Colors.grey)
           //                                   )
           //                                 ),
           //                                 child: Column(
           //                                   children: [
           //                                     TextField(
           //                                             onTap: (){
           //                                               setState(() {
           //                                            context.read<EnquiryUserContoller>().     ontapcusname();
           //                                               });
                                           
           //                                             },
                                            
           //                                             readOnly: true,
           //                                           decoration: InputDecoration(
           //                                             hintText: "Customer Name",
           //                                              hintStyle:TextStyle(color: Colors.black, fontSize: 15),
           //                                             contentPadding: EdgeInsets.all(8.0),
           //                                             border:OutlineInputBorder(borderSide: BorderSide.none),
           //                                             // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
           //                                             disabledBorder :OutlineInputBorder(borderSide: BorderSide.none),
           //                                             // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
           //                                             enabledBorder:OutlineInputBorder(borderSide: BorderSide.none),
           //                                             // UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
           //                                             focusedBorder:OutlineInputBorder(borderSide: BorderSide.none),
           //                                             // // UnderlineInputBorder(
           //                                             //   borderSide: BorderSide(color: Colors.grey)
           //                                             // ), 
           //                                             suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,)
           //                                           ),
                                            
           //                                           ),
           //                              context.watch<EnquiryUserContoller>(). iscusname ==true &&
           //                             context.watch<EnquiryUserContoller>().cusnamecolumn.isNotEmpty?
                               
           //                                 Container(
           //                                   height: Screens.padingHeight(context)*0.2,
           //                                   // color:Colors.amber,
           //                                   child:SingleChildScrollView(
           //                                     child: ListBody(
                                        
           //                                       children:context.watch<EnquiryUserContoller>().cusnamecolumn.
           //                                       map(
                                          
           //                                         (item)
           //                                        =>
                                        
           //                                         CheckboxListTile(
           //                                         value:context.watch<EnquiryUserContoller>().selectedcusname.contains(item.name) ,
           //                                         title: Text(item.name),
           //                                         controlAffinity: ListTileControlAffinity.leading,
           //                                         onChanged: (ischecked)=>
           //                                         context.read<EnquiryUserContoller>().itemselectCusname(item.name,ischecked!)
           //                                          ,
                                    
           //                                        )
           //                                        ).toList()
           //                                     ),
           //                                   ) ,
           //                                 ): Container()
                                   
           //                                   ],
           //                                 ),
           //                               ),
                              
           //                             ],),
           //                           ),
           //                         ),
           
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
                      //             value: context.read<EnquiryUserContoller>(). assignvalue,
                      //             icon: Icon(Icons.arrow_drop_down),
                      //             iconSize: 30,
                      //             onChanged: ( val) {
                      //               setState(() {
                      //              context.read<EnquiryUserContoller>(). selectassign(val.toString()); 
                      //               //  context.read<Outstandingcontroller>(). assignvalue  = val!;
                      //               });
                      //             },
                      //             items: context.read<EnquiryUserContoller>(). assigncolumn.map((e) {
                      //               return DropdownMenuItem(
                      //                   value:e.name ,
                      //                   child: Text(e.name));
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
                                             context.read<EnquiryUserContoller>().     ontapcusgroup();
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
                               context.watch<EnquiryUserContoller>(). iscusgroup ==true &&
                              context.watch<EnquiryUserContoller>().cusgroupcolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:context.watch<EnquiryUserContoller>().cusgroupcolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedcusgoup.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselectCusgroup(item.name,ischecked!)
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
                  //         Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Customer Group",
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
                  //           value:context.read<EnquiryUserContoller>(). cusnamevalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //          context.read<EnquiryUserContoller>().  selectcusname(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:context.read<EnquiryUserContoller>().cusgroupcolumn . map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e.name}",
                  //                 child: Container(child: Text("${e.name.toString()}")));
                  //           }).toList(),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //         ),
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
                              context.read<EnquiryUserContoller>().showfromDate(context);
                             
                            },
                            controller: context.read<EnquiryUserContoller>().mycontroller[16],
                            decoration: InputDecoration(
                              hintText: "From Date",
                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                             
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: (){
                                  context.read<EnquiryUserContoller>().showfromDate(context);
                             
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
                              context.read<EnquiryUserContoller>().showToDate(context); 
                            },
                            controller: context.read<EnquiryUserContoller>().mycontroller[17],
                            decoration: InputDecoration(
                              hintText: "To Date",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                               hintStyle:TextStyle(color: Colors.black, fontSize: 15),
                             
                              suffixIcon: IconButton(
                                onPressed: (){
                                  context.read<EnquiryUserContoller>().showToDate(context);
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
           
           
                          //new
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
                                             context.read<EnquiryUserContoller>().     onenqstatus();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Enquiry Status",
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
                               context.watch<EnquiryUserContoller>(). isenqstatus ==true &&
                               context.watch<EnquiryUserContoller>().enqstatuscolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children: context.watch<EnquiryUserContoller>(). enqstatuscolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedenqstatus.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselectenqstatus(item.name,ischecked!)
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
                  //         "Enquiry Status",
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
                  //           value: context.read<EnquiryUserContoller>().Enquirystatusvalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //          context.read<EnquiryUserContoller>().  selectEnqstatus(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:context.read<EnquiryUserContoller>(). enqstatuscolumn . map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e.name}",
                  //                 child: Container(child: Text("${e.name.toString()}")));
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
                                             context.read<EnquiryUserContoller>().     ontaplooking();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Looking For",
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
                               context.watch<EnquiryUserContoller>(). islookingfor ==true &&context.watch<EnquiryUserContoller>().filterlookingforcolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children: context.watch<EnquiryUserContoller>().filterlookingforcolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedlookingfor.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselect(item.name,ischecked!)
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
                     //                 Container(
                     //       width: Screens.width(context),
                     //       child: Padding(
                     //         padding: const EdgeInsets.all(8.0),
                     //         child: Column(
                     //           crossAxisAlignment: CrossAxisAlignment.start,
                     //           children: [
                     //             Container(
                     //                 child: Text(
                     //               "Lookingfor",
                     //               style: theme.textTheme.bodyMedium!.copyWith(
                     //                   color: theme.primaryColor, fontSize: 15),
                     //             )),
                     //             SizedBox(
                     //               height: Screens.padingHeight(context) * 0.01,
                     //             ),
                     //             Container(
                     //               // color: Colors.amber,
                     //               width: Screens.width(context),
                     //               // padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                     //               height:
                     //               context.watch<EnquiryUserContoller>().lookingforcolumnforshow.isEmpty? 
                     //                Screens.padingHeight(context) * 0.065
                     //               :Screens.padingHeight(context) * 0.2
                     //               ,
                     //               decoration: BoxDecoration(
                     //                   borderRadius: BorderRadius.circular(8),
                     //                   border: Border.all(color: Colors.black26)),
                     //                   child: Column(
                     //                     children: [
                     //                       TextField(
                     //                       //   onTap: (){
                     //                       // context.watch<EnquiryUserContoller>().islookloading = !context.watch<EnquiryUserContoller>().islookloading!;
                     //                       //   },
                     //                         onTap: (){
                     //                         setState(() {
                     //                           showDialog(context: context, builder: (_)
                     //                                             {
                     //                                               return StatefulBuilder(
                     //                                                 builder: (context,st) {
                     //                                                   return AlertDialog(
                     //                           insetPadding: EdgeInsets.all(10),
                     //                            contentPadding: EdgeInsets.all(0),
                     //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     //                           content:Container(
                     //                           width: Screens.width(context)*0.7,
                     //                           child: Column(
                     //                             mainAxisSize: MainAxisSize.min,
                     //                             children: [
                     //                             Container(
                     //                                 width: Screens.width(context),
                     //                                 height: Screens.bodyheight(context) * 0.06,
                     //                                 child: ElevatedButton(
                     //                                     onPressed: () {},
                     //                                     style: ElevatedButton.styleFrom(
                     //                                       textStyle: TextStyle(
                     //                                           // fontSize: 12,
                     //                                           ),
                     //                                       shape: RoundedRectangleBorder(
                     //                                           borderRadius: BorderRadius.only(
                     //                                         topRight: Radius.circular(10),
                     //                                         topLeft: Radius.circular(10),
                     //                                       )), //Radius.circular(6)
                     //                                     ),
                     //                                     child: Text(
                     //                                       "Looking For",
                     //                                     )),
                     //                               ),
                     //                                 SizedBox(
                     //                                       height: Screens.padingHeight(context)*0.01,
                     //                                     ),
                     //                               Padding(
                     //                                 padding: const EdgeInsets.all(8.0),
                     //                                 child: Container(
                     //                                         height: Screens.bodyheight(context) * 0.05,
                     //                                         decoration: BoxDecoration(
                     //                                           color: Colors.grey[200],
                     //                                           borderRadius:
                     //                                             BorderRadius.circular(Screens.width(context) * 0.01),
                                                     
                     //                                         ),
                     //                                         child: TextField(
                     //                                           // controller:
                     //                                             // context.read<EnquiryUserContoller>().mycontroller[1],
                     //                                           onTap: () {
                     //                                             // Get.toNamed(ConstantRoutes.screenshot);
                     //                                           },
                     //                                           autocorrect: false,
                     //                                           onChanged: (v) {
                     //                                             st(() {
                     //                                                   context
                     //                           .read<EnquiryUserContoller>()
                     //                           .lookingfilter(v);
                     //                                             });
                                                        
                                                        
                     //                                           },
                     //                                           decoration: InputDecoration(
                     //                                             filled: false,
                     //                                             hintText: 'Search',
                     //                                             enabledBorder: InputBorder.none,
                     //                                             focusedBorder: InputBorder.none,
                     //                                             suffixIcon: Icon(
                     //                                             Icons.search,
                     //                                             color: theme.primaryColor,
                     //                                             ),
                     //                                             contentPadding: const EdgeInsets.symmetric(
                     //                                             vertical: 10,
                     //                                             horizontal: 5,
                     //                                             ),
                     //                                           ),
                     //                                         ),
                     //                                       ),
                     //                               ),
                                  
                     //                                     SizedBox(
                     //                                       height: Screens.padingHeight(context)*0.01,
                     //                                     ),
                     //                                       Container(
                     //                                           height: Screens.padingHeight(context) * 0.30,
                     //                                           child: SingleChildScrollView(
                     //                                           child: Wrap(
                     //                                                   spacing: 5.0, // gap between adjacent chips
                     //                                                   runSpacing: 5.0, // gap between lines
                     //                                                   children: 
                     //                        List.generate(
                     //                         context.watch<EnquiryUserContoller>().filterlookingforcolumn.length,
                     //                           (ind)=>
                     //                           // StatefulBuilder(
                     //                           //   builder: (context,st) {
                     //                                GestureDetector(
                     //                                 onTap: () {
                     //                                   // context.read<EnquiryUserContoller>().selectedIdxFUser = ind;
                     //                                   st(() {
                     //                                      context.read<EnquiryUserContoller>().selectlookingfor(ind);
                     //                                     // context.read<EnquiryUserContoller>().filterlookingforcolumn[ind].ischecck= !context.read<EnquiryUserContoller>().filterlookingforcolumn[ind].ischecck;
                     //                                   });
                                             
                     //                                 },
                     //                                 child: Container(
                     //                                   // alignment: Alignment.center,
                     //                                   // width: Screens.width(context) * 0.2,
                     //                                   // height: Screens.bodyheight(context) * 0.06,
                     //                                   padding: EdgeInsets.all(5),
                     //                                   decoration: BoxDecoration(
                     //                                       color: context
                     //                         .watch<EnquiryUserContoller>()
                     //                         .filterlookingforcolumn[ind]
                     //                         .ischecck ==
                     //                                                   true
                     //                                           ? theme.primaryColor
                     //                                           : Colors.white,
                     //                                       border: Border.all(color: theme.primaryColor, width: 1),
                     //                                       borderRadius: BorderRadius.circular(5)),
                     //                                   child: Text(
                     //                                       context
                     //                                           .watch<EnquiryUserContoller>()
                     //                                           .filterlookingforcolumn[ind]
                     //                                           .name!,
                     //                                       // maxLines: 1,
                     //                                       //overflow: TextOverflow.ellipsis,
                     //                                       style: theme.textTheme.bodyText2?.copyWith(
                     //                                         fontWeight: FontWeight.normal,
                     //                                         fontSize: 12,
                     //                                         color: context
                     //                           .watch<EnquiryUserContoller>()
                     //                           .filterlookingforcolumn[ind]
                     //                           .ischecck ==
                     //                       true
                     //                                             //content[index].isselected == 1
                     //                                             ? Colors.white
                     //                                             : theme.primaryColor,
                     //                                       )),
                     //                                 ),
                     //                               )
                     //                           //   }
                     //                           // ),
                     //                       )
                                                              
                     //                                                   // listContainersProduct(
                     //                                                   //       theme,
                     //                                                   // )
                     //                                                   ),
                     //                                           ),
                     //                                         ),
                                                         
                     //                                                   Container(
                     //                                 width: Screens.width(context),
                     //                                 height: Screens.bodyheight(context) * 0.06,
                     //                                 child: ElevatedButton(
                     //                                     onPressed: () {
                     //                                       Navigator.pop(context);
                     //                                      context.read<EnquiryUserContoller>(). addlookingfor();
                     //                                     },
                     //                                     style: ElevatedButton.styleFrom(
                     //                                       textStyle: TextStyle(
                     //                                           // fontSize: 12,
                     //                                           ),
                     //                                       shape: RoundedRectangleBorder(
                     //                                           borderRadius: BorderRadius.only(
                     //                                         bottomLeft: Radius.circular(10),
                     //                                         bottomRight: Radius.circular(10),
                     //                                       )), //Radius.circular(6)
                     //                                     ),
                     //                                     child: Text(
                     //                                       "Ok",
                     //                                     )),
                     //                               ),
                     //                           ],),
                     //                           )
                     //                                                   );
                     //                                                 }
                     //                                               );
                                  
                     //                                             });
                     //                         });
                     //                       },
                     //                         readOnly: true,
                     //                       decoration: InputDecoration(
                     //                         contentPadding: EdgeInsets.all(8.0),
                     //                         border:InputBorder.none,
                     //                         disabledBorder :OutlineInputBorder(
                     //                           borderSide: BorderSide.none
                     //                         ),
                     //                         enabledBorder:OutlineInputBorder(
                     //                           borderSide: BorderSide.none
                     //                         ),
                     //                         focusedBorder:OutlineInputBorder(
                     //                           borderSide: BorderSide.none
                     //                         ), 
                     //                         suffixIcon: Icon(Icons.arrow_drop_down)
                     //                       ),
                                  
                     //                       ),
                     //                 context.watch<EnquiryUserContoller>().lookingforcolumnforshow.isEmpty
                     //  ?Container():
                     //           Container(
                     //                 width: Screens.width(context),
                     //                 height: Screens.padingHeight(context)*0.1,
                     //                 padding: EdgeInsets.only(
                     //                   top:  Screens.padingHeight(context)*0.002,
                     //                 left: Screens.width(context)*0.002,
                     //                 ),
                     //                 // decoration: BoxDecoration(
                     //                 //   borderRadius: BorderRadius.only(
                     //                 //     bottomLeft: Radius.circular(8),
                     //                 //     bottomRight: Radius.circular(8)
           
                     //                 //   ),
                     //                 //   border: Border.all(
                                  
                     //                 //     color: Colors.black26
                     //                 //   )
                     //                 // ),
                     //                 // color: Colors.amber,
                     //                 child: SingleChildScrollView(
                     //             child: Wrap(
                     //                 spacing: 5.0, // gap between adjacent chips
                     //                 runSpacing: 5.0, // gap between lines
                     //                 children: listContainersProducttoshow(
                     //                   theme,
                     //                 )),
                     //             ),
                     //               ),
                     //                     ],
                     //                   ),
                          
                     //             ),
                     
                     //           ],
                     //         ),
                     //       ),
                     //               ),
                        //new interest
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
                                             context.read<EnquiryUserContoller>().     ontapinterest();
                                                });
                                           
                                              },
                                            
                                              readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "Interest Level",
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
                               context.watch<EnquiryUserContoller>(). isinterest ==true &&
                               context.read<EnquiryUserContoller>(). intlevelcolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children: context.watch<EnquiryUserContoller>(). intlevelcolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedinterest.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselectinterest(item.name,ischecked!)
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
                  //          Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Interest Level",
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
                  //           value:context.read<EnquiryUserContoller>(). interestlevelvalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //           context.read<EnquiryUserContoller>(). selectinterest(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items:context.read<EnquiryUserContoller>(). intlevelcolumn. map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e.name}",
                  //                 child: Container(child: Text("${e.name.toString()}")));
                  //           }).toList(),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //         ),
           
           
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
                                             context.read<EnquiryUserContoller>().     ontaporder();
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
                               context.watch<EnquiryUserContoller>(). isorder ==true &&
                              context.watch<EnquiryUserContoller>().ordercolumn.isNotEmpty?
                               
                                  Container(
                                    height: Screens.padingHeight(context)*0.2,
                                    // color:Colors.amber,
                                    child:SingleChildScrollView(
                                      child: ListBody(
                                        children:  context.watch<EnquiryUserContoller>().ordercolumn.
                                        map((item)
                                         => CheckboxListTile(
                                          value:context.watch<EnquiryUserContoller>().selectedorder.contains(item.name) ,
                                          title: Text(item.name),
                                          controlAffinity: ListTileControlAffinity.leading,
                                          onChanged: (ischecked)=>
                                          context.read<EnquiryUserContoller>().itemselectorder(item.name,ischecked!)
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
                  //          Container(
                  // width: Screens.width(context),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           child: Text(
                  //         "Order Type",
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
                  //           value:context.read<EnquiryUserContoller>(). ordertypevalue,
                  //           icon: Icon(Icons.arrow_drop_down),
                  //           iconSize: 30,
                  //           onChanged: ( val) {
                  //             setState(() {
                  //           context.read<EnquiryUserContoller>(). selectordertype(val.toString()); 
                                    
                  //             });
                  //           },
                  //           items: context.read<EnquiryUserContoller>().ordercolumn . map((e) {
                  //             return DropdownMenuItem<String>(
                  //                 value: "${e.name}",
                  //                 child: Container(child: Text("${e.name.toString()}")));
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
                            controller: context.read<EnquiryUserContoller>().mycontroller[18],
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
              context.read<EnquiryUserContoller> (). clearfilterval();
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
                
                child: ElevatedButton(onPressed: (){
                 setState(() {
                    Navigator.pop(context);
           
                  context.read<EnquiryUserContoller>().  onfilterapply();
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
List<Widget>  listContainersProduct(ThemeData theme,){
  return List.generate(
    context.watch<EnquiryUserContoller>().filterlookingforcolumn.length,
      (ind)=>
      // StatefulBuilder(
      //   builder: (context,st) {
           GestureDetector(
            onTap: () {
              // context.read<EnquiryUserContoller>().selectedIdxFUser = ind;
              // st(() {
                //  context.read<EnquiryUserContoller>().selectlookingfor(ind);
                context.read<EnquiryUserContoller>().filterlookingforcolumn[ind].ischecck= !context.read<EnquiryUserContoller>().filterlookingforcolumn[ind].ischecck;
              // });
             
            },
            child: Container(
              // alignment: Alignment.center,
              // width: Screens.width(context) * 0.2,
              // height: Screens.bodyheight(context) * 0.06,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: context
                              .watch<EnquiryUserContoller>()
                              .filterlookingforcolumn[ind]
                              .ischecck ==
                          true
                      ? theme.primaryColor
                      : Colors.white,
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                  context
                      .watch<EnquiryUserContoller>()
                      .filterlookingforcolumn[ind]
                      .name!,
                  // maxLines: 1,
                  //overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: context
                                .watch<EnquiryUserContoller>()
                                .filterlookingforcolumn[ind]
                                .ischecck ==
                            true
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
                  )),
            ),
          )
      //   }
      // ),
  );
}

List<Widget>  listContainersProducttoshow(ThemeData theme,){
  return List.generate(
    context.watch<EnquiryUserContoller>().lookingforcolumnforshow.length,
      (ind)=>
      StatefulBuilder(
        builder: (context,st) {
          return GestureDetector(
            onTap: () {
              // context.read<EnquiryUserContoller>().selectedIdxFUser = ind;
              // st(() {
              //    context.read<EnquiryUserContoller>().selectlookingfor(ind);
              //   // context.read<EnquiryUserContoller>().lookingforcolumn[ind].ischecck= !context.read<EnquiryUserContoller>().lookingforcolumn[ind].ischecck;
              // });
             
            },
            child: Container(
              // alignment: Alignment.center,
              // width: Screens.width(context) * 0.2,
              // height: Screens.bodyheight(context) * 0.06,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: context
                              .watch<EnquiryUserContoller>()
                              .lookingforcolumnforshow[ind]
                              .ischecck ==
                          true
                      ? theme.primaryColor
                      : Colors.white,
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                  context
                      .watch<EnquiryUserContoller>()
                      .lookingforcolumnforshow[ind]
                      .name!,
                  // maxLines: 1,
                  //overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: context
                                .watch<EnquiryUserContoller>()
                                .lookingforcolumnforshow[ind]
                                .ischecck ==
                            true
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
                  )),
            ),
          );
        }
      ),
  );
}
}