import 'package:flutter/foundation.dart';

/// Difference between debug and release and profile mode
/// https://github.com/flutter/flutter/wiki/Flutter%27s-modes

bool isDebugMode() => kDebugMode;
bool isReleaseMode() => kReleaseMode;
bool isProfileMode() => kProfileMode;
