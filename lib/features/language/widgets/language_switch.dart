import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/bloc/language_cubit.dart';
import 'package:novian_recruitement_task/features/language/widgets/extensions/app_locale_extension.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';

/// Segmented language picker shared by onboarding and the session flow.
/// [isCompact] shows language codes, for tight spots like an app bar.
class LanguageSwitch extends StatelessWidget {
  const new({
    this.isCompact = false,
    super.key,
  });

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final locale = context.watch<LanguageCubit>().state;

    return SegmentedButton<AppLocale>(
      segments: [
        for (final option in AppLocale.values)
          ButtonSegment(
            value: option,
            label: Text(isCompact ? option.codeIn(t) : option.nameIn(t)),
            tooltip: isCompact ? option.nameIn(t) : null,
          ),
      ],
      selected: {locale},
      showSelectedIcon: false,
      expandedInsets: isCompact ? null : EdgeInsets.zero,
      onSelectionChanged: (selection) =>
          context.read<LanguageCubit>().select(selection.first),
    );
  }
}
