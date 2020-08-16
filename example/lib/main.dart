import 'package:action_mixin/action_mixin.dart';
import 'package:example/events/dismis_dialog_event.dart';
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
    await Future.delayed(Duration(seconds: 1));
    callback(DismisDialogEvent());
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulHookWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read(stProvider).initActions(actions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('null'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(stProvider).increA();
//            _scaffoldKey.currentState.showSnackBar(SnackBar(
//              content: Text('content'),
//            ));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  List<ActionEntry> actions() {
    return [
      ActionEntry(
          event: const LoadingEvent(),
          action: (event) {
            print('loading $event');
            showDialog(
                context: context,
                builder: (ct) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }),
      ActionEntry(
          event: DismisDialogEvent(),
          action: (_) {
            Navigator.of(context, rootNavigator: true).pop();
          }),
      ActionEntry(
          event: ShowSnackbarEvent(),
          action: (event) {
            final ShowSnackbarEvent showSnackbar = event;
            print('show snackbar $showSnackbar');
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('content'),
            ));
          })
    ];
  }
}
