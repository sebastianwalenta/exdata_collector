import 'package:flutter/material.dart';

class BottomMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isCenter;

  const BottomMenuButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    final backgroundColor = isCenter
        ? primaryColor
        : theme.colorScheme.surface;

    final contentColor = isCenter
        ? Colors.white
        : theme.iconTheme.color ?? theme.colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: theme.dividerColor.withAlpha(25),
                  width: 0.5,
                ),
              ),
            ),
            child: isLandscape
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 20, color: contentColor),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isCenter ? FontWeight.bold : FontWeight.w500,
                            color: isCenter
                                ? Colors.white
                                : theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 26, color: contentColor),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
