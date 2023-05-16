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
  late AnimationController _controller;
  late Animation<double> _animation;

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
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
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
            _listMySystem.sort((a, b) => a.level!.compareTo(b.level!.toInt()));

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
        child: _listMySystem.isNotEmpty
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
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(childCount: _listMySystem.length,
            (context, index) {
          final item = _listMySystem[index];

          return Column(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  item.expandLevel = !item.expandLevel;
                  if (item.expandLevel) {
                    _controller.forward();
                  } else {
                    _controller.animateBack(0,
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
                        'Cấp ${item.level} (${item.totalRecords})',
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: item.expandLevel
                    ? SizeTransition(
                        sizeFactor: _animation,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Tên',
                                        style: CommonStyles.size14W700Black1D(
                                            context),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Số điện thoại',
                                        style: CommonStyles.size14W700Black1D(
                                            context),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Email',
                                        style: CommonStyles.size14W700Black1D(
                                            context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: List.generate(item.details!.length,
                                    (index) {
                                  final a = item.details![index];

                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            a.fullName ?? '',
                                            style:
                                                CommonStyles.size14W400Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            a.phone ?? '',
                                            style:
                                                CommonStyles.size14W400Black1D(
                                                    context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            a.email ?? '',
                                            style:
                                                CommonStyles.size14W400Black1D(
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
                        // child: SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: DataTable(
                        //     columns: [
                        //       DataColumn(
                        //         label: Expanded(
                        //           child: Text(
                        //             'Tên',
                        //             style:
                        //                 CommonStyles.size14W700Black1D(context),
                        //           ),
                        //         ),
                        //       ),
                        //       DataColumn(
                        //         label: Expanded(
                        //           child: Text(
                        //             'Số điện thoại',
                        //             style:
                        //                 CommonStyles.size14W700Black1D(context),
                        //           ),
                        //         ),
                        //       ),
                        //       DataColumn(
                        //         label: Expanded(
                        //           child: Text(
                        //             'Email',
                        //             style:
                        //                 CommonStyles.size14W700Black1D(context),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //     rows: List.generate(
                        //       item.details!.length,
                        //       (index) {
                        //         final dataColumn = item.details![index];
                        //
                        //         return DataRow(
                        //           cells: [
                        //             DataCell(
                        //               Text(
                        //                 dataColumn.fullName ?? '',
                        //                 style: CommonStyles.size12W400Black1D(
                        //                     context),
                        //               ),
                        //             ),
                        //             DataCell(
                        //               Text(
                        //                 dataColumn.phone ?? '',
                        //                 style: CommonStyles.size12W400Black1D(
                        //                     context),
                        //               ),
                        //             ),
                        //             DataCell(
                        //               Text(
                        //                 dataColumn.email ?? '',
                        //                 style: CommonStyles.size12W400Black1D(
                        //                     context),
                        //               ),
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                      )
                    : const SizedBox(),
              ),
            ],
          );
        }),
      ),
    );
  }
}