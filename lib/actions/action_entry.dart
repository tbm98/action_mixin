import 'package:action_mixin/events/event_base.dart';

/// It map one event with one action
class ActionEntry {
  const ActionEntry({this.event, this.action});

  final EventBase event;
  final Function(EventBase) action;
}
