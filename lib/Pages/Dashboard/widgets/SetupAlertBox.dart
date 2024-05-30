// ignore_for_file: avoid_unnecessary_containers, unnecessary_string_interpolations, camel_case_types, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/methodchannel.dart';
import 'package:sellerkit/Services/AddressGetApi/AddressGetApi.dart';
import 'package:sellerkit/main.dart';

class setupAlerbox extends StatefulWidget {
  setupAlerbox({Key? key, required this.address}) : super(key: key);
  String address;
  @override
  State<setupAlerbox> createState() => _setupAlerboxState();
}

class _setupAlerboxState extends State<setupAlerbox> {
  String address = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    // print(_controller);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future getAddress() async {
    List<String>? wifiiInfo = await config.setNetwork();

    setState(() {
      Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        // Got a new connectivity status!
        if (result.name == 'none') {
          ConstantValues.ipaddress = '';
          ConstantValues.ipname = '';
        } else if (result.name == 'mobile') {
          if (Platform.isAndroid) {
            final MobileNetworkInfo mobileNetworkInfo = MobileNetworkInfo();
            final String? name = await Config.getipaddress();

            // List<String>? wifiiInfo = await config.setNetwork();
            //
             final String? data = await mobileNetworkInfo.getMobileNetworkName();
            //
            ConstantValues.ipaddress = name == null ? 'null' : name;
            ConstantValues.ipname = data == null ? 'null' : data;
          } else if (Platform.isIOS) {
            List<String>? wifiiInfo = await config.getIosNetworkInfo();
        ConstantValues.ipaddress =  wifiiInfo[1];
        ConstantValues.ipname =  wifiiInfo[0];
          }
        }
        // else if (result.name == 'mobile') {
        //   List<String>? wifiiInfo = await config.setNetwork();
        //   ConstantValues.ipaddress = wifiiInfo[1] == null ? 'null' : wifiiInfo[1];
        //   ConstantValues.ipname = wifiiInfo[0] == null ? 'null' : wifiiInfo[0];
        // }
        else if (result.name == 'wifi') {
          List<String>? wifiiInfo = await config.setNetwork();
          ConstantValues.ipaddress = wifiiInfo[1];
          ConstantValues.ipname = wifiiInfo[0];
        }
      });
      // await LocationTrack.checkcamlocation();
    });
    print('LATI::' + ConstantValues.latitude.toString());
    print('LONG::' + ConstantValues.langtitude.toString());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await AddressMasterApi.getData(ConstantValues.latitude.toString(),
              ConstantValues.langtitude.toString())
          .then((value) {
        print(value.stcode!);
        print(value.status!);

        if (200 >= value.stcode! && value.stcode! <= 210) {
          setState(() {
            address = value.results[1].formattedAddress!;
          });
        } else {
          print("error:api");
        }
      });
    }
    print('address::' + address);
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(double.parse(ConstantValues.latitude!),
        double.parse(ConstantValues.langtitude!)),
    zoom: 14.7,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        // height: Screens.bodyheight(context) * 0.4,
        width: Screens.width(context) * 0.65,
        padding: EdgeInsets.all(Screens.bodyheight(context) * 0.01),
        // ignore: sort_child_properties_last
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.2,
                  // color: Colors.amber,
                  child: Text(
                    'Lat',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context) * 0.3,
                  // color: Colors.amber,
                  child: Text('${ConstantValues.latitude}',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis),
                ),
                double.parse(ConstantValues.latitude.toString()) > 0
                    ? Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.001,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.2,
                  // color: Colors.amber,
                  child: Text(
                    'Long',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context) * 0.3,
                  // color: Colors.amber,
                  child: Text('${ConstantValues.langtitude}',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis),
                ),
                double.parse(ConstantValues.langtitude.toString()) > 0
                    ? Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.001,
            ),
            Stack(
              children: [
                Container(
                  height: Screens.bodyheight(context) * 0.2,
                  child: GoogleMap(
                    zoomControlsEnabled :false,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: Screens.bodyheight(context) * 0.2,
                  // child: GoogleMap(
                  //   mapType: MapType.normal,
                  //   myLocationEnabled: true,
                  //   initialCameraPosition: _kGooglePlex,
                  //   onMapCreated: (GoogleMapController controller) {
                  //     _controller.complete(controller);
                  //   },
                  // ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  // alignment: Alignment.centerLeft,
                  width: Screens.width(context) * 0.6,
                  // color: Colors.amber,
                  child: Text('${address}',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.2,
                  // color: Colors.amber,
                  child: Text(
                    'Network',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context) * 0.3,
                  // color: Colors.amber,
                  child: Text('${ConstantValues.ipname}',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis),
                ),
                ConstantValues.ipname.toString() != '' &&
                        ConstantValues.ipname.toString() != 'null'
                    ? Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.001,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.2,
                  // color: Colors.amber,
                  child: Text(
                    'IP',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context) * 0.3,
                  // color: Colors.amber,
                  child: Text('${ConstantValues.ipaddress}',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis),
                ),
                ConstantValues.ipaddress.toString() != '' &&
                        ConstantValues.ipaddress.toString() != 'null' &&
                        ConstantValues.ipaddress.toString() != '0'
                    ? Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        // width: Screens.width(context)*0.1,
                        // color: Colors.amber,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
              ],
            ),
          ],
        ),
        margin: EdgeInsets.only(top: Screens.bodyheight(context) * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
