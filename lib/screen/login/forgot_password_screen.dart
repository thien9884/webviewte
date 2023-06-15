import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_event.dart';
import 'package:webviewtest/blocs/forgot_password/forgot_password_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  late ScrollController _hideButtonController;
  String _messageError = '';
  String _message = '';
  final _formKey = GlobalKey<FormState>();

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

  _recoveryPassword() async {
    BlocProvider.of<ForgotPasswordBloc>(context)
        .add(RequestPostRecoveryPassword(email: _emailController.text));
  }

  _getMessage() {
    if (_message == 'Email not found!') {
      return 'Không tìm thấy email!';
    } else {
      return 'Email đã được gửi\nVui lòng kiểm tra email của bạn.';
    }
  }

  @override
  void initState() {
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) => _buildLoginUI(context),
        listener: (context, state) async {
          if (state is ForgotPasswordLoading) {
            EasyLoading.show();
          } else if (state is ForgotPasswordLoaded) {
            _message = state.message;

            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Thông báo',
                        style: CommonStyles.size17W700Black1D(context),
                      ),
                    ),
                    content: Text(
                      _getMessage(),
                      style: CommonStyles.size14W400Grey33(context),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          if (_message == 'Email has been send!') {
                            Navigator.pop(context);
                            _emailController.clear();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const NavigationScreen(
                                      isSelected: 2,
                                    )));
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Đồng ý',
                          style: CommonStyles.size14W700Blue007A(context),
                        ),
                      ),
                    ],
                  );
                });
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is ForgotPasswordLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
              if (EasyLoading.isShow) EasyLoading.dismiss();
            }
          }
        });
  }

  // recovery UI
  Widget _buildLoginUI(BuildContext context) {
    return CommonNavigateBar(
      index: 2,
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            controller: _hideButtonController,
            slivers: [
              _titleLogin(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _emailLogin(),
                      _buttonLogin(),
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

  // title recovery
  Widget _titleLogin() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Khôi phục mật khẩu',
            style: CommonStyles.size24W700Black1D(context),
          ),
        ),
      ),
    );
  }

  // email recovery
  Widget _emailLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Email:',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintStyle: CommonStyles.size14W400Grey86(context),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xffEBEBEB),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color(0xff0066CC),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value.toString());
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập email';
            } else if (!emailValid) {
              return 'Email không hợp lệ';
            }
            return null;
          },
        ),
      ],
    );
  }

  // recovery button
  Widget _buttonLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CommonButton(
        onTap: () async {
          FocusScope.of(context).unfocus();
          if(_formKey.currentState!.validate()) {
            _messageError = '';
            _recoveryPassword();
          }
        },
        title: 'Khôi phục',
      ),
    );
  }
}
