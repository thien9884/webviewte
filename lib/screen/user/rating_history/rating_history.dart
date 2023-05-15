import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/model/customer/rating_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class RatingHistory extends StatefulWidget {
  const RatingHistory({Key? key}) : super(key: key);

  @override
  State<RatingHistory> createState() => _RatingHistoryState();
}

class _RatingHistoryState extends State<RatingHistory> {
  List<RatingModel> _listRatingHistory = [];
  List<ProductHistory> _productsModel = [];
  int _customerId = 0;
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

  _getOrderData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _customerId = sPref.customerId;
    print(_customerId);

    if (context.mounted) {
      BlocProvider.of<CustomerBloc>(context)
          .add(RequestGetRatingHistory(_customerId));
    }
  }

  @override
  void initState() {
    _getOrderData();
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
        builder: (context, state) => _orderUI(),
        listener: (context, state) {
          if (state is RatingHistoryLoading) {
            EasyLoading.show();
          } else if (state is RatingHistoryLoaded) {
            _listRatingHistory = state.listRatingModel ?? [];

            for (var element in _listRatingHistory) {
              BlocProvider.of<CustomerBloc>(context)
                  .add(RequestGetProductRating(element.productId));
            }

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is RatingHistoryLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is ProductRatingLoading) {
            EasyLoading.show();
          } else if (state is ProductRatingLoaded) {
            _productsModel.add(state.productsModel.first);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ProductRatingLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _orderUI() {
    return CommonNavigateBar(
        index: 2,
        child: CustomScrollView(
          controller: _hideButtonController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Lịch sử đánh giá sản phẩm',
                    style: CommonStyles.size24W400Black1D(context),
                  ),
                ),
              ),
            ),
            _listRatingHistory.isNotEmpty
                ? _orderInfo()
                : SliverToBoxAdapter(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                        child: Text(
                          'Bạn chưa có bài đánh giá nào',
                          style: CommonStyles.size14W400Black1D(context),
                        ),
                      ),
                    ),
                  ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ));
  }

  Widget _orderInfo() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: _listRatingHistory.length, (context, index) {
        final item = _listRatingHistory[index];
        var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
            .parseUTC(item.createdOnUtc ?? '')
            .toLocal();
        String formattedDate =
            DateFormat("dd/MM/yyyy").add_jm().format(dateValue);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.reviewText ?? '',
                  style: CommonStyles.size14W400Black1D(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar(
                        initialRating: (item.rating ?? 0).toDouble(),
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xfffeb700),
                          ),
                          half: const Icon(
                            Icons.star_half_rounded,
                            color: Color(0xfffeb700),
                          ),
                          empty: const Icon(
                            Icons.star_border_rounded,
                            color: Color(0xfffeb700),
                          ),
                        ),
                        itemSize: 25,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                        onRatingUpdate: (rating) {},
                        updateOnDrag: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.network(
                            'https://shopdunk.com/images/uploaded-source/icon/Ellipse%20169.png'),
                      ),
                      Text(
                        formattedDate,
                        style: CommonStyles.size13W400Grey88(context),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        'Đánh giá sản phẩm:',
                        style: CommonStyles.size13W400Grey88(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShopDunkWebView(
                                      url: item.productsModel?.seName ?? '',
                                    ))),
                        child: Text(
                          item.productsModel?.name ?? '',
                          style: CommonStyles.size14W700Blue00(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
