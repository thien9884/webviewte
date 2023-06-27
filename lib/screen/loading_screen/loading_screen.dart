import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/login/login_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Categories
  List<Categories> _listCategories = [];
  List<LatestNews> _latestNews = [];
  List<NewsGroup> _newsGroup = [];
  String _messageError = '';
  List<Topics> _listTopics = [];

  // Sync data
  Future<void> _getCategories() async {
    EasyLoading.show();
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetCategories());
  }

  Future<void> _getTopics() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetFooterBanner());
  }

  Future<void> _getNews() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetNews());
  }

  _clearData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;

    sPref.remove(SharedPrefKeys.listCategories);
    sPref.remove(SharedPrefKeys.listIpad);
    sPref.remove(SharedPrefKeys.listIphone);
    sPref.remove(SharedPrefKeys.listMac);
    sPref.remove(SharedPrefKeys.listAppleWatch);
    sPref.remove(SharedPrefKeys.listSound);
    sPref.remove(SharedPrefKeys.listAccessories);
    sPref.remove(SharedPrefKeys.listNewsGroup);
    sPref.remove(SharedPrefKeys.listLatestNews);
    sPref.remove(SharedPrefKeys.listTopBanner);
    sPref.remove(SharedPrefKeys.listHomeBanner);
    sPref.remove(SharedPrefKeys.listTopics);
  }

  _saveData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    await _clearData();

    if (_listCategories.isNotEmpty &&
        _listTopics.isNotEmpty &&
        _newsGroup.isNotEmpty &&
        _latestNews.isNotEmpty) {
      //:TODO - Use isolates
      String listCategories = jsonEncode(_listCategories);
      String listTopics = jsonEncode(_listTopics);
      String listNewsGroup = jsonEncode(_newsGroup);
      String listLatestNews = jsonEncode(_latestNews);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          context
              .read<ShopdunkBloc>()
              .add(RequestLogoutEvent(isMoveToLogin: !sPref.isLogin));
          return NavigationScreen(
            listCategories: listCategories,
            listNewsGroup: listNewsGroup,
            listLatestNews: listLatestNews,
            listTopics: listTopics,
          );
        }), (route) => false);
      }
      if (EasyLoading.isShow) EasyLoading.dismiss();
    }
  }

  _getToken() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    final userName = sPref.userName;
    final password = sPref.password;
    print('Is login: ${sPref.isLogin}');
    if (userName.isNotEmpty && password.isNotEmpty && sPref.isLogin) {
      if (context.mounted) {
        BlocProvider.of<LoginBloc>(context).add(RequestPostLogin(
          loginModel: LoginModel(
            rememberMe: true,
            guest: false,
            username: userName,
            password: password,
          ),
        ));
      }
    } else {
      if (context.mounted) {
        BlocProvider.of<LoginBloc>(context).add(RequestPostLogin(
          loginModel: LoginModel(
            rememberMe: true,
            guest: true,
            username: 'userName',
            password: 'password',
          ),
        ));
      }
    }
  }

  @override
  void initState() {
    _getToken();
    _getCategories();
    _getTopics();
    _getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _buildLoadingUI(),
        listener: (context, state) async {
          if (state is CategoriesLoading) {
          } else if (state is CategoriesLoaded) {
            _listCategories = state.categories
                .where((element) => element.showOnHomePage == true)
                .toList();
            _listCategories.sort(
              (a, b) => a.displayOrder!.compareTo(b.displayOrder!.toInt()),
            );
            int indexSound = _listCategories
                .indexWhere((element) => element.seName == 'am-thanh');
            int indexAccessories = _listCategories
                .indexWhere((element) => element.seName == 'phu-kien');
            _listCategories[indexSound].name = 'Âm thanh';
            _listCategories[indexAccessories].name = 'Phụ kiện';
            _saveData();
          } else if (state is CategoriesLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is NewsLoading) {
          } else if (state is NewsLoaded) {
            _newsGroup = state.newsData.newsGroup ?? [];
            for (var element in _newsGroup) {
              if (element.name!.toLowerCase().contains('apple')) {
                element.icon = 'assets/icons/ic_apple_news.png';
              } else if (element.name!.toLowerCase().contains('review')) {
                element.icon = 'assets/icons/ic_review_news.png';
              } else if (element.name!.toLowerCase().contains('khám phá')) {
                element.icon = 'assets/icons/ic_discover_news.png';
              } else if (element.name!.toLowerCase().contains('thủ thuật')) {
                element.icon = 'assets/icons/ic_tip_news.png';
              } else if (element.name!.toLowerCase().contains('khuyến mại')) {
                element.icon = 'assets/icons/ic_sale_news.png';
              } else if (element.name!.toLowerCase().contains('tin khác')) {
                element.icon = 'assets/icons/ic_other_news.png';
              } else if (element.name!.toLowerCase().contains('ivideo')) {
                element.icon = 'assets/icons/ic_ivideo_news.png';
              }
            }
            _latestNews = state.newsData.latestNews ?? [];
            _latestNews.removeRange(
                2, _latestNews.lastIndexOf(_latestNews.last));
            _saveData();
          } else if (state is NewsLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is FooterLoading) {
          } else if (state is FooterLoaded) {
            _listTopics = state.listTopics.topics ?? [];
            _saveData();
          } else if (state is FooterLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);

              if (EasyLoading.isShow) EasyLoading.dismiss();
            }
          }
        });
  }

  // loading screen
  Widget _buildLoadingUI() {
    return SafeArea(
      bottom: false,
      child: _messageError.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hệ thống đang bảo trì\nVui lòng ấn vào đây để cập nhật lại dữ liệu.',
                  style: CommonStyles.size15W400Black1D(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 160,
                  child: CommonButton(
                    title: 'Cập nhật lại dữ liệu',
                    onTap: () {
                      setState(() {
                        _messageError = '';
                        _getToken();
                        _getCategories();
                      });
                    },
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
