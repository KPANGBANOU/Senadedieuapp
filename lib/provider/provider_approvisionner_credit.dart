// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderApprovisionnerCredit with ChangeNotifier {
  bool _affiche = false;
  int _montant = 0;
  String _credit = "";

  String get credit {
    return _credit;
  }

  bool get affiche {
    return _affiche;
  }

  int get montant {
    return _montant;
  }

  void change_credit(String? value) {
    _credit = value!;
    notifyListeners();
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void change_montant(String? value) {
    _montant = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }
}
