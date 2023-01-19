import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxcommon/presentation/navigation/cubit/navigation_cubit.dart';
import 'package:vnu/presentation/facilities/facilities_page.dart';
import 'package:vnu/presentation/facilities/giftshop_page.dart';
import 'package:vnu/presentation/webview/webview.dart';


  String FACILITIES1 ="2|131072";
  String FACILITIES2 ="2|262144";
  
  String FACILITIES8 ="2|33554432";
  String ICONNECT ="2|2048";
  String FNB ="2|32768";
  String INFO ="2|8192";
  String EVENTS ="2|2";
  String ABOUTUS ="2|4";
  String GIFTSHOP ="2|128";
  String PROMOTIONS ="2|1";

 void HandleClickItem(BuildContext context,String title,String previewImagePath,String actionDescription,String itemType, String sysId, String transId, String extUrl)
{

     print(actionDescription + extUrl);
     if(actionDescription == "EXTERNALURLS"  && extUrl != null && extUrl.length>0)
     {
      //BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavbarItem.html);
     Navigator.push(   context, MaterialPageRoute(builder: (context) => WebViewPage(extUrl, title)));
     }else if(actionDescription == "FACILITIES1")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(FACILITIES1, title)));
     }else if(actionDescription == "FACILITIES2")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(FACILITIES2, title)));
     }else if(actionDescription == "FACILITIES8")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(FACILITIES8, title)));
     }else if(actionDescription == "ICONNECT")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(ICONNECT, title)));
     }else if(actionDescription == "FNB")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(FNB, title)));
     }else if(actionDescription == "INFO")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(INFO, title)));
     }else if(actionDescription == "EVENTS")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(EVENTS, title)));
     }else if(actionDescription == "MYCLUB" || actionDescription == "ABOUTUS")
     {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(ABOUTUS, title)));
    //  Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(ABOUTUS, title)));
     } else if(actionDescription == "GIFTSHOP")
     {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GiftshopListPage(GIFTSHOP, title)));
    //  Navigator.push(context, MaterialPageRoute(builder: (context) => GiftshopListPage(GIFTSHOP, title)));
     } else if(actionDescription == "PROMOTIONS")
     {
     Navigator.push(context, MaterialPageRoute(builder: (context) => FacilitiesPage(PROMOTIONS, title)));
     }
}