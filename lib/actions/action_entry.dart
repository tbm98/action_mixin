import 'package:action_mixin/events/event_base.dart';

/// It carries an event and a corresponding CallbackFunction.
class ActionEntry {
  const ActionEntry({this.event, this.action});

  final EventBase event;
  final Function(EventBase) action;
}
