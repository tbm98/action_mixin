# action_mixin [other solution use stream](https://github.com/tbm98/event_mixin)
Makes it simple to pass events from logic code to UI code.

## Why use this package ?
If you used Provider or Riverpod or something similar, how do you display a dialog or show a snackbar from providers?
#### There are a few ways I usually come across the following:
* Use stream to send events and listen in the UI code
    * Listening to a stream in StatefulWidget is easy in the initState() function. But sometimes you forget to close the stream and the problem occurs.
* Use ProviderListener in Riverpod
    * `Even if a provider changes many times in a quick succession, onChange will be called only once, at the end of the frame.` You cannot post multiple events at the same time.
* What about Callback? Yes I use it but how to use it?
    * Using the callback seems pretty wordy and I'm a lazy person :P
#### What is the solution?
Store the FunctionCallback in a Map and initialize it from the UI code. Then you can get it to use according to the predefined key.
#### Usage
1) Create a ChangeNotifier or StateNotifier or something like that and they use `with ActionMixin`.
2) Init in the initState() or build() if in StatelessWidget.
    ```dart
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
    ```
3) call it in your logic code
   ```dart
   void increA() async {
       state++;
       // use callback
       callback(LoadingEvent());
       Future.delayed(Duration(seconds: 1));
       state++;
       // use callback with data
       callback(ShowSnackbarEvent(content: "some content to show", success: false));
     }
   ```
See more in the example for better understanding.