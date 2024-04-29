import 'package:flutter/material.dart';
import 'package:sarmad/_base/platform_manager.dart';

/// Mobile will be returned by default
class ScreenPlatformWidget extends StatelessWidget with PlatformManager {
  final Widget mobile;
  final Widget? web;

  ScreenPlatformWidget({super.key, required this.mobile, this.web});

  @override
  Widget build(BuildContext context) {
    return (isOnWeb() && web != null) ? web! : mobile;
  }
}
