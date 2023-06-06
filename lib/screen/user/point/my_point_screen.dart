import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:webviewtest/blocs/my_rank/my_rank_bloc.dart';
import 'package:webviewtest/blocs/my_rank/my_rank_event.dart';
import 'package:webviewtest/blocs/my_rank/my_rank_state.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/my_rank/my_rank_model.dart';

class MyPointScreen extends StatefulWidget {
  const MyPointScreen({Key? key}) : super(key: key);

  @override
  State<MyPointScreen> createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  int _point = 0;
  int _pagesSelected = 0;
  String _myRankTittle = '';
  String _messageError = '';
  MyRankModel? _myRankModel;
  final ScrollController _pageScrollController = ScrollController();

  _getMyRank() {
    if (_point >= 2000) {
      _myRankTittle = 'Bạn đang ở mức Rank Kim Cương';
    } else if (_point >= 1000 && _point < 2000) {
      _myRankTittle = 'Bạn đang ở mức Rank Vàng';
    } else if (_point >= 500 && _point < 1000) {
      _myRankTittle = 'Bạn đang ở mức Rank Bạc';
    } else {
      _myRankTittle = 'Bạn hiện tại chưa có Rank';
    }
  }

  _getData() {
    BlocProvider.of<MyRankBloc>(context).add(const RequestGetMyRank(1));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyRankBloc, MyRankState>(
        builder: (context, state) => _myRankUI(),
        listener: (context, state) {
          if (state is MyRankLoading) {
            EasyLoading.show();
          } else if (state is MyRankLoaded) {
            _myRankModel = state.myRankModel;
            _point = _myRankModel?.rewardPointsBalance ?? 0;
            _getMyRank();

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is MyRankLoadError) {
            if (_messageError.isEmpty) {
              _messageError = state.message;
              AlertUtils.displayErrorAlert(context, _messageError);
            }
            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  Widget _myRankUI() {
    return CommonNavigateBar(
      index: 2,
      showAppBar: false,
      child: _myRankModel != null
          ? Container(
              color: Colors.white,
              child: CustomScrollView(
                slivers: [
                  _myPointAppBar(),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _myPointBackground(),
                        _rankLevel(),
                        _myRank(),
                      ],
                    ),
                  ),
                  if (_myRankModel != null &&
                      _myRankModel!.rewardPoints!.isNotEmpty)
                    _dataTable(),
                  if (_myRankModel != null &&
                      _myRankModel?.pagerModel != null &&
                      _myRankModel!.pagerModel!.totalPages! > 1)
                    _pagesNumber(),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: 1,
                          (context, index) => const CommonFooter())),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _myPointAppBar() {
    return const CommonAppbar(title: 'Điểm thưởng');
  }

  // my point background
  Widget _myPointBackground() {
    if (_point >= 2000) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                      'assets/icons/ic_diamond_background.svg'),
                ),
                Center(
                  child: SvgPicture.asset('assets/icons/ic_cup_diamond.svg'),
                ),
              ],
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffE0D8F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${NumberFormat.decimalPattern().format(_point)} điểm',
                  style: CommonStyles.size24W700Purple35(context),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_point >= 1000 && _point < 2000) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child:
                      SvgPicture.asset('assets/icons/ic_gold_background.svg'),
                ),
                Center(
                  child: SvgPicture.asset('assets/icons/ic_cup_gold.svg'),
                ),
              ],
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffFFFAE6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${NumberFormat.decimalPattern().format(_point)} điểm',
                  style: CommonStyles.size24W700YellowFF(context),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_point >= 500 && _point < 1000) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child:
                      SvgPicture.asset('assets/icons/ic_silver_background.svg'),
                ),
                Center(
                  child: SvgPicture.asset('assets/icons/ic_cup_silver.svg'),
                ),
              ],
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffE1EBF4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${NumberFormat.decimalPattern().format(_point)} điểm',
                  style: CommonStyles.size24W700Grey79(context),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child:
                      SvgPicture.asset('assets/icons/ic_background_norank.svg'),
                ),
                Center(
                  child: SvgPicture.asset('assets/icons/ic_cup_norank.svg'),
                ),
              ],
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff86868B).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${NumberFormat.decimalPattern().format(_point)} điểm',
                  style: CommonStyles.size24W700Grey86(context),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  // rank level
  Widget _rankLevel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff8E98C9),
                        Color(0xffF5BD45),
                        Color(0xff6D37ED),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Text(
                      '500 điểm',
                      style: CommonStyles.size14W700Grey79(context),
                    ),
                  ),
                  SizedBox(
                      height: 18,
                      child: SvgPicture.asset(
                          'assets/icons/ic_silver_polygon.svg')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SvgPicture.asset(
                      'assets/icons/ic_cup_silver.svg',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  Text(
                    'Bạc',
                    style: CommonStyles.size14W700Grey79(context),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Text(
                      '1000 điểm',
                      style: CommonStyles.size14W700GoldFF(context),
                    ),
                  ),
                  SizedBox(
                      height: 18,
                      child:
                          SvgPicture.asset('assets/icons/ic_gold_polygon.svg')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SvgPicture.asset(
                      'assets/icons/ic_cup_gold.svg',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  Text(
                    'Vàng',
                    style: CommonStyles.size14W700GoldFF(context),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Text(
                      '2000 điểm',
                      style: CommonStyles.size14W700Purple35(context),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    child:
                        SvgPicture.asset('assets/icons/ic_diamond_polygon.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SvgPicture.asset(
                      'assets/icons/ic_cup_diamond.svg',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  Text(
                    'Kim cương',
                    style: CommonStyles.size14W700Purple35(context),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // my rank
  Widget _myRank() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xffF5F5F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '•',
                      style: CommonStyles.size14W400Grey86(context),
                    ),
                  ),
                  Text(
                    _myRankTittle,
                    style: CommonStyles.size14W400Grey86(context),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    '•',
                    style: CommonStyles.size14W400Grey86(context),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Hãy dùng điểm của mình mỗi khi mua sản phẩm tại ShopDunk bạn nhé',
                    style: CommonStyles.size14W400Grey86(context),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataTable() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
        color: const Color(0xffF5F5F7),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16,
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Ngày nhận',
                      style: CommonStyles.size14W700Black1D(context),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Điểm thưởng',
                      style: CommonStyles.size14W700Black1D(context),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Ghi chú',
                      style: CommonStyles.size14W700Black1D(context),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Ngày hết hạn',
                      style: CommonStyles.size14W700Black1D(context),
                    ),
                  ),
                ),
              ],
              rows: List.generate(
                _myRankModel!.rewardPoints!.length,
                (index) {
                  final item = _myRankModel!.rewardPoints![index];
                  String createOnDate = '';
                  String endDateTime = '';
                  if (item.createdOn != null && item.createdOn!.isNotEmpty) {
                    var createOn = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
                        .parseUTC(item.createdOn ?? '')
                        .toLocal();
                    createOnDate =
                        DateFormat("dd/MM/yyyy HH:mm").format(createOn);
                  }
                  if (item.endDate != null && item.endDate!.isNotEmpty) {
                    var endDate = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
                        .parseUTC(item.endDate ?? '')
                        .toLocal();
                    endDateTime =
                        DateFormat("dd/MM/yyyy HH:mm").format(endDate);
                  }

                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        SizedBox(
                          width: 80,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      createOnDate,
                                      style: CommonStyles.size12W400Black1D(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          NumberFormat.decimalPattern().format(item.points),
                          style: CommonStyles.size12W400Black1D(context),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.message ?? '',
                                      style: CommonStyles.size12W400Black1D(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 80,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      endDateTime,
                                      style: CommonStyles.size12W400Black1D(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // pages number
  Widget _pagesNumber() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xffF5F5F7),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Center(
          child: SizedBox(
            height: 35,
            width: _myRankModel!.pagerModel!.totalPages! > 6
                ? double.infinity
                : 35 * (_myRankModel!.pagerModel!.totalPages! + 1) + 25,
            child: Row(
              children: [
                if (_myRankModel!.pagerModel!.totalPages! > 6 &&
                    _pagesSelected >= 5)
                  GestureDetector(
                    onTap: () {
                      if (_pagesSelected != 0) {
                        setState(() {
                          _pagesSelected = 0;
                          BlocProvider.of<MyRankBloc>(context)
                              .add(const RequestGetMyRank(1));
                          _pageScrollController.animateTo(
                            _pageScrollController.position.minScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        });
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _pageScrollController,
                      itemCount: _myRankModel!.pagerModel!.totalPages!,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          _pagesSelected = index;
                          BlocProvider.of<MyRankBloc>(context)
                              .add(RequestGetMyRank(index + 1));
                        }),
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: _pagesSelected == index
                                ? Colors.blueAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: _pagesSelected == index
                                ? CommonStyles.size14W400White(context)
                                : CommonStyles.size14W400Black1D(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_myRankModel!.pagerModel!.totalPages! > 6 &&
                    _pagesSelected <=
                        (_myRankModel!.pagerModel!.totalPages! - 5))
                  GestureDetector(
                    onTap: () {
                      if (_pagesSelected !=
                          _myRankModel!.pagerModel!.totalPages! - 1) {
                        setState(() {
                          _pagesSelected =
                              _myRankModel!.pagerModel!.totalPages! - 1;
                          BlocProvider.of<MyRankBloc>(context).add(
                              RequestGetMyRank(
                                  _myRankModel!.pagerModel!.totalPages!));
                          _pageScrollController.animateTo(
                            _pageScrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                          );
                        });
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
