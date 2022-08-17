import 'package:example_flutter/model/data/user.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}
