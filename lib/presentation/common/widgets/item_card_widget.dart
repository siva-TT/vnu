import 'package:flutter/material.dart';
import 'package:vnu/constant/asset_images.dart';
import 'package:vnu/constant/constant.dart';
import 'package:vnu/constant/custom_text_style.dart';
import 'package:vnu/constant/strings.dart';
import 'package:vnu/presentation/common/pages/item_click.dart';
import 'package:vnu/presentation/common/widgets/textfield.dart';
import 'package:vnu/theme/theme.dart';
import '../../../theme/theme.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String previewImagePath;
  final String actionDescription;
  final String itemType;
  final String sysId;
  final String transId;
  final String extUrl;
  final String description;
  final String startDate;
  final String endDate;
  final List<dynamic> interest;

  const ItemCard({
    Key? key,
    required this.title,
    required this.previewImagePath,
    required this.actionDescription,
    required this.itemType,
    required this.sysId,
    required this.transId,
    required this.extUrl,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.interest,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double widthInterest = 100, tempwidthInterest = -1;
    int CHILDREN_COUNT = 3;
    //  List<Widget> children = []..length = 3;
    Widget dividerWidget = Divider(
      height: 119.0,
      thickness: 2,
      color: Colors.white,
    );
    List<Widget> children =
        List<Widget>.filled(CHILDREN_COUNT, dividerWidget, growable: true);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    int physicalWidth =
        (mediaQueryData.size.width * mediaQueryData.devicePixelRatio).floor();
    physicalWidth = physicalWidth - 50;
    for (int i = 0, pixelsLeft = physicalWidth; i < CHILDREN_COUNT; i++) {
      int columnWidth = (pixelsLeft / (CHILDREN_COUNT - i)).floor();
      if (i == 0)
        columnWidth = 10;
      else if (i == 2) columnWidth = 119;
      if (i == 1) {
        double devicewidth = mediaQueryData.devicePixelRatio;
        widthInterest = columnWidth / mediaQueryData.devicePixelRatio;
        children[i] = new Container(
          width: columnWidth / mediaQueryData.devicePixelRatio,
          color: Theme.of(context).backgroundColor,
        );
      }

      pixelsLeft -= columnWidth;
    }
    //List interest = interest;
    interest.sort();
    List<dynamic> tempInterest = List<dynamic>.empty(growable: true);
    tempInterest.clear();
    for (int i = 0; i < interest.length; i++) {
      int length = interest[i].toString().length;
      tempwidthInterest = length.toDouble() + 35;
      if (widthInterest - 20 > 0 && tempwidthInterest < widthInterest) {
        widthInterest = widthInterest - tempwidthInterest;
        tempInterest.add(interest[i]);
      //  print('$widthInterest total  temp $tempwidthInterest');
      }
    }

    return InkWell(
      
        onTap: () {
          print('position is clicked');
          HandleClickItem(context, title, previewImagePath, actionDescription,
              itemType, sysId, transId, extUrl);
        },
        child: Padding(
          
          padding: const EdgeInsets.only(
              left: Constant.padding05, right: Constant.padding05,),
              
          child: Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constant.cornerRadius10),
            
              ),
              
              child: Row(children: <Widget>[
                Container(
                  height: Constant.cardHeight119,
                  width: Constant.cardWidth10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Constant.cornerRadius08),
                      bottomLeft: Radius.circular(Constant.cornerRadius08),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Constant.padding10,
                          bottom: Constant.padding05,
                          right: Constant.padding10,
                          top: Constant.padding05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              height: Constant.cardHeight19,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: tempInterest.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Column(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: Constant.padding05),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: COLOR_PRIMARY,
                                          borderRadius: BorderRadius.circular(
                                              Constant.cornerRadius10),
                                        ),
                                        height: Constant.cardHeight14,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: Constant.padding05,
                                              right: Constant
                                                  .padding05), //apply padding to all four sides
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              tempInterest[index]
                                                  .toString()
                                                  .toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyle
                                                  .getInterestTagStyle(
                                                      Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]);
                                },
                              )),
                          SizedBox(
                            height: Constant.cardHeight20,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Constant.borderWidth02),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  title,
                                  style: CustomTextStyle.getCompTitleStyle(
                                      Colors.black),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Constant.cardHeight48,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                description,
                                style:
                                    CustomTextStyle.getDescStyle(Colors.black),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Constant.cardHeight22,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: Constant.borderWidth02,
                                  bottom: Constant.borderWidth02),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    Strings.offerExpire + endDate,
                                    style: CustomTextStyle.getDescStyle(
                                        Colors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Constant.cardHeight119,
                  width: Constant.cardHeight119,
                  color: Colors.transparent,
                  child: Stack(children: <Widget>[
                    Container(
                      height: Constant.cardHeight119,
                      width: Constant.cardWidth120,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white, width: Constant.borderWidth13),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(Constant.cornerRadius08),
                          bottomRight: Radius.circular(Constant.cornerRadius08),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: Constant.cardHeight98,
                        width: Constant.cardHeight98,
                        child: ClipRRect(
                          // ignore: sort_child_properties_last
                          child: FadeInImage(
                            placeholder:
                                AssetImage(LocalImages.placholderImagepath),
                            image:  NetworkImage(previewImagePath),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white,
                                      width: Constant.borderWidth04),
                                  borderRadius: BorderRadius.circular(
                                      Constant.cornerRadius10),
                                ),
                                child: Image.asset(
                                    LocalImages.placholderImagepath),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.circular(Constant.cornerRadius12),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: Constant.cardHeight104,
                        width: Constant.cardHeight104,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: Constant.borderWidth02),
                          borderRadius:
                              BorderRadius.circular(Constant.cornerRadius18),
                        ),
                      ),
                    )
                  ]),
                ),
              ])),
        ));
  }
}
