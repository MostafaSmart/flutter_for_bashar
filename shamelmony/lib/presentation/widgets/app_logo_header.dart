import 'package:flutter/material.dart';
import '../../shared/theme/app_colors.dart';

/// مكون لعرض شعار التطبيق والعنوان
class AppLogoHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double logoSize;
  final double spacing;
  final bool showLogo;
  final Widget? customLogo;

  const AppLogoHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.logoSize = 80,
    this.spacing = 24,
    this.showLogo = true,
    this.customLogo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLogo) ...[
          customLogo ?? _buildDefaultLogo(),
          SizedBox(height: spacing),
        ],
        Text(
          title,
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildDefaultLogo() {
    return Container(
      width: logoSize,
      height: logoSize,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.account_balance_wallet,
          color: Colors.white,
          size: logoSize * 0.5,
        ),
      ),
    );
  }
}
