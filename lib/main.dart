import 'package:exdata_collector/ActiveRacePage.dart';
import 'package:exdata_collector/Helpers/SelfTheme.dart';
import 'package:exdata_collector/Services/ActiveRaceService.dart';
import 'package:exdata_collector/Services/SettingsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exdata_collector/l10n/app_localizations.dart';

import "package:exdata_collector/HomePage.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsManager = await SettingsManager.getInstance();
  final localeCode = await settingsManager.getLocale();
  await ActiveRaceService.shared.tryLoadActiveRace();
  runApp(MyApp(initialLocale: Locale(localeCode)));
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;
  const MyApp({Key? key, required this.initialLocale}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  String _themeMode = 'system';
  bool isRaceActive = false;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    _initializeThemeMode();
    _initializeRaceData();
  }

  Future<void> _initializeThemeMode() async {
    final settingsManager = await SettingsManager.getInstance();
    final themeMode = await settingsManager.getThemeMode();
    setState(() {
      _themeMode = themeMode;
    });
  }

  Future<void> _initializeRaceData() async {
    await ActiveRaceService.shared.tryLoadActiveRace();
    setState(() {
      isRaceActive = ActiveRaceService.shared.isRaceActive();
    });
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  void setThemeMode(String value) {
    setState(() {
      _themeMode = value;
    });
  }

  ThemeMode _getThemeMode() {
    switch (_themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EX-Boat DC',
      theme: SelfTheme.from(colorScheme: ColorScheme.light()),
      darkTheme: SelfTheme.from(colorScheme: ColorScheme.dark()),
      themeMode: _getThemeMode(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('cs', ''),
      ],
      locale: _locale,
      home: isRaceActive ? const ActiveRacePage() : const HomePage(),
    );
  }
}
