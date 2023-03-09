import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/main_bloc.dart';
import 'package:webviewtest/screen/category/category_screen.dart';

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
        builder: EasyLoading.init(),
        home: const CategoryScreen(),
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
    ..maskColor = const Color(0xff0E879E).withOpacity(0.15)
    ..dismissOnTap = false;
}
