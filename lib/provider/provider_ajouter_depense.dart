// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

class ProviderAjouterDepense with ChangeNotifier {
  String _description = "";
  bool _affiche = false;
  int _montant = 0;

  bool get affiche {
    return _affiche;
  }

  String get description {
    return _description;
  }

  int get montant {
    return _montant;
  }

  void affiche_false() {
    _affiche = false;
    notifyListeners();
  }

  void affiche_true() {
    _affiche = true;
    notifyListeners();
  }

  void change_description(String? value) {
    _description = value!;
    notifyListeners();
  }

  void change_montant(String? value) {
    _montant = value!.isEmpty ? 0 : int.parse(value);
    notifyListeners();
  }
}
