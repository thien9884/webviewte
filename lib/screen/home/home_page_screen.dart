import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/custom_material_page_route.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/news/news_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/category/category_screen.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

TopBanner payloadFromJson(String str) => TopBanner.fromJson(json.decode(str));

String payloadToJson(TopBanner data) => json.encode(data.toJson());

class TopBanner {
  final String? link;
  final String? img;

  TopBanner({
    this.link,
    this.img,
  });

  factory TopBanner.fromJson(Map<String, dynamic> json) => TopBanner(
        link: json["link"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "img": img,
      };

  static List<TopBanner> decode(String banner) =>
      (json.decode(banner) as List<dynamic>)
          .map<TopBanner>((item) => TopBanner.fromJson(item))
          .toList();
}

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  var rating = 0.0;
  Timer? _timer;
  int _currentIndex = 0;
  var priceFormat = NumberFormat.decimalPattern('vi_VN');
  List<LatestNews> _latestNews = [];
  List<TopBanner> _listTopBannerImg = [];

  List<TopBanner> _listHomeBannerImg = [];

  // Categories
  List<Categories> _listCategories = [];

  _autoSlidePage() {
    if (_listTopBannerImg.isNotEmpty) {
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
  }

  late ScrollController _hideButtonController;

  bool _isVisible = false;

  _getHideBottomValue() {
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(RequestGetHideBottom(_isVisible));
          });
        }
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(RequestGetHideBottom(_isVisible));
          });
        }
      }
    });
  }

  _getListHomeScreen() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    List<ProductsModel> listIpad = [];
    List<ProductsModel> listIphone = [];
    List<ProductsModel> listMac = [];
    List<ProductsModel> listAppleWatch = [];
    List<ProductsModel> listSound = [];
    List<ProductsModel> listAccessories = [];

    listIpad = ProductsModel.decode(sPref.listIpad);
    listIphone = ProductsModel.decode(sPref.listIphone);
    listMac = ProductsModel.decode(sPref.listMac);
    listAppleWatch = ProductsModel.decode(sPref.listAppleWatch);
    listSound = ProductsModel.decode(sPref.listSound);
    listAccessories = ProductsModel.decode(sPref.listAccessories);
    _listCategories = Categories.decode(sPref.listCategories);
    _latestNews = LatestNews.decode(sPref.listLatestNews);
    _listTopBannerImg = TopBanner.decode(sPref.listTopBanner);
    _listHomeBannerImg = TopBanner.decode(sPref.listHomeBanner);

    if (_listCategories.isNotEmpty) {
      int indexIpad =
          _listCategories.indexWhere((element) => element.seName == 'ipad');
      int indexIphone =
          _listCategories.indexWhere((element) => element.seName == 'iphone');
      int indexMac =
          _listCategories.indexWhere((element) => element.seName == 'mac');
      int indexAppleWatch = _listCategories
          .indexWhere((element) => element.seName == 'apple-watch');
      int indexSound =
          _listCategories.indexWhere((element) => element.seName == 'am-thanh');
      int indexAccessories =
          _listCategories.indexWhere((element) => element.seName == 'phu-kien');

      _listCategories[indexIpad].listProduct = listIpad;
      _listCategories[indexIphone].listProduct = listIphone;
      _listCategories[indexMac].listProduct = listMac;
      _listCategories[indexAppleWatch].listProduct = listAppleWatch;
      _listCategories[indexSound].listProduct = listSound;
      _listCategories[indexAccessories].listProduct = listAccessories;
    }
    setState(() {});
  }

  @override
  void initState() {
    _getListHomeScreen();
    _autoSlidePage();
    _getHideBottomValue();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _buildHomeUI(context),
        listener: (context, state) {});
  }

  // home UI
  Widget _buildHomeUI(BuildContext context) {
    return _listTopBannerImg.isEmpty &&
            _listHomeBannerImg.isEmpty &&
            _listCategories.isEmpty
        ? Container()
        : Container(
            color: const Color(0xffF5F5F7),
            child: Stack(
              children: [
                CustomScrollView(
                  controller: _hideButtonController,
                  slivers: <Widget>[
                    if (_listTopBannerImg.isNotEmpty) _topPageView(),
                    _topListDeal(),
                    _buildCategoriesUI(),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(CustomMaterialPageRoute(
                                builder: (context) => const ShopDunkWebView(
                                      baseUrl:
                                          'https://doanhnghiep.shopdunk.com/',
                                    ))),
                        child: Image.asset(
                          'assets/images/banner_doanh_nghiep.png',
                          scale: 0.5,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 35, bottom: 15),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            'Tin Tức',
                            style: CommonStyles.size24W700Black1D(context),
                          ),
                        ),
                      ),
                    ),
                    _listNews(),
                    _allNews(),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: 1,
                            (context, index) => const CommonFooter())),
                  ],
                ),
              ],
            ),
          );
  }

  // page view deal
  Widget _topPageView() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index % _listTopBannerImg.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item =
                        _listTopBannerImg[index % _listTopBannerImg.length];

                    return GestureDetector(
                      onTap: () =>
                          Navigator.of(context).push(CustomMaterialPageRoute(
                              builder: (context) => ShopDunkWebView(
                                    baseUrl: item.link,
                                  ))),
                      child: SizedBox(
                        child: Image.network(
                          item.img ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          _listTopBannerImg.length,
                          (index) => Container(
                                height: Responsive.isMobile(context) ? 10 : 15,
                                width: Responsive.isMobile(context) ? 10 : 15,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: _currentIndex == index
                                        ? const Color(0xff4AB2F1)
                                            .withOpacity(0.5)
                                        : const Color(0xff515154)
                                            .withOpacity(0.5),
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
            final item = _listHomeBannerImg[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(CustomMaterialPageRoute(
                  builder: (context) => ShopDunkWebView(
                        baseUrl: item.link,
                      ))),
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Image.network(item.img ?? ''),
              ),
            );
          },
          childCount: _listHomeBannerImg.length,
        ),
      ),
    );
  }

  // build shopdunk UI
  Widget _buildCategoriesUI() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: _listCategories.length,
            (context, index) {
      final item = _listCategories[index];
      final cIndex =
          _listCategories.indexWhere((element) => element.seName == 'phu-kien');
      return Column(
        children: [
          _titleProduct(
            item.name ?? '',
            item.description ?? '',
            _listCategories[cIndex].description ?? '',
            item.seName ?? '',
            item.id,
          ),
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              _listProduct(
                item.listProduct ?? [],
              ),
            ],
          ),
          _allProduct(
            item.name ?? '',
            item.description ?? '',
            _listCategories[cIndex].description ?? '',
            item.seName ?? '',
            item.id,
          ),
        ],
      );
    }));
  }

  // title product
  Widget _titleProduct(
    String nameProduct,
    String desc,
    String descAccessories,
    String seName,
    int? groupId,
  ) {
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: false).push(
        MaterialPageRoute(
          builder: (context) => CategoryScreen(
            title: nameProduct,
            desc: desc,
            descAccessories: descAccessories,
            seName: seName,
            groupId: groupId,
          ),
          maintainState: false,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          nameProduct,
          style: CommonStyles.size24W700Black1D(context),
        ),
      ),
    );
  }

  // list product
  Widget _listProduct(List<ProductsModel> listProduct) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: listProduct.length,
          (context, index) {
            var item = listProduct[index];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                CustomMaterialPageRoute(
                  builder: (context) => ShopDunkWebView(
                    url: item.seName,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          top: Responsive.isMobile(context) ? 5 : 10,
                          right: Responsive.isMobile(context) ? 5 : 10),
                      child: item.productTags!.isNotEmpty
                          ? Image.network(
                              "https://api.shopdunk.com/images/uploaded/icon/${item.productTags?.first.seName}.png",
                              height: 25,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(
                              height: 25,
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Responsive.isMobile(context) ? 10 : 20),
                      child: Image.network(
                          item.defaultPictureModel?.imageUrl ?? ''),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                item.name ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CommonStyles.size14W700Black1D(context)
                                    .copyWith(
                                  wordSpacing: 1.5,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      '${priceFormat.format(item.productPrice?.priceValue ?? 0)}₫',
                                      style: CommonStyles.size13W700Blue00(
                                          context),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      '${priceFormat.format(item.productPrice?.oldPriceValue ?? item.productPrice?.priceValue)}₫',
                                      style:
                                          CommonStyles.size11W400Grey86(context)
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Responsive.isMobile(context) ? 200 : 300,
          mainAxisSpacing: Responsive.isMobile(context) ? 10 : 20,
          crossAxisSpacing: Responsive.isMobile(context) ? 10 : 20,
          childAspectRatio: 0.53,
        ),
      ),
    );
  }

  // all product
  Widget _allProduct(
    String nameProduct,
    String desc,
    String descAccessories,
    String seName,
    int? groupId,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.of(context, rootNavigator: false)
                  .push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            title: nameProduct,
                            desc: desc,
                            descAccessories: descAccessories,
                            seName: seName,
                            groupId: groupId,
                          ),
                      maintainState: false)),
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
          delegate: SliverChildBuilderDelegate(childCount: _latestNews.length,
              (context, index) {
        final item = _latestNews[index];
        final timeUpload = DateTime.parse(item.createdOn ?? '');
        final timeFormat = DateFormat("dd/MM/yyyy").format(timeUpload);

        return GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  item.pictureModel?.fullSizeImageUrl != null
                      ? Image.network(
                          item.pictureModel?.fullSizeImageUrl ?? '',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          height: 80,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CommonStyles.size16W700Grey33(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          timeFormat,
                          style: CommonStyles.size13W400Grey86(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }

  // all news
  Widget _allNews() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NavigationScreen(
                isSelected: 0,
              ),
            ),
          ),
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
    );
  }
}
