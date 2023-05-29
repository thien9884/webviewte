import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/model/my_system/my_system_model.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class MySystemScreen extends StatefulWidget {
  const MySystemScreen({Key? key}) : super(key: key);

  @override
  State<MySystemScreen> createState() => _MySystemScreenState();
}

class _MySystemScreenState extends State<MySystemScreen>
    with TickerProviderStateMixin {
  late ScrollController _hideButtonController;
  String _emailCode = '';
  String _phoneCode = '';
  String _userNameCode = '';
  String _codeSelected = 'none';
  InfoModel? _infoModel = InfoModel();
  final List<MySystemModel> _listMySystem = [];
  int _indexSelected = 0;
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

    if (infoCustomer.isNotEmpty) {
      setState(() {
        _infoModel = InfoModel.fromJson(jsonDecode(infoCustomer));
        _emailCode = _infoModel?.email ?? '';
        _phoneCode = _infoModel?.phone ?? '';
        _userNameCode = _infoModel?.username ?? '';
      });
    }

    if (context.mounted) {
      BlocProvider.of<CustomerBloc>(context).add(const RequestGetMySystem(1));
      BlocProvider.of<CustomerBloc>(context).add(const RequestGetMySystem(2));
      BlocProvider.of<CustomerBloc>(context).add(const RequestGetMySystem(3));
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
        builder: (context, state) => _mySystemUI(),
        listener: (context, state) {
          if (state is MySystemLoading) {
            EasyLoading.show();
          } else if (state is MySystemLoaded) {
            _listMySystem.add(state.mySystemModel);
            if (_listMySystem.every((element) => element.level != null)) {
              _listMySystem
                  .sort((a, b) => a.level!.compareTo(b.level!.toInt()));
            }

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is MySystemLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _mySystemUI() {
    return CommonNavigateBar(
        index: 2,
        showAppBar: false,
        child: _listMySystem.isNotEmpty && _listMySystem.length == 3
            ? Container(
                color: Colors.white,
                child: CustomScrollView(
                  controller: _hideButtonController,
                  slivers: [
                    _mySystemTitle(),
                    _myReferralCode(),
                    _noteMyCode(),
                    _myCode(
                      myCode: _emailCode,
                      key: 'emailCode',
                      onTap: () => setState(() {
                        _codeSelected = 'emailCode';
                        Clipboard.setData(ClipboardData(text: _emailCode));
                      }),
                    ),
                    _myCode(
                        myCode: _phoneCode,
                        key: 'phoneCode',
                        onTap: () => setState(
                              () {
                                _codeSelected = 'phoneCode';
                                Clipboard.setData(
                                    ClipboardData(text: _phoneCode));
                              },
                            )),
                    _myCode(
                      myCode: _userNameCode,
                      key: 'userNameCode',
                      onTap: () => setState(() {
                        _codeSelected = 'userNameCode';
                        Clipboard.setData(ClipboardData(text: _userNameCode));
                      }),
                    ),
                    _dataTableMySystem(),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: 1,
                            (context, index) => const CommonFooter())),
                  ],
                ),
              )
            : const SizedBox());
  }

  Widget _mySystemTitle() {
    return const CommonAppbar(title: 'Hệ thống của tôi');
  }

  Widget _myReferralCode() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Text(
          'Mã giới thiệu của bạn:',
          style: CommonStyles.size14W700Black1D(context),
        ),
      ),
    );
  }

  Widget _noteMyCode() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          CommonText.noteMyCode(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
      ),
    );
  }

  Widget _myCode({
    required String myCode,
    required String key,
    required VoidCallback onTap,
  }) {
    return SliverToBoxAdapter(
      child: myCode.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xffEBEBEB)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    myCode,
                    style: CommonStyles.size14W400Grey86(context),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: _codeSelected == key
                        ? Text(
                            'copied',
                            style: CommonStyles.size14W400Blue00(context),
                          )
                        : SvgPicture.asset('assets/icons/ic_copy_button.svg'),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _dataTableMySystem() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: List.generate(
                2,
                (index) => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            _indexSelected = index;
                          }),
                          child: Text(
                            'Cấp ${index + 1} (${_listMySystem[index].totalRecords ?? 0})',
                            style: _indexSelected == index
                                ? CommonStyles.size14W400Blue00(context)
                                : CommonStyles.size14W400Black1D(context),
                          ),
                        ),
                        _indexSelected == index
                            ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: 4,
                                width: 66,
                                decoration: BoxDecoration(
                                  color: const Color(0xff0066CC),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                height: 4,
                                width: 66,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                      ],
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                  ],
                ),
              ),
            ),
            _tableViewData(_indexSelected),
          ],
        ),
      ),
    );
  }

  Widget _tableViewData(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: _listMySystem[index].details != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xffEBEBEB),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xffEBEBEB),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Tên',
                                  style:
                                      CommonStyles.size14W700Black1D(context),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Số điện thoại',
                                  style:
                                      CommonStyles.size14W700Black1D(context),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Email',
                                  style:
                                      CommonStyles.size14W700Black1D(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                              _listMySystem[index].details != null
                                  ? _listMySystem[index].details!.length
                                  : 0, (i) {
                            final a = _listMySystem[index].details![i];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      a.fullName ?? '',
                                      style: CommonStyles.size14W400Black1D(
                                          context),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      a.phone ?? '',
                                      style: CommonStyles.size14W400Black1D(
                                          context),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      a.email ?? '',
                                      style: CommonStyles.size14W400Black1D(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(),
              ],
            )
          : const SizedBox(),
    );
  }
}
