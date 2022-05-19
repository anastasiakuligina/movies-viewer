import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/domain/models/home_model.dart';
import 'package:films_viewer/presentation/favourite/favourite_screen.dart';
import 'package:films_viewer/presentation/home/bloc/home_bloc.dart';
import 'package:films_viewer/presentation/home/bloc/home_event.dart';
import 'package:films_viewer/presentation/movies/movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _Tab {
  const _Tab({required this.icon, required this.label, required this.page});
  final Icon icon;
  final String label;
  final Widget page;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();
  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
        icon: Icon(Icons.local_movies_outlined),
        label: 'Movies',
        page: MoviesScreen()),
    _Tab(
        icon: Icon(Icons.favorite),
        label: 'Favourite movies',
        page: FavouritePage()),
  ];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: HomeScreen.globalKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: MovieColors.backgroundBlackColor,
        body: HomeScreen._tabs.elementAt(_selectedIndex).page,
        bottomNavigationBar: BottomNavigationBar(
          items: List.generate(HomeScreen._tabs.length, (index) {
            final _Tab tab = HomeScreen._tabs[index];
            return BottomNavigationBarItem(icon: tab.icon, label: tab.label);
          }),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
