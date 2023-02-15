import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/login/login_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _rememberMe = false;
  bool _isLogin = false;

  _keepLogin() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _rememberMe = sPref.rememberMe;
    return _rememberMe;
  }

  _checkLogin() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    _isLogin = sPref.isLogin;
    return _isLogin;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _keepLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (EasyLoading.isShow) EasyLoading.dismiss();
            return _rememberMe
                ? _basicInfo()
                : FutureBuilder(
                    future: _checkLogin(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        if (EasyLoading.isShow) EasyLoading.dismiss();
                        return _isLogin ? _basicInfo() : _loginButton();
                      } else {
                        EasyLoading.show();
                        return const SizedBox();
                      }
                    });
          } else {
            EasyLoading.show();
            return const SizedBox();
          }
        });
  }

  // basic info
  Widget _basicInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
            child: GestureDetector(
              onTap: () async {
                SharedPreferencesService sPref =
                    await SharedPreferencesService.instance;
                setState(() {
                  sPref.clear();
                });
              },
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
          ),
        ],
      ),
    );
  }

  // login button
  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_logo_home_page.svg',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          CommonButton(
              onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                      .then((value) async {
                    SharedPreferencesService sPref =
                        await SharedPreferencesService.instance;
                    setState(() {
                      sPref.setIsLogin(value);
                    });
                  }),
              title: 'Đăng nhập'),
          const SizedBox(),
        ],
      ),
    );
  }

  // user name
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
