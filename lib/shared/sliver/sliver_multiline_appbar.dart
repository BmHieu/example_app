import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../helper/dimension.dart';

class SliverMultilineAppBar extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final bool showLeading;

  final List<Widget> actions;
  final Color? backgroundColor;
  final VoidCallback? onPressedLeading;
  final bool floating;
  final PreferredSizeWidget? bottom;

  /// [SliverMultilineAppBar] is a [SliverAppBar] with multiline title
  ///
  /// [title] is required
  ///
  /// [titleStyle] default is [App.theme.appStyle.nhnSebo32.copyWith(fontSize: 14.h())]
  ///
  /// [leading] default is [SvgPicture.asset('assets/icons/ic_back.svg')]
  ///
  /// [showLeading] default is true
  ///
  /// [actions] default is []
  ///
  /// [backgroundColor] default is [App.theme.colors.primary.yellow]
  ///
  /// [onPressedLeading] default is [Navigator.pop(context)]
  ///
  /// [floating] default is true
  ///
  /// [bottom] default is [PreferredSizeWidget]
  const SliverMultilineAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.leading,
    this.showLeading = true,
    this.actions = const [],
    this.backgroundColor,
    this.onPressedLeading,
    this.floating = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: floating,
      snap: true,
      primary: false,
      backgroundColor: backgroundColor ?? App.theme.colors.primary.yellow,
      expandedHeight: 65.h(),
      automaticallyImplyLeading: false,
      leadingWidth: getRealWidth(56),
      bottom: bottom,
      leading: showLeading
          ? Padding(
              padding: const EdgeInsets.only(),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: leading ?? Assets.icons.icBack.svg(),
                onPressed: onPressedLeading ?? () => Navigator.pop(context),
              ),
            )
          : const SizedBox(),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Container(
          constraints: BoxConstraints(
            maxWidth: getRealWidth(233),
            minHeight: getRealHeight(75),
          ),
          alignment: Alignment.center,
          child: AutoSizeText(
            title,
            style: App.theme.textStyle.nhnSebo32,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
