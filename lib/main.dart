import 'package:films_viewer/components/widgets/empty_page.dart';
import 'package:films_viewer/presentation/main_page.dart';
import 'package:films_viewer/presentation/movies/movies_screen.dart';
import 'package:films_viewer/presentation/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      initialRoute: MainPage.path,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MainPage.path) {
          return MaterialPageRoute(builder: (context) {
            return const MainPage();
          });
        }
        if (settings.name == SettingsPage.path) {
          return MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          });
        }
        if (settings.name == MoviesScreen.path) {
          return MaterialPageRoute(builder: (context) {
            return const MoviesScreen();
          });
        }
        return MaterialPageRoute(builder: (context) {
          return const EmptyPage();
        });
      },
      // home: BlocProvider<ErrorBloc>(
      //     lazy: false,
      //     create: (_) => ErrorBloc(),
      //     child: RepositoryProvider<MoviesRepository>(
      //       lazy: true,
      //       create: (BuildContext context) => MoviesRepository(
      //         onErrorHandler: (String code, String message) {
      //           context
      //               .read<ErrorBloc>()
      //               .add(ShowDialogEvent(title: code, message: message));
      //         },
      //       ),
      //       child: BlocProvider<HomeBloc>(
      //         lazy: false,
      //         create: (BuildContext context) =>
      //             HomeBloc(context.read<MoviesRepository>()),
      //         child: const HomeScreen(),
      //       ),
      //     )),
    );
  }
}
