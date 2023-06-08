import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    // final WebViewController controller =
    //     WebViewController.fromPlatformCreationParams(params);

    // controller
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(NavigationDelegate(
    //     onPageStarted: (url) {
    //       print('page Started : $url');
    //       Future.delayed(const Duration(milliseconds: 1000), () {
    //         setState(() {
    //           isLoading = false;
    //         });
    //       });
    //     },
    //     onPageFinished: (url) {
    //       print('finished');
    //       controller.runJavaScript(
    //           "document.getElementsByTagName('header')[0].style.display='none'");
    //       controller.runJavaScript(
    //           "document.getElementsByTagName('footer')[0].style.display='none'");
    //     },
    //   ))
    //   ..loadRequest(Uri.parse('https://records.yourmuneem.com/'));

    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    // webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              // controller: webViewController,
              initialUrl: 'https://records.yourmuneem.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller.complete(controller);
              },
              onPageStarted: (url) {
                print('page Started : $url');
                Future.delayed(const Duration(milliseconds: 1000), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              onPageFinished: (url) async {
                print('finished');
                // _controller.runJavaScript(
                //     "document.getElementsByTagName('header')[0].style.display='none'");
                // _controller.runJavascript(
                //     "document.getElementsByTagName('footer')[0].style.display='none'");
              },
            ),
            if (isLoading)
              const Center(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final urlCurrent = await webViewController.currentUrl();
      //     print('current url $urlCurrent');
      //     webViewController.loadRequest('https://www.Youtube.com');
      //   },
      //   child: const Icon(Icons.video_collection_outlined, size: 35),
      // ),
    );
  }
}
