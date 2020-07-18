import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String,String > _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String , dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key,value.toString()));
  }

  String getTranslateValue(String key){
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate = _DemoLocalizationsDelegate();

}


class _DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations demoLocalizations = new DemoLocalizations(locale);
    await demoLocalizations.load();
    return demoLocalizations;
  }

  @override
  bool shouldReload(_DemoLocalizationsDelegate old) => false;
}