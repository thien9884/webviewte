import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webviewtest/common/common_appbar.dart';
import 'package:webviewtest/constant/list_constant.dart';
import 'package:webviewtest/constant/text_style_constant.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  int _selectGender = -1;
  final String _day = '1';
  final String _month = '1';
  final String _year = '1990';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonAppbar(title: 'Thông tin tài khoản'),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  'Tên',
                  style: CommonStyles.size14W400Black1D(context),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffEBEBEB),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffEBEBEB),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  'Email',
                  style: CommonStyles.size14W400Black1D(context),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffEBEBEB),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xffEBEBEB),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  children: [
                    Text(
                      'Giới tính:',
                      style: CommonStyles.size14W400Black1D(context),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 20,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: ListCustom.listGender.length,
                          itemBuilder: (context, index) {
                            final item = ListCustom.listGender[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectGender = item.id;
                                });
                              },
                              child: Row(
                                children: [
                                  _selectGender == item.id
                                      ? SvgPicture.asset(
                                          'assets/icons/ic_radio_check.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/ic_radio_uncheck.svg',
                                          height: 15,
                                          width: 15,
                                        ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    item.name,
                                    style:
                                        CommonStyles.size14W400Black1D(context),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            width: 42,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: _listDropDown(31, 1, _day, 'Ngày')),
                  const SizedBox(width: 10),
                  Flexible(child: _listDropDown(12, 1, _month, 'Tháng')),
                  const SizedBox(width: 10),
                  Flexible(child: _listDropDown(50, 1990, _year, 'Năm')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listDropDown(int length, int count, String type, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            name,
            style: CommonStyles.size14W400Black1D(context),
          ),
        ),
        SizedBox(
          height: 60,
          child: Center(
            child: DropdownButtonFormField<String>(

              value: type,
              menuMaxHeight: 300,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffEBEBEB)),
                borderRadius: BorderRadius.circular(8),
              )),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                setState(() {
                  type = value!;
                });
              },
              items: List.generate(
                  length,
                  (index) => DropdownMenuItem<String>(
                        value: (index + count).toString(),
                        child: Center(child: Text((index + count).toString())),
                      )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
