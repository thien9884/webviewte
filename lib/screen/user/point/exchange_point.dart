import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_bloc.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_event.dart';
import 'package:webviewtest/blocs/exchange_coupon/exchange_state.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/coupon/coupon_model.dart';

class ExchangePointScreen extends StatefulWidget {
  const ExchangePointScreen({Key? key}) : super(key: key);

  @override
  State<ExchangePointScreen> createState() => _ExchangePointScreenState();
}

class _ExchangePointScreenState extends State<ExchangePointScreen> {
  var formatter = NumberFormat.decimalPattern('vi_VN');
  String _messageError = '';
  TotalCoupon _totalCoupon = TotalCoupon();
  CouponModel? _couponModel;
  int _pagesSelected = 0;
  final ScrollController _pageScrollController = ScrollController();
  final dataKey = GlobalKey();

  _getData() {
    BlocProvider.of<ExchangeBloc>(context)
        .add(const RequestGetListCoupon(0, 10));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExchangeBloc, ExchangeState>(
        builder: (context, state) => _exchangePointUI(),
        listener: (context, state) {
          if (state is ExchangePointLoading) {
            EasyLoading.show();
          } else if (state is ExchangePointLoaded) {
            if (_couponModel == null) {
              _couponModel = state.couponModel;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Center(
                    child: Text(
                      _couponModel?.fetchStatus == 'COMPLETED'
                          ? 'Bạn vừa đổi thưởng thành công'
                          : 'Số điểm của bạn không đủ',
                    ),
                  ),
                  titleTextStyle: CommonStyles.size14W700Grey33(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  actionsPadding: EdgeInsets.zero,
                  actionsAlignment: MainAxisAlignment.center,
                  content: _couponModel?.fetchStatus == 'COMPLETED'
                      ? SizedBox(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/img_background_exchange.svg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                            top: 16,
                                            left: 16,
                                            child: SvgPicture.asset(
                                                'assets/icons/ic_logo_point.svg')),
                                        Positioned(
                                          top: 20,
                                          right: 16,
                                          child: Text(
                                            'Giảm ${formatter.format(_couponModel?.value)}VND',
                                            style: CommonStyles.size18W700White(
                                                context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FittedBox(
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/ic_clock.svg'),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Vô thời hạn',
                                                    style: CommonStyles
                                                        .size14W400Black1D(
                                                            context),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/ic_info_circle.svg'),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    'Áp dụng cho đơn hàng từ 2 triệu đồng',
                                                    style: CommonStyles
                                                        .size14W400Black1D(
                                                            context),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/ic_ticket.svg'),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: 'Mã Coupon: ',
                                                        style: CommonStyles
                                                            .size14W400Black1D(
                                                                context),
                                                        children: [
                                                          TextSpan(
                                                            text: _couponModel
                                                                ?.coupon,
                                                            style: CommonStyles
                                                                .size14W700Blue00(
                                                                    context),
                                                          ),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  actions: <Widget>[
                    Column(
                      children: [
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        TextButton(
                          child: Text(
                            'Đồng ý',
                            style: CommonStyles.size14W700Blue00(context),
                          ),
                          onPressed: () {
                            BlocProvider.of<ExchangeBloc>(context)
                                .add(const RequestGetListCoupon(0, 10));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ExchangePointLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
          if (state is ListCouponLoading) {
            EasyLoading.show();
          } else if (state is ListCouponLoaded) {
            _totalCoupon = state.listCoupon ?? TotalCoupon();

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ListCouponLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _exchangePointUI() {
    return CommonNavigateBar(
      index: 2,
      showAppBar: false,
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            const CommonAppbar(title: 'Điểm thưởng'),
            _couponSuggest(),
            _myCoupon(),
            if (_totalCoupon.totalCoupons != null &&
                _totalCoupon.totalCoupons! > 8)
              _pagesNumber(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  // coupon suggest
  Widget _couponSuggest() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _suggestTittle(),
            _suggestItem(),
            _note(),
          ],
        ),
      ),
    );
  }

  // suggest tittle
  Widget _suggestTittle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'Coupon được đề xuất',
        style: CommonStyles.size14W700Black1D(context),
      ),
    );
  }

  // note
  Widget _note() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xffF5FAF2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Lưu ý: Coupon chỉ áp dụng mua hàng trực tuyến tại các chi nhánh của ShopDunk, không áp dụng mua hàng trên Website',
        style: CommonStyles.size14W400Green33(context),
      ),
    );
  }

  // suggest item
  Widget _suggestItem() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SvgPicture.asset(
                  'assets/images/img_background_exchange.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  top: 16,
                  left: 16,
                  child: SvgPicture.asset('assets/icons/ic_logo_point.svg')),
              Positioned(
                top: 20,
                right: 16,
                child: Text(
                  'Giảm ${formatter.format(200000)}VND',
                  style: CommonStyles.size18W700White(context),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_clock.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Vô thời hạn',
                          style: CommonStyles.size14W400Black1D(context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icons/ic_info_circle.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'Áp dụng cho đơn hàng từ 2 triệu đồng\n200.000VND = 20000 điểm thưởng',
                            style: CommonStyles.size14W400Black1D(context),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          color: const Color(0xff0066CC),
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<ExchangeBloc>(context)
                                  .add(const RequestGetExchangePoint(200));
                              setState(() {
                                _couponModel = null;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  'Đổi thưởng',
                                  style: CommonStyles.size14W700White(context),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 12,
                child: Container(
                  height: 24,
                  width: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff4D94DB),
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '2',
                    style: CommonStyles.size13W400Blue4D(context),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // my coupon
  Widget _myCoupon() {
    List<CouponModel> listCoupon = _totalCoupon.coupons ?? [];

    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF5F5F7),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _myCouponTittle(),
            CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: listCoupon.length,
                    (context, index) {
                      final item = listCoupon[index];

                      return _myCouponItem(
                        isActive: item.active ?? false,
                        status: '',
                        value: item.value ?? 0,
                        coupon: item.active != null && item.active!
                            ? item.showCoupon
                                ? (item.coupon ?? '')
                                : '***************'
                            : (item.coupon ?? ''),
                        showEye: item.active == true,
                        onEyeTap: () {
                          setState(() {
                            item.showCoupon = !item.showCoupon;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // pages number
  Widget _pagesNumber() {
    var totalPage = (_totalCoupon.totalCoupons! / 8).ceil();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        color: const Color(0xffF5F5F7),
        child: Center(
          child: SizedBox(
            height: 35,
            width: totalPage > 6 ? double.infinity : 35 * (totalPage + 1) + 25,
            child: Row(
              children: [
                if (totalPage > 6 && _pagesSelected >= 5)
                  GestureDetector(
                    onTap: () {
                      if (_pagesSelected != 0) {
                        setState(() {
                          _pagesSelected = 0;
                          BlocProvider.of<ExchangeBloc>(context)
                              .add(const RequestGetListCoupon(0, 10));
                          _pageScrollController.animateTo(
                            _pageScrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        });
                        Scrollable.ensureVisible(dataKey.currentContext!);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _pageScrollController,
                      itemCount: totalPage,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          _pagesSelected = index;
                          BlocProvider.of<ExchangeBloc>(context)
                              .add(RequestGetListCoupon(index, 10));
                          Scrollable.ensureVisible(dataKey.currentContext!);
                        }),
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: _pagesSelected == index
                                ? Colors.blueAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: _pagesSelected == index
                                ? CommonStyles.size14W400White(context)
                                : CommonStyles.size14W400Black1D(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (totalPage > 6 && _pagesSelected <= totalPage - 5)
                  GestureDetector(
                    onTap: () {
                      if (_totalCoupon.totalCoupons != null &&
                          _pagesSelected != totalPage - 1) {
                        setState(() {
                          _pagesSelected = totalPage - 1;
                          BlocProvider.of<ExchangeBloc>(context)
                              .add(RequestGetListCoupon(totalPage, 10));
                          _pageScrollController.animateTo(
                            _pageScrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        });
                        Scrollable.ensureVisible(dataKey.currentContext!);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // my coupon tittle
  Widget _myCouponTittle() {
    return Padding(
      key: dataKey,
      padding: const EdgeInsets.only(bottom: 8, top: 20),
      child: Text(
        'Coupon bạn đang sở hữu',
        style: CommonStyles.size14W700Black1D(context),
      ),
    );
  }

  // my coupon item
  Widget _myCouponItem({
    required bool isActive,
    required String coupon,
    required int value,
    required bool showEye,
    required VoidCallback onEyeTap,
    String? status,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: isActive
                      ? SvgPicture.asset(
                          'assets/images/img_background_exchange.svg',
                          fit: BoxFit.fill,
                        )
                      : SvgPicture.asset(
                          'assets/images/img_bgec_grey.svg',
                          fit: BoxFit.fill,
                        ),
                ),
                Positioned(
                    top: 16,
                    left: 16,
                    child: SvgPicture.asset('assets/icons/ic_logo_point.svg')),
                Positioned(
                  top: 20,
                  right: 16,
                  child: Text(
                    'Giảm ${formatter.format(value)}VND',
                    style: CommonStyles.size18W700White(context),
                  ),
                ),
                if (!isActive)
                  Positioned(
                    right: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                      child:
                          SvgPicture.asset('assets/images/img_bg_status.svg'),
                    ),
                  ),
              ],
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          isActive
                              ? SvgPicture.asset('assets/icons/ic_clock.svg')
                              : SvgPicture.asset(
                                  'assets/icons/ic_clock_grey.svg'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Vô thời hạn',
                            style: isActive
                                ? CommonStyles.size14W400Black1D(context)
                                : CommonStyles.size14W400Grey86(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isActive
                              ? SvgPicture.asset(
                                  'assets/icons/ic_info_circle.svg')
                              : SvgPicture.asset(
                                  'assets/icons/ic_info_circle_grey.svg'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Áp dụng cho đơn hàng từ 2 triệu đồng',
                            style: isActive
                                ? CommonStyles.size14W400Black1D(context)
                                : CommonStyles.size14W400Grey86(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isActive
                              ? SvgPicture.asset('assets/icons/ic_ticket.svg')
                              : SvgPicture.asset(
                                  'assets/icons/ic_ticket_grey.svg'),
                          const SizedBox(
                            width: 8,
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Mã Coupon: ',
                                style: isActive
                                    ? CommonStyles.size14W400Black1D(context)
                                    : CommonStyles.size14W400Grey86(context),
                                children: [
                                  TextSpan(
                                    text: coupon,
                                    style: isActive
                                        ? CommonStyles.size14W700Blue00(context)
                                        : CommonStyles.size14W400Grey86(
                                            context),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (showEye)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onEyeTap,
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: isActive
                                ? const Color(0xff0066CC).withOpacity(0.2)
                                : const Color(0xffC0C0C0),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: isActive
                            ? SvgPicture.asset('assets/icons/ic_blue_eye.svg')
                            : SvgPicture.asset('assets/icons/ic_grey_eye.svg'),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
