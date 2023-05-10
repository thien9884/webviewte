import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/login/login_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
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
  List<ProductsModel> _listIphone = [];
  List<ProductsModel> _listIpad = [];
  List<ProductsModel> _listMac = [];
  List<ProductsModel> _listAppleWatch = [];
  List<ProductsModel> _listSound = [];
  List<ProductsModel> _listAccessories = [];
  String _topBanner = '';
  final List<TopBanner> _listTopBannerImg = [];

  String _homeBanner = '';
  final List<TopBanner> _listHomeBannerImg = [];

  // Sync data
  _getCategories() async {
    EasyLoading.show();
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetCategories());
  }

  _getListIpad() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'ipad');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetIpad(idIpad: _listCategories[index].id));
  }

  _getListIphone() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'iphone');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetIphone(idIphone: _listCategories[index].id));
  }

  _getListMac() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'mac');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetMac(idMac: _listCategories[index].id));
  }

  _getListWatch() async {
    int index = _listCategories
        .indexWhere((element) => element.seName == 'apple-watch');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetAppleWatch(idWatch: _listCategories[index].id));
  }

  _getListSound() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'am-thanh');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetSound(idSound: _listCategories[index].id));
  }

  _getListAccessories() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'phu-kien');
    BlocProvider.of<ShopdunkBloc>(context)
        .add(RequestGetAccessories(idAccessories: _listCategories[index].id));
  }

  _getNews() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetNews());
  }

  _getTopBanner() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetTopBanner(156));
  }

  _getHomeBanner() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetHomeBanner(6));
  }

  _getListProduct() async {
    await _getListIpad();
    await _getListIphone();
    await _getListMac();
    await _getListWatch();
    await _getListSound();
    await _getListAccessories();
    await _getNews();
    await _getTopBanner();
    await _getHomeBanner();
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
  }

  _saveData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    await _clearData();

    if (_listCategories.isNotEmpty &&
        _listIpad.isNotEmpty &&
        _listIphone.isNotEmpty &&
        _listMac.isNotEmpty &&
        _listAppleWatch.isNotEmpty &&
        _listSound.isNotEmpty &&
        _listAccessories.isNotEmpty &&
        _listTopBannerImg.isNotEmpty &&
        _listHomeBannerImg.isNotEmpty &&
        _newsGroup.isNotEmpty &&
        _latestNews.isNotEmpty &&
        _listTopBannerImg.isNotEmpty &&
        _listHomeBannerImg.isNotEmpty) {
      String listCategories = jsonEncode(_listCategories);
      String listIpad = jsonEncode(_listIpad);
      String listIphone = jsonEncode(_listIphone);
      String listMac = jsonEncode(_listMac);
      String listAppleWatch = jsonEncode(_listAppleWatch);
      String listSound = jsonEncode(_listSound);
      String listAccessories = jsonEncode(_listAccessories);
      String listNewsGroup = jsonEncode(_newsGroup);
      String listLatestNews = jsonEncode(_latestNews);
      String listTopBanner = jsonEncode(_listTopBannerImg);
      String listHomeBanner = jsonEncode(_listHomeBannerImg);
      await sPref.setListCategories(listCategories);
      await sPref.setListIpad(listIpad);
      await sPref.setListIphone(listIphone);
      await sPref.setListMac(listMac);
      await sPref.setListAppleWatch(listAppleWatch);
      await sPref.setListSound(listSound);
      await sPref.setListAccessories(listAccessories);
      await sPref.setListNewsGroup(listNewsGroup);
      await sPref.setListLatestNews(listLatestNews);
      await sPref.setListTopBanner(listTopBanner);
      await sPref.setListHomeBanner(listHomeBanner);

      if (context.mounted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NavigationScreen()));
      }
      if (EasyLoading.isShow) EasyLoading.dismiss();
    }
  }

  _getToken() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    bool rememberMe = sPref.rememberMe;
    String userName = sPref.userName;
    String password = sPref.password;

    if(context.mounted) {
      BlocProvider.of<LoginBloc>(context).add(RequestPostLogin(
      loginModel: rememberMe
          ? LoginModel(
              rememberMe: true,
              guest: false,
              username: userName,
              password: password,
            )
          : LoginModel(
              rememberMe: false,
              guest: true,
              username: 'thien',
              password: 'a',
            ),
    ));
    }
  }

  @override
  void initState() {
    _getToken();
    _getCategories();
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
            int indexSound = _listCategories
                .indexWhere((element) => element.seName == 'am-thanh');
            int indexAccessories = _listCategories
                .indexWhere((element) => element.seName == 'phu-kien');
            _listCategories[indexSound].name = 'Âm thanh';
            _listCategories[indexAccessories].name = 'Phụ kiện';
            _getListProduct();
          } else if (state is CategoriesLoadError) {
            if (context.mounted) {
              AlertUtils.displayErrorAlert(context, state.message);
              if (EasyLoading.isShow) EasyLoading.dismiss();
            }
          }

          if (state is IpadLoading) {
          } else if (state is IpadLoaded) {
            _listIpad = state.ipad;
            _saveData();
          } else if (state is IpadLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is IphoneLoading) {
          } else if (state is IphoneLoaded) {
            _listIphone = state.iphone;
            _saveData();
          } else if (state is IphoneLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is MacLoading) {
          } else if (state is MacLoaded) {
            _listMac = state.mac;
            _saveData();
          } else if (state is MacLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is AppleWatchLoading) {
          } else if (state is AppleWatchLoaded) {
            _listAppleWatch = state.watch;
            _saveData();
          } else if (state is AppleWatchLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is SoundLoading) {
          } else if (state is SoundLoaded) {
            _listSound = state.sound;
            _saveData();
          } else if (state is SoundLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is AccessoriesLoading) {
          } else if (state is AccessoriesLoaded) {
            _listAccessories = state.accessories;
            _saveData();
          } else if (state is AccessoriesLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is NewsLoading) {
          } else if (state is NewsLoaded) {
            _newsGroup = state.newsData.newsGroup ?? [];
            _latestNews = state.newsData.latestNews ?? [];
            _latestNews.removeRange(
                2, _latestNews.lastIndexOf(_latestNews.last));
            _saveData();
          } else if (state is NewsLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is TopBannerLoading) {
          } else if (state is TopBannerLoaded) {
            _topBanner = state.listTopics.topics?.first.body ?? '';
            var document = parse(
              _topBanner.replaceAll('src="', 'src="http://shopdunk.com'),
            );
            var imgList = document.querySelectorAll("img");
            var linkList = document.querySelectorAll("a");
            List<String> imageList = [];
            List<String> getLinkList = [];
            List<TopBanner> topBanner = [];
            for (dom.Element img in imgList) {
              imageList.add(img.attributes['src']!);
            }
            for (dom.Element img in linkList) {
              getLinkList.add(img.attributes['href']!);
            }
            for (int i = 0; i < imageList.length; i++) {
              topBanner.add(
                TopBanner(
                  img: imageList[i].toString(),
                  link: getLinkList[i].toString(),
                ),
              );
            }
            _listTopBannerImg.clear();
            _listTopBannerImg.addAll(topBanner);
            _saveData();
          } else if (state is TopBannerLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is HomeBannerLoading) {
          } else if (state is HomeBannerLoaded) {
            _homeBanner = state.listTopics.topics?.first.body ?? '';
            var document = parse(
              _homeBanner.replaceAll('src="', 'src="http://shopdunk.com'),
            );
            var imgList = document.querySelectorAll("img");
            var linkList = document.querySelectorAll("a");
            List<String> imageList = [];
            List<String> getLinkList = [];
            List<TopBanner> homeBanner = [];
            for (dom.Element img in imgList) {
              imageList.add(img.attributes['src']!);
            }
            for (dom.Element img in linkList) {
              getLinkList.add(img.attributes['href']!);
            }
            for (int i = 0; i < imageList.length; i++) {
              homeBanner.add(
                TopBanner(
                  img: imageList[i].toString(),
                  link: getLinkList[i].toString(),
                ),
              );
            }
            _listHomeBannerImg.clear();
            _listHomeBannerImg.addAll(homeBanner);
            _saveData();
          } else if (state is HomeBannerLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  // loading screen
  Widget _buildLoadingUI() {
    return SafeArea(bottom: false, child: Container());
  }
}