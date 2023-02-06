import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/home/home_page_screen.dart';
import 'package:webviewtest/screen/user/user_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _isSelected = 0;
  String url = '';

  final pages = [
    const HomePageScreen(),
    const SizedBox(),
    const UserScreen(),
    const SizedBox(),
  ];

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
              _buildAppbar(),
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
                        builder: (context) => WebViewExample(
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

  Widget _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(Icons.menu)),
          ),
          SvgPicture.asset('assets/icons/ic_logo_home_page.svg'),
          SvgPicture.asset('assets/icons/ic_search_home.svg'),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(ListCustom.listBottomBar.length, (index) {
          final item = ListCustom.listBottomBar[index];
          return GestureDetector(
            onTap: () => setState(() => _isSelected = item.id),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  SvgPicture.asset(
                    _isSelected == item.id
                        ? item.img.toString()
                        : item.imgUnselect.toString(),
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
