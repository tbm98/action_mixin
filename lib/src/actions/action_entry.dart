import 'package:action_mixin/src/events/event_base.dart';

/// Each ActionEntry provides an EventBase as a key and a function callback corresponding to that key.
class ActionEntry {
  const ActionEntry({this.event, this.action});

  /// This is any event you create yourself
  final EventBase event;

  /// function callback with 1 parameter is an EventBase,
  /// this makes the code logic can both get the callback function
  /// by key and pass the data needed for processing.
  final Function(EventBase) action;
}
