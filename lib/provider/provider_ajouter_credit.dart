// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';

class ProviderAjouterCredit with ChangeNotifier {
  String _nom = "";
  int _benefice = 0;
  int _montant_initial = 0;
  int _seuil_approvisionnement = 0;
  bool _affiche = false;

  String get nom {
    return _nom;
  }

  bool get affiche {
    return _affiche;
  }

  int get benefice {
    return _benefice;
  }

  int get montant_initial {
    return _montant_initial;
  }

  int get seuil_approvisionnement {
    return _seuil_approvisionnement;
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void change_nom(String? value, TextEditingController nomCredit) {
    _nom = value!;
    nomCredit.value = TextEditingValue(
        text: value.toUpperCase(), selection: nomCredit.selection);
    notifyListeners();
  }

  void change_benefice(String? value) {
    _benefice = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_montant_initial(String? value) {
    _montant_initial = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_seuil_approvisionnement(String? value) {
    _seuil_approvisionnement = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }
}
