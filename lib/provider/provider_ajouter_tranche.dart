// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderAjouterTranche with ChangeNotifier {
  String _nom = "";
  String _description = "";
  String _tranche = "";
  bool _affiche = false;

  String get nom {
    return _nom;
  }

  String get description {
    return _description;
  }

  String get tranche {
    return _tranche;
  }

  bool get affiche {
    return _affiche;
  }

  void change_nom(String? value, TextEditingController nomTranche) {
    _nom = value!;
    nomTranche.value = TextEditingValue(
        text: value.toUpperCase(), selection: nomTranche.selection);
    notifyListeners();
  }

  void change_description(String? value) {
    _description = value!;
    notifyListeners();
  }

  void change_tranche(String? value) {
    _tranche = value!;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }
}
