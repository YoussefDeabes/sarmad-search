import 'package:flutter/material.dart';
import 'package:sarmad/_base/widgets/base_stateful_widget.dart';
import 'package:sarmad/util/ui/screen_controller.dart';

class HomeScreen extends BaseStatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  @override
  void initState() {
    /// to exit full screen
    exitFullScreen();
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
