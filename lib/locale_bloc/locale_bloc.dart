import 'package:films_viewer/locale_bloc/locale_event.dart';
import 'package:films_viewer/locale_bloc/locale_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('ru', 'Ru'))) {
    on<ChangeLocaleEvent>(_onLocalChanged);
  }
  void _onLocalChanged(ChangeLocaleEvent event, Emitter<LocaleState> emit) {
    emit(state.copyWith(locale: event.locale));
  }
}
