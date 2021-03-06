import 'package:films_viewer/features/home/pages/catalog_page.dart';
import 'package:films_viewer/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class _Tab {
  const _Tab({required this.icon, required this.label, required this.page});
  final Icon icon;
  final String label;
  final Widget page;
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  // late List<FilmCardModel> filmss = <FilmCardModel>[];
  static const String routeName = '/';
  static const List<_Tab> _tabs = <_Tab>[
    _Tab(
        icon: Icon(Icons.local_movies_outlined),
        label: 'Feed',
        page: HomePage(
          title: 'Films',
        )),
    _Tab(
        icon: Icon(Icons.movie_filter),
        label: 'Catalog',
        page: CatalogPage(title: 'Films')),
  ];
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage._tabs.elementAt(_selectedIndex).page,
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(MainPage._tabs.length, (index) {
          final _Tab tab = MainPage._tabs[index];
          return BottomNavigationBarItem(icon: tab.icon, label: tab.label);
        }),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
