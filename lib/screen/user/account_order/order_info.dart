import 'package:flutter/material.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const CommonAppbar(title: 'Chi tiết đơn hàng'),
              Container(
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff339901),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Hoàn thành',
                          style: CommonStyles.size14W700Green33(context),
                        ),
                      ),
                      _infoValue(context, 'Mã đơn hàng', '111'),
                      _infoValue(context, 'Ngày đặt hàng', '02/11/2020'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // info custom value
  Widget _infoValue(BuildContext context, String title, String value) {
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
}
