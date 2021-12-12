import 'package:flutter/material.dart';

import 'package:meuapp/shared/theme/app_theme.dart';

class AppBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.colors.textEnabled,
      ),
      height: 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconBottomNavigator(
            icon: Icons.home,
            enabled: currentIndex == 0,
            onTap: () {
              onChanged(0);
            },
          ),
          IconBottomNavigator(
            icon: Icons.add,
            enabled: false,
            onTap: () {
              onChanged(3);
            },
          ),
          IconBottomNavigator(
            icon: Icons.settings,
            enabled: currentIndex == 1,
            onTap: () {
              onChanged(1);
            },
          )
        ],
      ),
    );
  }
}

class IconBottomNavigator extends StatelessWidget {
  const IconBottomNavigator({
    Key? key,
    required this.onTap,
    required this.enabled,
    required this.icon,
  }) : super(key: key);

  final Function() onTap;
  final bool enabled;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: enabled ? AppTheme.colors.primary : AppTheme.colors.background,
        ),
        child: Icon(
          icon,
          color: enabled
              ? AppTheme.colors.textEnabled
              : AppTheme.colors.iconInactive,
        ),
      ),
    );
  }
}
