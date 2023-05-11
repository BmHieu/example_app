import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../helper/theme/theme_provider.dart';
import 'screen_router.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  get _primaryColor => App.theme.colors.primary;

  @override
  Widget build(BuildContext context) {
    var screenRouter = ScreenRouter();
    final theme = Provider.of<ThemeProvider>(context).getTheme(context);
    App.theme = theme;

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primaryColor: _primaryColor.yellow,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: _primaryColor.white,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: _primaryColor.yellow,
          elevation: .5,
        ),
        unselectedWidgetColor: _primaryColor.grey,
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: _primaryColor.grey,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      ),
      onGenerateRoute: screenRouter.generateRoute,
      onUnknownRoute: screenRouter.unknownRoute,
      initialRoute: '/',
    );
  }
}
