import 'package:flutter/material.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool _savePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Đăng nhập',
                      style: CommonStyles.size24W700Black1D(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      'Email, Số điện thoại',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffEBEBEB),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      'Mật khẩu',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xffEBEBEB),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => _showPassword = !_showPassword),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: _showPassword ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: !_showPassword,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _savePassword,
                              onChanged: (value) =>
                                  setState(() => _savePassword = value!),
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
                  ),
                  Row(
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xff0066CC),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      'Đăng nhập',
                      style: CommonStyles.size14W700White(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
