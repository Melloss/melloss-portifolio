import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/bloc/brightness/brightness_bloc.dart';
import 'package:melloss_portifolio/bloc/file_system/file_system_bloc.dart';
import 'package:melloss_portifolio/bloc/ui/ui_bloc.dart';
import 'package:melloss_portifolio/config/routes/go_routing.dart';
import 'package:melloss_portifolio/config/theme/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'bloc/battery/battery_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BatteryBloc(),
        ),
        BlocProvider(
          create: (context) => BrightnessBloc(),
        ),
        BlocProvider(
          create: (context) => FileSystemBloc(),
        ),
        BlocProvider(
          create: (context) => UIBloc(),
        ),
      ],
      child: ResponsiveApp(
        builder: (_) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouting,
          theme: themeData,
        ),
      ),
    );
  }
}
