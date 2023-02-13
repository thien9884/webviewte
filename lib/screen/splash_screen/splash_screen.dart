import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/login/login_event.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/screen/login/login_screen.dart';
import 'package:webviewtest/screen/login/register_screen.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showButtonLogin = false;

  Future<void> _checkVersion() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    bool rememberMe = sPref.rememberMe;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        EasyLoading.show();
        Future.delayed(
            const Duration(seconds: 2),
            () => setState(() {
                  if (EasyLoading.isShow) {
                    EasyLoading.dismiss();
                  }
                  if (rememberMe) {
                    var login = LoginModel(
                      guest: true,
                      username: sPref.userName,
                      password: sPref.password,
                      rememberMe: sPref.rememberMe,
                    );
                    if (!mounted) return;
                    BlocProvider.of<LoginBloc>(context)
                        .add(RequestPostLogin(loginModel: login));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NavigationScreen()));
                  } else {
                    _showButtonLogin = true;
                  }
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
                        EasyLoading.isShow
                            ? Text(
                                "Version 1.0.3",
                                style: CommonStyles.size16W700Grey33(context),
                              )
                            : const SizedBox(),
                        EasyLoading.isShow
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
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      content: const Text('under development'),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                          isDestructiveAction: false,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff0066CC)),
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Đăng ký',
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
