import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimibits/exports.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> MainProvider()),
        ChangeNotifierProvider(create: (_)=> SendProvider()),
        ChangeNotifierProvider(create: (_)=> CardProvider()),
      ],
      builder: (context, child) => GimiBits(),
    ),
  );
}

class GimiBits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GimiBits',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      builder: (context, child) => MediaQuery(
        child: child,
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: MediaQuery.of(context).size.width <= 800 ? 0.8 : 1.9,
        ),
      ),
      theme: AppTheme.lightThemeData.copyWith(
        platform: TargetPlatform.android,
      ),
      darkTheme: AppTheme.darkThemeData.copyWith(
        platform: TargetPlatform.android,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: GBIntro(),
      ),
    );
  }
}
