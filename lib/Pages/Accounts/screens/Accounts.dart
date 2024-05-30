import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/AccountsController/AccountsController.dart';
import '../../../Models/AccountsModel/AccountsModel.dart';
import '../../../Services/AccountsApi/AccountsApi.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/search_bar.dart';
import 'AccoountsDetails.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  List<AccountsNewData> AccountsData = [];
  List<String> items = ["VIP", "PREMIER", "FAKE", "AAAAAA", "XXXXXX", "BBBB"];
  List<AccountsNewData> get getAccountsData => AccountsData;
  List<String> get getitems => items;
  List<String> countitem = [];
  List<String> get getcountitem => countitem;
  List<String> countitemlength = [];
  List<String> get getcountitemlength => countitemlength;
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool cartLoading = false;
  bool isLoading = true;
  bool get getisLoading => isLoading;
  bool get getcartLoading => cartLoading;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   context.read<AccountsContoller>().boolmethod();
      context.read<AccountsContoller>().callAccountsApi();
      
      
      context.read<AccountsContoller>().scrollcontrollerAddlistener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Accounts", scaffoldKey, theme, context),
        body: SafeArea(
          child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
            child: Stack(
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: paddings.padding2(context),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      // SearchWidget(themes: theme),
                      // SearchbarWidget(
                      //   theme: theme,
                      //   accountsContoller: prdACC,
                      // ),
                      Container(
                        height: Screens.bodyheight(context) * 0.06,
                        decoration: BoxDecoration(
                          color: theme.primaryColor
                              .withOpacity(0.1), //Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                              Screens.width(context) * 0.02),
                        ),
                        child: TextField(
                          autocorrect: false,
                          onChanged: (v) {
                            print(v);
                            context.read<AccountsContoller>().SearchFilter(v);
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'Search Here!!..',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                FocusScopeNode focus = FocusScope.of(context);
                                if (!focus.hasPrimaryFocus) {
                                  focus.unfocus();
                                }
                                // accountsContoller.boolmethod();
                                // Get.offAllNamed(ConstantRoutes.cartLoading);
                                // setState(() {
                                // prdACC.boolmethod();
                                // });
                              }, //
                              color: theme.primaryColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.005,
                      ),
                      Expanded(
                        child: (context.read<AccountsContoller>().getisLoading ==
                                    true &&
                                context
                                    .read<AccountsContoller>()
                                    .getErrorMsg
                                    .isEmpty &&
                                context
                                    .read<AccountsContoller>()
                                    .getAccountsDataFilter
                                    .isEmpty)
                            ? Center(child: CircularProgressIndicator())
                            : (context.read<AccountsContoller>().getisLoading ==
                                    false &&
                                context
                                    .read<AccountsContoller>()
                                    .getErrorMsg
                                    .isEmpty &&
                                context
                                    .read<AccountsContoller>()
                                    .getAccountsDataFilter
                                    .isEmpty)?
                                    
                                    Center(
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
                          Text(
                              "No Data..!!",textAlign: TextAlign.center,),
                        ],
                      ),
                    ):
                                    (context.read<AccountsContoller>().getisLoading ==
                                        false &&
                                    context
                                        .read<AccountsContoller>()
                                        .getErrorMsg
                                        .isNotEmpty &&
                                    context
                                        .watch<AccountsContoller>()
                                        .getAccountsDataFilter
                                        .isEmpty)
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                         
                                      children: [
                                         context.watch<AccountsContoller>().lottie!.isEmpty?Container():
                                context.watch<AccountsContoller>().lottie!.isNotEmpty && context.watch<AccountsContoller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<AccountsContoller>().lottie}',
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
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${context.watch<AccountsContoller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                        Text(context
                                            .read<AccountsContoller>()
                                            .getErrorMsg,textAlign: TextAlign.center,),
                                      ],
                                    ))
                                : ListView.builder(
                                    itemCount: context
                                        .read<AccountsContoller>()
                                        .getAccountsDataFilter
                                        .length,
          
                                    // prdACC.getAccountsData.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Container(
                                        width: Screens.width(context),
                                         padding: EdgeInsets.symmetric(
                                              // horizontal:
                                              //     Screens.width(context) * 0.02,
                                              vertical:
                                                  Screens.bodyheight(context) *
                                                      0.003),
                                        child: Container(
                                         
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Screens.width(context) * 0.02,
                                              vertical:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                                      
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                         color: Colors.grey[200],
                                                        border:Border.all(color: Colors.black26) ),
                                          width: Screens.width(context),
                                          child: GestureDetector(
                                            onTap: () {
                                              AccountsDetailsState.i = i;
                                              context
                                                  .read<AccountsContoller>()
                                                  .loadmore();
                                                context
                                                  .read<AccountsContoller>()
                                                  .   getCustomerTag(context
                                                      .read<AccountsContoller>()
                                                      .getAccountsDataFilter[i]
                                                      .CustomerGroup.toString());
                                              context
                                                  .read<AccountsContoller>()
                                                  .callApi(context
                                                      .read<AccountsContoller>()
                                                      .getAccountsDataFilter[i]
                                                      .CustomerCode!.toString(),context);
                                                       context
                                                  .read<AccountsContoller>()
                                                  .GetAllOutstandingscall(context
                                                      .read<AccountsContoller>()
                                                      .getAccountsDataFilter[i]
                                                      .CustomerName!.toString());
                                              // AccountsDetailsState
                                              //         .data =
                                              //     "Balamurugan";
                                              Get.toNamed(
                                                  ConstantRoutes.accountsDetails);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                          "Customer",
                                                          style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                       context.watch<AccountsContoller>().getAccountsDataFilter[i].Status ==null|| context.watch<AccountsContoller>().getAccountsDataFilter[i].Status!.isEmpty?Container():       Container(
                                                                        // color: Colors.amber,
                                                                      alignment: Alignment.centerRight,
                                                                      //  width: Screens.width(context) * 0.5,
                                                                        padding: EdgeInsets.only(
                                        left: Screens.width(context) * 0.02,
                                        right: Screens.width(context) * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                        color: Colors.green[200],
                                        borderRadius: BorderRadius.circular(4)
                                        ),
                                                                        child:
                                         Text(
                                            "VIP", style:theme.textTheme.bodyText2?.copyWith(
                                               fontSize: 12,
                                                color:Colors.green[700],
                                                fontStyle: FontStyle.italic
                                               
                                               // fontWeight: FontWeight.bold
                                                )),
                                         
                                                                         
                                                                      )  
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      
                                                      Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                            "${context.watch<AccountsContoller>().getAccountsDataFilter[i].CustomerName}",
                                                            style: theme.textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              // fontWeight: FontWeight.bold
                                                            )),
                                                      ),
                                                    
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                          "Mobile",
                                                          style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                     
                                                      // Container(
                                                      //   width: Screens.width(
                                                      //           context) *
                                                      //       0.4,
                                                      //   child: Text(
                                                      //     "Email",
                                                      //     style: theme
                                                      //         .textTheme.bodyText2
                                                      //         ?.copyWith(
                                                      //             color: Colors
                                                      //                 .grey),
                                                      //   ),
                                                      // ),
                                                      // Container(
                                                      //   alignment:
                                                      //       Alignment.centerRight,
                                                      //   width: Screens.width(
                                                      //           context) *
                                                      //       0.4,
                                                      //   child: Text(
                                                      //     "City",
                                                      //     style: theme
                                                      //         .textTheme.bodyText2
                                                      //         ?.copyWith(
                                                      //             color: Colors
                                                      //                 .grey),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                        Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                            '${context.watch<AccountsContoller>().getAccountsDataFilter[i].CustomerCode}',
                                                            style: theme.textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              //fontWeight: FontWeight.bold
                                                            )),
                                                      ),
                                                      Container(
                                        padding: EdgeInsets.only(
                                        left: Screens.width(context) * 0.02,
                                        right: Screens.width(context) * 0.02,
                                        ),
                                        decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.circular(4)
                                        ),
                                                                       // width: Screens.width(context) * 0.1,
                                        child: Text(
                                          "${context.watch<AccountsContoller>().getAccountsDataFilter[i].CustomerGroup}",
                                          style: theme.textTheme.bodyText2?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 12,
                                          
                                             fontWeight: FontWeight.w500
                                              )),
                                                                        ),
                                                                
                                                      
                                                      
                                                      // Container(
                                                      //   alignment:
                                                      //       Alignment.centerRight,
                                                      //   width: Screens.width(
                                                      //           context) *
                                                      //       0.4,
                                                      //   child: Text(
                                                      //       '${context.watch<AccountsContoller>().getAccountsDataFilter[i].Bil_City}',
                                                      //       style: theme.textTheme
                                                      //           .bodyText2
                                                      //           ?.copyWith(
                                                      //         color: theme
                                                      //             .primaryColor,
                                                      //         //fontWeight: FontWeight.bold
                                                      //       )),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                          "Address",
                                                          style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                      
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                            "${context.watch<AccountsContoller>().getAccountsDataFilter[i].Bil_Address1} ${context.watch<AccountsContoller>().getAccountsDataFilter[i].Bil_Address2} ${context.watch<AccountsContoller>().getAccountsDataFilter[i].Bil_City}",
                                                            style: theme.textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                              color: theme
                                                                  .primaryColor,
                                                              // fontWeight: FontWeight.bold
                                                            )),
                                                      ),
                                                     
                                                    ],
                                                  ),
                                                  //  SizedBox(
                                                  //   height: Screens.bodyheight(
                                                  //           context) *
                                                  //       0.01,
                                                  // ),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text("Last active on  ${context
                                                          .read<
                                                              AccountsContoller>()
                                                          .config.alignDate(context.watch<AccountsContoller>().getAccountsDataFilter[i].UpdatedOn.toString()) }",
                                                          
                                                    style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                    ),
                                                  ),
                                        //           Container(
                                        //             width: Screens.width(context),
                                        //             // color: Colors.amber,
                                        //             // padding: EdgeInsets.only(
                                        //             //   left:
                                        //             //       Screens.width(context) *
                                        //             //           0.01,
                                        //             //   right:
                                        //             //       Screens.width(context) *
                                        //             //           0.01,
                                        //             //   top: Screens.bodyheight(
                                        //             //           context) *
                                        //             //       0.01,
                                        //             //   bottom: Screens.bodyheight(
                                        //             //           context) *
                                        //             //       0.001,
                                        //             // ),
                                        //             // alignment:
                                        //             //     Alignment.centerRight,
                                        //             child: Row(
                                        //               mainAxisAlignment:
                                        //                   MainAxisAlignment.spaceBetween,
                                        //               children: [
                                      
                                        //                  Container(
                                        // padding: EdgeInsets.only(
                                        // left: Screens.width(context) * 0.02,
                                        // right: Screens.width(context) * 0.02,
                                        // ),
                                        // decoration: BoxDecoration(
                                        // color: Colors.orange[100],
                                        // borderRadius: BorderRadius.circular(4)
                                        // ),
                                        //                                // width: Screens.width(context) * 0.1,
                                        // child: Text(
                                        //   "${context.watch<AccountsContoller>().getAccountsDataFilter[i].CustomerGroup}",
                                        //   style: theme.textTheme.bodyText2?.copyWith(
                                        //       color: Colors.grey,
                                        //       fontSize: 12,
                                          
                                        //      fontWeight: FontWeight.w500
                                        //       )),
                                        //                                 ),
                                                                
                                                      
                                        //               ],
                                        //             ),
                                        //           ),
                                                  // SizedBox(
                                                  //   height:
                                                  //       Screens.bodyheight(context) * 0.01,
                                                  // ),
                                              
                                                  // SizedBox(
                                                  //   height: Screens.bodyheight(
                                                  //           context) *
                                                  //       0.01,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: context.watch<AccountsContoller>().cartLoading,
                  child: Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context),
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.03,
                        vertical: Screens.bodyheight(context) * 0.02),
                    child:
                        //  context.watch<DownLoadController>().exception == true &&
                        //         context.watch<DownLoadController>().getErrorMsg != ''
                        //     ? Center(
                        //         child: Text('${context.watch<DownLoadController>().errorMsg}'),
                        //       )
                        //     :
                        Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.toNamed(ConstantRoutes.accounts);
                            // HelperFunctions.clearCheckedOnBoardSharedPref();
                            // HelperFunctions.clearUserLoggedInSharedPref();
                          },
                          child: Lottie.asset('Assets/cart2.json',
                              animate: true,
                              repeat: true,
                              height: Screens.padingHeight(context) * 0.3,
                              width: Screens.width(context) * 0.3),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.3),
                            child: LinearProgressIndicator(
                                backgroundColor: Colors.white))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //   });
        // })
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(ConstantRoutes.newcustomerReg);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
