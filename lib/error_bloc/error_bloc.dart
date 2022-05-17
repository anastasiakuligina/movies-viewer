import 'package:bloc/bloc.dart';
import 'package:films_viewer/components/dialogs/error_dialog.dart';
import 'package:films_viewer/error_bloc/error_event.dart';
import 'package:films_viewer/error_bloc/error_state.dart';
import 'package:films_viewer/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<ShowDialogEvent>(_onShowDialog);
  }
  void _onShowDialog(ShowDialogEvent event, Emitter<ErrorState> emit) {
    showErrorDialog(error: '${event.title} ${event.message}');
  }

  void showErrorDialog({BuildContext? context, required String error}) {
    final _context = context ?? HomeScreen.globalKey.currentContext;
    if (_context != null) {
      showDialog(
        context: _context,
        builder: (_) => ErrorDialog(error),
      );
    }
  }
}
