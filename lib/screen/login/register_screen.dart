import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/screen/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectGender = -1;
  final String _day = '1';
  final String _month = '1';
  final String _year = '1990';
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          'Tên, Họ',
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
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          children: [
                            Text(
                              'Giới tính:',
                              style: CommonStyles.size14W400Black1D(context),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Flexible(
                              child: SizedBox(
                                height: 20,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ListCustom.listGender.length,
                                  itemBuilder: (context, index) {
                                    final item = ListCustom.listGender[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectGender = item.id;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          _selectGender == item.id
                                              ? SvgPicture.asset(
                                                  'assets/icons/ic_radio_check.svg',
                                                )
                                              : SvgPicture.asset(
                                                  'assets/icons/ic_radio_uncheck.svg',
                                                  height: 15,
                                                  width: 15,
                                                ),
                                          Text(
                                            item.name,
                                            style:
                                                CommonStyles.size14W400Black1D(
                                                    context),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    width: 42,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(child: _listDropDown(31, 1, _day, 'Ngày')),
                          const SizedBox(width: 10),
                          Flexible(
                              child: _listDropDown(12, 1, _month, 'Tháng')),
                          const SizedBox(width: 10),
                          Flexible(
                              child: _listDropDown(50, 1990, _year, 'Năm')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          'Email',
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
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          'Số điện thoại',
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
                      Text(
                        'Lưu ý: Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ, số và các ký tự đặc biệt',
                        style: CommonStyles.size12W400Grey51(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          'Xác nhận mật khẩu',
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
                      Row(
                        children: [
                          Text(
                            'Bạn đã có tài khoản? ',
                            style: CommonStyles.size14W400Black1D(context),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Đăng nhập ngay',
                              style: CommonStyles.size14W400Blue00(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen())),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xff0066CC),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      'Đăng ký',
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

  Widget _listDropDown(int length, int count, String type, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            name,
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        SizedBox(
          height: 60,
          child: Center(
            child: DropdownButtonFormField<String>(
              value: type,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffEBEBEB)),
                borderRadius: BorderRadius.circular(8),
              )),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                setState(() {
                  type = value!;
                });
              },
              items: List.generate(
                  length,
                  (index) => DropdownMenuItem<String>(
                        value: (index + count).toString(),
                        child: Center(child: Text((index + count).toString())),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
