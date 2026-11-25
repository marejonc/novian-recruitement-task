import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/widgets/language_switch.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

/// The compact language switch as an app bar action, inset from the edge.
class LanguageSwitchAction extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: context.appSpacing.m),
      child: const LanguageSwitch(isCompact: true),
    );
  }
}
