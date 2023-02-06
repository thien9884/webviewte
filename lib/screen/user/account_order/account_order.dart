import 'package:flutter/material.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/user/account_order/order_info.dart';

class AccountOrder extends StatefulWidget {
  const AccountOrder({Key? key}) : super(key: key);

  @override
  State<AccountOrder> createState() => _AccountOrderState();
}

class _AccountOrderState extends State<AccountOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const CommonAppbar(title: 'Đơn đặt hàng'),
              _orderInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEBEBEB), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemStatus(false),
            _infoValue('Mã đơn hàng', '111'),
            _infoValue('Ngày đặt hàng', '02/11/2020'),
            _infoValue('Giá bán', '38.950.000đ'),
            _viewInfo(),
          ],
        ),
      ),
    );
  }

  Widget _itemStatus(bool value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: value ? const Color(0xff339901) : const Color(0xffFEB700),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        value ? 'Hoàn thành' : 'Đang xử lý',
        style: value
            ? CommonStyles.size14W700Green33(context)
            : CommonStyles.size14W700YellowFE(context),
      ),
    );
  }

  Widget _infoValue(String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$title: ',
              style: CommonStyles.size14W400Grey86(context),
            ),
            Text(
              value,
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
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const OrderInfo())),
      child:
          Text('Xem chi tiết', style: CommonStyles.size14W400Blue00(context)),
    );
  }
}
