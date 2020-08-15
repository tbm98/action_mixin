import 'package:action_mixin/src/events/event_base.dart';

import 'action_entry.dart';

/// This class provides a Map to store callback functions with EventBase as key.
mixin ActionMixin {
  Map<String, Function(EventBase)> _actions;
  bool _firstInit = true;

  /// Initialize the callback list once, it will ignore init times after that.
  void initActions(List<ActionEntry> listAction) {
    if (_firstInit == false) {
      return;
    }
    _actions ??= {};

    for (final action in listAction) {
      if (_actions[action.event.getKey()] == null) {
        _actions[action.event.getKey()] = action.action;
      }
    }

    _firstInit = false;
  }

  /// Add a list of callbacks after init
  ///
  /// If it is the default actions then you should use initActions.
  void addActions(List<ActionEntry> listAction) {
    _actions ??= {};

    for (final action in listAction) {
      if (_actions[action.event.getKey()] == null) {
        _actions[action.event.getKey()] = action.action;
      }
    }
  }

  /// The callback function is called from the provider,
  /// it requires passing an EventBase,
  /// you can create yourself a class that extends
  /// EventBase with arbitrary data.
  void callback(EventBase event) {
    if (_actions[event.getKey()] == null) {
      throw UnimplementedError('Unimplemented $event');
    }
    _actions[event.getKey()].call(event);
  }
}
