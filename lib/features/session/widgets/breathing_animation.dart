import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/assets/app_assets.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_pacer_view_model.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:rive/rive.dart';

/// The session's breathing guide. It receives the choices as a plain value
/// and writes them into the Rive view model, so the animation follows the
/// pickers without owning any app state.
class BreathingAnimation extends StatefulWidget {
  const new({
    required this.choices,
    super.key,
  });

  final SessionChoices choices;

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation> {
  static const _maxSize = 340.0;

  late final _fileLoader = FileLoader.fromAsset(
    AppAssets.sessionPacer,
    riveFactory: Factory.rive,
  );

  SessionPacerViewModel? _pacer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-runs when the theme switches between light and dark.
    _applyPalette();
  }

  @override
  void didUpdateWidget(BreathingAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.choices != widget.choices) {
      _applyChoices();
    }
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  void _onLoaded(RiveLoaded state) {
    if (state.viewModelInstance case final viewModelInstance?) {
      _pacer = SessionPacerViewModel(viewModelInstance);
      _applyPalette();
      _applyChoices();
    }
  }

  void _applyChoices() => _pacer?.setChoices(widget.choices);

  void _applyPalette() => _pacer?.setPalette(context.appColors);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: _maxSize,
        maxHeight: _maxSize,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: RiveWidgetBuilder(
          fileLoader: _fileLoader,
          dataBind: DataBind.auto(),
          onLoaded: _onLoaded,
          builder: (context, state) => switch (state) {
            RiveLoaded(:final controller) => RiveWidget(
              controller: controller,
            ),
            RiveLoading() || RiveFailed() => const SizedBox.expand(),
          },
        ),
      ),
    );
  }
}
