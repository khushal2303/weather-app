import 'dart:async';

class CustomDebouncer<T> {
  CustomDebouncer(this.duration, this.onValue);
  final Duration duration;
  void Function(T value) onValue;
  late T _value;
  Timer? _timer;
  Timer? get timer => _timer;
  T get value => _value;
  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}
