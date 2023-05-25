import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/change_password/change_password_bloc.dart';
import 'package:webviewtest/blocs/change_password/change_password_event.dart';
import 'package:webviewtest/blocs/change_password/change_password_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewController = TextEditingController();
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
    BlocProvider.of<ChangePasswordBloc>(context).add(RequestPutChangePassword(
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
      confirmNew: _confirmNewController.text,
    ));
  }

  _getMessage() {
    if (_message == 'Mật khẩu cũ không khớp') {
      return 'Mật khẩu cũ không khớp!';
    } else {
      return 'Mật khẩu của bạn đã được đổi thành công.';
    }
  }

  @override
  void initState() {
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) => _buildLoginUI(context),
        listener: (context, state) async {
          if (state is ChangePasswordLoading) {
            EasyLoading.show();
          } else if (state is ChangePasswordLoaded) {
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
                          if (_message != 'Mật khẩu cũ không khớp') {
                            Navigator.pop(context);
                            _oldPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmNewController.clear();
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
          } else if (state is ChangePasswordLoadError) {
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
      showAppBar: false,
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            controller: _hideButtonController,
            slivers: [
              _titleChangePass(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _oldPassword(),
                      _newPassword(),
                      _confirmNewPassword(),
                      _buttonLogin(),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: 1, (context, index) => const CommonFooter())),
            ],
          ),
        ),
      ),
    );
  }

  // title change password
  Widget _titleChangePass() {
    return const SliverToBoxAdapter(
      child: CommonAppbar(title: 'Đổi mật khẩu'),
    );
  }

  // email recovery
  Widget _oldPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Mật khẩu cũ',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _oldPasswordController,
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
                width: 1,
                color: Color(0xffEBEBEB),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            bool passwordValid = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value.toString());
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập mật khẩu';
            } else if (!passwordValid) {
              return 'Mật khẩu không hợp lệ';
            }
            return null;
          },
        ),
      ],
    );
  }

  // email recovery
  Widget _newPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Mật khẩu mới',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _newPasswordController,
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
                width: 1,
                color: Color(0xffEBEBEB),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            bool passwordValid = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value.toString());
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập mật khẩu';
            } else if (!passwordValid) {
              return 'Mật khẩu không hợp lệ';
            }
            return null;
          },
        ),
      ],
    );
  }

  // email recovery
  Widget _confirmNewPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Nhập lại mật khẩu mới',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _confirmNewController,
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
                width: 1,
                color: Color(0xffEBEBEB),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập lại mật khẩu';
            } else if (value != _newPasswordController.text) {
              return 'Mật khẩu nhập lại không khớp';
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
          if (_formKey.currentState!.validate()) {
            _messageError = '';
            _recoveryPassword();
          }
        },
        title: 'Khôi phục',
      ),
    );
  }
}
