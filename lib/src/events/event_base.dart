/// Every custom event must extends EventBase.
///
/// This class acts as a key in the Map function callback,
/// and it also acts as a carryover of the data logic code.
abstract class EventBase {
  const EventBase();

  @override
  String toString() {
    return runtimeType.toString();
  }
}
