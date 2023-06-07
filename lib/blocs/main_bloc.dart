import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:webviewtest/blocs/change_password/change_password_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_bloc.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/news/news_bloc.dart';
import 'package:webviewtest/blocs/news_category/news_category_bloc.dart';
import 'package:webviewtest/blocs/order/order_bloc.dart';
import 'package:webviewtest/blocs/register/register_bloc.dart';
import 'package:webviewtest/blocs/related_news/related_news_bloc.dart';
import 'package:webviewtest/blocs/search_products/search_products_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() => [
        // Post
        BlocProvider<ShopdunkBloc>(
            create: (BuildContext context) => ShopdunkBloc()),
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<NewsBloc>(create: (BuildContext context) => NewsBloc()),
        BlocProvider<RelatedNewsBloc>(
            create: (BuildContext context) => RelatedNewsBloc()),
        BlocProvider<SearchProductsBloc>(
            create: (BuildContext context) => SearchProductsBloc()),
        BlocProvider<NewsCategoryBloc>(
            create: (BuildContext context) => NewsCategoryBloc()),
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc()),
        BlocProvider<OrderBloc>(create: (BuildContext context) => OrderBloc()),
        BlocProvider<CustomerBloc>(
            create: (BuildContext context) => CustomerBloc()),
        BlocProvider<ForgotPasswordBloc>(
            create: (BuildContext context) => ForgotPasswordBloc()),
        BlocProvider<ChangePasswordBloc>(
            create: (BuildContext context) => ChangePasswordBloc()),
        BlocProvider<ExchangeBloc>(
            create: (BuildContext context) => ExchangeBloc()),
      ];
}
