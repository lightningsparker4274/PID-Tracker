import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController with specific settings
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: Update a loading indicator here.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('track-x-taupe.vercel.app')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://track-x-taupe.vercel.app')); // Your specific URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFCDFFE1), // #cdffe1
                Color(0xFFFFE6AD), // #ffe6ad
                //Color(0xFFE4A5FF), // #e4a5ff
              ],
            ),
          ),
          child: AppBar(
            title: Text(
              'TrackX',
              style: TextStyle(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                //color: Colors.white,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.grey[800]!,
                /* fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic, 
                  fontSize: 23,*/
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body:
          WebViewWidget(controller: controller), // Updated to use WebViewWidget
    );
  }
}
