import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webviewx/webviewx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  late WebViewXController _controller;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My WebView'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            WebViewX(
              key: const ValueKey('webviewx'),
              initialContent: "https://dwb8g5mh70903.cloudfront.net/?organizationId=95ccf75e-c549-44e5-b3c6-d310af6d1e38&token=uti6q0iqt2bbc&orgUserIdType=institute_id&orgUserIdValue=kyofighter&cohortId=e581d889-1763-4d4f-a9da-834615fc48a6&programId=72354e11-b412-4914-bd0e-d6bf530bf6aa",
              initialSourceType: SourceType.url,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (_) {
                // _loader.value = true;
              },
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (_) async {
                // _loader.value = false;
                // final content = await _controller.getContent();
                //
                // log(content.sourceType.toString());
                // log(content.source.toString());
                // log(content.headers.toString());
                // log(content.webPostRequestBody.toString());
              },
              jsContent: const {
                EmbeddedJsContent(
                  js: "function testPlatformIndependentMethod() { messageHandler() }",
                ),
                EmbeddedJsContent(
                  webJs:
                  "function testPlatformSpecificMethod() { messageHandler() }",
                  mobileJs:
                  "function testPlatformSpecificMethod() { TestDartCallback.postMessage('Mobile callback says:') }",
                ),
              },
              navigationDelegate: (navigation) {
                debugPrint(navigation.content.sourceType.toString());
                return NavigationDecision.navigate;
              },
              webSpecificParams: const WebSpecificParams(
                printDebugInfo: true,
              ),
              mobileSpecificParams: const MobileSpecificParams(
                androidEnableHybridComposition: true,
              ),
              dartCallBacks: {
                DartCallback(
                  name: 'messageHandler',
                  callBack: (message) async {
                    ValueNotifier<WebViewContent> content =
                    ValueNotifier<WebViewContent>(
                        await _controller.getContent());
                    content.addListener(() {
                      if (content.value.webPostRequestBody != null) {
                        // log(content.value.webPostRequestBody.toString());
                      }
                    });
                    // log(content.value.sourceType.toString() + " Source type");
                    // log(message.toString() + ' Message---');
                    print(message.toString());
                  },
                )
              },
            ),

          ]),
        ),
      ),
    );
  }
}
