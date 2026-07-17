import '../models/child.dart';

class CurrentChildService {
  CurrentChildService._();

  static Child? _currentChild;

  static Child? get currentChild => _currentChild;

  static void setCurrentChild(Child child) {
    _currentChild = child;
  }

  static bool get hasCurrentChild {
    return _currentChild != null;
  }

  static void clear() {
    _currentChild = null;
  }
}