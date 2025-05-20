import 'package:flutter/material.dart';

/// ألوان التطبيق
class AppColors {
  // الألوان الرئيسية
  static const Color primaryColor = Color(0xFF0F7C79);
  static const Color secondaryColor = Color(0xFF0A5F61);
  
  // ألوان مكملة
  static const Color accentColor = Color(0xFFF9A826);
  static const Color lightAccentColor = Color(0xFFFFD180);
  
  // ألوان محايدة
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color surfaceColor = Colors.white;
  static const Color cardColor = Colors.white;
  
  // ألوان النصوص
  static const Color textPrimaryColor = Color(0xFF2D3142);
  static const Color textSecondaryColor = Color(0xFF4F5D75);
  static const Color textLightColor = Color(0xFF9098B1);
  
  // ألوان الحالة
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE53935);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF2196F3);
  
  // ألوان الظلال
  static const Color shadowColor = Color(0x1A000000);
  
  // تدرجات الألوان
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentColor, Color(0xFFFF8C00)],
  );
}
