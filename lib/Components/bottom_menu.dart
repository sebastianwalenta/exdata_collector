import 'package:flutter/material.dart';
import 'package:exdata_collector/l10n/app_localizations.dart';
import 'bottom_menu_button.dart';

class BottomMenu extends StatelessWidget {
  final VoidCallback onAddScore;
  final VoidCallback onAddBoat;
  final VoidCallback onAddRace;
  final VoidCallback onActiveRace;
  final VoidCallback onSynchronize;
  final VoidCallback onSettings;

  const BottomMenu({
    super.key,
    required this.onAddScore,
    required this.onAddBoat,
    required this.onAddRace,
    required this.onActiveRace,
    required this.onSynchronize,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaQuery = MediaQuery.of(context);

    final children = [
      BottomMenuButton(
        icon: Icons.add,
        label: l10n.addScore,
        onPressed: onAddScore,
      ),
      BottomMenuButton(
        icon: Icons.directions_boat,
        label: l10n.addBoat,
        onPressed: onAddBoat,
      ),
      BottomMenuButton(
        icon: Icons.date_range,
        label: l10n.addRace,
        onPressed: onAddRace,
      ),
      BottomMenuButton(
        icon: Icons.flag,
        label: l10n.activeRace,
        onPressed: onActiveRace,
        isCenter: true,
      ),
      BottomMenuButton(
        icon: Icons.sync,
        label: l10n.synchronize,
        onPressed: onSynchronize,
      ),
      BottomMenuButton(
        icon: Icons.settings,
        label: l10n.settings,
        onPressed: onSettings,
      ),
    ];

    final double height = isLandscape
        ? 56.0
        : (mediaQuery.size.width / children.length);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(31),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children
                .map((btn) => Expanded(child: btn))
                .toList(),
          ),
        ),
      ),
    );
  }
}
