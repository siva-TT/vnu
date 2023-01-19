// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/presentation/common/pages/item_click.dart';

import 'package:vnu/constant/custom_text_style.dart';

class ItemMore extends StatelessWidget {
  final String title;
  final String previewImagePath;
  final String actionDescription;
  final String itemType;
  final String sysId;
  final String transId;
  final String extUrl;

  const ItemMore({
    Key? key,
    required this.title,
    required this.previewImagePath,
    required this.actionDescription,
    required this.itemType,
    required this.sysId,
    required this.transId,
    required this.extUrl,
  }) : super(key: key);

/*   @override
  State<ItemMore> createState() => _ItemMoreState();
}

class _ItemMoreState extends State<ItemMore> { */
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
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: Constant.padding10,),
                child: Container(
                  height: Constant.imageHeight35,
                  width: Constant.imageHeight35,
                  child: FadeInImage(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(LocalImages.placholderImagepath);
                    },
                    placeholder:
                        const AssetImage(LocalImages.placholderImagepath),
                    image: NetworkImage(previewImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Constant.padding20,
                        top: Constant
                            .padding05), //apply padding to all four sides
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.getTitleStyle(Colors.white),
                      maxLines: Constant.maxLines02,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon:
                    Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey),
              ),
            ]),
            Divider(thickness: Constant.thickness04, color: Colors.grey),
          ],
        ));
  }
}
