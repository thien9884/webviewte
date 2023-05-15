import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/address/address.dart';
import 'package:webviewtest/model/customer/customer_model.dart';
import 'package:webviewtest/model/state/state_model.dart';
import 'package:webviewtest/screen/user/account_address/user_address.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class AddAddress extends StatefulWidget {
  final Addresses? addressModel;

  const AddAddress({required this.addressModel, Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String _country = 'Việt Nam';
  String _city = '';
  int _customerId = 0;
  List<StateModel> _listState = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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

    _customerId = sPref.customerId;
    if (widget.addressModel != null) {
      final address = widget.addressModel;
      _nameController.text = address!.firstName ?? '';
      _emailController.text = address.email ?? '';
      _phoneController.text = address.phoneNumber ?? '';
      _addressController.text = address.address1 ?? '';
    }

    if (context.mounted) {
      BlocProvider.of<CustomerBloc>(context).add(const RequestGetState());
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
        builder: (context, state) => _addAddressUI(),
        listener: (context, state) {
          if (state is AddAddressLoading) {
            EasyLoading.show();
          } else if (state is AddAddressLoaded) {
            showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      content: Text(
                        'Thêm tài khoản thành công',
                        style: CommonStyles.size14W400Grey86(context),
                      ),
                      actions: [
                        CupertinoDialogAction(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UserAddress()));
                            },
                            child: Text(
                              'Ok',
                              style: CommonStyles.size14W700Blue00(context),
                            ))
                      ],
                    ));

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is AddAddressLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is PutAddressLoading) {
            EasyLoading.show();
          } else if (state is PutAddressLoaded) {
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UserAddress()));
                            },
                            child: Text(
                              'Ok',
                              style: CommonStyles.size14W700Blue00(context),
                            ))
                      ],
                    ));

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is PutAddressLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);
            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is GetStateLoading) {
            EasyLoading.show();
          } else if (state is GetStateLoaded) {
            _listState = state.stateModel ?? [];
            _city = _listState[0].text.toString();

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is GetStateLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _addAddressUI() {
    return CommonNavigateBar(
        index: 2,
        child: CustomScrollView(
          controller: _hideButtonController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              'Thêm địa chỉ',
                              style: CommonStyles.size24W400Black1D(context),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xffEBEBEB)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              _nameField(),
                              _phoneField(),
                              _emailField(),
                              _listDropDownCity(),
                              _listDropDownDistrict(),
                              _districtField(),
                              _wardField(),
                              _addressField(),
                            ],
                          ),
                        )
                      ],
                    ),
                    _saveButton(),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ));
  }

  // input name
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  // input phone number
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  // input email
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  Widget _listDropDownCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(
            'Quốc gia:',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _country,
                menuMaxHeight: 300,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                elevation: 16,
                isDense: true,
                style: CommonStyles.size14W400Grey86(context),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _country = value!;
                  });
                },
                items: List.generate(
                    1,
                    (index) => const DropdownMenuItem<String>(
                          value: 'Việt Nam',
                          child: Text('Việt Nam'),
                        )).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listDropDownDistrict() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: Text(
            'Tỉnh, thành phố:',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _city,
                menuMaxHeight: 300,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                elevation: 16,
                isDense: true,
                style: CommonStyles.size14W400Grey86(context),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _city = value!;
                  });
                },
                items: List.generate(_listState.length, (index) {
                  final item = _listState[index];

                  return DropdownMenuItem<String>(
                    value: item.text,
                    child: Text(item.text ?? ''),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // input district
  Widget _districtField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Quận, huyện:',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _districtController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  // input ward
  Widget _wardField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            'Phường, xã:',
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        TextFormField(
          controller: _wardController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

  // input address
  Widget _addressField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'Địa chỉ cụ thể:',
              style: CommonStyles.size14W400Black1D(context),
            ),
          ),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CommonButton(
          title: 'Lưu lại',
          onTap: () {
            if (widget.addressModel != null) {
              var putAddressModel = PutAddress(
                firstName: _nameController.text,
                lastName: 'string',
                email: _emailController.text,
                company: 'string',
                countryId: 242,
                stateProvinceId: 0,
                county: 'VN',
                city: _city,
                address1: _addressController.text,
                address2: 'string',
                zipPostalCode: 'string',
                phoneNumber: _phoneController.text,
                faxNumber: 'string',
                customAttributes: '',
                createdOnUtc: DateTime.now().toUtc().toString(),
                countyId: 0,
                id: widget.addressModel?.id,
              );
              BlocProvider.of<CustomerBloc>(context)
                  .add(RequestPutAddress(putAddressModel));
            } else {
              var addressModel = Addresses(
                firstName: _nameController.text,
                lastName: 'string',
                email: _emailController.text,
                company: 'string',
                countryId: 242,
                country: 'VN',
                stateProvinceId: 0,
                city: _city,
                address1: _addressController.text,
                address2: 'string',
                zipPostalCode: 'string',
                phoneNumber: _phoneController.text,
                faxNumber: 'string',
                customerAttributes: 'string',
                createdOnUtc: '2023-05-08T17:43:35.207Z',
                province: 'string',
                id: 0,
              );
              BlocProvider.of<CustomerBloc>(context)
                  .add(RequestPostAddAddress(_customerId, addressModel));
            }
          }),
    );
  }
}
