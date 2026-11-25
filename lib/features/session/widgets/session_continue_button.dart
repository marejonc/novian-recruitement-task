import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/routing/app_router.gr.dart';

/// Opens the summary inside the session flow; the choices stay in the shared
/// cubit, so nothing is passed along.
class SessionContinueButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return FilledButton(
      onPressed: () => unawaited(context.router.push(const SummaryRoute())),
      child: Text(t.session.continueToSummary),
    );
  }
}
