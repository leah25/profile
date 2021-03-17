import 'package:e_revenue_flutter/providers/global/colors_provider.dart';
import 'package:e_revenue_flutter/screens/change_pin_page/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePinPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _colors = useProvider(colorProvider);

    return PlatformScaffold(
      backgroundColor: _colors.mainBackgroundColor,
      body: ChangePinForm(),
    );
  }
}
