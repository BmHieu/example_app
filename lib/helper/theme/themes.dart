import 'color/color.dart';
import 'color/dark.dart';
import 'color/light.dart';
import 'text_style.dart';

class Themes {
  final AppColor themeColor;
  final String suffix;

  AppColor get colors => themeColor;

  final AppTextStyle textStyle = appTextStyle;
  AppTextStyle get styles => textStyle;

  Themes({
    required this.themeColor,
    required this.suffix,
  });
}

final darkTheme = Themes(
  themeColor: darkColor,
  suffix: '_dark',
);

final lightTheme = Themes(
  themeColor: lightColor,
  suffix: '',
);
