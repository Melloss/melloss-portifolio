import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:melloss_portifolio/config/routes/go_routing.dart';
import 'package:melloss_portifolio/config/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('am'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', 'US'),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (_) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: goRouting,
        theme: themeData,
      ),
    );
  }
}
