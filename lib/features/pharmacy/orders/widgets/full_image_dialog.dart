import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class FullImageDialog extends StatefulWidget {
  final String prescriptionImage;
  final String orderNumber;
  final String customerName;

  const FullImageDialog({
    super.key,
    required this.prescriptionImage,
    required this.orderNumber,
    required this.customerName,
  });

  @override
  State<FullImageDialog> createState() => _FullImageDialogState();
}

class _FullImageDialogState extends State<FullImageDialog> {
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  final double _minScale = 0.5;
  final double _maxScale = 4.0;

  void _increaseZoom() {
    setState(() {
      _currentScale = (_currentScale * 1.5).clamp(_minScale, _maxScale);
      _updateTransformationMatrix();
    });
  }

  void _decreaseZoom() {
    setState(() {
      _currentScale = (_currentScale / 1.5).clamp(_minScale, _maxScale);
      _updateTransformationMatrix();
    });
  }

  void _updateTransformationMatrix() {
    final Matrix4 matrix = Matrix4.identity()
      ..scale(_currentScale, _currentScale, 1.0);
    _transformationController.value = matrix;
  }

  String _getZoomPercentage() {
    return '${(_currentScale * 100).round()}%';
  }

  @override
  void initState() {
    super.initState();
    _updateTransformationMatrix();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.all(AppSizes.spacing12.w),
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Column(
        children: [
          // Header
          Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                NavigateBackButton(),
      
                // Title
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Order#${widget.orderNumber} ',
                        style: AppTextStyles.bold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: widget.customerName,
                        style: AppTextStyles.bold16.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      
          SizedBox(height: AppSizes.spacing16.h),
      
          // Image Container
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.borderRadius16.r),
                  topRight: Radius.circular(AppSizes.borderRadius16.r),
                ),
              ),
              child: InteractiveViewer(
                transformationController: _transformationController,
                minScale: _minScale,
                maxScale: _maxScale,
                scaleEnabled: true,
                panEnabled: true,
                boundaryMargin: EdgeInsets.all(100),
                constrained: false,
                onInteractionUpdate: (details) {
                  // Update the current scale when user interacts with the image
                  final scale = _transformationController.value.getMaxScaleOnAxis();
                  if (scale != _currentScale) {
                    setState(() {
                      _currentScale = scale.clamp(_minScale, _maxScale);
                    });
                  }
                },
                child: Image.network(
                  widget.prescriptionImage,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.error_outline, color: AppColors.errorNormal),
                ),
              ),
            ),
          ),
      
          // Bottom Controls
          Container(
            padding: EdgeInsets.all(AppSizes.spacing16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.borderRadius16.r),
                bottomRight: Radius.circular(AppSizes.borderRadius16.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlphaPercent(0.1),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Increase Button
                GestureDetector(
                  onTap: _increaseZoom,
                  child: Container(
                    width: AppSizes.iconSize24.w,
                    height: AppSizes.iconSize32.h,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      border: Border(
                        right: BorderSide(
                          color: AppColors.secondaryLightActive,
                          width: 1.w,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          AppSizes.borderRadius4.r,
                        ),
                        bottomLeft: Radius.circular(
                          AppSizes.borderRadius4.r,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text("+"),
                    ),
                  ),
                ),

                // Percentage Display
                Container(
                  width: AppSizes.iconSize32.w,
                  height: AppSizes.iconSize32.h,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                  ),
                  child: Center(
                    child: Text(
                      _getZoomPercentage(),
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.secondaryDarkHover,
                      ),
                    ),
                  ),
                ),

                // Decrease Button
                GestureDetector(
                  onTap: _decreaseZoom,
                  child: Container(
                    width: AppSizes.iconSize24.w,
                    height: AppSizes.iconSize32.h,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      border: Border(
                        left: BorderSide(
                          color: AppColors.secondaryLightActive,
                          width: 1.w,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          AppSizes.borderRadius4.r,
                        ),
                        bottomRight: Radius.circular(
                          AppSizes.borderRadius4.r,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text("-"),
                    ),
                  ),
                ),
            
                SizedBox(width: AppSizes.spacing8.w),
            
                // Download Button
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing12.w,
                      vertical: AppSizes.spacing8.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryNormal,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius16.r,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Download',
                        style: AppTextStyles.medium12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            
                SizedBox(width: AppSizes.spacing4.w),
            
                // Report Issue Button
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spacing12.w,
                      vertical: AppSizes.spacing8.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.neutralLightActive,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius16.r,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Report Issue',
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}