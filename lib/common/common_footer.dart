import 'package:flutter/material.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/screen/load_html/load_html_screen.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class Footer {
  String? name;
  bool expand;
  List<Topics>? listFooter;

  Footer({
    this.name,
    this.expand = false,
    this.listFooter,
  });
}

class CommonFooter extends StatefulWidget {
  const CommonFooter({Key? key}) : super(key: key);

  @override
  State<CommonFooter> createState() => _CommonFooterState();
}

class _CommonFooterState extends State<CommonFooter> {
  final List<Footer> _listFooter = [];
  List<Topics> _listTopics = [];
  final TextEditingController _emailController = TextEditingController();

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

  @override
  void initState() {
    _getListTopics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xffF2F2F2),
          padding: const EdgeInsets.only(top: 60, bottom: 40),
          margin: EdgeInsets.only(
            left: Responsive.isMobile(context) ? 0 : 150,
            right: Responsive.isMobile(context) ? 0 : 150,
          ),
          child: Column(
            children: [
              Text(
                'Đăng ký nhận tin từ ShopDunk',
                style: CommonStyles.size24W700Black1D(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'Thông tin sản phẩm mới nhất và chương trình khuyến mãi',
                  style: CommonStyles.size13W400Grey86(context),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email của bạn',
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      suffixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: const Color(0xff0066CC),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Đăng ký',
                              style: CommonStyles.size12W400White(context),
                            ),
                          ],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black,
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              _footerShop(),
              _listFooterExpand(),
              _infoShop(),
            ],
          ),
        ),
      ],
    );
  }

  // footer web
  Widget _footerShop() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/ic_sd_white.png',
                scale: Responsive.isMobile(context) ? 3 : 1.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  CommonText.footerInfo(context),
                  style: CommonStyles.size15W400WhiteD2(context),
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets/icons/ic_face.png',
                      scale: Responsive.isMobile(context) ? 1 : 0.6,
                    ),
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => const ShopDunkWebView(
                    //             hideBottom: false,
                    //             baseUrl:
                    //                 'https://www.tiktok.com/@shopdunk_apple',
                    //           )));
                    // },
                    child: Image.asset(
                      'assets/icons/ic_tiktok.png',
                      scale: Responsive.isMobile(context) ? 1 : 0.6,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/ic_zalo.png',
                    scale: Responsive.isMobile(context) ? 1 : 0.6,
                  ),
                  Image.asset(
                    'assets/icons/ic_youtube.png',
                    scale: Responsive.isMobile(context) ? 1 : 0.6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // list footer expand information
  Widget _listFooterExpand() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: _listFooter.length,
            (context, index) {
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xff424245)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      items.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: CommonStyles.size15W400WhiteD2(context),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Color(0xff424245),
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: items.expand ? 40 * items.listFooter!.length.toDouble() : 0,
            child: items.expand
                ? CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                                childCount: items.listFooter?.length,
                                (context, i) {
                          final item = items.listFooter![i];

                          return GestureDetector(
                            onTap: () {
                              if (item.title.toString().toLowerCase() ==
                                  'hệ thống cửa hàng') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationScreen(
                                          isSelected: 3,
                                        )));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        LoadHtmlScreen(data: item.body ?? '')));
                              }
                            },
                            child: Container(
                              height: 40,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyles.size13W400Grey86(context),
                              ),
                            ),
                          );
                        })),
                      ])
                : const SizedBox(),
          ),
        ],
      );
    }));
  }

  // Widget _listFooterExpand() {
  //   return SliverList(
  //       delegate: SliverChildBuilderDelegate(childCount: _listFooter.length,
  //           (context, index) {
  //     final items = _listFooter[index];
  //     return Theme(
  //       data: ThemeData().copyWith(dividerColor: Colors.transparent),
  //       child: ListTileTheme(
  //         dense: true,
  //         child: ExpansionTile(
  //           iconColor: const Color(0xff424245),
  //           collapsedIconColor: const Color(0xff424245),
  //           backgroundColor: Colors.black,
  //           collapsedBackgroundColor: Colors.black,
  //           title: Container(
  //             height: 42,
  //             alignment: Alignment.centerLeft,
  //             decoration: const BoxDecoration(
  //                 border: Border(
  //                     bottom: BorderSide(width: 1, color: Color(0xff424245)))),
  //             child: Text(
  //               items.name ?? '',
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //               style: CommonStyles.size15W400WhiteD2(context),
  //             ),
  //           ),
  //           childrenPadding: const EdgeInsets.symmetric(horizontal: 40),
  //           trailing: Padding(
  //             padding: const EdgeInsets.only(top: 25),
  //             child: const Icon(Icons.keyboard_arrow_down_rounded),
  //           ),
  //           children: [
  //             _listItemExpand(items.listFooter ?? []),
  //           ],
  //         ),
  //       ),
  //     );
  //   }));
  // }

  // info shop
  Widget _infoShop() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CommonText.footerGPKD(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              CommonText.footerAddress(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              CommonText.footerLaw(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
