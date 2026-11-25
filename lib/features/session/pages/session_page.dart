import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_page_content.dart';

@RoutePage()
class SessionPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => const SessionPageContent();
}
