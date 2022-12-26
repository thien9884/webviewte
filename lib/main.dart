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
    home: const WebViewExample(),
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