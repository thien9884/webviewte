import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/main_bloc.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

void main() {
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'ArialCustom'),
        builder: EasyLoading.init(),
        home: const NavigationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.custom
    ..boxShadow = <BoxShadow>[]
    ..maskColor = Colors.transparent
    ..dismissOnTap = false;
}
