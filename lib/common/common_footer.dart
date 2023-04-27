import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_bloc.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_event.dart';
import 'package:webviewtest/blocs/shopdunk/shopdunk_state.dart';
import 'package:webviewtest/common/responsive.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/banner/banner_model.dart';
import 'package:webviewtest/screen/load_html/load_html_screen.dart';

class Footer {
  final String? name;
  final String? img;
  List<Topics>? listFooter;

  Footer({
    this.name,
    this.img,
    this.listFooter,
  });
}

class CommonFooter extends StatefulWidget {
  const CommonFooter({Key? key}) : super(key: key);

  @override
  State<CommonFooter> createState() => _CommonFooterState();
}

class _CommonFooterState extends State<CommonFooter> {
  final List<Footer> _listFooter = [];

  // Sync data
  _getCategories() async {
    BlocProvider.of<ShopdunkBloc>(context).add(const RequestGetFooterBanner());
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopdunkBloc, ShopdunkState>(
        builder: (context, state) => _footerUI(),
        listener: (context, state) {
          if (state is FooterLoading) {
          } else if (state is FooterLoaded) {
            _listFooter.clear();
            _listFooter.add(Footer(
              name: 'Thông tin',
              listFooter: state.listTopics.topics
                  ?.where((element) => element.includeInFooterColumn1 == true)
                  .toList(),
            ));
            _listFooter.add(Footer(
              name: 'Chính sách',
              listFooter: state.listTopics.topics
                  ?.where((element) => element.includeInFooterColumn2 == true)
                  .toList(),
            ));
            _listFooter.add(Footer(
              name: 'Địa chỉ & liên hệ',
              listFooter: state.listTopics.topics
                  ?.where((element) => element.includeInFooterColumn3 == true)
                  .toList(),
            ));
            print(_listFooter);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          } else if (state is FooterLoadError) {
            AlertUtils.displayErrorAlert(context, state.message);

            if (EasyLoading.isShow) EasyLoading.dismiss();
          }
        });
  }

  // footer UI
  Widget _footerUI() {
    return _listFooter.isNotEmpty
        ? Container(
            color: Colors.black,
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              slivers: [
                _footerShop(),
                _listFooterExpand(),
                _infoShop(),
              ],
            ),
          )
        : Container();
  }

  // footer web
  Widget _footerShop() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/ic_sd_white.png',
                scale: Responsive.isMobile(context) ? 3 : 1.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  CommonText.footerInfo(context),
                  style: CommonStyles.size15W400WhiteD2(context),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets/icons/ic_face.png',
                      scale: Responsive.isMobile(context) ? 1 : 0.6,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/ic_tiktok.png',
                    scale: Responsive.isMobile(context) ? 1 : 0.6,
                  ),
                  Image.asset(
                    'assets/icons/ic_zalo.png',
                    scale: Responsive.isMobile(context) ? 1 : 0.6,
                  ),
                  Image.asset(
                    'assets/icons/ic_youtube.png',
                    scale: Responsive.isMobile(context) ? 1 : 0.6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // list footer expand information
  Widget _listFooterExpand() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: _listFooter.length,
            (context, index) {
      final items = _listFooter[index];
      return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          dense: true,
          child: ExpansionTile(
            iconColor: const Color(0xff424245),
            collapsedIconColor: const Color(0xff424245),
            backgroundColor: Colors.black,
            collapsedBackgroundColor: Colors.black,
            title: Container(
              height: 42,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xff424245)))),
              child: Text(
                items.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CommonStyles.size15W400WhiteD2(context),
              ),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 40),
            trailing: const Icon(Icons.keyboard_arrow_down_rounded),
            children: [
              _listItemExpand(items.listFooter ?? []),
            ],
          ),
        ),
      );
    }));
  }

  // list item expand
  Widget _listItemExpand(List<Topics> listResource) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int childIdx) {
        final item = listResource[childIdx];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        LoadHtmlScreen(data: item.body ?? ''))),
                child: Text(
                  item.title,
                  style: CommonStyles.size13W400Grey86(context),
                ),
              ),
              // item.showAddress ? _itemFooterInfo() : const SizedBox(),
            ],
          ),
        );
      },
      itemCount: listResource.length,
    );
  }

  // item footer info
  Widget _itemFooterInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: RichText(
              text: TextSpan(
                  text: 'Mua hàng: ',
                  style: CommonStyles.size13W400Grey86(context),
                  children: [
                TextSpan(
                  text: '1900.6626',
                  style: CommonStyles.size16W400Blue00(context),
                )
              ])),
        ),
        Text(
          CommonText.footerNhanh1(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          CommonText.footerNhanh2(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          CommonText.footerNhanh3(context),
          style: CommonStyles.size13W400Grey86(context),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: RichText(
              text: TextSpan(
                  text: 'Doanh nghiệp: ',
                  style: CommonStyles.size13W400Grey86(context),
                  children: [
                TextSpan(
                  text: '0822.688.668',
                  style: CommonStyles.size13W400Blue00(context),
                )
              ])),
        ),
      ],
    );
  }

  // info shop
  Widget _infoShop() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CommonText.footerGPKD(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              CommonText.footerAddress(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              CommonText.footerLaw(context),
              style:
                  CommonStyles.size13W400Grey51(context).copyWith(height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
