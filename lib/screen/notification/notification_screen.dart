import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/noti/noti_bloc.dart';
import 'package:webviewtest/blocs/noti/noti_event.dart';
import 'package:webviewtest/blocs/noti/noti_state.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/notification/noti_model.dart';
import 'package:webviewtest/screen/navigation_screen/navigation_screen.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  int size = 5;
  int? _totalSize;
  String _messageError = '';
  List<RewardPointsNoti> _listNoti = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isVisible = false;

  _getData() {
    BlocProvider.of<NotiBloc>(context).add(RequestGetNoti(size));
  }

  void _getMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        size += 5;
      });
      if (_totalSize != null && _totalSize! + 5 >= size) {
        BlocProvider.of<NotiBloc>(context).add(RequestGetNoti(size));
      }
    }
  }

  _getHideBottomValue() {
    _isVisible = true;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
            BlocProvider.of<ShopdunkBloc>(context)
                .add(RequestGetHideBottom(_isVisible));
          });
        }
      }
      if (_scrollController.position.userScrollDirection ==
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
    _getData();
    _getHideBottomValue();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotiBloc, NotiState>(
        builder: (context, state) => _notificationUI(),
        listener: (context, state) {
          if (state is NotiLoading) {
            EasyLoading.show();
          } else if (state is NotiLoaded) {
            _isLoading = false;
            _listNoti = state.pointNotiModel.rewardPoints ?? [];
            _totalSize = state.pointNotiModel.pagerModel?.totalRecords;
            print(_listNoti);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is NotiLoadError) {
            if (_messageError.isEmpty) {
              _messageError = 'Vui lòng đăng nhập để xem thông báo';
              AlertUtils.displayErrorAlert(context, _messageError,
                  onPress: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NavigationScreen(
                            isSelected: 2,
                          ))));
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _notificationUI() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _listNoti.length,
        itemBuilder: (context, index) {
          final item = _listNoti[index];
          DateTime dateValue;
          String? formattedDate;
          try {
            dateValue = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
                .parseUTC(item.createdOn ?? '')
                .toLocal();
            formattedDate = DateFormat("dd/MM/yyyy").add_jm().format(dateValue);
          } catch (e) {}

          if (index == _listNoti.length) {
            return _buildProgressIndicator();
          } else {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  width: 1,
                  color: Color(0xffEBEBEB),
                )),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông báo điểm thưởng',
                    style: CommonStyles.size16W700Black1D(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      item.message ?? '',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ),
                  Text(
                    'Số điểm của bạn ${item.points.toString().startsWith('-') ? item.points : '+${item.points}'}',
                    style: CommonStyles.size14W400Black1D(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'Tổng số điểm đang có: ${item.pointsBalance}',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                  ),
                  Text(
                    'Ngày hết hạn: Vĩnh viễn',
                    style: CommonStyles.size14W400Black1D(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      formattedDate ?? '',
                      style: CommonStyles.size14W400Grey86(context),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
