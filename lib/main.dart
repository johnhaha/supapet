import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supapet/config.dart';
import 'package:supapet/routes.dart';
import 'package:supapet/utils.dart';

void main() async {
  await initEnv();
  await initDatabase();
  await initSharedPrefs();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          brightness: Brightness.dark,
          cardColor: kCardColor,
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: kPrimaryColor,
            onPrimary: kFontColor,
            secondary: kPrimaryColor,
            onSecondary: kFontColor,
            error: kAlertColor,
            onError: kFontColor,
            background: kPageColor,
            onBackground: kFontColor,
            surface: kCardColor,
            onSurface: kFontColor,
          )),
    );
  }
}
