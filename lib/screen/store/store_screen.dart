import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webviewtest/blocs/news/news_bloc.dart';
import 'package:webviewtest/blocs/news/news_state.dart';
import 'package:webviewtest/common/common_button.dart';
import 'package:webviewtest/constant/alert_popup.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _city = '0';
  String _district = '0';
  String _store = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NewsBloc, NewsState>(
        builder: (context, state) => _buildNewsUI(),
        listener: (context, state) {
          if (state is NewsLoading) {
          } else if (state is NewsLoaded) {
          } else if (state is NewsLoadError) {
            if (EasyLoading.isShow) EasyLoading.dismiss();

            AlertUtils.displayErrorAlert(context, state.message);
          }
        },
      );

  // build UI
  Widget _buildNewsUI() {
    return Container(
      color: const Color(0xfff5f5f7),
      child: CustomScrollView(
        slivers: [
          _tittleStore(),
          _findStore(),
        ],
      ),
    );
  }

  // tittle store
  Widget _tittleStore() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Xem chi tiết cửa hàng',
            style: CommonStyles.size24W700Black1D(context),
          ),
        ),
      ),
    );
  }

  // find store
  Widget _findStore() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _listDropdownCity(),
              _listDropdownDistrict(),
              _listDropdownStore(),
              _findStoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  // list drop down city
  Widget _listDropdownCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Tỉnh, thành phố:',
            style: CommonStyles.size15W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
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
              items: List.generate(
                  20,
                  (index) => DropdownMenuItem<String>(
                        value: index.toString(),
                        child: Center(child: Text('city $index')),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // list drop down district
  Widget _listDropdownDistrict() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Quận, huyện:',
              style: CommonStyles.size15W400Black1D(context),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffEBEBEB), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _district,
                menuMaxHeight: 300,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                elevation: 16,
                isDense: true,
                style: CommonStyles.size14W400Grey86(context),
                onChanged: (String? value) {
                  setState(() {
                    _district = value!;
                  });
                },
                items: List.generate(
                    20,
                    (index) => DropdownMenuItem<String>(
                          value: index.toString(),
                          child: Center(child: Text('district $index')),
                        )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // list drop down store
  Widget _listDropdownStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Cửa hàng:',
            style: CommonStyles.size15W400Black1D(context),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffEBEBEB), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _store,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              elevation: 16,
              isDense: true,
              style: CommonStyles.size14W400Grey86(context),
              onChanged: (String? value) {
                setState(() {
                  _store = value!;
                });
              },
              items: List.generate(
                  20,
                  (index) => DropdownMenuItem<String>(
                        value: index.toString(),
                        child: Center(child: Text('store $index')),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // find store button
  Widget _findStoreButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      child: SizedBox(
          width: 200, child: CommonButton(title: 'Xem chi tiết', onTap: () {})),
    );
  }
}
