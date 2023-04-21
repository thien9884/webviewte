import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/search_products/search_products_bloc.dart';
import 'package:webviewtest/blocs/search_products/search_products_event.dart';
import 'package:webviewtest/blocs/search_products/search_products_state.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/search_products/search_products.dart';
import 'package:webviewtest/screen/store/store_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NavigationScreen extends StatefulWidget {
  final int isSelected;

  const NavigationScreen({this.isSelected = 1, Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _isSelected = 1;
  String url = '';
  final TextEditingController _searchController = TextEditingController();
  List<ProductsModel> _listAllProduct = [];
  final _delayInput = DelayInput(milliseconds: 1000);
  bool _showSearch = false;
  bool _showDrawer = false;
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
    const NewsScreen(),
    const HomePageScreen(),
    // const LoginScreen(),
    const StoreScreen(),
  ];

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchProductsBloc, SearchProductsState>(
        builder: (context, state) => _buildNavigationUI(),
        listener: (context, state) {
          if (state is SearchProductsLoading) {
          } else if (state is SearchProductsLoaded) {
            setState(() {
              _listAllProduct = state.catalogProductsModel.products ?? [];
            });
          } else if (state is SearchProductsLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
          }
        });
  }

  // buildNavigation
  Widget _buildNavigationUI() {
    return Scaffold(
      key: _key,
      drawer: _buildDrawer(),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildAppbar(),
                  Expanded(
                    child: Stack(
                      children: [
                        pages[_isSelected],
                        _buildDrawerUI(),
                      ],
                    ),
                  ),
                  _buildBottomBar(),
                ],
              ),
              if (_showSearch) _buildSearchUI(),
            ],
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
        height: MediaQuery.of(context).size.height * 0.4,
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
      ),
    );
  }

  // build search UI
  Widget _buildSearchUI() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSearch = false;
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
              }),
              child: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isSelected = 1),
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
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // build search bar
  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => setState(() {
        _showSearch = false;
        _searchController.clear();
        _listAllProduct.clear();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color(0xff515154),
        child: TextField(
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
                  BlocProvider.of<SearchProductsBloc>(context).add(
                    RequestGetSearchProductResult(1, value),
                  );
                });
              }
            });
          },
          onSubmitted: (value) {
            _showSearch = false;
            _searchController.clear();
            if (value.length >= 3) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchProductsScreen(keySearch: value),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // build search result
  Widget _buildSearchResult() {
    return GestureDetector(
      onTap: () => setState(() {
        _showSearch = false;
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
                  _showSearch = false;
                  _searchController.clear();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchProductsScreen(
                          keySearch: _searchController.text),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
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

  // drawer
  Widget _buildDrawer() {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 80, left: 20, bottom: 40),
              alignment: Alignment.centerLeft,
              color: Colors.grey,
              child: Image.asset('assets/icons/ic_sd_white.png', scale: 4),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: ListCustom.listDrawers.length,
                  itemBuilder: (context, index) {
                    final item = ListCustom.listDrawers[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShopDunkWebView(
                            url: item.linkUrl,
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffEBEBEB)))),
                        child: Row(
                          children: [
                            Image.asset(
                              item.img.toString(),
                              scale: 0.8,
                            ),
                            Text(
                              item.name,
                              style: CommonStyles.size14W400Black1D(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  // bottom bar
  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
                            border: Border.all(color: Colors.blue, width: 2),
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
