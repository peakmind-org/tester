import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://web2.peakmind.in/?organizationId=95ccf75e-c549-44e5-b3c6-d310af6d1e38&token=uti6q0iqt2bbc&orgUserIdType=institute_id&orgUserIdValue=100001&cohortId=e581d889-1763-4d4f-a9da-834615fc48a6&programId=990c7ab2-0541-48a9-b3a6-c715013fde76'));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          WebViewWidget(
            controller: _controller,
            key: const ValueKey('webviewx'),

            // 'https://web2-qa.peakmind.in/?organizationId=95ccf75e-c549-44e5-b3c6-d310af6d1e38&token=uti6q0iqt2bbc&orgUserIdType=institute_id&orgUserIdValue=kyofighter&cohortId=e581d889-1763-4d4f-a9da-834615fc48a6&programId=72354e11-b412-4914-bd0e-d6bf530bf6aa',
            // "https://web2.peakmind.in/?organizationId=95ccf75e-c549-44e5-b3c6-d310af6d1e38&token=uti6q0iqt2bbc&orgUserIdType=institute_id&orgUserIdValue=kyofighter&cohortId=e581d889-1763-4d4f-a9da-834615fc48a6&programId=72354e11-b412-4914-bd0e-d6bf530bf6aa",
            // initialSourceType: SourceType.url,
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // javascriptMode: JavascriptMode.unrestricted,
            // onPageStarted: (_) {
            // _loader.value = true;
            // },
            // onWebViewCreated: (controller) {
            //   _controller = controller;
            // },
            // onPageFinished: (_) async {
            // _loader.value = false;
            // final content = await _controller.getContent();
            //
            // log(content.sourceType.toString());
            // log(content.source.toString());
            // log(content.headers.toString());
            // log(content.webPostRequestBody.toString());
            // },
            // jsContent: const {
            //   EmbeddedJsContent(
            //     js: "function testPlatformIndependentMethod() { messageHandler() }",
            //   ),
            //   EmbeddedJsContent(
            //     webJs:
            //         "function testPlatformSpecificMethod() { messageHandler() }",
            //     mobileJs:
            //         "function testPlatformSpecificMethod() { TestDartCallback.postMessage('Mobile callback says:') }",
            //   ),
            // },
            // navigationDelegate: (navigation) {
            //   debugPrint(navigation.content.sourceType.toString());
            //   return NavigationDecision.navigate;
            // },
            // webSpecificParams: const WebSpecificParams(
            //   printDebugInfo: true,
            // ),
            // mobileSpecificParams: const MobileSpecificParams(
            //   androidEnableHybridComposition: true,
            // ),
            // dartCallBacks: {
            //   DartCallback(
            //     name: 'messageHandler',
            //     callBack: (message) async {},
            //   )
            // },
          ),
        ]),
      ),
    );
  }
}
