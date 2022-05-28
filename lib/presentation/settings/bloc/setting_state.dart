import 'package:equatable/equatable.dart';
import 'package:films_viewer/components/constants.dart';

class SettingState extends Equatable {
  final String? name;
  final bool? isEnLocale;
  final String? sortingType;
  const SettingState({this.name, this.isEnLocale, this.sortingType});

  SettingState copyWith(
          {String? name, bool? isEnLocale, String? sortingType}) =>
      SettingState(
          name: name ?? this.name,
          isEnLocale: isEnLocale ?? this.isEnLocale,
          sortingType: sortingType ?? this.sortingType);
  @override
  List<Object> get props =>
      [name ?? '', isEnLocale ?? false, sortingType ?? MovieLocal.name];
}
