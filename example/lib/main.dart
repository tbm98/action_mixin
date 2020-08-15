import 'package:action_mixin/action_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import 'events/loading_event.dart';
import 'events/show_snackbar_event.dart';

class ST extends StateNotifier<int> with ActionMixin {
  ST() : super(0);

  void increA() async {
    state++;
    callback(LoadingEvent());
    Future.delayed(Duration(seconds: 1));
    state++;
    callback(ShowSnackbarEvent());
  }
}

final stProvider = StateNotifierProvider((ref) => ST());

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulHookWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // init actions
    useProvider(stProvider).initActions(actions());

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(stProvider).increA();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  List<ActionEntry> actions() {
    return [
      ActionEntry(
          event: LoadingEvent(),
          action: (event) {
            print('loading $event');
          }),
      ActionEntry(
          event: ShowSnackbarEvent(),
          action: (event) {
            final ShowSnackbarEvent showSnackbar = event;
            print('show snackbar $showSnackbar');
          })
    ];
  }
}
