import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/order/order_bloc.dart';
import 'package:webviewtest/blocs/order/order_event.dart';
import 'package:webviewtest/blocs/order/order_state.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/order/order_model.dart';
import 'package:webviewtest/screen/user/account_order/order_info.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class AccountOrder extends StatefulWidget {
  const AccountOrder({Key? key}) : super(key: key);

  @override
  State<AccountOrder> createState() => _AccountOrderState();
}

class _AccountOrderState extends State<AccountOrder> {
  List<Orders>? _listOrders = [];
  int _customerId = 0;

  _getOrderData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _customerId = sPref.customerId;
    print(_customerId);

    if (context.mounted) {
      BlocProvider.of<OrderBloc>(context).add(RequestGetOrder(_customerId));
    }
  }

  @override
  void initState() {
    _getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
        builder: (context, state) => _orderUI(),
        listener: (context, state) {
          if (state is OrderLoading) {
            EasyLoading.show();
          } else if (state is OrderLoaded) {
            _listOrders = state.orderModel?.orders?.reversed.toList();
            print(_listOrders);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is OrderLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _orderUI() {
    return CommonNavigateBar(
        child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Đơn đặt hàng',
                style: CommonStyles.size24W400Black1D(context),
              ),
            ),
          ),
        ),
        _orderInfo(),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 1,
                    (context, index) => const CommonFooter())),
      ],
    ));
  }

  Widget _orderInfo() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: _listOrders?.length,
              (context, index) {
        final item = _listOrders![index];
        var priceFormat = NumberFormat.decimalPattern('vi_VN');

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderInfo(
                      orders: item,
                    )));
          },
          child: Container(
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
                  _itemStatus(item.orderStatus ?? ''),
                  _infoValue(title: 'Mã đơn hàng', id: item.id ?? 0),
                  _infoValue(title: 'Ngày đặt hàng', value: item.createdOnUtc),
                  _infoValue(
                      title: 'Tổng tiền',
                      value: '${priceFormat.format(item.orderTotal ?? 0)}₫'),
                  _viewInfo(),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }

  Widget _itemStatus(String value) {
    switch (value) {
      case 'Complete':
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff339901),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Hoàn thành',
            style: CommonStyles.size14W700Green33(context),
          ),
        );
      case 'Pending':
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffFEB700),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Đang xử lý',
            style: CommonStyles.size14W700YellowFE(context),
          ),
        );
      case 'Cancelled':
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffFF4127),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Đã huỷ',
            style: CommonStyles.size14W700RedFF(context),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _infoValue({
    required String title,
    int? id,
    String? value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$title: ',
              style: CommonStyles.size14W400Grey86(context),
            ),
            Text(
              id != null ? id.toString() : value.toString(),
              style: CommonStyles.size14W400Black1D(context),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Widget _viewInfo() {
    return Text('Xem chi tiết', style: CommonStyles.size14W400Blue00(context));
  }
}
