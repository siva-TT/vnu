// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/presentation/common/pages/item_click.dart';

class ItemInterest extends StatefulWidget {
  final String title;
  final String previewImagePath;
  final String actionDescription;
  final String itemType;
  final String sysId;
  final String transId;
  final String extUrl;

  const ItemInterest({
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
  State<ItemInterest> createState() => _ItemInterestState();
}

class _ItemInterestState extends State<ItemInterest> {
  @override
  Widget build(BuildContext context) {
   // print(widget.previewImagePath +" title "+ widget.title);
    return InkWell(
        onTap: () {
          print('position is clicked');
          HandleClickItem(
              context,
              widget.title,
              widget.previewImagePath,
              widget.actionDescription,
              widget.itemType,
              widget.sysId,
              widget.transId,
              widget.extUrl);
        },
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Constant.padding10,
                  top: Constant.padding05),
              child: Column(children: <Widget>[
                Container(
                  height: Constant.imageHeight,
                  width: Constant.imageHeight,
                  child: Card(
                    color: Colors.transparent,
                    child: ClipRRect(
                      child: FadeInImage(
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(LocalImages.placholderImagepath);
                        },
                        placeholder:
                            const AssetImage(LocalImages.placholderImagepath),
                        image: NetworkImage(widget.previewImagePath), //setImage(widget.previewImagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.circular(Constant.cornerRadius12),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constant.cornerRadius12),
                        side: BorderSide(
                            width: Constant.borderWidth02,
                            color: Theme.of(context).dividerColor)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: Constant.imageHeight,
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Constant
                              .padding05), //apply padding to all four sides
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.getDescStyle(Colors.white),
                        maxLines: Constant.maxLines02,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
