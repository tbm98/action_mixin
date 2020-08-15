/// Every custom event must extends EventBase.
///
/// This class acts as a key in the Map function callback,
/// and it also acts as a carryover of the data logic code.
abstract class EventBase {
  /// return a unique String as key in map _action
  String getKey();

  @override
  String toString() {
    return getKey();
  }
}
