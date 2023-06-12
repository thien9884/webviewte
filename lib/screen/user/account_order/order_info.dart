import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/order/order_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class OrderInfo extends StatefulWidget {
  final Orders orders;

  const OrderInfo({required this.orders, Key? key}) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
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

  @override
  void initState() {
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonNavigateBar(
      index: 2,
      child: CustomScrollView(
        controller: _hideButtonController,
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 25,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Trở lại',
                      style: CommonStyles.size16W400Blue00(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Chi tiết đơn hàng',
                  style: CommonStyles.size24W400Black1D(context),
                ),
              ),
            ),
          ),
          _orderInfo(context),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          _customerInfo(context),
        ],
      ),
    );
  }

  Widget _orderStatus(BuildContext context) {
    switch (widget.orders.orderStatus) {
      case 'Complete':
        return Text(
          'Hoàn thành',
          style: CommonStyles.size13W400White(context),
        );
      case 'Pending':
        return Text(
          'Đang xử lý',
          style: CommonStyles.size13W400White(context),
        );
      case 'Cancelled':
        return Text(
          'Đã huỷ',
          style: CommonStyles.size13W400White(context),
        );
      default:
        return const SizedBox();
    }
  }

  // info custom value
  Widget _infoValue(
    BuildContext context, {
    required String title,
    int? id,
    String? value,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0xffEBEBEB),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title: ',
                style: CommonStyles.size14W400Grey86(context),
              ),
              Text(
                id != null ? id.toString() : value.toString(),
                style: id != null
                    ? CommonStyles.size15W700Black1D(context)
                    : CommonStyles.size14W400Black1D(context),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Widget _orderInfo(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
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
              _infoValue(context, title: 'Mã đơn hàng', id: widget.orders.id),
              _infoValue(context,
                  title: 'Ngày đặt hàng',
                  value: DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(widget.orders.createdOnUtc ?? ''))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tình trạng:',
                      style: CommonStyles.size15W400Grey86(context),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff339901),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: _orderStatus(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customerInfo(BuildContext context) {
    var priceFormat = NumberFormat.decimalPattern('vi_VN');

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              _infoCustomer(
                context,
                title: 'Tên khách hàng',
                value: widget.orders.billingAddress?.firstName ?? '',
              ),
              _infoCustomer(
                context,
                title: 'Số điện thoại',
                value: widget.orders.billingAddress?.phoneNumber ?? '',
              ),
              _infoCustomer(
                context,
                title: 'Email',
                value: widget.orders.billingAddress?.email ?? '',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffEBEBEB),
                ),
              ),
              _infoCustomer(
                context,
                title: 'Địa chỉ nhận hàng',
                value:
                    '${widget.orders.billingAddress?.address1 ?? ''}, ${widget.orders.billingAddress?.city ?? ''}',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffEBEBEB),
                ),
              ),
              _infoCustomer(
                context,
                title: 'Phương thức thanh toán',
                value: _getPaymentMethod(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xffEBEBEB),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Sản phẩm:',
                  style: CommonStyles.size14W400Grey86(context),
                ),
              ),
              CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  _listProduct(context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng số tiền đã đặt hàng:',
                    style: CommonStyles.size13W400Grey86(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        '${priceFormat.format(widget.orders.orderTotal ?? 0)}₫',
                        style: CommonStyles.size24W700Blue00(context),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCustomer(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: CommonStyles.size15W400Grey86(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              child: Text(
                value,
                style: CommonStyles.size14W400Black1D(context),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getPaymentMethod() {
    if (widget.orders.paymentMethodSystemName!.isNotEmpty &&
        widget.orders.paymentMethodSystemName!.contains('Payments.')) {
      return 'Thanh toán ${widget.orders.paymentMethodSystemName!.replaceAll('Payments.', '')}';
    } else {
      return 'Chuyển khoản ngân hàng';
    }
  }

  Widget _listProduct(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: widget.orders.orderItems?.length,
        (context, index) {
          final item = widget.orders.orderItems?[index];
          final itemIndex = item?.attributeDescription?.lastIndexOf(':');

          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShopDunkWebView(
                      url: item.product?.seName,
                    ))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xffEBEBEB),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item?.product?.name ?? '',
                          style: CommonStyles.size15W700Black1D(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'SL: ${item?.quantity}',
                        style: CommonStyles.size14W400Grey44(context),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (item!.attributeDescription!.isNotEmpty)
                    Text(
                      ('Màu sắc${item.attributeDescription?.replaceRange(0, itemIndex, '')}'),
                      style: CommonStyles.size13W400Grey86(context),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
