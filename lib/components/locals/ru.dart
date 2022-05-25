import 'package:films_viewer/components/locals/locale_base.dart';

class LocaleRu implements LocaleBase {
  @override
  String get error => 'Ошибка';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get ratingPrefix => 'Оценка: ';

  @override
  String get ratingSuffix => '/ 10';

  @override
  String get search => 'Поиск';

  @override
  String get language => 'Язык';

  @override
  String get runtime => 'Длительность серии';

  @override
  String get min => 'мин';

  @override
  String get deleteFromFavorites => 'Удалить из избранного';

  @override
  String get addInFavorites => 'Добавить в избранное';

  @override
  String get releaseDate => 'Дата выхода';

  @override
  String get noDataTitle => 'Нет данных';

  @override
  String get dataButtonTitle => 'Получить данные';

  @override
  String get switchLanguage => 'Сменить язык';
}
