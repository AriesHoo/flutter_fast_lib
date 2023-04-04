import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_belfry/mixin/fast_lib_mixin.dart';
import 'package:flutter_fast_lib/flutter_fast_lib.dart';
import 'package:google_fonts/google_fonts.dart';

///App主题-浅色及深色
class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static bool get platformDarkMode =>
      MediaQuery.of(currentContext).platformBrightness == Brightness.dark;

  static bool get darkMode => platformDarkMode;

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    var theme = ThemeData(
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      // primaryColor: const Color(0xFF030303),
      primaryColor: const Color(0xFF242424),
      appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.onBackground,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.primary),
          titleSpacing: 10),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium?.apply(color: _darkFillColor),
      ),
      dialogTheme: DialogTheme(
        shape: fastLibMixin.defaultDialogShape,
        backgroundColor: colorScheme.background,
      ),

      ///TabBar样式设置
      tabBarTheme: TabBarTheme(
        ///选中label颜色
        labelColor: colorScheme.primary,

        ///未选择label颜色
        unselectedLabelColor: colorScheme.onSecondary,

        ///标签内边距
        labelPadding: const EdgeInsets.symmetric(horizontal: 6),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
    return theme.copyWith(
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
      backgroundColor: colorScheme.onBackground,
    ));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    secondary: Color(0xFFEFF3F3),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
    primaryContainer: Color(0xFF117378),
    secondaryContainer: Color(0xFFFAFBFB),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    secondary: Color(0xFF4D1F7C),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
    primaryContainer: Color(0xFF1CDEC9),
    secondaryContainer: Color(0xFF451B6F),
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),

    ///ListTitle title
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),

    ///ListTitle subtitle
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),

    ///Button类默认样式+TextButton等
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),

    /// FormField-错误提示文本样式
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 12.0),
  );

  ///设置系统Bar主题
  static setSystemBarTheme({Color? systemNavigationBarColor}) async {
    ///黑色主题需加一个延迟等待底部bottomAppBarColor切换完成
    Future.delayed(
      Duration(
        milliseconds: darkMode ? 500 : 0,
      ),
      () {
        _setSystemBarTheme(
          systemNavigationBarColor: systemNavigationBarColor,
        );
      },
    );
  }

  ///最终执行
  static _setSystemBarTheme({Color? systemNavigationBarColor}) async {
    bool statusEnable = FastPlatformUtil.isAndroid
        ? await FastPlatformUtil.statusColorCanChange()
        : true;
    bool navigationEnable = FastPlatformUtil.isAndroid
        ? await FastPlatformUtil.navigationColorCanChange()
        : true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      ///状态栏背景色
      statusBarColor: darkMode || statusEnable ? Colors.transparent : null,

      ///状态栏icon 亮度（浅色/深色）
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,

      ///导航栏颜色-保持和bottomAppBarColor一致
      systemNavigationBarColor: systemNavigationBarColor ??
          (darkMode
              ? Theme.of(currentContext).bottomAppBarTheme.color
              : navigationEnable
                  ? (darkMode ? Colors.transparent : Colors.white)
                  : null),

      ///导航栏icon（浅色/深色）
      systemNavigationBarIconBrightness:
          darkMode ? Brightness.light : Brightness.dark,

      systemNavigationBarContrastEnforced: true,
    ));
  }
}
