import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/flash_sale/flash_sale_screen.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/login/login_screen.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/store/store_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NavigationScreen extends StatefulWidget {
  final int isSelected;

  const NavigationScreen({this.isSelected = 2, Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _isSelected = 2;
  bool _showSearch = false;
  String url = '';
  int a = 0;
  final TextEditingController _searchController =
      TextEditingController(text: '0');

  final pages = [
    const FlashSaleScreen(),
    const NewsScreen(),
    const HomePageScreen(),
    const LoginScreen(),
    const StoreScreen(),
  ];

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (_isSelected != 3) _buildAppbar(),
                  Expanded(child: pages[_isSelected]),
                  _buildBottomBar(),
                ],
              ),
              if (_showSearch == true) _buildSearchUI(context),
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
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Image.asset(
            'assets/icons/ic_sd_white.png',
            scale: Responsive.isMobile(context) ? 4 : 1.5,
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

  // build search UI
  Widget _buildSearchUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showSearch = false;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: CustomScrollView(
          slivers: [
            _buildSearchBar(),
            _buildSearchResult(),
          ],
        ),
      ),
    );
  }

  // build search bar
  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color(0xff515154),
        child: TextField(
          controller: _searchController,
          keyboardType: TextInputType.number,
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
                });
              },
              child: const Icon(Icons.close_rounded),
            ),
          ),
          onChanged: (value) {
            setState(() {
              a = int.parse(value);
            });
          },
        ),
      ),
    );
  }

  // build search result
  Widget _buildSearchResult() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: a,
          (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: index == a - 1
                    ? null
                    : const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                borderRadius: index == a - 1
                    ? const BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      )
                    : null,
              ),
              child: Text(index.toString()),
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
                          width: 30,
                          height: 30,
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
