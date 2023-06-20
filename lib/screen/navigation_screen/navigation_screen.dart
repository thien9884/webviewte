import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/category/category_screen.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/load_html/load_html_screen.dart';
import 'package:webviewtest/screen/login/login_screen.dart';
import 'package:webviewtest/screen/news/news_category.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/notification/notification_screen.dart';
import 'package:webviewtest/screen/search_products/search_products.dart';
import 'package:webviewtest/screen/user/user_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class NavigationScreen extends StatefulWidget {
  final int isSelected;

  const NavigationScreen({this.isSelected = 0, Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  int _isSelected = 0;
  String url = '';
  final TextEditingController _searchController = TextEditingController();
  List<ProductsModel> _listAllProduct = [];
  FocusNode _focusNode = FocusNode();

  // Categories
  List<Categories> _listCategories = [];
  final _delayInput = DelayInput(milliseconds: 1000);
  bool _showSearch = false;
  bool _showDrawer = false;
  bool _isVisible = true;
  bool _isLogin = false;
  bool _accountExpand = false;
  NewsGroup _newsGroup = NewsGroup();
  final List<Footer> _listFooter = [];
  List<Topics> _listTopics = [];

  _getListTopics() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _listFooter.clear();

    _listTopics = Topics.decode(sPref.listTopics);
    _listFooter.add(
      Footer(
        name: 'Thông tin',
        listFooter: _listTopics
            .where((element) => element.includeInFooterColumn1 == true)
            .toList(),
      ),
    );
    _listFooter.add(
      Footer(
        name: 'Chính sách',
        listFooter: _listTopics
            .where((element) => element.includeInFooterColumn2 == true)
            .toList(),
      ),
    );
    _listFooter.add(
      Footer(
        name: 'Địa chỉ & liên hệ',
        listFooter: _listTopics
            .where((element) => element.includeInFooterColumn3 == true)
            .toList(),
      ),
    );
    setState(() {});
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
    reverseCurve: Curves.linear,
  );

  final pages = [
    // const FlashSaleScreen(),
    const HomePageScreen(),
    const NewsScreen(),
    const LoginScreen(),
    const NotifScreen(),
    const ShopDunkWebView(
      url: 'app-find-store',
      hideBottom: false,
    )
  ];

  _getListNavigationBar() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _listCategories = Categories.decode(sPref.listCategories);
    _newsGroup = NewsGroup.decode(sPref.listNewsGroup)
        .lastWhere((element) => element.id == 1);
    setState(() {});
  }

  @override
  void initState() {
    _isSelected = widget.isSelected;
    _getListNavigationBar();
    _getListTopics();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetHideBottom(false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _buildNavigationUI(),
        listener: (context, state) {
          if (state is SearchProductsLoading) {
          } else if (state is SearchProductsLoaded) {
            setState(() {
              _listAllProduct = state.catalogProductsModel.products ?? [];
            });
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is SearchProductsLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
          } else if (state is HideBottomSuccess) {
            _isVisible = state.isHide;
          } else if (state is LogoutSuccess) {
            pages[2] = state.isLogin ? const LoginScreen() : const UserScreen();
          }
        });
  }

  // buildNavigation
  Widget _buildNavigationUI() {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff515154),
          elevation: 0,
          title: Text(
            _isSelected == 0
                ? 'Trang chủ'
                : _isSelected == 1
                    ? 'Tin tức'
                    : _isSelected == 2
                        ? 'Tài khoản'
                        : _isSelected == 3
                            ? 'Thông báo'
                            : 'Cửa hàng',
            style: CommonStyles.size18W700White(context),
          ),
          centerTitle: true,
          actions: [
            !_showSearch
                ? Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showSearch = true;
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/ic_search_home.svg',
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff515154),
                ),
                child: Center(
                  child: Image.asset('assets/icons/ic_sd_white.png'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final cIndex = _listCategories
                      .indexWhere((element) => element.seName == 'phu-kien');

                  setState(() {
                    _showDrawer = false;
                    _controller.reverse();
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            title: _listCategories[cIndex].name ?? '',
                            desc: _listCategories[cIndex].description ?? '',
                            descAccessories:
                                _listCategories[cIndex].description ?? '',
                            seName: _listCategories[cIndex].seName ?? '',
                            groupId: _listCategories[cIndex].id,
                          )));
                },
                child: Container(
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xffEBEBEB),
                      ),
                    ),
                  ),
                  child: Text(
                    'Phụ kiện',
                    style: CommonStyles.size15W400Black1D(context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showDrawer = false;
                    _controller.reverse();
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NewsCategory(newsGroup: _newsGroup)));
                },
                child: Container(
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: const BorderSide(
                        width: 1,
                        color: Color(0xffEBEBEB),
                      ),
                      top: BorderSide(
                        width: 1,
                        color: _accountExpand
                            ? Colors.grey.withOpacity(0.5)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Text(
                    'Khuyến mãi',
                    style: CommonStyles.size15W400Black1D(context),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _listFooter.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final items = _listFooter[index];

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  items.expand = !items.expand;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffEBEBEB)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        items.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: CommonStyles.size15W400Black1D(
                                            context),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                      color: Color(0xff86868B),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: items.expand
                                  ? 40 * items.listFooter!.length.toDouble()
                                  : 0,
                              child: items.expand
                                  ? ListView.builder(
                                      itemCount: items.listFooter?.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        final item = items.listFooter![i];

                                        return GestureDetector(
                                          onTap: () {
                                            if (item.title
                                                    .toString()
                                                    .toLowerCase() ==
                                                'hệ thống cửa hàng') {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const NavigationScreen(
                                                            isSelected: 3,
                                                          )));
                                            } else {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoadHtmlScreen(
                                                              data: item.body ??
                                                                  '')));
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              item.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  CommonStyles.size13W400Grey86(
                                                      context),
                                            ),
                                          ),
                                        );
                                      })
                                  : const SizedBox(),
                            ),
                          ],
                        );
                      }))
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              BlocProvider.of<ShopdunkBloc>(context)
                  .add(const RequestGetHideBottom(true));
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    if (_isSelected == 0) _buildCategoryBar(),
                    Expanded(
                      child: Stack(
                        children: [
                          pages[_isSelected],
                          _buildDrawerUI(),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: _isVisible
                          ? Platform.isIOS
                              ? 76
                              : 60
                          : 0,
                      child: _isVisible
                          ? SingleChildScrollView(child: _buildBottomBar())
                          : Container(),
                    ),
                  ],
                ),
                if (_showSearch) _buildSearchUI(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerUI() {
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.vertical,
      axisAlignment: -1,
      child: Container(
        height: 56 * 2,
        margin: const EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [],
          ),
        ),
      ),
    );
  }

  // build search UI
  Widget _buildSearchUI() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSearch = false;
          BlocProvider.of<ShopdunkBloc>(context)
              .add(const RequestGetHideBottom(true));
          _searchController.clear();
          _listAllProduct.clear();
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildSearchResult()),
          ],
        ),
      ),
    );
  }

  // home app bar
  Widget _buildAppbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: const Color(0xff515154),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => setState(() {
                _showDrawer = !_showDrawer;
                if (_showDrawer) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
                _accountExpand = false;
              }),
              child: Icon(
                _showDrawer ? Icons.close_rounded : Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isSelected = 0),
            child: Image.asset(
              'assets/icons/ic_sd_white.png',
              scale: Responsive.isMobile(context) ? 4 : 1.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showSearch = true;
              });
            },
            child: SvgPicture.asset(
              'assets/icons/ic_search_home.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // build category bar
  Widget _buildCategoryBar() {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_listCategories.length, (index) {
          final item = _listCategories[index];
          final cIndex = _listCategories
              .indexWhere((element) => element.seName == 'phu-kien');

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    title: item.name ?? '',
                    desc: item.description ?? '',
                    descAccessories: _listCategories[cIndex].description ?? '',
                    seName: item.seName ?? '',
                    groupId: item.id,
                  ),
                ),
              );
            },
            child: Center(
              child: FittedBox(
                child: Text(
                  item.name ?? '',
                  style: CommonStyles.size15W400Black1D(context),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // build search bar
  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => setState(() {
        _showSearch = false;
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetHideBottom(true));
        _searchController.clear();
        _listAllProduct.clear();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color(0xff515154),
        child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showSearch = false;
                  BlocProvider.of<ShopdunkBloc>(context)
                      .add(const RequestGetHideBottom(true));
                  _searchController.clear();
                  _listAllProduct.clear();
                });
              },
              child: const Icon(Icons.close_rounded),
            ),
          ),
          onChanged: (value) {
            _delayInput.run(() {
              if (value.length >= 3) {
                setState(() {
                  BlocProvider.of<ShopdunkBloc>(context).add(
                    RequestGetSearchProductResult(1, value),
                  );
                });
              }
            });
          },
          onFieldSubmitted: (value) {
            _showSearch = false;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(const RequestGetHideBottom(true));
            _searchController.clear();
            if (value.length >= 3) {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => SearchProductsScreen(keySearch: value),
                ),
              )
                  .then((value) {
                setState(() {
                  _showSearch = false;
                  _searchController.clear();
                  _listAllProduct.clear();
                });
              });
            }
          },
          focusNode: _focusNode,
          autofocus: true,
        ),
      ),
    );
  }

  // build search result
  Widget _buildSearchResult() {
    return GestureDetector(
      onTap: () => setState(() {
        _showSearch = false;
        BlocProvider.of<ShopdunkBloc>(context)
            .add(const RequestGetHideBottom(true));
        _searchController.clear();
        _listAllProduct.clear();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: _listAllProduct.length,
          itemBuilder: (context, index) {
            final item = _listAllProduct[index];

            return GestureDetector(
              onTap: () {
                if (index == 7) {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => SearchProductsScreen(
                          keySearch: _searchController.text),
                    ),
                  )
                      .then((value) {
                    setState(() {
                      _showSearch = false;
                      _searchController.clear();
                      _listAllProduct.clear();
                    });
                  });
                } else {
                  Navigator.of(context).push(
                    CustomMaterialPageRoute(
                      builder: (context) => ShopDunkWebView(
                        url: item.seName,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: index == _listAllProduct.length - 1
                      ? null
                      : const Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                  borderRadius: index == _listAllProduct.length - 1
                      ? const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        )
                      : null,
                ),
                child: index == 7
                    ? Text(
                        'Xem tất cả kết quả...',
                        style: CommonStyles.size15W400Grey86(context),
                      )
                    : Row(
                        children: [
                          Image.network(
                            item.defaultPictureModel!.imageUrl.toString(),
                            height: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              item.name ?? '',
                              style: CommonStyles.size15W400Grey86(context),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  // bottom bar
  Widget _buildBottomBar() {
    return Container(
      height: Platform.isIOS ? 76 : 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, -20),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(ListCustom.listBottomBar.length, (index) {
          final item = ListCustom.listBottomBar[index];

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => setState(() => _isSelected = item.id),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                children: [
                  Container(
                    decoration: _isSelected == item.id
                        ? BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff0066CC), width: 2),
                            borderRadius: BorderRadius.circular(8))
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Image.asset(
                          _isSelected == item.id
                              ? item.img.toString()
                              : item.imgUnselect.toString(),
                          color: _isSelected == item.id
                              ? const Color(0xff0066CC)
                              : const Color(0xff86868B),
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          item.name,
                          style: _isSelected == item.id
                              ? CommonStyles.size12W400Grey86(context)
                                  .copyWith(color: const Color(0xff0066CC))
                              : CommonStyles.size12W400Grey86(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

class DelayInput {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  DelayInput({required this.milliseconds, this.action, this.timer, Key? key});

  run(VoidCallback action) {
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
