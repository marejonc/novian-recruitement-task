import 'package:material_ui/material_ui.dart';
import 'package:rive/rive.dart';

/// One-shot writes into a Rive view model instance. Every property lookup
/// hands out a native handle, so each write releases its handle right away
/// instead of keeping handles that could outlive the instance.
extension ViewModelInstanceExtension on ViewModelInstance {
  void setNumber(String name, double value) {
    if (number(name) case final property?) {
      property
        ..value = value
        ..dispose();
    }
  }

  void setColor(String name, Color value) {
    if (color(name) case final property?) {
      property
        ..value = value
        ..dispose();
    }
  }
}
