import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/lib.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/common/widgets/item_interest_widget.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';

class GiftshopList extends StatefulWidget {
  const GiftshopList({Key? key}) : super(key: key);

  @override
  State<GiftshopList> createState() => _GiftshopListState();
}

class _GiftshopListState extends State<GiftshopList> {
  @override
  void initState() {
    super.initState();
    getGiftshop();
  }

  Future<void> getGiftshop() async {
    context.read<GiftShopBloc>().add(GiftShopFetched());
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<GiftShopBloc, GiftShopState>(builder: (context, state) {
      int pos  = state.posts.length;

      if(pos > 3) pos = 3;

      return Container(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (state.posts.length > 0)
                Padding(
                  padding: EdgeInsets.only(left: Constant.padding15),
                  child: HomeWidgettitle(context, Strings.titlegiftshop),
                ),
               if (state.posts.length > 3)
                InkWell(
                  onTap: () => {print('Viewmore is clicked')},
                  child: Text.rich(
                    TextSpan(
                      style: CustomTextStyle.getDescStyle(Colors.white),
                      children: const [
                        TextSpan(
                          text: Strings.titleViewMore,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ), 
            ],
          ),
          SizedBox(
              height: Constant.homeWidgetImage,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pos,//state.posts.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ItemInterest(
                      title: state.posts[index].title,
                      previewImagePath: state.posts[index].previewImagePath,
                      actionDescription: "",
                      itemType: "",
                      sysId: "",
                      transId: state.posts[index].transactionId,
                      extUrl: "");
                },
              )),
        ]),
      );
    });
  }
}
