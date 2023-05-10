import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/customer_address/customer_address_bloc.dart';
import 'package:webviewtest/blocs/customer_address/customer_address_event.dart';
import 'package:webviewtest/blocs/customer_address/customer_address_state.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/screen/user/account_address/add_address.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  List<Addresses> _listAddress = [];

  _getData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    final customerId = sPref.customerId;

    if (context.mounted) {
      BlocProvider.of<CustomerAddressBloc>(context)
          .add(RequestGetCustomerAddress(customerId));
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerAddressBloc, CustomerAddressState>(
        builder: (context, state) => _userAddressUI(),
        listener: (context, state) {
          if (state is CustomerAddressLoading) {
            EasyLoading.show();
          } else if (state is CustomerAddressLoaded) {
            _listAddress =
                state.customerModel?.customers?.first.addresses ?? [];
            print(_listAddress);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is CustomerAddressLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _userAddressUI() {
    return CommonNavigateBar(
        child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Địa chỉ nhận hàng',
                style: CommonStyles.size24W400Black1D(context),
              ),
            ),
          ),
        ),
        _listAddress.isNotEmpty
            ? _buildListAddress()
            : const SliverToBoxAdapter(
                child: SizedBox(
                  height: 300,
                ),
              ),
        _addButton(),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 1, (context, index) => const CommonFooter())),
      ],
    ));
  }

  // list address
  Widget _buildListAddress() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: _listAddress.length,
          (context, index) {
        final item = _listAddress[index];

        return Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_address.svg',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Địa chỉ',
                          style: CommonStyles.size14W700Black1D(context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _editButton(true, () {}),
                        const SizedBox(
                          width: 10,
                        ),
                        _editButton(false, () {

                        }),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xffEBEBEB),
                  ),
                ),
                _accountInfo(false, 'Tên', item.firstName ?? ''),
                _accountInfo(false, 'Số điện thoại', item.phoneNumber ?? ''),
                _accountInfo(false, 'Email', item.email ?? ''),
                _accountInfo(true, 'Địa chỉ',
                    '${item.address1}${item.city!.isNotEmpty ? ', ${item.city}' : ''}'),
              ],
            ),
          ),
        );
      }),
    );
  }

  // action button
  Widget _editButton(bool isEdit, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: isEdit ? const EdgeInsets.all(6) : const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isEdit ? const Color(0xff0066CC) : null,
              border: isEdit
                  ? null
                  : Border.all(color: const Color(0xffFF4127), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                SvgPicture.asset(isEdit
                    ? 'assets/icons/ic_edit.svg'
                    : 'assets/icons/ic_delete.svg'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  isEdit ? 'Sửa' : 'Xoá',
                  style: isEdit
                      ? CommonStyles.size14W400White(context)
                      : CommonStyles.size14W400White(context)
                          .copyWith(color: const Color(0xffFF4127)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // info account
  Widget _accountInfo(
    bool top,
    String name,
    String value,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment:
              top ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Text(
              "$name: ",
              style: CommonStyles.size12W400Grey86(context),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                value,
                style: CommonStyles.size14W400Black1D(context),
                maxLines: 2,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _addButton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: CommonButton(
          title: 'Thêm mới',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddAddress())),
        ),
      ),
    );
  }
}
