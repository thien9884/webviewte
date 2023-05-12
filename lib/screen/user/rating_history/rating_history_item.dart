import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webviewtest/blocs/customer/customer_bloc.dart';
import 'package:webviewtest/blocs/customer/customer_event.dart';
import 'package:webviewtest/blocs/customer/customer_state.dart';
import 'package:webviewtest/constant/text_style_constant.dart';
import 'package:webviewtest/model/customer/product_rating_model.dart';
import 'package:webviewtest/screen/webview/shopdunk_webview.dart';

class RatingHistoryItem extends StatefulWidget {
  final String reviewText;
  final double rating;
  final String timeReview;
  final int productId;

  const RatingHistoryItem(
      {required this.reviewText,
      required this.rating,
      required this.timeReview,
      required this.productId,
      Key? key})
      : super(key: key);

  @override
  State<RatingHistoryItem> createState() => _RatingHistoryItemState();
}

class _RatingHistoryItemState extends State<RatingHistoryItem> {
  ProductHistory _productsModel = ProductHistory();

  _getData() async {
    BlocProvider.of<CustomerBloc>(context)
        .add(RequestGetProductRating(widget.productId));
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
        builder: (context, state) => _itemUI(),
        listener: (context, state) {

        });
  }

  Widget _itemUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.reviewText,
              style: CommonStyles.size14W400Black1D(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RatingBar(
                    initialRating: widget.rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star_rate_rounded,
                        color: Color(0xfffeb700),
                      ),
                      half: const Icon(
                        Icons.star_half_rounded,
                        color: Color(0xfffeb700),
                      ),
                      empty: const Icon(
                        Icons.star_border_rounded,
                        color: Color(0xfffeb700),
                      ),
                    ),
                    itemSize: 25,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                    onRatingUpdate: (rating) {},
                    updateOnDrag: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(
                        'https://shopdunk.com/images/uploaded-source/icon/Ellipse%20169.png'),
                  ),
                  Text(
                    widget.timeReview,
                    style: CommonStyles.size13W400Grey88(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    'Đánh giá sản phẩm:',
                    style: CommonStyles.size13W400Grey88(context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShopDunkWebView(
                              url: _productsModel.seName ?? '',
                            ))),
                    child: Text(
                      _productsModel.name ?? '',
                      style: CommonStyles.size14W700Blue00(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
