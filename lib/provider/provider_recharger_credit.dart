// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

class ProviderRechargerCredit with ChangeNotifier {
  String _credit = "";
  int _montant = 0;
  bool _affiche = false;

  String get credit {
    return _credit;
  }

  int get montant {
    return _montant;
  }

  bool get affiche {
    return _affiche;
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void change_credit(String? value) {
    _credit = value!;
    notifyListeners();
  }

  void change_montant(String? value) {
    _montant = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }
}
