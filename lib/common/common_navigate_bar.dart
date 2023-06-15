import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/screen/news/news_category.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/search_products/search_products.dart';
import 'package:webviewtest/screen/store/store_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class CommonNavigateBar extends StatefulWidget {
  final Widget child;
  final int index;
  final bool isLogin;
  final bool showNavigation;
  final bool showAppBar;

  const CommonNavigateBar({
    required this.child,
    this.index = 1,
    this.isLogin = false,
    this.showNavigation = true,
    this.showAppBar = true,
    Key? key,
  }) : super(key: key);

  @override
  State<CommonNavigateBar> createState() => _CommonNavigateBarState();
}

class _CommonNavigateBarState extends State<CommonNavigateBar>
    with TickerProviderStateMixin {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();
  List<ProductsModel> _listAllProduct = [];
  final FocusNode _focusNode = FocusNode();

  // Categories
  List<Categories> _listCategories = [];
  final _delayInput = DelayInput(milliseconds: 1000);
  bool _showDrawer = false;
  bool _isVisible = true;
  bool _isLogin = false;
  bool _accountExpand = false;
  NewsGroup _newsGroup = NewsGroup();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 500),
    vsync: this,
  );
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

  _getListNavigationBar() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    final rememberMe = sPref.rememberMe;

    _listCategories = Categories.decode(sPref.listCategories);
    _newsGroup = NewsGroup.decode(sPref.listNewsGroup)
        .lastWhere((element) => element.id == 1);
    if (rememberMe) {
      _isLogin = rememberMe;
    } else {
      _isLogin = widget.isLogin;
    }
    setState(() {});
  }

  @override
  void initState() {
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
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _commonNavigatorUI(),
        listener: (context, state) {
          if (state is SearchProductsLoading) {
          } else if (state is SearchProductsLoaded) {
            _listAllProduct = state.catalogProductsModel.products ?? [];
          } else if (state is SearchProductsLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
          } else if (state is HideBottomSuccess) {
            _isVisible = state.isHide;
          }
        });
  }

  // common navigator ui
  Widget _commonNavigatorUI() {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F7),
        appBar: widget.showNavigation && widget.showAppBar
            ? AppBar(
                backgroundColor: const Color(0xff515154),
                elevation: 0,
                title: Text(
                  widget.index == 0
                      ? 'Trang chủ'
                      : widget.index == 1
                          ? 'Tin tức'
                          : widget.index == 2
                              ? 'Tài khoản'
                              : widget.index == 3
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
              )
            : null,
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
        body: Stack(
          children: [
            Column(
              children: [
                if (widget.showNavigation && widget.showAppBar)
                  if (widget.index == 0) _buildCategoryBar(),
                Expanded(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          BlocProvider.of<ShopdunkBloc>(context)
                              .add(const RequestGetHideBottom(true));
                        },
                        child: widget.child,
                      ),
                      _buildDrawerUI(),
                    ],
                  ),
                ),
                if (widget.showNavigation)
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: _isVisible ? 65 : 0,
                      child: _isVisible
                          ? SingleChildScrollView(
                              child: _buildBottomBar(),
                            )
                          : Container()),
              ],
            ),
            if (_showSearch) _buildSearchUI(),
          ],
        ),
      ),
    );
  }

  // build drawer UI
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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NavigationScreen(
                  isSelected: 0,
                ),
              ),
            ),
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
                  _showSearch = false;
                  BlocProvider.of<ShopdunkBloc>(context)
                      .add(const RequestGetHideBottom(true));
                  _searchController.clear();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchProductsScreen(
                        keySearch: _searchController.text,
                      ),
                    ),
                  );
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
      height: 65,
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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  isSelected: item.id,
                ),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Column(
                children: [
                  Container(
                    decoration: widget.index == item.id
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
                          widget.index == item.id
                              ? item.img.toString()
                              : item.imgUnselect.toString(),
                          color: widget.index == item.id
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
                          style: widget.index == item.id
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
