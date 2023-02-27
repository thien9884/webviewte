import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/flip_widget.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/news/news_screen.dart';
import 'package:webviewtest/screen/store/store_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NavigationScreen extends StatefulWidget {
  final int isSelected;

  const NavigationScreen({this.isSelected = 0, Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _isSelected = 0;
  String url = '';

  final pages = [
    const HomePageScreen(),
    const NewsScreen(),
    const ShopDunkWebView(
      key: Key('info'),
      url: 'customer/info',
      hideBottom: false,
    ),
    const ShopDunkWebView(
      key: Key('store'),
      url: 'he-thong-cua-hang',
      hideBottom: false,
    ),
    // const StoreScreen(),
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
          child: Column(
            children: [
              Expanded(child: pages[_isSelected]),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, left: 20),
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset('assets/icons/ic_logo_home_page.svg'),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: ListCustom.listDrawers.length,
                itemBuilder: (context, index) {
                  final item = ListCustom.listDrawers[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShopDunkWebView(
                              url: item.linkUrl,
                            ))),
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
    );
  }

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
                        SvgPicture.asset(_isSelected == item.id
                            ? item.img.toString()
                            : item.imgUnselect.toString()),
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
