import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notebook_task_flutter_mhr/localization/demo_localization.dart';
import 'package:notebook_task_flutter_mhr/screens/screenDetails.dart';
import 'package:notebook_task_flutter_mhr/screens/screenListNote.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext buildContext, Locale locale) {
    _MyAppState state = buildContext.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      this._locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "NoteBook",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan, brightness: Brightness.dark),
      locale: _locale,
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'YE')],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: screenListNote(),
    );
  }
}
