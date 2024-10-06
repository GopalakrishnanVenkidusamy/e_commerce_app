import 'package:e_commerce/config/enum_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelperClass{
  /// width < 768
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 768;

  /// width < 768
  /// Include Tablet & 13'' Laptop
  static bool isTab(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 768 &&
          MediaQuery.sizeOf(context).width <= 1024;

  static CurrentPlatform getCurrentPlatform(BuildContext context){
    if(isMobile(context)){
      return CurrentPlatform.mobile;
    }else if(isTab(context)){
      return CurrentPlatform.tab;
    }
    return CurrentPlatform.web;
  }

  static List<TextInputFormatter> numbersOnly = [
    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
  ];
}