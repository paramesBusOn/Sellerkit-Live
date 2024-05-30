// // ignore_for_file: prefer_collection_literals

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WEBV extends StatefulWidget {
//   @override
//   _WebviewState createState() => _WebviewState();
// }

// class _WebviewState extends State<WEBV> {
//   final Completer<WebViewController> _controller =
//   Completer<WebViewController>();
//   WebViewController? _con;

//   /*
//   *
//   * Webview
//   * */

//   String setHTML() {
//     return ('''
//   <!DOCTYPE html>
// <html>
// <body>

// <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
// <video width="1000" height="400" controls preview id="myvideotag">
//   <source src="http://216.48.186.108:19977/SK/s1.mp4" type="video/mp4">
// </video>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <br><br/>
// <br><br/>
// <br><br/>
// <br><br/>
// <p>HI there</p>
// <br><br/>

// <script>

// var myvid = \$('#myvideotag')[0];
// \$(window).scroll(function(){
//   var scroll = \$(this).scrollTop();
//   scroll > 170 ? myvid.pause() : myvid.play()
// })


// </script>

// </body>
// </html>
      
//     ''');
//   }

//   _loadHTML() async {
//     _con!.loadUrl(Uri.dataFromString(
//         setHTML(),
//         mimeType: 'text/html',
//         encoding: Encoding.getByName('utf-8')
//     ).toString());
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Webview'),
//       ),
//       body: Builder(builder: (BuildContext context) {
//         return WebView(
//           initialUrl: 'https://flutter.dev',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             // _controller.complete(webViewController);
//             _con = webViewController;
//             _loadHTML();
//           },
//           onProgress: (int progress) {
//             print("WebView is loading (progress : $progress%)");
//           },
//           navigationDelegate: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               print('blocking navigation to $request}');
//               return NavigationDecision.prevent;
//             }
//             print('allowing navigation to $request');
//             return NavigationDecision.navigate;
//           },
//           onPageStarted: (String url) {
//             print('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             print('Page finished loading: $url');
//           },
//           javascriptChannels: [
//     JavascriptChannel(
//         name: 'FLUTTER_CHANNEL',
//         onMessageReceived: (message) {
//             if (message.message.toString() ==
//                 "end of scroll") {
//                 setState((){ 
//                    // enableAgreeButton = true; 
//                 });
//             }
//         })
//     ].toSet(),
//     gestureNavigationEnabled: true,
//     debuggingEnabled: true,

//         );
//       }),
//     );
//   }

// }