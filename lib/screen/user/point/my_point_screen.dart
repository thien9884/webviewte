import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/common/common_footer.dart';
import 'package:webviewtest/common/common_navigate_bar.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class MyPointScreen extends StatefulWidget {
  const MyPointScreen({Key? key}) : super(key: key);

  @override
  State<MyPointScreen> createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonNavigateBar(
      index: 2,
      showAppBar: false,
      child: Container(
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
            _dataTable(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  Widget _myPointAppBar() {
    return const CommonAppbar(title: 'Điểm thưởng');
  }

  // my point background
  Widget _myPointBackground() {
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
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xffE1EBF4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '2001 điểm',
                style: CommonStyles.size24W700Grey79(context),
              ),
            ),
          ),
        ],
      ),
    );
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
                    'Bạn đang ở mức Rank Kim Cương',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: const Color(0xffF5F5F7),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Ngày',
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
                      'Chú thích',
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
                20,
                (index) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(
                        '20/05/2023',
                        style: CommonStyles.size12W400Black1D(context),
                      ),
                    ),
                    DataCell(
                      Text(
                        '10.000',
                        style: CommonStyles.size12W400Black1D(context),
                      ),
                    ),
                    DataCell(
                      Text(
                        'Admin cho',
                        style: CommonStyles.size12W400Black1D(context),
                      ),
                    ),
                    DataCell(
                      Text(
                        '20/05/2023',
                        style: CommonStyles.size12W400Black1D(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
