import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class LoadNameEvent extends SettingEvent {}

class SaveNameEvent extends SettingEvent {
  final String name;
  const SaveNameEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class ClearNameEvent extends SettingEvent {}

class SetEnLocaleEvent extends SettingEvent {
  final bool isEnLocale;
  const SetEnLocaleEvent({required this.isEnLocale});

  @override
  List<Object> get props => [isEnLocale];
}

class SortingEvent extends SettingEvent {
  final String sortingType;
  const SortingEvent({required this.sortingType});
  @override
  List<Object> get props => [sortingType];
}

class LoadSoringType extends SettingEvent {}
