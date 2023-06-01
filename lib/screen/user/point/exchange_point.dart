import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class ExchangePointScreen extends StatefulWidget {
  const ExchangePointScreen({Key? key}) : super(key: key);

  @override
  State<ExchangePointScreen> createState() => _ExchangePointScreenState();
}

class _ExchangePointScreenState extends State<ExchangePointScreen> {
  var formatter = NumberFormat.decimalPattern('vi_VN');

  @override
  Widget build(BuildContext context) {
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
                  'Giảm ${formatter.format(500000)}VND',
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
                        SvgPicture.asset('assets/icons/ic_clock.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'Áp dụng cho đơn hàng từ 2 triệu đồng\n500.000VND = 500 điểm thưởng',
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
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        title: Text(
                                          'Bạn vừa đổi thưởng thành công',
                                          style: CommonStyles.size14W700Grey33(
                                              context),
                                        ),
                                        content: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
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
                                                        'Giảm ${formatter.format(500000)}VND',
                                                        style: CommonStyles
                                                            .size18W700White(
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
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
                                                                CrossAxisAlignment
                                                                    .start,
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
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/icons/ic_ticket.svg'),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              RichText(
                                                                text: TextSpan(
                                                                    text:
                                                                        'Mã Coupon: ',
                                                                    style: CommonStyles
                                                                        .size14W400Black1D(
                                                                            context),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'KM200AB0YF6D8JL',
                                                                        style: CommonStyles.size14W700Blue00(
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
                                        actions: [
                                          CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Đồng ý',
                                                style: CommonStyles
                                                    .size14W700Blue007A(
                                                        context),
                                              ))
                                        ],
                                      ));
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
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF5F5F7),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _myCouponTittle(),
            Column(
              children: List.generate(
                4,
                (index) {
                  return _myCouponItem(
                    isActive: index == 0,
                    status: index == 1 ? 'Đã sử dụng' : 'Vô hiệu hoá',
                    coupon: index != 1 || index == 0
                        ? '***************'
                        : 'KM200AB0YF6D8JL',
                    showEye: index == 1 ? false : true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // my coupon tittle
  Widget _myCouponTittle() {
    return Padding(
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
    required bool showEye,
    String? status,
  }) {
    return Card(
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
                  'Giảm ${formatter.format(500000)}VND',
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
                    child: status == 'Đã sử dụng'
                        ? SvgPicture.asset('assets/images/img_bg_status.svg')
                        : SvgPicture.asset('assets/images/img_bg_disable.svg'),
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
                                      : CommonStyles.size14W400Grey86(context),
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
                    onTap: () {
                      setState(() {});
                    },
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
    );
  }
}
