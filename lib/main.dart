import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel(
      'com.taoweiji.flutter.flutter_platform_view.AndroidTextView');

  Widget getPlatformTextView() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
          viewType: "platform_text_view",
          creationParams: <String, dynamic>{"text": "Android Text View$i"},
          creationParamsCodec: const StandardMessageCodec());
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
          viewType: "platform_text_view",
          creationParams: <String, dynamic>{"text": "iOS Label"},
          creationParamsCodec: const StandardMessageCodec());
    } else {
      return Text("Not supported");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Expanded(
                child: getPlatformTextView(),
              )),
          Text(
            nativeData,
            style: TextStyle(color: Colors.green, fontSize: 18),
          )
        ])));
  }

  int i = 1;

  String nativeData = "";

  @override
  void initState() {
    platform.setMethodCallHandler((call) {
      if (call.method == "reresult") {
        setState(() {
          nativeData = call.arguments;
        });
      }
    });
    getTest();
  }

  void getTest() async {
    bool a = true;
    while (a) {
      await new Future.delayed(const Duration(seconds: 1), () => {})
          .then((value) => {
                this.setState(() {
                  i++;
                  platform.invokeMethod("setText", {"msg": "ssd$i"});
                  if (i == 100) {
                    a = !a;
                  }
                })
              });
    }
  }
}
