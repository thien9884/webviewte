import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:webviewtest/blocs/categories/categories_bloc.dart';
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/news/news_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
        // Post
        BlocProvider<CategoriesBloc>(
            create: (BuildContext context) => CategoriesBloc()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<NewsBloc>(create: (BuildContext context) => NewsBloc()),
      ];
}
