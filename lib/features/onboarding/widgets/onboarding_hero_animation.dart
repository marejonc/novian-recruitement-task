import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/assets/app_assets.dart';
import 'package:novian_recruitement_task/features/motion/bloc/device_tilt_cubit.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_bloom_view_model.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:rive/rive.dart';

class OnboardingHeroAnimation extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboardingHeroAnimation> createState() =>
      _OnboardingHeroAnimationState();
}

class _OnboardingHeroAnimationState extends State<OnboardingHeroAnimation> {
  static const _maxSize = 320.0;

  late final _fileLoader = FileLoader.fromAsset(
    AppAssets.onboardingBloom,
    riveFactory: Factory.rive,
  );

  OnboardingBloomViewModel? _bloom;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-runs when the theme switches between light and dark.
    _applyPalette();
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  void _onLoaded(RiveLoaded state) {
    if (state.viewModelInstance case final viewModelInstance?) {
      _bloom = OnboardingBloomViewModel(viewModelInstance);
      _applyPalette();
      _applyTilt(context.read<DeviceTiltCubit>().state);
    }
  }

  void _applyPalette() => _bloom?.setPalette(context.appColors);

  void _applyTilt(DeviceTilt tilt) => _bloom?.setTilt(tilt);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceTiltCubit, DeviceTilt>(
      listener: (context, tilt) => _applyTilt(tilt),
      child: ConstrainedBox(
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
      ),
    );
  }
}
