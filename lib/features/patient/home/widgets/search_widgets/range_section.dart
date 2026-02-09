import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RangeSection extends StatelessWidget {
  const RangeSection({
    super.key,
    required this.title,
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
    this.labelPrefix = '',
    this.labelSuffix = '',
  });

  final String title;
  final RangeValues values;
  final double min;
  final double max;
  final Function(RangeValues) onChanged;
  final String labelPrefix;
  final String labelSuffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        top: 12.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive, width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.medium16.copyWith(
              color: AppColors.neutralDarkActive,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$labelPrefix${min.toInt()}$labelSuffix',
                style: AppTextStyles.medium16.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
              Text(
                '$labelPrefix${max.toInt()}$labelSuffix',
                style: AppTextStyles.medium16.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6.h,

              activeTrackColor: AppColors.successNormal,
              inactiveTrackColor: AppColors.primaryLightHover,
              showValueIndicator: ShowValueIndicator.never,
              overlayColor: Colors.transparent,
              rangeThumbShape: _ValueBasedLabelThumbShape(
                thumbRadius: 16.r,
                min: min,
                max: max,
                currentValues: values,
                labelPrefix: labelPrefix,
                labelSuffix: labelSuffix,
              ),
            ),
            child: RangeSlider(
              padding: EdgeInsets.only(top: 20.h),
              values: values,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueBasedLabelThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final double min;
  final double max;
  final RangeValues currentValues;
  final String labelPrefix;
  final String labelSuffix;

  _ValueBasedLabelThumbShape({
    required this.thumbRadius,
    required this.min,
    required this.max,
    required this.currentValues,
    this.labelPrefix = '',
    this.labelSuffix = '',
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    final Paint thumbPaint = Paint()
      ..color = AppColors.successDarker
      ..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..color = AppColors.neutralLight
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, thumbPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);

    bool shouldShowLabel = false;
    String textToShow = '';

    if (thumb == Thumb.start) {
      if (currentValues.start > min) {
        shouldShowLabel = true;
        textToShow = '$labelPrefix${currentValues.start.toInt()}$labelSuffix';
      }
    } else if (thumb == Thumb.end) {
      if (currentValues.end < max) {
        shouldShowLabel = true;
        textToShow = '$labelPrefix${currentValues.end.toInt()}$labelSuffix';
      }
    }

    if (shouldShowLabel) {
      _drawLabel(context, center, textToShow);
    }
  }

  void _drawLabel(PaintingContext context, Offset center, String text) {
    final Canvas canvas = context.canvas;
    final double bubbleWidth = 47.w;
    final double bubbleHeight = 35.h;
    final double bubbleBottomMargin = 25.h;

    final Rect bubbleRect = Rect.fromCenter(
      center: Offset(
        center.dx,
        center.dy - bubbleBottomMargin - (bubbleHeight / 2),
      ),
      width: bubbleWidth,
      height: bubbleHeight,
    );

    final Paint bubblePaint = Paint()
      ..color = AppColors.secondaryLight
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(bubbleRect, const Radius.circular(8)),
      bubblePaint,
    );

    final TextSpan span = TextSpan(
      style: AppTextStyles.semiBold14.copyWith(color: AppColors.primaryDarker),
      text: text,
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    final Offset textOffset = Offset(
      bubbleRect.center.dx - (tp.width / 2),
      bubbleRect.center.dy - (tp.height / 2),
    );
    tp.paint(canvas, textOffset);
  }
}
