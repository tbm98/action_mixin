abstract class EventBase {
  /// return a unique String as key in map _action
  String getKey();

  @override
  String toString() {
    return getKey();
  }
}
