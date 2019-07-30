import 'package:scoped_model/scoped_model.dart';

class Donation extends Model {
  int _amount = 0;
  bool _hasSubmitted = false;

  int get amount {
    return _amount;
  }

  bool get hasSubmitted => _hasSubmitted;

  void increment() {
    _amount++;
    notifyListeners();
  }

  void decrement() {
    if (_amount < 1) {
      return;
    }
    _amount--;
    notifyListeners();
  }

  void resetAmount() {
    _amount = 0;
    notifyListeners();
  }

  void donate() {
    if (_amount == 0){
      return;
    }
    _hasSubmitted = true;
    notifyListeners();
  }

  void donateAgain() {
    _hasSubmitted = false;
    notifyListeners();
  }
}