import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sarmad/res/assets_paths.dart';
import 'package:sarmad/res/const_colors.dart';
import 'package:sarmad/util/lang/app_localization.dart';
import 'package:sarmad/util/lang/app_localization_keys.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: MediaQuery.of(context).size.height * 0.09,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: ConstColors.app,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 22,
              child: SvgPicture.asset(AssPaths.warningNew),
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.of(context)
                  .translate(LangKeys.youAreCurrentlyOffline),
              style: const TextStyle(
                color: ConstColors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
