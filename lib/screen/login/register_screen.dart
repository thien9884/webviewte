import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/register/register_bloc.dart';
import 'package:webviewtest/blocs/register/register_event.dart';
import 'package:webviewtest/blocs/register/register_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/register/register_model.dart';
import 'package:webviewtest/model/register/register_response.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _selectGender = 0;
  String _day = '1';
  String _month = '1';
  String _year = '1990';
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  RegisterResponse? _registerResponse = RegisterResponse();
  late ScrollController _hideButtonController;
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

  @override
  void initState() {
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        builder: (context, state) => _registerUI(),
        listener: (context, state) {
          if (state is RegisterLoading) {
            EasyLoading.show();
          } else if (state is RegisterLoaded) {
            _registerResponse = state.registerResponse;
            print(_registerResponse?.httpStatusCode);

            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'Thông báo',
                      style: CommonStyles.size17W700Black1D(context),
                    ),
                    content: Text(
                      _registerResponse!.success!
                          ? 'Đăng ký thành công'
                          : 'Đăng ký thất bại',
                      style: CommonStyles.size14W400Grey33(context),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          if (_registerResponse!.success!) {
                            Navigator.pop(context);
                            _userNameController.clear();
                            _emailController.clear();
                            _phoneController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                            _nameController.clear();
                            _referralController.clear();
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
          } else if (state is RegisterLoadError) {
            String error = state.message;
            if (error == 'Wrong username or password') {
              error = 'Sai tên tài khoản hoặc mật khẩu';
            }
            AlertUtils.displayErrorAlert(context, error);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _registerUI() {
    return CommonNavigateBar(
      index: 2,
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            controller: _hideButtonController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Đăng ký',
                      style: CommonStyles.size24W700Black1D(context),
                    ),
                  ),
                ),
              ),
              _formRegister(),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: 1, (context, index) => const CommonFooter())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listDropDownDay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Ngày',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _day,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              elevation: 16,
              isDense: true,
              style: CommonStyles.size14W400Grey86(context),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  _day = value!;
                });
              },
              items: List.generate(
                  31,
                  (index) => DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Center(child: Text((index + 1).toString())),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listDropDownMonth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Tháng',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _month,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              elevation: 16,
              isDense: true,
              style: CommonStyles.size14W400Grey86(context),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  _month = value!;
                });
              },
              items: List.generate(
                  12,
                  (index) => DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Center(child: Text((index + 1).toString())),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listDropDownYear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Năm',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _year,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              elevation: 16,
              isDense: true,
              style: CommonStyles.size14W400Grey86(context),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  _year = value!;
                });
              },
              items: List.generate(
                  50,
                  (index) => DropdownMenuItem<String>(
                        value: (index + 1990).toString(),
                        child: Center(child: Text((index + 1990).toString())),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _formRegister() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Tên, Họ:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.all(10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên';
                }
                return null;
              },
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
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  item.name,
                                  style:
                                      CommonStyles.size14W400Black1D(context),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
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
                Flexible(child: _listDropDownDay()),
                const SizedBox(width: 10),
                Flexible(child: _listDropDownMonth()),
                const SizedBox(width: 10),
                Flexible(child: _listDropDownYear()),
              ],
            ),
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
                contentPadding: const EdgeInsets.all(10),
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
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Số điện thoại:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.all(10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                'Username:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.all(10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username không được để trống';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                'Mật khẩu:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => setState(
                    () => _showPassword = !_showPassword,
                  ),
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
                contentPadding: const EdgeInsets.all(10),
              ),
              obscureText: !_showPassword,
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Lưu ý: Mật khẩu phải có tối thiểu 8 ký tự bao gồm chữ, số và các ký tự đặc biệt',
                style: CommonStyles.size12W400Grey51(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                'Xác nhận mật khẩu:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () => setState(
                    () => _showConfirmPassword = !_showConfirmPassword,
                  ),
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: _showConfirmPassword ? Colors.blue : Colors.grey,
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
                contentPadding: const EdgeInsets.all(10),
              ),
              obscureText: !_showConfirmPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập lại mật khẩu';
                } else if (value != _passwordController.text) {
                  return 'Mật khẩu nhập lại không khớp';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text(
                'Mã giới thiệu:',
                style: CommonStyles.size14W400Black1D(context),
              ),
            ),
            TextFormField(
              controller: _referralController,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.all(10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mã giới thiệu';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text(
                    'Bạn đã có tài khoản? ',
                    style: CommonStyles.size14W400Black1D(context),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NavigationScreen(
                              isSelected: 2,
                            ))),
                    child: Text(
                      'Đăng nhập ngay',
                      style: CommonStyles.size14W400Blue00(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  final registerModel = RegisterModel(
                    email: _emailController.text,
                    enteringEmailTwice: false,
                    confirmEmail: _emailController.text,
                    usernamesEnabled: true,
                    username: _userNameController.text,
                    checkUsernameAvailabilityEnabled: true,
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text,
                    genderEnabled: true,
                    gender: _selectGender == 0 ? 'Male' : 'Female',
                    firstNameEnabled: true,
                    firstName: _nameController.text,
                    firstNameRequired: true,
                    lastNameEnabled: true,
                    lastName: '',
                    lastNameRequired: true,
                    dateOfBirthEnabled: true,
                    dateOfBirthDay: int.parse(_day),
                    dateOfBirthMonth: int.parse(_month),
                    dateOfBirthYear: int.parse(_year),
                    dateOfBirthRequired: true,
                    companyEnabled: true,
                    companyRequired: true,
                    company: '',
                    streetAddressEnabled: true,
                    streetAddressRequired: true,
                    streetAddress: '',
                    streetAddress2Enabled: true,
                    streetAddress2Required: true,
                    streetAddress2: '',
                    zipPostalCodeEnabled: true,
                    zipPostalCodeRequired: true,
                    zipPostalCode: '',
                    cityEnabled: true,
                    cityRequired: true,
                    city: '',
                    countyEnabled: true,
                    countyRequired: true,
                    county: '',
                    countryEnabled: true,
                    countryRequired: true,
                    countryId: 242,
                    availableCountries: [
                      AvailableCountries(
                        disabled: true,
                        group: Group(
                          disabled: true,
                          name: '',
                        ),
                        selected: true,
                        text: '',
                        value: '',
                      ),
                    ],
                    stateProvinceEnabled: true,
                    stateProvinceRequired: true,
                    stateProvinceId: 0,
                    availableStates: [
                      AvailableStates(
                        disabled: true,
                        group: Group(
                          disabled: true,
                          name: '',
                        ),
                        selected: true,
                        text: '',
                        value: '',
                      ),
                    ],
                    phoneEnabled: true,
                    phoneRequired: true,
                    phone: _phoneController.text,
                    faxEnabled: true,
                    faxRequired: true,
                    fax: '',
                    newsletterEnabled: true,
                    newsletter: true,
                    acceptPrivacyPolicyEnabled: true,
                    acceptPrivacyPolicyPopup: true,
                    timeZoneId: '',
                    allowCustomersToSetTimeZone: true,
                    availableTimeZones: [
                      AvailableTimeZones(
                        disabled: true,
                        group: Group(
                          disabled: true,
                          name: '',
                        ),
                        selected: true,
                        text: '',
                        value: '',
                      ),
                    ],
                    vatNumber: '',
                    displayVatNumber: true,
                    honeypotEnabled: true,
                    displayCaptcha: true,
                    customerAttributes: [
                      CustomerAttributes(
                        name: '',
                        isRequired: true,
                        defaultValue: '',
                        attributeControlType: 'DropdownList',
                        values: [
                          Values(
                            name: '',
                            isPreSelected: true,
                          ),
                        ],
                      ),
                    ],
                    gdprConsents: [
                      GdprConsents(
                        message: '',
                        isRequired: true,
                        requiredMessage: '',
                        accepted: true,
                      ),
                    ],
                    referralCode: _referralController.text,
                  );

                  BlocProvider.of<RegisterBloc>(context).add(
                    RequestPostRegister(registerModel: registerModel),
                  );
                  setState(() {});
                }
              },
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
            )
          ],
        ),
      ),
    );
  }
}
