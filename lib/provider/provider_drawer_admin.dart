// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ProviderDrawerAdmin with ChangeNotifier {
  bool _home = true;
  bool _liquidite_credit = false;
  bool _recharger_stock = false;
  bool _list_credits = false;
  bool _list_depenses = false;
  bool _list_perte = false;
  bool _vente_credits = false;
  bool _list_clients = false;
  bool _depot = false;
  bool _retrait = false;

  bool get retrait {
    return _retrait;
  }

  bool get home {
    return _home;
  }

  bool get liquidite_credit {
    return _liquidite_credit;
  }

  bool get recharger_stock {
    return _recharger_stock;
  }

  bool get list_credits {
    return _list_credits;
  }

  bool get list_depenses {
    return _list_depenses;
  }

  bool get list_pertes {
    return _list_perte;
  }

  bool get vente_credits {
    return _vente_credits;
  }

  bool get list_clients {
    return _list_clients;
  }

  bool get depot {
    return _depot;
  }

  void put_home() {
    _home = true;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_liquidite_credit() {
    _home = false;
    _retrait = false;
    _liquidite_credit = true;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_recharger_stock() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = true;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_list_credits() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = true;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_list_depense() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = true;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_list_perte() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = true;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_vente_credits() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = true;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }

  void put_list_clients() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = true;
    _depot = false;
    notifyListeners();
  }

  void put_depot() {
    _home = false;
    _retrait = false;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = true;
    notifyListeners();
  }

  void put_retrait() {
    _home = false;
    _retrait = true;
    _liquidite_credit = false;
    _recharger_stock = false;
    _list_credits = false;
    _list_depenses = false;
    _list_perte = false;
    _vente_credits = false;
    _list_clients = false;
    _depot = false;
    notifyListeners();
  }
}
