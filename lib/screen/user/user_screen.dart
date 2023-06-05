import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/info_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';
import 'package:webviewtest/services/shared_preferences/shared_pref_services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  InfoModel? _infoModel = InfoModel();
  final String _language = 'Tiếng Việt';
  String _messageError = '';
  XFile? _image;
  bool _showButton = false;
  String _avatar = '';

  _getData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;
    final infoCustomer = sPref.infoCustomer;

    if (infoCustomer.isNotEmpty) {
      setState(() {
        _infoModel = InfoModel.fromJson(jsonDecode(infoCustomer));
      });
    } else {
      if (context.mounted) {
        BlocProvider.of<CustomerBloc>(context).add(const RequestGetInfo());
      }
    }
  }

  _getAvatar() async {
    BlocProvider.of<CustomerBloc>(context).add(const RequestGetAvatar());
  }

  _clearData() async {
    SharedPreferencesService sPref = await SharedPreferencesService.instance;

    sPref.setRememberMe(false);
    sPref.setIsLogin(false);

    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const NavigationScreen(
                isSelected: 2,
              )));
    }
  }

  @override
  void initState() {
    _getData();
    _getAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
        builder: (context, state) => _basicInfo(),
        listener: (context, state) {
          if (state is GetInfoLoading) {
            EasyLoading.show();
          } else if (state is GetInfoLoaded) {
            _infoModel = state.infoModel;

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is GetInfoLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is GetAvatarLoading) {
            EasyLoading.show();
          } else if (state is GetAvatarLoaded) {
            _avatar = state.avatar ?? '';

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is GetAvatarLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }

          if (state is UploadAvatarLoading) {
            EasyLoading.show();
          } else if (state is UploadAvatarLoaded) {
            BlocProvider.of<CustomerBloc>(context)
                .add(const RequestGetAvatar());
            showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      content: Text(
                        state.avatar.toString(),
                        style: CommonStyles.size14W400Grey33(context),
                      ),
                      actions: [
                        CupertinoDialogAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Đồng ý',
                              style: CommonStyles.size14W700Blue007A(context),
                            ))
                      ],
                    ));

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is UploadAvatarLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  // basic info
  Widget _basicInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: _image == null
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(_avatar.isNotEmpty
                                ? _avatar
                                : 'https://vnn-imgs-a1.vgcloud.vn/image1.ictnews.vn/_Files/2020/03/17/trend-avatar-1.jpg'),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(
                              File(_image!.path),
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          if (_image != image) {
                            _image = image;
                            _showButton = true;
                          }
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: SvgPicture.asset('assets/icons/ic_camera.svg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_showButton)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Text(
                      'Hình đại diện phải ở định dạng GIF hoặc JPEG có kích thước tối đa là 20 KB',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonButton(
                        title: 'upload',
                        onTap: () {
                          BlocProvider.of<CustomerBloc>(context).add(
                              RequestUploadAvatar(file: File(_image!.path)));
                          setState(() {
                            _showButton = false;
                          });
                        }),
                  ],
                ),
              ),
            _nameUser(),
            const SizedBox(
              height: 5,
            ),
            _emailUser(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Color(0xffEBEBEB),
              ),
            ),
            _settingComponent(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                thickness: 1,
                height: 1,
                color: Color(0xffEBEBEB),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         SvgPicture.asset('assets/icons/ic_language.svg'),
            //         const SizedBox(
            //           width: 14,
            //         ),
            //         Text(
            //           'Ngôn ngữ',
            //           style: CommonStyles.size14W400Black1D(context),
            //         ),
            //       ],
            //     ),
            //     DropdownButtonHideUnderline(
            //       child: ButtonTheme(
            //         alignedDropdown: true,
            //         child: DropdownButton<String>(
            //           value: _language,
            //           menuMaxHeight: 300,
            //           icon: const Icon(Icons.keyboard_arrow_down_rounded),
            //           elevation: 16,
            //           isDense: true,
            //           style: CommonStyles.size14W400Grey86(context),
            //           onChanged: (String? value) {
            //             // This is called when the user selects an item.
            //             setState(() {
            //               _language = value!;
            //             });
            //           },
            //           items: List.generate(1, (index) {
            //             return DropdownMenuItem<String>(
            //               value: 'Tiếng Việt',
            //               child: Text(
            //                 'Tiếng Việt',
            //                 style: CommonStyles.size14W400Black1D(context),
            //               ),
            //             );
            //           }).toList(),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              content: Text(
                                'Bạn có chắc muốn đăng xuất chứ?',
                                style: CommonStyles.size14W400Grey33(context),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      'Trở lại',
                                      style: CommonStyles.size14W400Grey86(
                                          context),
                                    )),
                                CupertinoDialogAction(
                                    onPressed: () => setState(() {
                                          _clearData();
                                        }),
                                    child: Text(
                                      'Đồng ý',
                                      style: CommonStyles.size14W700Blue007A(
                                          context),
                                    )),
                              ],
                            ));
                  });
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_logout.svg'),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      'Đăng xuất',
                      style: CommonStyles.size14W400RedFF(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // user name
  Widget _nameUser() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          _infoModel?.firstName ?? '',
          style: CommonStyles.size18W700Black1D(context),
        ),
      ),
    );
  }

  Widget _emailUser() {
    return Center(
      child: Text(
        _infoModel?.phone ?? '',
        style: CommonStyles.size14W400Black1D(context),
      ),
    );
  }

  Widget _settingComponent() {
    return Column(
      children: List.generate(ListCustom.listAccountSettings.length, (index) {
        var item = ListCustom.listAccountSettings[index];

        return GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => item.screen ?? const SizedBox()))
              .then((value) {
            setState(() {
              BlocProvider.of<ShopdunkBloc>(context)
                  .add(const RequestGetHideBottom(true));
            });
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(item.img.toString()),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      item.name,
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ],
            ),
          ),
        );
      }),
    );
  }
}
