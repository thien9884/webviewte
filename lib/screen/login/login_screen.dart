import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/login/login_bloc.dart';
import 'package:webviewtest/blocs/login/login_event.dart';
import 'package:webviewtest/blocs/login/login_state.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/login/login_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool _savePassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) => _buildLoginUI(context),
        listener: (context, state) async {
          if (state is LoginLoading) {
            EasyLoading.show();
          } else if (state is LoginLoaded) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NavigationScreen()));
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            // Navigator.of(context).pop(state.isLogin);
          } else if (state is LoginLoadError) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
            AlertUtils.displayErrorAlert(context, state.message);
          }
        });
  }

  // login UI
  Widget _buildLoginUI(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleLogin(),
                    _emailLogin(),
                    _passwordLogin(),
                    _rememberMe(),
                    _createAccount(),
                  ],
                ),
                _buttonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // title login
  Widget _titleLogin() {
    return Center(
      child: Text(
        'Đăng nhập',
        style: CommonStyles.size24W700Black1D(context),
      ),
    );
  }

  // email login
  Widget _emailLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Email, Số điện thoại',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'email',
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
          ),
        ),
      ],
    );
  }

  // password login
  Widget _passwordLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Mật khẩu',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'password',
            hintStyle: CommonStyles.size14W400Grey86(context),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _showPassword = !_showPassword),
              child: Icon(
                Icons.remove_red_eye_outlined,
                color: _showPassword ? Colors.blue : Colors.grey,
              ),
            ),
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
          ),
          obscureText: !_showPassword,
        )
      ],
    );
  }

  // remember me
  Widget _rememberMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _savePassword,
                onChanged: (value) => setState(() => _savePassword = value!),
              ),
              Text(
                'Nhớ mật khẩu này',
                style: CommonStyles.size14W400Grey86(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Text(
              'Quên mật khẩu?',
              style: CommonStyles.size14W400Blue00(context),
            ),
          ),
        ],
      ),
    );
  }

  // create account
  Widget _createAccount() {
    return Row(
      children: [
        Text(
          'Bạn chưa có tài khoản? ',
          style: CommonStyles.size14W400Black1D(context),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Tạo tài khoản ngay',
            style: CommonStyles.size14W400Blue00(context),
          ),
        ),
      ],
    );
  }

  // login button
  Widget _buttonLogin() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonButton(
        onTap: () async {
          FocusScope.of(context).unfocus();
          var login = LoginModel(
            guest: false,
            username: _emailController.text,
            password: _passwordController.text,
            rememberMe: _savePassword,
          );
          BlocProvider.of<LoginBloc>(context)
              .add(RequestPostLogin(loginModel: login));
        },
        title: 'Đăng nhập',
      ),
    );
  }
}
