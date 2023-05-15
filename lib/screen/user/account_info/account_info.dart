import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  int _selectGender = -1;
  String _day = '1';
  String _month = '1';
  String _year = '1990';
  InfoModel? _infoModel = InfoModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late ScrollController _hideButtonController;

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

  _getData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    final infoCustomer = sPref.infoCustomer;

    _infoModel = InfoModel.fromJson(jsonDecode(infoCustomer));
    _handleData();
  }

  _handleData() {
    if (_infoModel != null) {
      _nameController.text = _infoModel!.firstName ?? '';
      _emailController.text = _infoModel!.email ?? '';
      _phoneController.text = _infoModel!.phone ?? '';

      if (_infoModel!.gender == 'M') {
        _selectGender = 0;
      } else {
        _selectGender = 1;
      }
      if (_infoModel!.dateOfBirthDay != null &&
          _infoModel!.dateOfBirthMonth != null &&
          _infoModel!.dateOfBirthYear != null) {
        _day = _infoModel!.dateOfBirthDay.toString();
        _month = _infoModel!.dateOfBirthMonth.toString();
        _year = _infoModel!.dateOfBirthYear.toString();
      }
    }
  }

  @override
  void initState() {
    _getData();
    _getHideBottomValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
        builder: (context, state) => _accountInfo(),
        listener: (context, state) {
          if (state is GetInfoLoading) {
            EasyLoading.show();
          } else if (state is GetInfoLoaded) {
            _infoModel = state.infoModel;

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is GetInfoLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is PutInfoLoading) {
            EasyLoading.show();
          } else if (state is PutInfoLoaded) {
            showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      content: Text(
                        state.message ?? '',
                        style: CommonStyles.size14W400Grey86(context),
                      ),
                      actions: [
                        CupertinoDialogAction(
                            onPressed: () {
                              BlocProvider.of<CustomerBloc>(context)
                                  .add(const RequestGetInfo());
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Ok',
                              style: CommonStyles.size14W700Blue00(context),
                            ))
                      ],
                    ));

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is PutInfoLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _accountInfo() {
    return CommonNavigateBar(
      index: 2,
      child: CustomScrollView(
        controller: _hideButtonController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'Thông tin tài khoản',
                  style: CommonStyles.size24W400Black1D(context),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _nameField(),
                    _emailField(),
                    _phoneField(),
                    _genderSelect(),
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
                    _userNameField(),
                    _referralField(),
                    _buttonBuild(),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1, (context, index) => const CommonFooter())),
        ],
      ),
    );
  }

  Widget _nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Tên:',
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
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _emailField() {
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
        ),
      ],
    );
  }

  Widget _phoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _genderSelect() {
    return Padding(
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
                          width: 5,
                        ),
                        Text(
                          item.name,
                          style: CommonStyles.size14W400Black1D(context),
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

  Widget _buttonBuild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CommonButton(
        title: 'Lưu lại',
        onTap: () {
          setState(() {
            _infoModel?.firstName = _nameController.text;
            _infoModel?.email = _emailController.text;
            _infoModel?.phone = _phoneController.text;
            _infoModel?.dateOfBirthDay = int.parse(_day);
            _infoModel?.dateOfBirthMonth = int.parse(_month);
            _infoModel?.dateOfBirthYear = int.parse(_year);
            _infoModel?.gender = _selectGender == 0 ? 'M' : 'F';
            BlocProvider.of<CustomerBloc>(context)
                .add(RequestPutInfo(infoModel: _infoModel));
          });
        },
      ),
    );
  }

  Widget _userNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Username:',
            style: CommonStyles.size15W400Black1D(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            _infoModel?.username ?? '',
            style: CommonStyles.size14W400Grey77(context),
          ),
        ],
      ),
    );
  }

  Widget _referralField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Mã giới thiệu:',
            style: CommonStyles.size15W400Black1D(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            _infoModel?.referralCode ?? '',
            style: CommonStyles.size14W400Grey77(context),
          ),
        ],
      ),
    );
  }
}
