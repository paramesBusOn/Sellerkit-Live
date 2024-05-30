// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/Dashboard/widgets/PhotoViwer.dart';
import 'package:sellerkit/Pages/ForgotPassword/widgets/ConfirmPassword.dart';
import 'package:sellerkit/Pages/Splash/Widgets/custom_elevatedBtn.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Controller/LoginController/LoginController.dart';
import '../../../Widgets/Navi3.dart';

class NewProfile extends StatefulWidget {
  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
          onWillPop: onbackpress,child:Scaffold(
        key: scaffoldKey,
        drawer: drawer3(context),
        body: 
         Stack(
            children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                      painter: HeaderCurvedContainer(
                          grandient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                        theme.primaryColor,
                        theme.primaryColor.withOpacity(0.8),
                        theme.primaryColor.withOpacity(0.6),
                      ])))),
              Positioned(
                  top: Screens.padingHeight(context) * 0.23,
                  left: Screens.padingHeight(context) * 0.19,
                  right: Screens.padingHeight(context) * 0.19,
                  child: Container(
                      height: Screens.padingHeight(context) * 0.125,
                      width: Screens.width(context) * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: theme.primaryColor,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                         Get.toNamed(ConstantRoutes.photoViewer);
                        },
                        child: ConstantValues.profilepic!.isNotEmpty
                            ? Container(
                                width: Screens.width(context) * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${ConstantValues.profilepic}'),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                width: Screens.width(context) * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage("Assets/avatar.png"),
                                        fit: BoxFit.cover))),
                        // Icon(
                        //     Icons.person,
                        //     color: theme.primaryColor,
                        //     size: 80,
                        //   )
                        // : SizedBox()
                      ))),
              Positioned(
                  top: Screens.padingHeight(context) * 0.4,
                  left: Screens.padingHeight(context) * 0.0,
                  right: Screens.padingHeight(context) * 0.0,
                  child: Column(
                    children: [
                      Container(
                          child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "${ConstantValues.firstName}",
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                          prefixIcon: Container(
                              alignment: Alignment.centerLeft,
                              width: Screens.padingHeight(context) * 0.18,
                              padding: EdgeInsets.only(
                                  left: Screens.padingHeight(context) * 0.05),
                              child: Icon(
                                Icons.perm_identity,
                                color: theme.primaryColor,
                                size: 30,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: theme.primaryColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )),
                      // SizedBox(height: Screens.padingHeight(context) * 0.01),
                      // Container(
                      //     child: TextFormField(
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //     hintText: "${ConstantValues.lastName}",
                      //     hintStyle: theme.textTheme.bodyText2
                      //         ?.copyWith(color: theme.primaryColor),
                      //     prefixIcon: Container(
                      //         alignment: Alignment.centerLeft,
                      //         width: Screens.padingHeight(context) * 0.18,
                      //         padding: EdgeInsets.only(
                      //             left: Screens.padingHeight(context) * 0.05),
                      //         child: Icon(
                      //           Icons.perm_identity,
                      //           color: theme.primaryColor,
                      //           size: 30,
                      //         )),
                      //     enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(
                      //       color: theme.primaryColor,
                      //     )),
                      //     focusedBorder: UnderlineInputBorder(
                      //       borderSide: BorderSide(
                      //         color: theme.primaryColor,
                      //       ),
                      //     ),
                      //   ),
                      // )),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Container(
                          child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "${ConstantValues.mailId}",
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                          prefixIcon: Container(
                              alignment: Alignment.centerLeft,
                              width: Screens.padingHeight(context) * 0.18,
                              padding: EdgeInsets.only(
                                  left: Screens.padingHeight(context) * 0.05),
                              child: Icon(
                                Icons.mail_outline,
                                color: theme.primaryColor,
                                size: 30,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: theme.primaryColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Container(
                          child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "${ConstantValues.phoneNum}",
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                          prefixIcon: Container(
                              alignment: Alignment.centerLeft,
                              width: Screens.padingHeight(context) * 0.18,
                              padding: EdgeInsets.only(
                                  left: Screens.padingHeight(context) * 0.05),
                              child: Icon(
                                Icons.phone_outlined,
                                color: theme.primaryColor,
                                size: 30,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: theme.primaryColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Container(
                          child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "${ConstantValues.branch}",
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                          prefixIcon: Container(
                              alignment: Alignment.centerLeft,
                              width: Screens.padingHeight(context) * 0.18,
                              padding: EdgeInsets.only(
                                  left: Screens.padingHeight(context) * 0.05),
                              child: Icon(
                                Icons.house_outlined,
                                color: theme.primaryColor,
                                size: 30,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: theme.primaryColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Container(
                          child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: ConstantValues.deviceId,
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                          prefixIcon: Container(
                              alignment: Alignment.centerLeft,
                              width: Screens.padingHeight(context) * 0.18,
                              padding: EdgeInsets.only(
                                  left: Screens.padingHeight(context) * 0.05),
                              child: Icon(
                                Icons.phone_android_outlined,
                                color: theme.primaryColor,
                                size: 30,
                              )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: theme.primaryColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      )),
                    ],
                  )),
                Positioned(
                  top: Screens.padingHeight(context) * 0.96,
                  left: Screens.padingHeight(context) * 0.01,
                  right: Screens.padingHeight(context) * 0.01,
                  child: CustomSpinkitdButton(
                    onTap: () {
                       LoginController.loginPageScrn=false;
                      Get.toNamed(ConstantRoutes.chagnePassword);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmPasswordPage()));
                    },
                    label: 'Change Password',
                    labelLoading: "Change Password",
                    textcolor: Colors.white,
                  )),
            ],
          ),
        ));
  }
}

DateTime? currentBackPressTime;
Future<bool> onbackpress() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Get.offAllNamed(ConstantRoutes.dashboard);
    return Future.value(false);
  }
  return Future.value(false);
}

DateTime? currentBackPressTime1;
Future<bool> onbackpress1() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Get.offAllNamed(ConstantRoutes.newprofile);
    return Future.value(false);
  }
  return Future.value(false);
}

class HeaderCurvedContainer extends CustomPainter {
  HeaderCurvedContainer({required this.grandient});

  final Gradient grandient;
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    Path rectPathThree = Path();
    Paint paint = Paint();
    paint.shader = grandient.createShader(rect);
    Path path = Path()
      ..relativeLineTo(0, 170)
      ..quadraticBezierTo(size.width / 2, 310.0, size.width, 170)
      ..relativeLineTo(10, -250)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}










//  sheetbottom() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             Container(
//                 height: Screens.padingHeight(context) * 0.13,
//                 width: Screens.width(context) * 0.35,
//                 child: IconButton(
//                   color: Color(0xFF750537),
//                   onPressed: () {
//                     context
//                         .read<NewProfileController>()
//                         .imagetoBinary(ImageSource.gallery);

//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.image,
//                     size: 60,
//                   ),
//                 )),
//             Container(
//                 height: Screens.padingHeight(context) * 0.13,
//                 width: Screens.width(context) * 0.4,
//                 child: IconButton(
//                   color: Color(0xFF750537),
//                   onPressed: () {
//                     context
//                         .read<NewProfileController>()
//                         .imagetoBinary(ImageSource.camera);

//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.add_a_photo,
//                     size: 60,
//                   ),
//                 ))
//           ],
//         );
//       },
//     );
//   }
