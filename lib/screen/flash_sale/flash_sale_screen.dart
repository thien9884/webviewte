import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/categories/categories_bloc.dart';
import 'package:webviewtest/blocs/categories/categories_event.dart';
import 'package:webviewtest/blocs/categories/categories_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/category/category_model.dart';
import 'package:webviewtest/model/product/products_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({Key? key}) : super(key: key);

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  var priceFormat = NumberFormat.decimalPattern('vi_VN');
  final TextEditingController _emailController = TextEditingController();

  // Categories
  List<Categories> _listCategories = [];

  List<ProductsModel> _listIphone = [];

  Timer? countdownTimer;
  Duration _timeCountdown = const Duration(hours: 200);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = _timeCountdown.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        _timeCountdown = Duration(seconds: seconds);
      }
    });
  }

  // Sync data
  _getCategories() async {
    BlocProvider.of<CategoriesBloc>(context).add(const RequestGetCategories());
  }

  _getListIphone() async {
    int index =
        _listCategories.indexWhere((element) => element.seName == 'iphone');
    BlocProvider.of<CategoriesBloc>(context)
        .add(RequestGetIphone(idIphone: _listCategories[index].id));
  }

  @override
  void initState() {
    _getCategories();
    // startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<CategoriesBloc, CategoriesState>(
          builder: (context, state) => _buildUI(context),
          listener: (context, state) {
            if (state is CategoriesLoading) {
              EasyLoading.show();
            } else if (state is CategoriesLoaded) {
              _listCategories = state.categories
                  .where((element) => element.showOnHomePage == true)
                  .toList();
              _getListIphone();
              if (EasyLoading.isShow) {
                EasyLoading.dismiss();
              }
            } else if (state is CategoriesLoadError) {
              if (EasyLoading.isShow) {
                EasyLoading.dismiss();
              }
              AlertUtils.displayErrorAlert(context, state.message);
            }

            if (state is IphoneLoading) {
              // EasyLoading.show();
            } else if (state is IphoneLoaded) {
              _listIphone = state.iphone;
              startTimer();
            } else if (state is IphoneLoadError) {
              if (EasyLoading.isShow) {
                EasyLoading.dismiss();
              }
              AlertUtils.displayErrorAlert(context, state.message);
            }
          });

  // flash sale UI
  Widget _buildUI(BuildContext context) {
    return Placeholder(
      color: const Color(0xffF5F5F7),
      child: CustomScrollView(
        slivers: [
          // _bannerSale(),
          _tittleFlashSale(),
          _listFlashSale(_listIphone),
          _receiveInfo(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1, (context, index) => const CommonFooter())),
        ],
      ),
    );
  }

  // banner sale
  Widget _bannerSale() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://shopdunk.com/images/uploaded/banner/banner%20MB%20FLASH%20SALE.jpeg'))),
      ),
    );
  }

  // tittle flash sale
  Widget _tittleFlashSale() {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Flash sale',
              style: CommonStyles.size24W700Black1D(context),
            ),
          ),
        ));
  }

  // list product
  Widget _listFlashSale(List<ProductsModel> listProduct) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(_timeCountdown.inHours);
    final minutes = strDigits(_timeCountdown.inMinutes.remainder(60));
    final seconds = strDigits(_timeCountdown.inSeconds.remainder(60));
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
                      builder: (context) => ShopDunkWebView(
                            url: item.seName,
                          ))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            top: Responsive.isMobile(context) ? 5 : 10,
                            right: Responsive.isMobile(context) ? 5 : 10),
                        child: Image.asset(
                          'assets/images/tet_2023.png',
                          scale: Responsive.isMobile(context) ? 10 : 6,
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        priceFormat.format(
                                            item.productPrice?.priceValue ?? 0),
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
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color(0xfffedb80),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      'Đã bán 0/10 sản phẩm',
                                      style: CommonStyles.size12W400Grey66(
                                          context),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      '$hours:$minutes:$seconds',
                                      style:
                                          CommonStyles.size20W700Black(context),
                                    ),
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
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Responsive.isMobile(context) ? 200 : 300,
          mainAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          crossAxisSpacing: Responsive.isMobile(context) ? 5 : 20,
          childAspectRatio: 0.45,
        ),
      ),
    );
  }

  // receive information
  Widget _receiveInfo() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF2F2F2),
        padding: const EdgeInsets.symmetric(vertical: 40),
        margin: EdgeInsets.only(
          top: 20,
          left: Responsive.isMobile(context) ? 0 : 150,
          right: Responsive.isMobile(context) ? 0 : 150,
        ),
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
}
