import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:webviewtest/blocs/categories/categories_bloc.dart';
import 'package:webviewtest/blocs/categories/categories_event.dart';
import 'package:webviewtest/blocs/categories/categories_state.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category_model.dart';
import 'package:webviewtest/model/web_view_model.dart';

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

  // Loading flag
  bool _isLoading = false;

  // Posts
  List<Categories> _listCategories = [];

  // Sync data
  _getCategories() async {
    BlocProvider.of<CategoriesBloc>(context).add(const RequestGetCategories());
  }

  _autoSlidePage() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
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
            _isLoading = true;
          } else if (state is CategoriesLoaded) {
            _isLoading = false;
            _listCategories = state.categories
                .where((element) => element.showOnHomePage == true)
                .toList();
          } else if (state is CategoriesLoadError) {
            _isLoading = false;
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
          // // list iPhone
          // _titleProduct('iPhone'),
          // _listProduct(),
          // _allProduct('iPhone'),
          //
          // // list iPad
          // _titleProduct('iPad'),
          // _listProduct(),
          // _allProduct('iPad'),
          //
          // // list Mac
          // _titleProduct('Mac'),
          // _listProduct(),
          // _allProduct('Mac'),
          //
          // // list Watch
          // _titleProduct('Watch'),
          // _listProduct(),
          // _allProduct('Watch'),
          //
          // // list Âm thanh
          // _titleProduct('Âm thanh'),
          // _listProduct(),
          // _allProduct('Âm thanh'),
          //
          // // list Phụ kiện
          // _titleProduct('Phụ kiện'),
          // _listProduct(),
          // _allProduct('Phụ kiện'),
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
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index % ListCustom.listIcon.length;
                });
              },
              itemBuilder: (context, index) {
                return ListCustom.listIcon[index % ListCustom.listIcon.length];
              },
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
                    ),
                    CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        _listProduct(),
                      ],
                    ),
                    _allProduct(
                      _listCategories[index].name.toString(),
                    ),
                  ],
                )));
  }

  Widget _titleProduct(String nameProduct) {
    return Text(
      nameProduct,
      style: CommonStyles.size24W700Black1D(context),
    );
  }

  Widget _listProduct() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: 4,
          (context, index) {
            return Card(
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.asset('assets/images/ip_14_pro.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'iPhone 14 Pro Max 128GB',
                          style: CommonStyles.size14W700Black1D(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: SmoothStarRating(
                            rating: rating,
                            size: 20,
                            starCount: 5,
                            onRated: (value) {
                              setState(() {
                                rating = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          '29.990.000₫',
                          style: CommonStyles.size14W400Blue00(context),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '36.990.000₫',
                          style: CommonStyles.size14W400Grey66(context)
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 0.48,
        ),
      ),
    );
  }

  Widget _allProduct(String nameProduct) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/web',
            arguments: WebViewModel(url: 'https://shopdunk.com/iphone')),
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
              Text(
                item.name,
                style: CommonStyles.size13W400Grey86(context),
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
