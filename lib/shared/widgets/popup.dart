import 'package:flutter/material.dart';

import '../../config/config.dart';

/// [AppPopup] is a class to show popup
///
/// example:
/// 
/// ```dart
/// GestureDetector(
/// onTap: () {
///     AppPopup.showSvgPopup(
///       context,
///       svg: Assets.svg.icSuccess.svg(),
///       title: 'Thành công',
///       content: 'Bạn đã đăng ký thành công',
///       actions: PrimaryButton(
///         title: 'Đóng',
///         onPressed: () {
///           Navigator.pop(context);
///         },
///       ),
///     );
///   }
/// ),
/// ```
class AppPopup {
  ///
  /// [showSvgPopup] is a method to show popup with svg
  ///
  /// example:
  /// 
  /// ```dart
  /// GestureDetector(
  /// onTap: () {
  ///     AppPopup.showSvgPopup(
  ///       context,
  ///       svg: Assets.svg.icSuccess.svg(),
  ///       title: 'Thành công',
  ///       content: 'Bạn đã đăng ký thành công',
  ///       actions: PrimaryButton(
  ///         title: 'Đóng',
  ///         onPressed: () {
  ///           Navigator.pop(context);
  ///         },
  ///       ),
  ///     );
  ///   }
  /// ),
  /// ```
  static Future<T?> showSvgPopup<T>(
    BuildContext context, {
    required Widget svg,
    required String title,
    required String content,
    required Widget actions,
  }) =>
      showDialog<T?>(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                svg,
                const SizedBox(
                  height: 16,
                ),
                Text(
                  title,
                  style: App.theme.textStyle.nhnSebo32,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  content,
                  style: App.theme.textStyle.nhnSebo32,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                actions,
              ],
            ),
          ),
        ),
      );
}
