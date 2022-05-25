import 'package:films_viewer/components/locals/en.dart';
import 'package:films_viewer/components/locals/locale_base.dart';
import 'package:films_viewer/components/locals/ru.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String ruLocale = 'ru_RU';
const String enLocale = 'en_EN';

Map<String, LocaleBase> get initialLocals => <String, LocaleBase>{
      ruLocale: LocaleRu(),
      enLocale: LocaleEn(),
    };
Map<String, Locale> get availableLocales => <String, Locale>{
      ruLocale: const Locale('ru', 'RU'),
      enLocale: const Locale('en', 'EN'),
    };

extension LocalContextExtension on BuildContext {
  LocaleBase get locale => Localizations.of<Locals>(this, Locals)!.current;
}

class Locals {
  Locals(this.locale, this.localizedValues) {
    current = localizedValues[locale.toString()] ?? initialLocals[ruLocale]!;
  }
  final Locale locale;

  final Map<String, LocaleBase> localizedValues;

  late LocaleBase current;
}

class MyLocalizationDelegate extends LocalizationsDelegate<Locals> {
  Map<String, LocaleBase> localizedValues;
  MyLocalizationDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) =>
      localizedValues.keys.toList().contains(locale.toString());

  @override
  Future<Locals> load(Locale locale) => SynchronousFuture<Locals>(
        Locals(
          isSupported(locale) ? locale : availableLocales[ruLocale]!,
          localizedValues,
        ),
      );

  @override
  bool shouldReload(MyLocalizationDelegate old) => false;
}
