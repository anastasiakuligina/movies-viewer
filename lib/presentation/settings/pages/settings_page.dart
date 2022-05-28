import 'package:films_viewer/components/constants.dart';
import 'package:films_viewer/presentation/settings/bloc/setting_bloc.dart';
import 'package:films_viewer/presentation/settings/bloc/setting_event.dart';
import 'package:films_viewer/presentation/settings/bloc/setting_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const path = '/settings';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      lazy: false,
      create: (_) => SettingBloc()..add(LoadSoringType()),
      child: const SettingsPageContent(),
    );
  }
}

class SettingsPageContent extends StatefulWidget {
  const SettingsPageContent({Key? key}) : super(key: key);

  @override
  _SettingsPageContentState createState() => _SettingsPageContentState();
}

class _SettingsPageContentState extends State<SettingsPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<SettingBloc, SettingState>(
                buildWhen: (oldState, newState) =>
                    oldState.sortingType != newState.sortingType,
                builder: (context, state) {
                  return Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          MovieLocal.sorting,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton<String>(
                            value: state.sortingType,
                            items: <String>[
                              MovieLocal.name,
                              MovieLocal.rating,
                              MovieLocal.year
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                context.read<SettingBloc>().add(SortingEvent(
                                    sortingType: value ?? MovieLocal.name));
                              });
                            },
                          )),
                    ],
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.exit_to_app),
                    Text('Exit'),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.arrow_back),
                    Text('Back'),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
