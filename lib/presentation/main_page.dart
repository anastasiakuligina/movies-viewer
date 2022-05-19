import 'package:films_viewer/data/repositories/movies_repository.dart';
import 'package:films_viewer/error_bloc/error_bloc.dart';
import 'package:films_viewer/error_bloc/error_event.dart';
import 'package:films_viewer/presentation/home/bloc/home_bloc.dart';
import 'package:films_viewer/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const path = '/';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ErrorBloc>(
      lazy: false,
      create: (_) => ErrorBloc(),
      child: RepositoryProvider<MoviesRepository>(
        lazy: true,
        create: (BuildContext context) =>
            MoviesRepository(onErrorHandler: (String code, String message) {
          context
              .read<ErrorBloc>()
              .add(ShowDialogEvent(title: code, message: message));
        }),
        child: BlocProvider<HomeBloc>(
          lazy: false,
          create: (BuildContext context) =>
              HomeBloc(context.read<MoviesRepository>()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
