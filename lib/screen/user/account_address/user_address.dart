import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/user/account_address/add_address.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CommonAppbar(title: 'Địa chỉ nhận hàng'),
                  _buildListAddress(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: CommonButton(
                  title: 'Thêm mới',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddAddress())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // list address
  Widget _buildListAddress() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
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
                      'Địa chỉ 1',
                      style: CommonStyles.size14W700Black1D(context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _editButton(true),
                    const SizedBox(
                      width: 10,
                    ),
                    _editButton(false),
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
            _accountInfo('Tên', 'Nguyễn Tú'),
            _accountInfo('Số điện thoại', '0987654321'),
            _accountInfo('Email', 'admin12345@gmail.com'),
            _accountInfo('Địa chỉ',
                'Số nhà 3, ngõ 268 Phùng Khoang, Quận Nam Từ Liêm, Thành phố Hà Nội'),
          ],
        ),
      ),
    );
  }

  // action button
  Widget _editButton(bool isEdit) {
    return Row(
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
    );
  }

  // info account
  Widget _accountInfo(
    String name,
    String value,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$name: ",
              style: CommonStyles.size12W400Grey86(context),
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
}
