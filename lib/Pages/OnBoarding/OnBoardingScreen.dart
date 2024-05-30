// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/onboardModel/onboardmodel.dart';
import 'package:sellerkit/Services/onboardApi/onboardApi.dart';
import '../../Constant/ConstantRoutes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  
List<onBoardData> onboarddata=[];
bool isloaing=false;
  void initState(){
    super.initState();
    setState(() {
      onboarddata.clear();
      isloaing=false;   
      callApi();
    });
  }
  callApi() async{
    setState(() {
   isloaing=false;   
 });
   await   onBoardApi.getData().then((value) {
if (value.stcode! >= 200 && value.stcode! <= 210){
  if (value.itemdata != null) {
         final stopwatch = Stopwatch()..start();
        
       setState(() {
          onboarddata = value.itemdata!;
          log("message"+onboarddata.length.toString());
          isloaing=true;  
       }); 
        
         stopwatch.stop();
            log('API EnquiryType ${stopwatch.elapsedMilliseconds} milliseconds');
      } else if (value.itemdata == null) {
       setState(() {
        isloaing = true;  
       });
       
        
       
      }
     
}else if (value.stcode! >= 400 &&
        value.stcode! <= 410) {
     setState(() {
        isloaing = true;  
       });
    } else if (value.stcode == 500) {
     setState(() {
        isloaing = true;  
       });
    }
    });
 
  }
  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

    return Scaffold(
   body: isloaing==false?Center(child: CircularProgressIndicator(),):
   isloaing==true&&  onboarddata.length > 0?
  //  Container(
      // child: 
      Container(
        width: Screens.width(context),
      height: Screens.padingHeight(context),
      // color: Colors.red,
        child: Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemCount: onboarddata.length,
            //     itemBuilder:(BuildContext context,int ind){
                  // return  
                  Container(
                   height: Screens.padingHeight(context),
                    width:Screens.width(context),
                    // color: Colors.amber,
                    child:
                    // Column(children: [
                    //   Container(
                    //     padding: EdgeInsets.all(8.0),
                    //   height: Screens.padingHeight(context)*0.6,
                    //     // color: Colors.amber,
                    //     child: firstImagelist(onboarddata[ind].urL1.toString()),
                    //   ),
                    //   // Container(
                    //   //   child: ,
                    //   // )
                    
                    // ],)
                    //  Text("hi")
                    IntroductionScreen(
                          done: Text("Done",style: theme.textTheme.bodyMedium,),
                          onDone: ()=>gotoHome(context),
                          next: Icon(Icons.arrow_forward),
                          showSkipButton: true,
                          skip: Text("Skip"),
                           onSkip: ()=>gotoHome(context),
                          dotsDecorator: dotsDecorations(theme),
                             // globalBackgroundColor: theme.primaryColor,
                          isProgressTap: false,
                          freeze: false,
                          rawPages: [

                            for(int i=0;i<onboarddata.length;i++)
                              buildrawpage(context, i),
                            
                          //  Container(
                            
      // title: "Page 1 Title",
      // body: "Page 1 Body",
      
      // child: 
      // ListView.builder(
      //   shrinkWrap: true,
      //   scrollDirection: Axis.horizontal,
      //   itemCount: onboarddata.length,
      //   itemBuilder:(BuildContext context,int ind){
      //     return 
      //   }
      // ), // Example image asset
    // ),


    //  Container(
                            
    //   // title: "Page 1 Title",
    //   // body: "Page 1 Body",
      
    //   child: Column(
    //     children: [
    //       Container(
    //         height: Screens.padingHeight(context)*0.65,
    //         width: Screens.width(context),
    //         // color:Colors.red,
    //         child:  firstImagelist(onboarddata[ind].urL2.toString()),
    //       ),
    //        Container(
    //         alignment: Alignment.center,
    //         height: Screens.padingHeight(context)*0.2,
    //         width: Screens.width(context)*0.8,
    //         // color:Colors.amber,
    //         child: Padding(
    //           padding:  EdgeInsets.all(8.0),
    //           child: Center(child:Text("Easy checkout & Safe payment method trused by our customers from all over the world",
    //           textAlign: TextAlign.center,
    //           style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),)),
    //         ),
    //       )
    //     ],
    //   ), // Example image asset
    // ),


    // Container(
                            
    //   // title: "Page 1 Title",
    //   // body: "Page 1 Body",
      
    //   child: Column(
    //     children: [
    //       Container(
    //         height: Screens.padingHeight(context)*0.65,
    //         width: Screens.width(context),
    //         // color:Colors.red,
    //         child:  firstImagelist(onboarddata[ind].urL3.toString()),
    //       ),
    //        Container(
    //         alignment: Alignment.center,
    //         height: Screens.padingHeight(context)*0.2,
    //         width: Screens.width(context)*0.8,
    //         // color:Colors.amber,
    //         child: Padding(
    //           padding:  EdgeInsets.all(8.0),
    //           child: Center(child:Text("To make it easier for you to shop we provide customer service if you have any questions",
    //           textAlign: TextAlign.center,
    //           style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),)),
    //         ),
    //       )
    //     ],
    //   ), // Example image asset
    // ),
                          ],
                    //       pages: [
                    //         PageViewModel(
                    // title: "Great Sales App",
                    // // body: '',
                    // body:  "we have a 100k++ products choose your product from our Store",
                    // image: firstImagelist(onboarddata[ind].urL1.toString()),
                    // decoration: getPageDecoration(theme),
                    
                    //         ),
                    //          PageViewModel(
                    // title: "Online Payment",
                    // // body: '',
                    // body:  "Easy checkout & Safe payment method trused by our customers from all over the world",
                    // image: firstImagelist(onboarddata[ind].urL2.toString()),
                    //  decoration: getPageDecoration(theme),
                    //         ),
                    //          PageViewModel(
                    // title: "Customer Services",
                    // // body: '',
                    // body:  "To make it easier for you to shop we provide customer service if you have any questions",
                    // image: firstImagelist(onboarddata[ind].urL3.toString()),
                    //  decoration: getPageDecoration(theme),
                    //         ),
                    //       ],
                            ),
                  ),
            //     } 
            //     ),
            // ),
          ],
        ),
      )
    // )
    :
    
    
    IntroductionScreen(
      done: Text("Done",style: theme.textTheme.bodyMedium,),
      onDone: ()=>gotoHome(context),
      next: Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: Text("Skip"),
      onSkip: ()=>gotoHome(context),
      dotsDecorator: dotsDecorations(theme),
     // globalBackgroundColor: theme.primaryColor,
      isProgressTap: false,
      freeze: false,
      
      pages: [
        
        PageViewModel(
          title: "Great Sales App",
          body:  "we have a 100k++ products choose your product from our Store",
          image: firstImage('Assets/boarding_1.png'),
          decoration: getPageDecoration(theme),
          
        ),
         PageViewModel(
          title: "Online Payment",
          body:  "Easy checkout & Safe payment method trused by our customers from all over the world",
          image: firstImage('Assets/boarding_2.png'),
           decoration: getPageDecoration(theme),
        ),
         PageViewModel(
          title: "Customer Services",
          body:  "To make it easier for you to shop we provide customer service if you have any questions",
          image: firstImage('Assets/boarding_3.png'),
           decoration: getPageDecoration(theme),
        ),
      ],
    )
);
  }

  Widget buildrawpage(BuildContext context, int ind) {
    return Container(
          height: Screens.padingHeight(context),
          width: Screens.width(context),
          // color:Colors.red,
          child:  firstImagelist(onboarddata[ind].urL1.toString()),
        );
  }

  Widget firstImage(String path)=>
  Center(child: Image.asset(path,width: Screens.padingHeight(context)*0.5,),
  
  );
 
Widget firstImagelist(String path)=>
  Container(
    // color: Colors.amber,
    // height: 50,
    //width: 600,
    child: Image.network(path,fit: BoxFit.fill,));
//image deco
 PageDecoration getPageDecoration(ThemeData theme )=> PageDecoration(
   titleTextStyle: theme.textTheme.headline5!.copyWith(fontWeight:FontWeight.bold),
   bodyTextStyle: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
//    imagePadding: EdgeInsets.only(top:Screens.padingHeight(context)*0.1),
//    titlePadding: EdgeInsets.only(top:Screens.padingHeight(context)*0.1),
// bodyPadding: EdgeInsets.only(top:Screens.padingHeight(context)*0.05),
   pageColor: Colors.white
 );

 //

 void gotoHome(Context)
 async{
   await HelperFunctions.saveOnBoardSharedPreference(true);
    await HelperFunctions.getOnBoardSharedPreference().then((value){
      log("onboard: "+value.toString());
    });
   Get.offAllNamed(ConstantRoutes.splash);
 } 
//  Navigator.of(context).pushReplacement(
//   // MaterialPageRoute(builder: (_)=>SplashScreen())
//  );

 //
 DotsDecorator dotsDecorations(ThemeData theme)=> DotsDecorator(
   color: Colors.grey,//theme.primaryColor.withOpacity(0.1),
    size: Size(10,10),
    activeSize: Size(20,10),
    activeColor: theme.primaryColor,
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))

 );
}