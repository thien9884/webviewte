import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/ic_success.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Bạn đã đăng ký thành công',
                        style: CommonStyles.size16W700Green33(context),
                      ),
                    ),
                    Text(
                      'Bạn sẽ nhận được email với hướng dẫn kích hoạt tài khoản',
                      style: CommonStyles.size14W400Grey51(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: CommonButton(
                title: 'Đăng nhập ngay',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NavigationScreen(
                        isSelected: 2,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
