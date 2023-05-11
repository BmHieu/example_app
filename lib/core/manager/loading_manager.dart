import 'package:flutter/material.dart';

class LoadingManager {
  static OverlayEntry? _overlayEntry;

  static void _showLoading({required BuildContext context}) {
    final overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black.withOpacity(0.2),
        child: const Center(
          child: SizedBox(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
    LoadingManager._overlayEntry = overlayEntry;
    Overlay.of(context).insert(overlayEntry);
  }

  static void _hideLoading() {
    LoadingManager._overlayEntry?.remove();
    LoadingManager._overlayEntry = null;
  }

  static void setLoading(BuildContext context, {required bool loading}) {
    if (loading) {
      if (LoadingManager._overlayEntry == null) {
        LoadingManager._showLoading(context: context);
      }
    } else {
      LoadingManager._hideLoading();
    }
  }
}
