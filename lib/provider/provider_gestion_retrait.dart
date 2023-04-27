// ignore_for_file: non_constant_identifier_nam, non_constant_identifier_names
import 'package:flutter/material.dart';

class ProviderGestionRetrait with ChangeNotifier {
  bool _affiche = false;
  int _montant = 0;
  String _nom_client = "";
  String _numero_client = "";
  String _client = "";
  String _numero_retrait = "";

  bool get affiche {
    return _affiche;
  }

  int get montant {
    return _montant;
  }

  String get nom_client {
    return _nom_client;
  }

  String get numero_client {
    return _numero_client;
  }

  String get client {
    return _client;
  }

  String get numero_retrait {
    return _numero_retrait;
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void change_mntant(String? value) {
    _montant = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }

  void change_client(String? value) {
    _client = value!;
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

  void change_numero_retrait(String? value) {
    _numero_retrait = value!;
    notifyListeners();
  }
}
