import 'package:flutter/material.dart';

import '../../exports.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(
    lightColorScheme,
    _lightFocusColor,
  );
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    primaryVariant: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryVariant: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.barlow(fontWeight: _bold, fontSize: 70.0),
    headline2: GoogleFonts.barlow(fontWeight: _bold, fontSize: 60.0),
    headline3: GoogleFonts.barlow(fontWeight: _bold, fontSize: 40.0),
    headline4: GoogleFonts.barlow(fontWeight: _medium, fontSize: 20.0),
    headline5: GoogleFonts.barlow(fontWeight: _medium, fontSize: 16.0),
    headline6: GoogleFonts.barlow(fontWeight: _bold, fontSize: 16.0),
    caption: GoogleFonts.barlow(fontWeight: _semiBold, fontSize: 16.0),
    bodyText1: GoogleFonts.barlow(fontWeight: _regular, fontSize: 14.0),
    bodyText2: GoogleFonts.barlow(fontWeight: _regular, fontSize: 16.0),
    overline: GoogleFonts.barlow(fontWeight: _medium, fontSize: 12.0),
    subtitle2: GoogleFonts.barlow(fontWeight: _medium, fontSize: 14.0),
    subtitle1: GoogleFonts.barlow(fontWeight: _medium, fontSize: 16.0),
    button: GoogleFonts.barlow(fontWeight: _semiBold, fontSize: 14.0),
  );

  static InputDecoration inputDecoration({hintText: String}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      focusedBorder: borderTextField(),
      border: borderTextField(),
      enabledBorder: borderTextField(),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 16,
        color: kTextMediumColor,
      ),
    );
  }

  static InputDecoration inputImageDecoration(
      {image: String, hintText: String}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(0),
      prefixIcon: image == null
          ? SizedBox.shrink()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconWidget(iconPath: image, size: 24.0),
                Container(height: 40.0, width: 1.0, color: kTextMediumColor),
                SizedBox(width: 5.0),
              ],
            ),
      focusedBorder: borderTextField(),
      border: borderTextField(),
      enabledBorder: borderTextField(),
      errorBorder: borderTextField(color: kRedColor),
      focusedErrorBorder: borderTextField(color: kRedColor),
      hintText: hintText,
      hintStyle: hintStyle(),
    );
  }

  static InputDecoration getInputDecoration({String helper, style, context}) {
    return InputDecoration(
      helperStyle: style,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primaryVariant,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kRedColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: kTextMediumColor,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kRedColor, width: 1),
      ),
      errorStyle: TextStyle(color: Colors.transparent),
      helperText: '',
      hintText: helper,
      hintStyle: Theme.of(context).textTheme.subtitle1,
    );
  }

  static InputBorder borderTextField({color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.solid,
        color: color ?? kTextMediumColor,
      ),
    );
  }

  static TextStyle inputTextStyle({size, color, weight}) {
    return GoogleFonts.quicksand(
      fontSize: size ?? 16.0,
      fontWeight: weight ?? FontWeight.w500,
      color: color ?? kTextMediumColor,
    );
  }

  static TextStyle hintStyle() {
    return GoogleFonts.quicksand(fontSize: 16, fontWeight: _medium);
  }

  static double viewportHeight(context) => MediaQuery.of(context).size.height;

  static double viewportWidth(context) => MediaQuery.of(context).size.width;

  static Color getColor(context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Colors.black;
    }
    return Colors.white;
  }

  //New #8a2be2

  EdgeInsets kCustomMargin(double yAxis) {
    return EdgeInsets.symmetric(horizontal: 16.0, vertical: yAxis);
  }

  static LinearGradient primaryGradient(context) {
    return LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primaryVariant,
      ],
    );
  }

  static Color getAssetColor(String asset) {
    if (asset == 'BTC') return Color(0xFFf69c3d);
    if (asset == 'ETH') return Color(0xFF497493);
    if (asset == 'LTC') return Color(0xFF949494);
    if (asset == 'XPR') return Colors.deepPurpleAccent;
    if (asset == 'DASH') return Color(0xFF1376b5);
    if (asset == 'ETC') return Color(0xFFf2a900);
    if (asset == 'BCH') return Color(0xFFf2a900);
    if (asset == 'XMR') return Colors.deepOrange;
    if (asset == 'XLM') return Color(0xFFFFFFF);
    if (asset == 'ZEC') return Color(0xFFf2a900);
    if (asset == 'EOS') return Colors.black87;
    if (asset == 'TRX') return Color(0xFFf2a900);
    if (asset == 'BAT') return Colors.red;
    if (asset == 'ALGO') return Colors.black;
    if (asset == 'USDT') return Color(0xFF2ea07b);
    if(asset == 'ZIL') return Colors.teal;
    if(asset == 'NEO') return Colors.lightGreenAccent;
    if(asset == 'IOT') return Colors.black87;
    if(asset == 'NGN') return Colors.green;
    return Colors.black45;
  }

// Colors
  static final Color kRedColor = Color(0xFFEE6B8D);
  static final Color kPurpleColor = Color(0xFFC482F9);
  static final Color kBackgroundColor = Color(0xFFFBF8FF);

  static final Color kShadowColor4 = Color.fromRGBO(207, 236, 248, 0.50);
  static final Color kShadowColor5 = Color.fromRGBO(238, 226, 255, 0.70);
  static final Color kInactiveChartColor = Color(0xFFEAECEF);
  static final kTextMediumColor = Color(0xFF53627C);
}
