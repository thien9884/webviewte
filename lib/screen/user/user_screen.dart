import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameUser(),
          const SizedBox(
            height: 5,
          ),
          _emailUser(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Color(0xffEBEBEB),
            ),
          ),
          _settingComponent(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              thickness: 1,
              height: 1,
              color: Color(0xffEBEBEB),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/ic_language.svg'),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    'Ngôn ngữ',
                    style: CommonStyles.size14W400Black1D(context),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Tiếng Việt',
                    style: CommonStyles.size14W400Black1D(context),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/ic_logout.svg'),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Đăng xuất',
                  style: CommonStyles.size14W400RedFF(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameUser() {
    return Text(
      'Tú Nguyễn',
      style: CommonStyles.size18W700Black1D(context),
    );
  }

  Widget _emailUser() {
    return Text(
      'Nguyentu198@gmail.com',
      style: CommonStyles.size13W400Grey51(context),
    );
  }

  Widget _settingComponent() {
    return Column(
      children: List.generate(ListCustom.listAccountSettings.length, (index) {
        var item = ListCustom.listAccountSettings[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => item.screen ?? const SizedBox())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(item.img.toString()),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      item.name,
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ],
            ),
          ),
        );
      }),
    );
  }
}
