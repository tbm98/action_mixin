import 'package:action_mixin/action_mixin.dart';

class LoadingEvent extends EventBase {
  @override
  String getKey() {
    return 'loading-event';
  }
}
