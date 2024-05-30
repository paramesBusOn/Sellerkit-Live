// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowPdf extends StatefulWidget {
  @override
  ShowPdfs createState() => ShowPdfs();
}

class ShowPdfs extends State<ShowPdf> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static PDFDocument? document;
  PDFDocument? document2;
  String name = "";
  String companyID = "";
  String? imei;
  static String? docNO;
  static String? title;
  @override
  void initState() {
    super.initState();
    setState(() {
      document2 = document;
    });
  }

  List<String> paths = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final theme = Theme.of(context);
    return
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   home:
        Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('title'),
        backgroundColor: theme.primaryColor,
        leading: Row(
          children: [
            InkWell(
              onTap: () async {
                // direc: /data/user/0/com.buson.crm/cache
                final tempDir = await getTemporaryDirectory();
                print(
                    "direc: " + tempDir.path.toString() + '/$title-$docNO.pdf');
                paths.add('${tempDir.path}/$title-$docNO.pdf');
                await Share.shareFiles(paths);
                paths.clear();
              },
              child: Icon(
                Icons.share,
                size: width * 0.1,
              ),
            )
          ],
        ),
      ),
      // appBar: appBar(),
      //  (width <= 568)
      //     ? buildPreferredSizeMobile
      //     : (width <= 968)
      //         ? buildPreferredSizeTab
      //         : buildPreferredSizeWeb,
      // drawer: buildDrawer(),
      // key: _scaffoldKey,
      body: document2 == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : 
          SafeArea(
              child: contentOfmobile(context),
            ),
      //  ),
    );
  }

  Center contentOfmobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    //pass one agrument build context
    return Center(
        child: SizedBox(
      height: height,
      width: width,
      child: PDFViewer(
        document: document2!,
        lazyLoad : true,
        showPicker : true,
        zoomSteps: 1,
        tooltip :PDFViewerTooltip()
      ),
    ));
  }

  AppBar appBar() {
    final width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Container(
                    child: Icon(
                      Icons.menu,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue),
                    child: Icon(
                      Icons.home_filled,
                      color: Colors.black,
                      size: 30,
                    )),
              ]),
            ),
            SizedBox(
              width: width / 9,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Sales Order Report",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  PreferredSize get buildPreferredSizeTab {
    return PreferredSize(
        child: SafeArea(
          //use safe area to avoid menu shown in status bar
          child: Container(
            color: Colors.pink,
            height: 60.0,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    //
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, left: 10.0),
                          child: Column(children: [
                            Text(
                              "Follow Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Welcome Admin",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                        Text(
                          "Admin",
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
            //   ),
          ),
        ),
        preferredSize: Size.fromHeight(100));
  }

  PreferredSize get buildPreferredSizeWeb {
    return PreferredSize(
        child: SafeArea(
          //use safe area to avoid menu shown in status bar
          child: Container(
            color: Colors.blue,
            height: 60.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    //
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, left: 10.0),
                          child: Column(children: [
                            Text(
                              "Follow Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Welcome Admin",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.logout),
                          iconSize: 30.0,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
        preferredSize: Size.fromHeight(100));
  }

  PreferredSize get buildPreferredSizeMobile {
    return PreferredSize(
        child: SafeArea(
          //use safe area to avoid menu shown in status bar
          child: Container(
            color: Colors.green,
            height: 60.0,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    //
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          iconSize: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, left: 10.0),
                          child: Column(children: [
                            // ignore: prefer_const_constructors
                            Text(
                              "Follow Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              "Welcome Admin",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30.0,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ]),
            //   ),
          ),
        ),
        preferredSize: Size.fromHeight(100));
  }
}
