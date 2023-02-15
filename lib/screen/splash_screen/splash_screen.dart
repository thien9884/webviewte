import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showCheckVersion = false;

  Future<void> _checkVersion() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    await sPref.remove(SharedPrefKeys.isLogin);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showCheckVersion = true;
        EasyLoading.show();
        Future.delayed(
            const Duration(seconds: 2),
            () => setState(() {
                  if (!mounted) return;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NavigationScreen()));

                  if (EasyLoading.isShow) {
                    EasyLoading.dismiss();
                  }

                  _showCheckVersion = false;
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
                  const SizedBox(
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        _showCheckVersion
                            ? Text(
                                "Version 1.0.3",
                                style: CommonStyles.size16W700Grey33(context),
                              )
                            : const SizedBox(),
                        _showCheckVersion
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 24),
                                child: Text(
                                  "Checking for update...",
                                  style: CommonStyles.size14W400Grey66(context),
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
