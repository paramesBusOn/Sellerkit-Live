import 'dart:developer';
import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sellerkit/DBHelper/DBHelper.dart';
import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
import 'package:sellerkit/Pages/OfferZone/OfferPopup.dart';
import 'package:sqflite/sqflite.dart';

import '../../DBHelper/DBOperation.dart';

class OfferZoneController extends ChangeNotifier {
  OfferZoneController() {
    offerdbmethod();
  }
  List<offerproductlist>? offerproduct = [];
  List<offerproductlist>? get getofferproduct => offerproduct;
  List<offerstorelist>? offerstore = [];
  List<offerstorelist>? get getofferstore => offerstore;
  List<OfferZoneData> searchofferzone = [];
  List<OfferZoneData> get getofferzone => searchofferzone;
  String offerZoneexpmsg = '';
  String get getofferZoneexpmsg => offerZoneexpmsg;
  bool offerLoading = true;
  bool get getofferLoading => offerLoading;

  List<OfferZoneData> offerviewAll = [];
  List<OfferZoneData> get getofferviewAll => offerviewAll;
Future<void> sharefiles(String? url1 ,String? url2,String? content)async{
  
  log("url1url1::+"+url1.toString());
    log("url2url2::+"+url2.toString());
    if(url1!.isNotEmpty && url2!.isNotEmpty ){

 
      try{
        // if (url1.contains('.mp4') ){}
List<XFile> filez=[];
filez.clear();
final response1 = await http.get(Uri.parse(url1.toString()));
    final documentDirectory1 = await getTemporaryDirectory();
    String fileName1=url1!.split('/').last;
    final file1 = File('${documentDirectory1.path}/$fileName1');
    log("jjjjj::"+file1.toString());
     await file1.writeAsBytes(response1.bodyBytes);
     filez.add(
  XFile(file1.path) ,
     );
    log("file::::"+file1.path.toString());

    final response2 = await http.get(Uri.parse(url2.toString()));
    // final documentDirectory2 = await getTemporaryDirectory();
    String fileName2=url2!.split('/').last;
    final file2 = File('${documentDirectory1.path}/$fileName2');
    log("jjjjj222::"+file2.toString());
     await file2.writeAsBytes(response2.bodyBytes);
     filez.add(
XFile(file2.path),
     );
    //  log("filez:::"+filez)
      List<String> filePaths = filez.map((file) => file.path).toList();
      log("filePaths::"+filePaths.toString());
    await Share.shareXFiles(filez, text: content);
      }catch(e){
log("eeeee:::"+e.toString());
      }
      
    }
    
   
    // filesz.add();
}

dowloadfile(String url1) async{
  final response1 = await http.get(Uri.parse(url1.toString()));
    final documentDirectory1 = await getTemporaryDirectory();
    String fileName1=url1!.split('/').last;
    final file1 = File('${documentDirectory1.path}/$fileName1');
    log("jjjjj::"+file1.toString());
     await file1.writeAsBytes(response1.bodyBytes);
     return file1;
}
//old
// Future<void> sharefiles(String? url1 ,String? url2,String? content)async{
//   log("url1url1::+"+url1.toString());
//     log("url2url2::+"+url2.toString());
//     if(url1!.isNotEmpty && url2!.isNotEmpty ){
//       try{
//         // if (url1.contains('.mp4') ){}
// List<XFile> filez=[];
// final response1 = await http.get(Uri.parse(url1.toString()));
//     final documentDirectory1 = await getTemporaryDirectory();
//     String fileName1=url1!.split('/').last;
//     final file1 = File('${documentDirectory1.path}/$fileName1');
//     log("jjjjj::"+file1.toString());
//      await file1.writeAsBytes(response1.bodyBytes);
//      filez.add(
//   XFile(file1.path) ,
//      );
//     log("file::::"+file1.path.toString());

//     final response2 = await http.get(Uri.parse(url2.toString()));
//     final documentDirectory2 = await getTemporaryDirectory();
//     String fileName2=url2!.split('/').last;
//     final file2 = File('${documentDirectory2.path}/$fileName2');
//     log("jjjjj222::"+file2.toString());
//      await file2.writeAsBytes(response2.bodyBytes);
//      filez.add(
// XFile(file2.path),
//      );
//       // List<String> filePaths = filez.map((file) => file.path).toList();
//       // log("filePaths::"+filePaths.toString());
//     await Share.shareXFiles(filez,text: content);
//       }catch(e){
// log("eeeee:::"+e.toString());
//       }
      
//     }
    
   
//     // filesz.add();
// }
  offerdbmethod() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.getofferFavData(db);
    List<Map<String, Object?>> getDBsalespaysettle6 =
        await DBOperation.getofferDataproduct(db);
    List<Map<String, Object?>> getDBsalespaysettle7 =
        await DBOperation.getofferDatastore(db);
// searchofferzone[].offerproductlistdetails.add(value)
if(getDBsalespaysettle6 !=null && getDBsalespaysettle6.isNotEmpty){
for(int ij = 0; ij < getDBsalespaysettle6.length; ij++){
  // if(getDBsalespaysettle6[ij]["offerid"].toString()==offerviewAll[ij].offerId.toString() ){
offerproduct!.add(offerproductlist(
  itemName:getDBsalespaysettle6[ij]["ItemName"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["ItemName"].toString() ,
              brand:getDBsalespaysettle6[ij]["Brand"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["Brand"].toString() ,
              category: getDBsalespaysettle6[ij]["Category"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["Category"].toString(),
              subCategory: getDBsalespaysettle6[ij]["SubCategory"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["SubCategory"].toString(),
              itemDescription: getDBsalespaysettle6[ij]["ItemDescription"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["ItemDescription"].toString(),
          id: getDBsalespaysettle6[ij]["Id"].toString().isEmpty
              ? 0
              : int.parse(getDBsalespaysettle6[ij]["Id"].toString()),
          itemid: getDBsalespaysettle6[ij]["Itemid"].toString().isEmpty
              ? ''
              : getDBsalespaysettle6[ij]["Itemid"].toString(),
          
          offerid: getDBsalespaysettle6[ij]["Offerid"].toString().isEmpty
              ? 0
              : int.parse(getDBsalespaysettle6[ij]["Offerid"].toString()),
         
        )
        );
 
  log("offerproductlistdetails:${offerproduct!.length.toString()}");
    
  //  log("offerproductlistdetails:${offerviewAll[ij].offerproductlistdetails!.length.toString()}");
      



   }
}
 
for (int k = 0; k < getDBsalespaysettle5.length; k++) {
      searchofferzone.add(OfferZoneData(
          offerId: getDBsalespaysettle5[k]["OfferID"].toString().isEmpty
              ? 0
              : int.parse(getDBsalespaysettle5[k]["OfferID"].toString()),
          itemCode: getDBsalespaysettle5[k]["ItemCode"].toString().isEmpty
              ? 0
              : int.parse(getDBsalespaysettle5[k]["ItemCode"].toString()),
          offerName: getDBsalespaysettle5[k]["OfferName"].toString().isEmpty
              ? ''
              : getDBsalespaysettle5[k]["OfferName"].toString(),
          offerDetails:
              getDBsalespaysettle5[k]["OfferDetails"].toString().isEmpty
                  ? ''
                  : getDBsalespaysettle5[k]["OfferDetails"].toString(),
          mediaurl1: getDBsalespaysettle5[k]["mediaurl1"].toString().isEmpty
              ? ''
              : getDBsalespaysettle5[k]["mediaurl1"].toString(),
          mediaurl2:
              getDBsalespaysettle5[k]["mediaurl2"].toString().isEmpty
                  ? ''
                  : getDBsalespaysettle5[k]["mediaurl2"].toString(),
          incentive: getDBsalespaysettle5[k]["Incentive"].toString().isEmpty
              ? ''
              : getDBsalespaysettle5[k]["Incentive"].toString(),
          validTill: getDBsalespaysettle5[k]["ValidTill"].toString().isEmpty
              ? ''
              : getDBsalespaysettle5[k]["ValidTill"].toString(),
          offerproductlistdetails: offerproduct,
          ));
      offerviewAll = searchofferzone;
     
  log("offerproductlistdetails:${offerviewAll.length.toString()}");
      log("offerstorelistdetails:${offerviewAll[k].mediaurl2.toString()}");
 
    }
      


    // if (getDBsalespaysettle7.isNotEmpty) {
    //   for (int i = 0; i < getDBsalespaysettle7.length; i++) {
    //     offerstore!.add(offerstorelist(
    //         id: getDBsalespaysettle7[i]["Id2"].toString().isEmpty
    //             ? 0
    //             : int.parse(getDBsalespaysettle7[i]["Id2"].toString()),
    //         offerid: getDBsalespaysettle7[i]["OfferId2"].toString().isEmpty
    //             ? 0
    //             : int.parse(getDBsalespaysettle7[i]["OfferId2"].toString()),
    //         storeid: getDBsalespaysettle7[i]["StoreId"].toString().isEmpty
    //             ? 0
    //             : int.parse(getDBsalespaysettle7[i]["StoreId"].toString())));
    //   }
    // }

    // if (getDBsalespaysettle6.isNotEmpty) {
    //   for (int j = 0; j < getDBsalespaysettle6.length; j++) {
    //     log("jhjh"+getDBsalespaysettle6[j]["Id"].toString());
    //     offerproduct!.add(offerproductlist(
    //       id: getDBsalespaysettle6[j]["Id"].toString().isEmpty
    //           ? 0
    //           : int.parse(getDBsalespaysettle6[j]["Id"].toString()),
    //       itemid: getDBsalespaysettle6[j]["Itemid"].toString().isEmpty
    //           ? 0
    //           : int.parse(getDBsalespaysettle6[j]["Itemid"].toString()),
    //       offer: getDBsalespaysettle6[j]["Offer"].toString().isEmpty
    //           ? 0.0
    //           : double.parse(getDBsalespaysettle6[j]["Offer"].toString()),
    //       offerid: getDBsalespaysettle6[j]["Offerid"].toString().isEmpty
    //           ? 0
    //           : int.parse(getDBsalespaysettle6[j]["Offerid"].toString()),
    //       relevanttag:
    //           getDBsalespaysettle6[j]["RelaventTags"].toString().isEmpty
    //               ? ''
    //               : getDBsalespaysettle6[j]["RelaventTags"].toString(),
    //     ));
    //   }
    // }
    // for (int k = 0; k < getDBsalespaysettle5.length; k++) {
    //   searchofferzone.add(OfferZoneData(
    //       offerId: getDBsalespaysettle5[k]["OfferID"].toString().isEmpty
    //           ? 0
    //           : int.parse(getDBsalespaysettle5[k]["OfferID"].toString()),
    //       itemCode: getDBsalespaysettle5[k]["ItemCode"].toString().isEmpty
    //           ? 0
    //           : int.parse(getDBsalespaysettle5[k]["ItemCode"].toString()),
    //       offerName: getDBsalespaysettle5[k]["OfferName"].toString().isEmpty
    //           ? ''
    //           : getDBsalespaysettle5[k]["OfferName"].toString(),
    //       offerDetails:
    //           getDBsalespaysettle5[k]["OfferDetails"].toString().isEmpty
    //               ? ''
    //               : getDBsalespaysettle5[k]["OfferDetails"].toString(),
    //       item: getDBsalespaysettle5[k]["Item"].toString().isEmpty
    //           ? ''
    //           : getDBsalespaysettle5[k]["Item"].toString(),
    //       discoutDetails:
    //           getDBsalespaysettle5[k]["DiscountDetails"].toString().isEmpty
    //               ? ''
    //               : getDBsalespaysettle5[k]["DiscountDetails"].toString(),
    //       incentive: getDBsalespaysettle5[k]["Incentive"].toString().isEmpty
    //           ? ''
    //           : getDBsalespaysettle5[k]["Incentive"].toString(),
    //       validTill: getDBsalespaysettle5[k]["ValidTill"].toString().isEmpty
    //           ? ''
    //           : getDBsalespaysettle5[k]["ValidTill"].toString(),
    //       offerproductlistdetails: offerproduct,
    //       offerstorelistdetails: offerstore));
    //   offerviewAll = searchofferzone;
    //   log("offerproductlistdetails:${searchofferzone[k].offerproductlistdetails!.length.toString()}");
    //   log("offerstorelistdetails:${searchofferzone[k].offerstorelistdetails!.length}");
    //    log("offerviewAll:${searchofferzone[k].offerproductlistdetails![0].relevanttag}");

    // }
    // searchofferzone = getDBsalespaysettle5;

    notifyListeners();
  }
  searchmethod(OfferZoneData ij,BuildContext context,ThemeData themes){
   bool isitemloaded=true;
   log("ij::::"+ij.validTill.toString());
    for(int i=0;i<offerviewAll.length;i++){
      for(int ik=0;ik<offerviewAll[i].offerproductlistdetails!.length;ik++){
        if(offerviewAll[i].offerproductlistdetails![ik].offerid==ij.offerId){
          isitemloaded=false;
       notifyListeners();
        }
       
      }
      }
if(!isitemloaded){
 showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    // if( prdOffZ
                                                    //             .getofferviewAll[i].offerproductlistdetails!.isNotEmpty){
                                                    return DiviceDialogBox(
                                                      pardata: ij,
                                                      theme: themes,
                                                      // pardata: offerviewAll[0],
                                                      // i: i,
                                                      // popvalues2:prdOffZ.getofferviewAll,
                                                    );
                                                    // }
                                                  });
}else{
  log("hiii");
}
      notifyListeners();

    
  }

  Future<void> refreshData() async {
    offerviewAll.clear();
    searchofferzone.clear();
    offerdbmethod();
  }

  offerfilterList(String v) {
    if (v.isNotEmpty) {
      offerviewAll = searchofferzone
          .where((e) =>
              e.offerDetails!.toLowerCase().contains(v.toLowerCase()) ||
              // e.discoutDetails!.toLowerCase().contains(v.toLowerCase()) ||
              e.offerName!.toLowerCase().contains(v.toLowerCase()) ||
              e.validTill!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      offerviewAll = searchofferzone;
      notifyListeners();
    }
  }
}
