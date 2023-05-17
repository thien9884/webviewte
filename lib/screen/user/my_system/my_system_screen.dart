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
  bool _isVisible = false;
  bool _expandLevel1 = false;
  bool _expandLevel2 = false;
  bool _expandLevel3 = false;
  late AnimationController _controller1;
  late Animation<double> _animation1;
  late AnimationController _controller2;
  late Animation<double> _animation2;
  late AnimationController _controller3;
  late Animation<double> _animation3;

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
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation3 = CurvedAnimation(
      parent: _controller3,
      curve: Curves.fastLinearToSlowEaseIn,
    );
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
            print(_listMySystem);

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
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Hệ thống của tôi',
            style: CommonStyles.size24W400Black1D(context),
          ),
        ),
      ),
    );
  }

  Widget _myReferralCode() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Mã giới thiệu của bạn',
          style: CommonStyles.size15W700Black1D(context),
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
            Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _expandLevel1 = !_expandLevel1;
                    if (_expandLevel1) {
                      _controller1.forward();
                    } else {
                      _controller1.animateBack(0,
                          duration: const Duration(milliseconds: 500));
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffEBEBEB),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cấp 1 (${_listMySystem[0].totalRecords ?? 0})',
                          style: CommonStyles.size14W700Black1D(context),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xff86868B),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _expandLevel1 && _listMySystem[0].details != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SizeTransition(
                            sizeFactor: _animation1,
                            axis: Axis.vertical,
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
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Color(0xffEBEBEB),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Tên',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Số điện thoại',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Email',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        _listMySystem[0].details != null
                                            ? _listMySystem[0].details!.length
                                            : 0, (index) {
                                      final a =
                                          _listMySystem[0].details![index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                a.fullName ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.phone ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.email ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
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
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _expandLevel2 = !_expandLevel2;
                    if (_expandLevel2) {
                      _controller2.forward();
                    } else {
                      _controller2.animateBack(0,
                          duration: const Duration(milliseconds: 500));
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffEBEBEB),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cấp 2 (${_listMySystem[1].totalRecords ?? 0})',
                          style: CommonStyles.size14W700Black1D(context),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xff86868B),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _expandLevel2 && _listMySystem[1].details != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SizeTransition(
                            sizeFactor: _animation2,
                            axis: Axis.vertical,
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
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Color(0xffEBEBEB),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Tên',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Số điện thoại',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Email',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        _listMySystem[1].details != null
                                            ? _listMySystem[1].details!.length
                                            : 0, (index) {
                                      final a =
                                          _listMySystem[1].details![index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                a.fullName ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.phone ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.email ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
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
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    _expandLevel3 = !_expandLevel3;
                    if (_expandLevel3) {
                      _controller3.forward();
                    } else {
                      _controller3.animateBack(0,
                          duration: const Duration(milliseconds: 500));
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffEBEBEB),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cấp 3 (${_listMySystem[2].totalRecords ?? 0})',
                          style: CommonStyles.size14W700Black1D(context),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xff86868B),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _expandLevel3 && _listMySystem[2].details != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SizeTransition(
                            sizeFactor: _animation3,
                            axis: Axis.vertical,
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
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Color(0xffEBEBEB),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Tên',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Số điện thoại',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Email',
                                            style:
                                                CommonStyles.size14W700Black1D(
                                                    context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        _listMySystem[2].details != null
                                            ? _listMySystem[2].details!.length
                                            : 0, (index) {
                                      final a =
                                          _listMySystem[2].details![index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                a.fullName ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.phone ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                a.email ?? '',
                                                style: CommonStyles
                                                    .size14W400Black1D(context),
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
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
