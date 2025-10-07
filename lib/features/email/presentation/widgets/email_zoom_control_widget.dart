import 'package:core/presentation/extensions/color_extension.dart';
import 'package:core/presentation/resources/image_paths.dart';
import 'package:core/presentation/utils/theme_utils.dart';
import 'package:core/presentation/views/button/tmail_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmail_ui_user/main/localizations/app_localizations.dart';

class EmailZoomControlWidget extends StatelessWidget {
  final double zoomLevel;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onZoomReset;
  final bool isVisible;

  const EmailZoomControlWidget({
    super.key,
    required this.zoomLevel,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onZoomReset,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final imagePaths = Get.find<ImagePaths>();
    
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TMailButtonWidget.fromIcon(
            key: const Key('zoom_out_button'),
            icon: imagePaths.icZoomOut,
            backgroundColor: Colors.transparent,
            tooltipMessage: AppLocalizations.of(context).zoomOut,
            iconSize: 20,
            iconColor: zoomLevel <= 0.5 ? Colors.grey : AppColor.primaryColor,
            padding: const EdgeInsets.all(8),
            onTapActionCallback: zoomLevel > 0.5 ? onZoomOut : null,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 60),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: onZoomReset,
              child: Text(
                '${(zoomLevel * 100).round()}%',
                style: ThemeUtils.getTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TMailButtonWidget.fromIcon(
            key: const Key('zoom_in_button'),
            icon: imagePaths.icZoomIn,
            backgroundColor: Colors.transparent,
            tooltipMessage: AppLocalizations.of(context).zoomIn,
            iconSize: 20,
            iconColor: zoomLevel >= 3.0 ? Colors.grey : AppColor.primaryColor,
            padding: const EdgeInsets.all(8),
            onTapActionCallback: zoomLevel < 3.0 ? onZoomIn : null,
          ),
        ],
      ),
    );
  }
}