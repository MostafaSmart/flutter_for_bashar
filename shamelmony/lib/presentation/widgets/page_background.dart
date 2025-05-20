import 'package:flutter/material.dart';
import '../../shared/theme/app_colors.dart';

/// خلفية الصفحة بتصميم عصري
class PageBackground extends StatelessWidget {
  final Widget child;
  final bool showTopCircle;
  final bool showBottomCircle;
  final Color? topCircleColor;
  final Color? bottomCircleColor;

  const PageBackground({
    super.key,
    required this.child,
    this.showTopCircle = true,
    this.showBottomCircle = true,
    this.topCircleColor,
    this.bottomCircleColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Stack(
      children: [
        // خلفية الصفحة
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backgroundColor,
        ),
        
        // دائرة علوية
        if (showTopCircle)
          Positioned(
            top: -size.width * 0.3,
            right: -size.width * 0.2,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: topCircleColor ?? AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          
        // دائرة سفلية
        if (showBottomCircle)
          Positioned(
            bottom: -size.width * 0.2,
            left: -size.width * 0.3,
            child: Container(
              width: size.width * 0.6,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bottomCircleColor ?? AppColors.accentColor.withOpacity(0.1),
              ),
            ),
          ),
          
        // محتوى الصفحة
        child,
      ],
    );
  }
}
