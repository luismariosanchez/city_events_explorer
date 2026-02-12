import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:city_events_explorer/src/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF111113),
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF111113),
          surfaceTintColor: Color(0xFF111113),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: Colors.white,
        ),
      ),
    );
  }
}
