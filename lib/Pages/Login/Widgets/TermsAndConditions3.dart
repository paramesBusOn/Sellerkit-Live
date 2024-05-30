
// ignore_for_file: prefer_const_constructors

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:sellerkit/Constant/Screen.dart';

class pdfViwer extends StatefulWidget {
  const pdfViwer({Key? key}) : super(key: key);

  @override
  State<pdfViwer> createState() => _pdfViwerState();
}

class _pdfViwerState extends State<pdfViwer> {
 late PDFDocument document;
  @override
  void initState(){
     super.initState();
      loadinit();
  }

  loadinit()async{
    document=await PDFDocument.fromAsset('Assets/terms/terms2.pdf');
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:theme.primaryColor ,
        title: Text("Terms and Conditions"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future:loadinit() ,
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
 return Container(
  height: Screens.padingHeight(context),
  width: Screens.width(context),
            child:
            // PDFView(
            //   filePath: 'Assets/terms/terms.pdf',
            // )
            PDFViewer(document: document,
            //  lazyLoad: false,
            showPicker :false,
            showIndicator: true,
            scrollDirection:Axis.vertical,
             showNavigation :false,
            
             
                    
            ) 
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
         
        }
      ),
    );
  }
}