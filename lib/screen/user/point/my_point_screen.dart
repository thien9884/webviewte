import 'package:flutter/material.dart';
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
      child: Container(
        color: const Color(0xffF5F5F7),
        child: CustomScrollView(
          slivers: [
            _myPointUI(),
            _myPointBackground(),
            _dataTable(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: 1, (context, index) => const CommonFooter())),
          ],
        ),
      ),
    );
  }

  Widget _myPointUI() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Thành tích giới thiệu',
            style: CommonStyles.size24W400Black1D(context),
          ),
        ),
      ),
    );
  }

  Widget _myPointBackground() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/img_point_background.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Số điểm đang có của bạn',
                    style: CommonStyles.size15W700Black1D(context),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff002650),
                        Color(0xff25005C),
                        Color(0xff680036),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '200.000 điểm',
                    style: CommonStyles.size24W700White(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataTable() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                              '10000000',
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
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
