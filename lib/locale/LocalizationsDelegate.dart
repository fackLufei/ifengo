import 'package:flutter/material.dart';
import 'Localizations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class I18nLocalizationsDelegate extends LocalizationsDelegate<I18n>{

  const I18nLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<I18n> load(Locale locale) {
    return new SynchronousFuture<I18n>(new I18n(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) {
    return false;
  }

  static I18nLocalizationsDelegate delegate = const I18nLocalizationsDelegate();
}