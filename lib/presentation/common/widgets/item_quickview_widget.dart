import 'package:flutter/material.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/presentation/common/pages/item_click.dart';
import '../../../theme/theme.dart';
import 'package:vnu/constant/custom_text_style.dart';

class ItemQuickView extends StatelessWidget {
  final String title;
  final String previewImagePath;
  final String actionDescription;
  final String itemType;
  final String sysId;
  final String transId;
  final String extUrl;

  const ItemQuickView({
    Key? key,
    required this.title,
    required this.previewImagePath,
    required this.actionDescription,
    required this.itemType,
    required this.sysId,
    required this.transId,
    required this.extUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        print('position is clicked');
        HandleClickItem(context, title, previewImagePath, actionDescription,
            itemType, sysId, transId, extUrl);
      },
      child: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height/2.8) -30, // Constant.cardHeight190,
           // height:  Constant.cardHeight190,
            width: MediaQuery.of(context).size.width,
            //alignment: Alignment.center,
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                placeholder: LocalImages.placholderImagepath,
                placeholderFit: BoxFit.fitHeight,
                image: previewImagePath,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    LocalImages.placholderImagepath,
                    height: Constant.cardHeight100,
                    width: Constant.cardHeight100,
                  );
                },
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              //   color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                    left: Constant.padding15,
                    right: Constant.padding10,
                    top: Constant.padding10), //apply padding to all four sides
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.getsubTitleStyle(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
