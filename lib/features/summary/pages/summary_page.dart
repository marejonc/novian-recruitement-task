import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_page_content.dart';

@RoutePage()
class SummaryPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => const SummaryPageContent();
}
