import 'package:films_viewer/components/buttons/primary_button.dart';
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
      create: (_) => SettingBloc()..add(LoadNameEvent()),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SettingBloc, SettingState>(
                buildWhen: (oldState, newState) =>
                    oldState.name != newState.name,
                builder: (context, state) {
                  return Text(state.name ?? '');
                }),
            PrimaryButton('Получить имя', onPressed: () {
              context.read<SettingBloc>().add(LoadNameEvent());
            }),
            PrimaryButton('Сохранить имя', onPressed: () {
              context
                  .read<SettingBloc>()
                  .add(const SaveNameEvent(name: 'alex'));
            }),
            PrimaryButton('Очистить имя', onPressed: () {
              context.read<SettingBloc>().add(ClearNameEvent());
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
