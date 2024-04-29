import 'package:flutter/material.dart';
import 'package:sarmad/_base/widgets/base_stateful_widget.dart';

/// BaseState screenCreateState();
abstract class BaseScreenWidget extends BaseStatefulWidget {
  const BaseScreenWidget({super.key, super.backGroundColor});

  @override
  BaseState baseCreateState() => screenCreateState();

  BaseState screenCreateState();
}

/// buildScreenWidget
abstract class BaseScreenState<W extends BaseScreenWidget>
    extends BaseState<W> {
  @override
  Widget baseBuild(BuildContext context) {
    return Stack(
      children: [
        buildScreenWidget(context),
        // BlocConsumer<InternetConnectionBloc, InternetConnectionState>(
        //   listener: (context, state) {
        //     // if (!state.isConnected) {
        //     //   showToast("No Internet Connection");
        //     //   log("No Internet Connection");
        //     // }
        //   },
        //   builder: (context, state) {
        //     if (!state.isConnected) {
        //       return const NoInternetWidget();
        //     }
        //     return const SizedBox.shrink();
        //   },
        // ),
      ],
    );
  }

  Widget buildScreenWidget(BuildContext context);
}
