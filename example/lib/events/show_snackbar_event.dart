import 'package:action_mixin/action_mixin.dart';

class ShowSnackbarEvent extends EventBase {
  ShowSnackbarEvent({this.content, this.success});

  final String content;
  final bool success;

  @override
  String getKey() {
    return 'show-snackbar';
  }
}
