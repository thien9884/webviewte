import 'package:flutter/material.dart';
import 'package:webviewtest/screen/user/account_info/account_info.dart';
import 'package:webviewtest/screen/user/account_order/account_order.dart';
import 'package:webviewtest/screen/user/account_address/user_address.dart';

class Resource {
  Widget? screen;
  int id;
  String name;
  String? img;
  String? imgUnselect;
  String? linkUrl;
  String? baseUrl;
  bool isCheck = false;
  bool showAddress = false;

  Resource({
    required this.id,
    required this.name,
    this.screen,
    this.img,
    this.imgUnselect,
    this.linkUrl,
    this.baseUrl,
    this.isCheck = false,
    this.showAddress = false,
  });
}

class InfoFooter {
  int id;
  String name;
  List<Resource> listExpand;

  InfoFooter({
    required this.id,
    required this.name,
    required this.listExpand,
  });
}

class ListCustom {
  static List<Resource> listGender = [
    Resource(id: 0, name: 'Nam'),
    Resource(id: 1, name: 'Nữ'),
  ];

  static List<Resource> listBottomBar = [
    Resource(
        id: 0,
        name: 'Flash sale',
        img: 'assets/icons/ic_news.svg',
        imgUnselect: 'assets/icons/ic_news_un.svg'),
    Resource(
        id: 1,
        name: 'News',
        img: 'assets/icons/ic_news.svg',
        imgUnselect: 'assets/icons/ic_news_un.svg'),
    Resource(
        id: 2,
        name: 'Shop',
        img: 'assets/icons/ic_monitor.svg',
        imgUnselect: 'assets/icons/ic_monitor_un.svg'),
    Resource(
        id: 3,
        name: 'Account',
        img: 'assets/icons/ic_user.svg',
        imgUnselect: 'assets/icons/ic_user_un.svg'),
    Resource(
        id: 4,
        name: 'Store',
        img: 'assets/icons/ic_bag.svg',
        imgUnselect: 'assets/icons/ic_bag_un.svg'),
  ];

  static List<Resource> listNews = [
    Resource(
      id: 0,
      img: 'assets/images/banner_12.png',
      name: '',
    ),
    Resource(
      id: 1,
      img: 'assets/images/care_mb_1000.jpeg',
      name: '',
    ),
    Resource(
      id: 2,
      img: 'assets/images/bonusaa.png',
      name: '',
    ),
  ];

  static List<Resource> listDrawers = [
    Resource(
        id: 0,
        img: 'assets/icons/ic_iphone.png',
        name: 'iPhone',
        linkUrl: 'iphone'),
    Resource(
        id: 1, img: 'assets/icons/ic_ipad.png', name: 'iPad', linkUrl: 'ipad'),
    Resource(
        id: 2, img: 'assets/icons/ic_mac.png', name: 'Mac', linkUrl: 'mac'),
    Resource(
        id: 3,
        img: 'assets/icons/ic_watch.png',
        name: 'Watch',
        linkUrl: 'apple-watch'),
    Resource(
        id: 4,
        img: 'assets/icons/ic_sound.png',
        name: 'Âm thanh',
        linkUrl: 'am-thanh'),
    Resource(
        id: 5,
        img: 'assets/icons/ic_accessory.png',
        name: 'Phụ kiện',
        linkUrl: 'phu-kien'),
  ];

  static List<Resource> listAccountSettings = [
    Resource(
      id: 0,
      img: 'assets/icons/ic_user_black.svg',
      name: 'Thông tin tài khoản',
      screen: const AccountInfo(),
    ),
    Resource(
      id: 1,
      img: 'assets/icons/ic_address.svg',
      name: 'Địa chỉ nhận hàng',
      screen: const UserAddress(),
    ),
    Resource(
      id: 2,
      img: 'assets/icons/ic_order.svg',
      name: 'Đơn đặt hàng',
      screen: const AccountOrder(),
    ),
    Resource(
      id: 3,
      img: 'assets/icons/ic_refund.svg',
      name: 'Hoàn trả hàng',
      screen: const AccountInfo(),
    ),
    Resource(
      id: 4,
      img: 'assets/icons/ic_change_password.svg',
      name: 'Đổi mật khẩu',
      screen: const AccountInfo(),
    ),
    Resource(
      id: 5,
      img: 'assets/icons/ic_history.svg',
      name: 'Lịch sử đánh giá sản phẩm',
      screen: const AccountInfo(),
    ),
  ];

  static List<InfoFooter> listFooter = [
    InfoFooter(
      id: 0,
      name: 'Thông tin',
      listExpand: [
        Resource(
          id: 0,
          name: 'Tin tức',
          linkUrl: 'tin-tuc',
        ),
        Resource(
          id: 1,
          name: 'Giới thiệu',
          linkUrl: 'giới-thiệu',
        ),
        Resource(
          id: 2,
          name: 'Check IMEI',
          linkUrl: 'check-imei',
        ),
        Resource(
          id: 3,
          name: 'Phương thức thanh toán',
          linkUrl: 'phuong-thuc-thanh-toan',
        ),
        Resource(
          id: 4,
          name: 'Thuê điểm bán lẻ',
          linkUrl: 'thue-diem-ban-le',
        ),
        Resource(
          id: 5,
          name: 'Bảo hành và sửa chữa',
          baseUrl: 'https://care.shopdunk.com/',
        ),
        Resource(
          id: 6,
          name: 'Tuyển dụng',
        ),
        Resource(
          id: 7,
          name: 'Đánh giá chất lượng, khiếu nại',
          linkUrl: 'web-review',
        ),
      ],
    ),
    InfoFooter(
      id: 1,
      name: 'Chính sách',
      listExpand: [
        Resource(
          id: 0,
          name: 'Thu cũ đổi mới',
          linkUrl: 'tis-trade-in-sale',
        ),
        Resource(
          id: 1,
          name: 'Giao hàng',
          linkUrl: 'chinh-sach-ship-cod',
        ),
        Resource(
          id: 2,
          name: 'Giao hàng (ZaloPay)',
          linkUrl: 'giao-hang-zalopay',
        ),
        Resource(
          id: 3,
          name: 'Huỷ giao dịch',
          linkUrl: 'chinh-sach-huy-giao-dich-va-hoan-tien',
        ),
        Resource(
          id: 4,
          name: 'Đổi trả',
          linkUrl: 'chinh-sach-doi-tra',
        ),
        Resource(
          id: 5,
          name: 'Bảo hành',
          linkUrl: 'chinh-sach-bao-hanh',
        ),
        Resource(
          id: 6,
          name: 'Giải quyết khiếu nại',
          linkUrl: 'giai-quyet-khieu-nai',
        ),
        Resource(
          id: 7,
          name: 'Bảo mật thông tin',
          linkUrl: 'chinh-sach-bao-mat',
        ),
        Resource(
          id: 8,
          name: 'Trả góp',
          linkUrl: 'tra-gop',
        ),
      ],
    ),
    InfoFooter(
      id: 2,
      name: 'Địa chỉ & Liên hệ',
      listExpand: [
        Resource(
          id: 0,
          name: 'Tài khoản của tôi',
          linkUrl: 'customer/info',
        ),
        Resource(
          id: 1,
          name: 'Đơn đặt hàng',
          linkUrl: 'order/history',
        ),
        Resource(
          id: 2,
          name: 'Hệ thống cửa hàng',
          linkUrl: 'he-thong-cua-hang',
        ),
        Resource(
          id: 3,
          name: 'Tìm Store trên Google Map',
          baseUrl: 'https://www.google.com/',
          linkUrl:
              'maps/@/data=!3m1!4b1!4m3!11m2!2s0Vq6CiZoSh-QELJ3lKHSgQ!3e3?shorturl=1',
          showAddress: true,
        ),
      ],
    ),
  ];

  static List listIcon = [
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_apple_watch.png',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_apple_watch.png',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_flash_sale_mb.jpeg',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_apple_watch.png',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_flash_sale_mb.jpeg',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_flash_sale_mb.jpeg',
        fit: BoxFit.cover,
      )),
    ),
    SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
          child: Image.asset(
        'assets/images/banner_flash_sale_mb.jpeg',
        fit: BoxFit.cover,
      )),
    ),
  ];

  static List listScrollBar = [
    Resource(
      id: 0,
      name: 'Tài khoản của tôi',
    ),
    Resource(
      id: 1,
      name: 'Đơn đặt hàng',
    ),
    Resource(
      id: 2,
      name: 'Hệ thống cửa hàng',
    ),
    Resource(
      id: 3,
      name: 'Tìm Store trên Google Map',
    ),
  ];
}
