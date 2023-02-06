import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showProgress = false;
  bool _showButtonLogin = false;

  Future<void> _checkVersion() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showProgress = true;
        Future.delayed(
            const Duration(seconds: 2),
            () => setState(() {
                  _showProgress = false;
                  _showButtonLogin = true;
                }));
      });
    });
  }

  @override
  void initState() {
    _checkVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    SvgPicture.asset('assets/icons/ic_logo_black.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, bottom: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/ic_shop.svg'),
                          SvgPicture.asset('assets/icons/ic_dunk.svg'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Đại lý ủy quyền chính hãng Apple',
                        style: CommonStyles.size14W400Grey33(context),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '© ShopDunk 2022',
                    style: CommonStyles.size14W400Grey66(context),
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  _showProgress
                      ? Padding(
                          padding: const EdgeInsets.only(top: 250),
                          child: Image.asset('assets/icons/ic_loading.png'),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        _showProgress
                            ? Text(
                                "Version 1.0.3",
                                style: CommonStyles.size16W700Grey33(context),
                              )
                            : const SizedBox(),
                        _showProgress
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 24),
                                child: Text(
                                  "Checking for update...",
                                  style: CommonStyles.size14W400Grey66(context),
                                ),
                              )
                            : const SizedBox(),
                        _showButtonLogin
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen())),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff0066CC),
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Đăng nhập',
                                      style:
                                          CommonStyles.size14W700White(context),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        _showButtonLogin
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 20, 40),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff0066CC)),
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Đăng nhập',
                                      style:
                                          CommonStyles.size14W700Blue(context),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
