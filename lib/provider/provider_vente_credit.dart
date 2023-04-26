// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderVenteCredit with ChangeNotifier {
  String _credit = "";
  int _montant = 0;
  bool _affiche = false;
  bool _payer = true;
  String _numero_client = "";
  String _nom_client = "";
  String _numero = "";

  int get montant {
    return _montant;
  }

  bool get affiche {
    return _affiche;
  }

  String get credit {
    return _credit;
  }

  String get nom_client {
    return _nom_client;
  }

  String get numero_client {
    return _numero_client;
  }

  String get numero {
    return _numero;
  }

  bool get payer {
    return _payer;
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void change_credit(String? value) {
    _credit = value!;
    notifyListeners();
  }

  void change_payer(bool? value) {
    _payer = value!;
    notifyListeners();
  }

  void change_montant(String? value) {
    _montant = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_nom_client(String? value, TextEditingController nomClient) {
    _nom_client = value!;
    nomClient.value = TextEditingValue(
        text: value.toUpperCase(), selection: nomClient.selection);
    notifyListeners();
  }

  void change_numero_client(String? value) {
    _numero_client = value!;
    notifyListeners();
  }

  void change_numero(String? value) {
    _numero = value!;
    notifyListeners();
  }
}
