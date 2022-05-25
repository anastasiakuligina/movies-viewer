import 'package:films_viewer/presentation/settings/bloc/setting_event.dart';
import 'package:films_viewer/presentation/settings/bloc/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String tagName = 'name';
  static const String isEnLocaleTag = 'isEnLocale';

  SettingBloc() : super(const SettingState()) {
    on<LoadNameEvent>(_onLoadName);
    on<SaveNameEvent>(_onSaveName);
    on<ClearNameEvent>(_onClearName);
    on<SetEnLocaleEvent>(_onSetEnLocal);
  }
  void _onLoadName(LoadNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString(tagName);
    emit(state.copyWith(name: name));
  }

  void _onSaveName(SaveNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tagName, event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onClearName(ClearNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tagName);
    emit(state.copyWith(name: ''));
  }

  void _onSetEnLocal(SetEnLocaleEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isEnLocaleTag);
    emit(state.copyWith(isEnLocale: event.isEnLocale));
  }
}
