import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/categories/categories_bloc.dart';
import 'package:webviewtest/blocs/categories/categories_event.dart';
import 'package:webviewtest/blocs/categories/categories_state.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/model/web_view_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _emailController = TextEditingController();
  var rating = 0.0;
  Timer? _timer;
  int _currentIndex = 0;
  var priceFormat = NumberFormat.decimalPattern('vi_VN');

  // Categories
  List<Categories> _listCategories = [];


  // Sync data
  _getCategories() async {
    BlocProvider.of<CategoriesBloc>(context).add(const RequestGetCategories());
  }

  _getListIpad() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'ipad');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetIpad(idIpad: _listCategories[index].id));
  }

  _getListIphone() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'iphone');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetIphone(idIphone: _listCategories[index].id));
  }

  _getListMac() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'mac');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetMac(idMac: _listCategories[index].id));
  }

  _getListWatch() async {
    int index = _listCategories
        .indexWhere((element) => element.seName == 'apple-watch');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetAppleWatch(idWatch: _listCategories[index].id));
  }

  _getListSound() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'am-thanh');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetSound(idSound: _listCategories[index].id));
  }

  _getListAccessories() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'phu-kien');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetAccessories(idAccessories: _listCategories[index].id));
  }

  _getListProduct() async {
    await _getListIpad();
    await _getListIphone();
    await _getListMac();
    await _getListWatch();
    await _getListSound();
    await _getListAccessories();
  }

  _autoSlidePage() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < ListCustom.listIcon.length + 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  void initState() {
    _getCategories();
    _autoSlidePage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
        builder: (context, state) => _buildHomeUI(context),
        listener: (context, state) {
          if (state is CategoriesLoading) {
            EasyLoading.show();
          } else if (state is CategoriesLoaded) {
            _listCategories = state.categories
                .where((element) => element.showOnHomePage == true)
                .toList();
            _getListProduct();
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
          } else if (state is CategoriesLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is IpadLoading) {
            EasyLoading.show();
          } else if (state is IpadLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'ipad');

            _listCategories[index].listProduct = state.ipad;
          } else if (state is IpadLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is IphoneLoading) {
            EasyLoading.show();
          } else if (state is IphoneLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'iphone');

            _listCategories[index].listProduct = state.iphone;
          } else if (state is IphoneLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is MacLoading) {
            EasyLoading.show();
          } else if (state is MacLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'mac');

            _listCategories[index].listProduct = state.mac;
          } else if (state is MacLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is AppleWatchLoading) {
            EasyLoading.show();
          } else if (state is AppleWatchLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'apple-watch');

            _listCategories[index].listProduct = state.watch;
          } else if (state is AppleWatchLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is SoundLoading) {
            EasyLoading.show();
          } else if (state is SoundLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'am-thanh');

            _listCategories[index].listProduct = state.sound;
          } else if (state is SoundLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }

          if (state is AccessoriesLoading) {
            EasyLoading.show();
          } else if (state is AccessoriesLoaded) {
            int index = _listCategories
                .indexWhere((element) => element.seName == 'phu-kien');

            _listCategories[index].listProduct = state.accessories;

            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
          } else if (state is AccessoriesLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }
        });
  }

  Widget _buildHomeUI(BuildContext context) {
    return Container(
      color: const Color(0xffF5F5F7),
      child: CustomScrollView(
        slivers: <Widget>[
          _topPageView(),
          _topListDeal(),
          _buildCategoriesUI(),
          SliverToBoxAdapter(
            child: Image.asset('assets/images/banner_doanh_nghiep.png'),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Tin Tức',
                    style: CommonStyles.size24W700Black1D(context),
                  ),
                ),
              ),
            ),
          ),
          _listNews(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            sliver: SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/web',
                    arguments:
                        WebViewModel(url: 'https://shopdunk.com/iphone')),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xem tất cả Tin Tức',
                      style: CommonStyles.size14W400Blue00(context),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xff0066CC),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _receiveInfo(),
          _footerShop(),
          _listFooterExpand(),
          _infoShop(),
        ],
      ),
    );
  }

  // page view deal
  Widget _topPageView() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 36),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index % ListCustom.listIcon.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WebViewExample(
                                url: 'iphone',
                              ))),
                      child: ListCustom
                          .listIcon[index % ListCustom.listIcon.length],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          ListCustom.listIcon.length,
                          (index) => Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? const Color(0xff4AB2F1)
                                            .withOpacity(0.7)
                                        : const Color(0xff515154)
                                            .withOpacity(0.7),
                                    shape: BoxShape.circle),
                              )),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  // list deal top view
  _topListDeal() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final item = ListCustom.listNews[index];
            return Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Image.asset(item.img.toString()));
          },
          childCount: ListCustom.listNews.length,
        ),
      ),
    );
  }

  // build categories
  Widget _buildCategoriesUI() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: _listCategories.length,
            (context, index) => Column(
                  children: [
                    _titleProduct(
                      _listCategories[index].name.toString(),
                      _listCategories[index].seName.toString().toLowerCase(),
                    ),
                    CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        _listProduct(_listCategories[index].listProduct ?? []),
                      ],
                    ),
                    _allProduct(
                      _listCategories[index].name.toString(),
                      _listCategories[index].seName.toString().toLowerCase(),
                    ),
                  ],
                )));
  }

  Widget _titleProduct(String nameProduct, String allProduct) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebViewExample(
                url: allProduct,
              ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          nameProduct,
          style: CommonStyles.size24W700Black1D(context),
        ),
      ),
    );
  }

  Widget _listProduct(List<ProductsModel> listProduct) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: listProduct.length,
          (context, index) {
            var item = listProduct[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WebViewExample(
                            url: 'iphone-14-pro-max',
                          ))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        child: Image.asset(
                          'assets/images/tet_2023.png',
                          scale: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset('assets/images/ip_14_pro.png'),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  item.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      CommonStyles.size14W700Black1D(context),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        priceFormat.format(item.price),
                                        style: CommonStyles.size16W700Blue00(
                                            context),
                                      ),
                                      Text(
                                        '₫',
                                        style: CommonStyles.size12W400Blue00(
                                            context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${priceFormat.format(item.oldPrice)}₫',
                                    style:
                                        CommonStyles.size12W400Grey66(context)
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.5,
        ),
      ),
    );
  }

  Widget _allProduct(String nameProduct, String allProduct) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebViewExample(
                        url: allProduct,
                      ))),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff0066CC), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Xem tất cả $nameProduct',
                      style: CommonStyles.size14W400Blue00(context),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xff0066CC),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // list news
  Widget _listNews() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/news_sale.jpeg'),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 20,
                            ),
                            child: Text(
                              'Airpods Pro 2 thay đổi nhỏ ngoại hình, cải tiến lớn tính năng',
                              style: CommonStyles.size16W700Grey33(context),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 20, left: 20),
                            child: Text(
                              '14/12/2022',
                              style: CommonStyles.size13W400Grey86(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
    );
  }

  // receive information
  Widget _receiveInfo() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF2F2F2),
        padding: const EdgeInsets.symmetric(vertical: 40),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              'Đăng ký nhận tin từ ShopDunk',
              style: CommonStyles.size24W700Black1D(context),
            ),
            Text(
              'Thông tin sản phẩm mới nhất và chương trình khuyến mãi',
              style: CommonStyles.size13W400Grey86(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                scale: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  CommonText.footerInfo(context),
                  style: CommonStyles.size15W400WhiteD2(context),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_face.png'),
                  Image.asset('assets/icons/ic_tiktok.png'),
                  Image.asset('assets/icons/ic_zalo.png'),
                  Image.asset('assets/icons/ic_youtube.png'),
                ],
              ),
              // const SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // list expand information
  Widget _listFooterExpand() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: ListCustom.listFooter.length, (context, index) {
      final items = ListCustom.listFooter[index];
      return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          dense: true,
          child: ExpansionTile(
            iconColor: const Color(0xff424245),
            collapsedIconColor: const Color(0xff424245),
            backgroundColor: Colors.black,
            collapsedBackgroundColor: Colors.black,
            title: Container(
              height: 42,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xff424245)))),
              child: Text(
                items.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CommonStyles.size15W400WhiteD2(context),
              ),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 40),
            trailing: const Icon(Icons.keyboard_arrow_down_rounded),
            children: [
              _listItemExpand(items.listExpand),
            ],
          ),
        ),
      );
    }));
  }

  Widget _listItemExpand(List<Resource> listResource) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int childIdx) {
        final item = listResource[childIdx];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebViewExample(
                          baseUrl: item.baseUrl,
                          url: item.linkUrl,
                        ))),
                child: Text(
                  item.name,
                  style: CommonStyles.size13W400Grey86(context),
                ),
              ),
              item.showAddress ? _itemFooterInfo() : const SizedBox(),
            ],
          ),
        );
      },
      itemCount: listResource.length,
    );
  }

  Widget _itemFooterInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: RichText(
              text: TextSpan(
                  text: 'Mua hàng: ',
                  style: CommonStyles.size13W400Grey86(context),
                  children: [
                TextSpan(
                  text: '1900.6626',
                  style: CommonStyles.size16W400Blue00(context),
                )
              ])),
        ),
        Text(
          CommonText.footerNhanh1(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          CommonText.footerNhanh2(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          CommonText.footerNhanh3(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: RichText(
              text: TextSpan(
                  text: 'Doanh nghiệp: ',
                  style: CommonStyles.size13W400Grey86(context),
                  children: [
                TextSpan(
                  text: '0822.688.668',
                  style: CommonStyles.size13W400Blue00(context),
                )
              ])),
        ),
      ],
    );
  }

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
