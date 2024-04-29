import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sarmad/_base/widgets/base_stateful_widget.dart';
import 'package:sarmad/res/assets_paths.dart';
import 'package:sarmad/res/const_colors.dart';
import 'package:sarmad/ui/screens/home/home_screen.dart';
import 'package:sarmad/util/ui/screen_controller.dart';

class SplashScreen extends BaseStatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    /// to make full screen
    enterFullScreen();

    /// to start time to switch to another screen
    _startTime();
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: height,
            width: width,
            color: ConstColors.white,
          ),
          Center(child: Image.asset(AssPaths.appLogo,scale: 0.8,),)
        ],
      ),
    );
  }

  void _startTime() async {
    var _duration = const Duration(milliseconds: 3000);
    Timer(_duration, () => _goToNextScreen());
  }

  Future _goToNextScreen() async {
    await Navigator.of(context).pushReplacementNamed(
      HomeScreen.routeName,
    );
  }
}
