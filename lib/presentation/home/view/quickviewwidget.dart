import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:rxcommon/presentation/quickview/quickviews.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/presentation/common/widgets/item_quickview_widget.dart';

class QuickViewItem extends StatefulWidget {
  @override
  _QuickViewItemState createState() => _QuickViewItemState();
}

class _QuickViewItemState extends State<QuickViewItem> {
  late CarouselSliderController _sliderController;
double height = 0.0;
GlobalKey _globalKey = GlobalKey();
  @override
  void initState() {
    
     
    getQuickView();
    _sliderController = CarouselSliderController();
    super.initState();
  }

  Future<void> getQuickView() async {
    context.read<QuickViewBloc>().add(QuickViewFetched());
  }

  @override
  Widget build(BuildContext context) {
    return QuickViewWidget();
  }

  Widget placeholder() {
    return Container(
      height: Constant.cardHeight100,
      width: Constant.cardHeight100,
      child: ClipRRect(
        child: Image.asset(
          LocalImages.placholderImagepath,
        ),
      ),
    );
  }

  Widget QuickViewWidget() {
    return BlocBuilder<QuickViewBloc, QuickViewState>(
        builder: (context, state) {
      if (state.status == QuickViewStatus.initial) {
        return placeholder();
      }

      if (state.status == QuickViewStatus.loading) {
        return placeholder();
      }

      if (state.status == QuickViewStatus.error) {
        return placeholder();
      }

      return CarouselSlider.builder(
        unlimitedMode: true,
        controller: _sliderController,
        slideBuilder: (index) {
          return ItemQuickView(
            title: state.posts[index].title,
            previewImagePath: state.posts[index].quickViewURL,
            actionDescription: state.posts[index].actionDescription,
            itemType: state.posts[index].itemType,
            sysId: state.posts[index].venueSystemId,
            transId: state.posts[index].transactionId,
            extUrl: state.posts[index].extUrl,
          );
        },
        slideIndicator: CircularStaticIndicator(
            padding: EdgeInsets.only(bottom: Constant.padding50),
            indicatorBackgroundColor: Colors.grey,
            indicatorRadius: 5,
            indicatorBorderWidth: 5,
            itemSpacing: 15,
            currentIndicatorColor: Colors.white),
        itemCount: state.posts.length,
        initialPage: 0,
        enableAutoSlider: true,
      );
    });
  }
}
