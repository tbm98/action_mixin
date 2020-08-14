import 'package:action_mixin/events/event_base.dart';

import 'action_entry.dart';

mixin ActionMixin {
  Map<String, Function(EventBase)> _actions;

  /// Put listAction into _action map
  /// this will ignore if _action map is exists that key
  void initActions(List<ActionEntry> listAction) {
    _actions ??= {};

    for (final action in listAction) {
      if (_actions[action.event.getKey()] == null) {
        _actions[action.event.getKey()] = action.action;
      }
    }
  }

  void callback(EventBase event) {
    if (_actions[event.getKey()] == null) {
      throw UnimplementedError('Unimplemented $event');
    }
    _actions[event.getKey()].call(event);
  }
}
