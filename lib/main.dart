import 'package:films_viewer/components/widgets/empty_page.dart';
import 'package:films_viewer/presentation/detail_page.dart';
import 'package:films_viewer/presentation/home/movie_card.dart';
import 'package:films_viewer/presentation/main_page.dart';
import 'package:films_viewer/presentation/movies/movies_screen.dart';
import 'package:films_viewer/presentation/settings/pages/settings_detail_page.dart';
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
        if (settings.name == DetailPage.routeName) {
          final SettingsArgument arguments =
              settings.arguments as SettingsArgument;
          return MaterialPageRoute(builder: (context) {
            return DetailPage(settingsArguments: arguments);
          });
        }
        if (settings.name == SettingsDetailPage.path) {
          final SettingsArgument arguments =
              settings.arguments as SettingsArgument;
          return MaterialPageRoute(builder: (context) {
            return SettingsDetailPage(
              arguments: arguments,
            );
          });
        }
        return MaterialPageRoute(builder: (context) {
          return const EmptyPage();
        });
      },
    );
  }
}
