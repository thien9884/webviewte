// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/webviewex.dart';

void main() {
  configLoading();
  runApp(MaterialApp(
    home: const HomePage(),
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(
      builder: (context, widget) {
        widget = GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: widget,
        );
        return widget;
      },
    ),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = const Color(0xff07A0B8)
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorWidget = SizedBox(
    //   width: 80,
    //   height: 80,
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       Image.asset(
    //         'assets/icons/ic_app_logo.jpg',
    //         width: 20,
    //         height: 20,
    //       ),
    //       // you can replace
    //       const CircularProgressIndicator(
    //         valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0E879E)),
    //         strokeWidth: 0.9,
    //       ),
    //     ],
    //   ),
    // )
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..boxShadow = <BoxShadow>[]
    ..maskColor = const Color(0xff0E879E).withOpacity(0.15)
    ..dismissOnTap = false;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController urlController =
      TextEditingController(text: 'https://shopdunk.com');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Shopdunk webview example',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.link_outlined),
                  hintText: 'What do people call you?',
                  labelText: 'Url *',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            WebViewExample(url: urlController.text)));
                  });
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Go to url',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
