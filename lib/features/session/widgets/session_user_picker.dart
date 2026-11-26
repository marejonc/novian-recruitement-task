import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/user/bloc/users_cubit.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Who the session is for, as one compact row: the label on the left and the
/// selected user's name on the right, opening a menu with the users from the
/// backend. While they load a hint is shown; a failed load
/// retries on tap.
class SessionUserPicker extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final typography = context.appTypography;
    final state = context.watch<UsersCubit>().state;

    return Row(
      children: [
        Text(t.session.userLabel.toUpperCase(), style: typography.label),
        const Spacer(),
        switch (state) {
          UsersLoading() => Text(
            t.session.usersLoading,
            style: typography.caption,
          ),
          UsersError() => TextButton.icon(
            onPressed: () => context.read<UsersCubit>().load(),
            icon: const Icon(Icons.refresh),
            iconAlignment: IconAlignment.end,
            label: Text(t.session.usersLoadError),
          ),
          UsersLoaded(:final users, :final selectedUser) => buildMenu(
            context,
            users: users,
            selectedUser: selectedUser,
          ),
        },
      ],
    );
  }

  Widget buildMenu(
    BuildContext context, {
    required List<User> users,
    required User selectedUser,
  }) {
    final t = context.t;
    String nameOf(User user) => t.session.userName(
      firstName: user.firstName,
      lastName: user.lastName,
    );

    return MenuAnchor(
      menuChildren: [
        for (final user in users)
          MenuItemButton(
            // Hidden but sized for the other users, so the names line up.
            leadingIcon: Visibility.maintain(
              visible: user == selectedUser,
              child: const Icon(Icons.check),
            ),
            onPressed: () => context.read<UsersCubit>().select(user),
            child: Text(nameOf(user)),
          ),
      ],
      builder: (context, controller, _) => TextButton.icon(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.expand_more),
        iconAlignment: IconAlignment.end,
        label: Text(nameOf(selectedUser)),
      ),
    );
  }
}
