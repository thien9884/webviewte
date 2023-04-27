import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/category/category_screen.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/screen/news/news_category.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/search_products/search_products.dart';
import 'package:webviewtest/screen/store/store_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class CommonNavigateBar extends StatefulWidget {
  final Widget child;
  final int index;
  final bool showAppBar;

  const CommonNavigateBar({
    required this.child,
    this.index = 1,
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

  // Categories
  List<Categories> _listCategories = [];
  final _delayInput = DelayInput(milliseconds: 1000);
  bool _showDrawer = false;
  bool _isVisible = true;
  NewsGroup _newsGroup = NewsGroup();
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

  // Sync data
  _getCategories() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetCategories());
  }

  // Sync data
  _getNews() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetNews());
  }

  @override
  void initState() {
    _getCategories();
    _getNews();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _commonNavigatorUI(),
        listener: (context, state) {
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
          } else if (state is CategoriesLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
          } else if (state is SearchProductsLoading) {
          } else if (state is SearchProductsLoaded) {
            _listAllProduct = state.catalogProductsModel.products ?? [];
          } else if (state is SearchProductsLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
          } else if (state is HideBottomSuccess) {
            _isVisible = state.isHide;
          }

          if (state is NewsLoading) {
          } else if (state is NewsLoaded) {
            _newsGroup = state.newsData.newsGroup!
                .lastWhere((element) => element.id == 1);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is NewsLoadError) {
            if (EasyLoading.isShow) EasyLoading.dismiss();

            AlertUtils.displayErrorAlert(context, state.message);
          }
        });
  }

  // common navigator ui
  Widget _commonNavigatorUI() {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                if (widget.showAppBar) _buildAppbar(),
                if (widget.showAppBar) _buildCategoryBar(),
                Expanded(
                  child: Stack(
                    children: [
                      widget.child,
                      _buildDrawerUI(),
                    ],
                  ),
                ),
                if (widget.showAppBar)
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
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => const RegisterScreen()));
              //   },
              //   child: Container(
              //     height: 56,
              //     alignment: Alignment.centerLeft,
              //     decoration: BoxDecoration(
              //         border: Border(
              //             bottom: BorderSide(
              //                 width: 1, color: Colors.grey.withOpacity(0.5)))),
              //     child: Text(
              //       'Tạo tài khoản ngay',
              //       style: CommonStyles.size15W400Black1D(context),
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => const LoginScreen()));
              //   },
              //   child: Container(
              //     height: 56,
              //     alignment: Alignment.centerLeft,
              //     decoration: BoxDecoration(
              //         border: Border(
              //             bottom: BorderSide(
              //                 width: 1, color: Colors.grey.withOpacity(0.5)))),
              //     child: Text(
              //       'Đăng nhập',
              //       style: CommonStyles.size15W400Black1D(context),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  final cIndex = _listCategories
                      .indexWhere((element) => element.seName == 'phu-kien');

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
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Colors.grey.withOpacity(0.5)))),
                  child: Text(
                    'Phụ kiện',
                    style: CommonStyles.size15W400Black1D(context),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NewsCategory(newsGroup: _newsGroup)));
                },
                child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Khuyến mãi',
                    style: CommonStyles.size15W400Black1D(context),
                  ),
                ),
              ),
            ],
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
                  isSelected: 1,
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
              color: Colors.white,
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
                  BlocProvider.of<ShopdunkBloc>(context).add(
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
