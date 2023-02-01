import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewtest/blocs/main_bloc.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: const MaterialApp(
        home: NavigationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
