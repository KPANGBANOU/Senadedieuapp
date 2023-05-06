// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/depense.dart';
import 'package:senadedieu/models/depot.dart';
import 'package:senadedieu/models/depot_marchant.dart';
import 'package:senadedieu/models/pertes.dart';
import 'package:senadedieu/models/retrait.dart';
import 'package:senadedieu/models/tranches.dart';
import 'package:senadedieu/models/vente_a_credit.dart';
import 'package:senadedieu/models/vente_credit.dart';

import '../models/user.dart';

class ServiceDB {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

  Stream<donnesUtilisateur> user_data(String user_uid) {
    return _ref
        .collection("users")
        .doc(user_uid)
        .snapshots()
        .map((snap) => donnesUtilisateur.fromFiresotre(snap));
  }

  Stream<List<DepotMarchants>> depots_marchants(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depot_marchants")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => DepotMarchants.FromFirestore(e)).toList());
  }

  Stream<DepotMarchants> depot_marchant(String tranche_uid, String depot_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depot_marchants")
        .doc(depot_uid)
        .snapshots()
        .map((event) => DepotMarchants.FromFirestore(event));
  }

  Stream<donnesUtilisateur> get currentuserdata {
    return _ref
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((event) => donnesUtilisateur.fromFiresotre(event));
  }

  Stream<Budget> get budget {
    return _ref
        .collection("budget")
        .doc("budget")
        .snapshots()
        .map((event) => Budget.FromFirestore(event));
  }

  Stream<BudgetTranche> budget_tranche(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("budget")
        .doc("budget_tranche")
        .snapshots()
        .map((event) => BudgetTranche.FromFirestore(event));
  }

  Stream<List<Tranches>> get list_tranches {
    return _ref
        .collection("tranches")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Tranches.FromFirestore(e)).toList());
  }

  Stream<Tranches> tranche(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .snapshots()
        .map((event) => Tranches.FromFirestore(event));
  }

  Stream<List<Credits>> credits(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("credits")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Credits.FromFirestore(e)).toList());
  }

  Stream<Credits> credit(String tranche_uid, String credit_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("credits")
        .doc(credit_uid)
        .snapshots()
        .map((event) => Credits.FromFirestore(event));
  }

  Stream<List<Depenses>> depenses(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depenses")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Depenses.FromFirestore(e)).toList());
  }

  Stream<Depenses> depense(String tranche_uid, String depense_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depenses")
        .doc(depense_uid)
        .snapshots()
        .map((event) => Depenses.FromFirestore(event));
  }

  Stream<List<Pertes>> pertes(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("pertes")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => Pertes.FromFirestore(e)).toList());
  }

  Stream<Pertes> perte(String tranche_uid, String perte_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("pertes")
        .doc(perte_uid)
        .snapshots()
        .map((event) => Pertes.FromFirestore(event));
  }

  Stream<List<VenteACredits>> ventes_a_credits(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("vente_a_credits")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => VenteACredits.FromFirestore(e)).toList());
  }

  Stream<VenteACredits> vente_a_credit(
      String tranche_uid, String vente_a_credit_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("vente_a_credits")
        .doc(vente_a_credit_uid)
        .snapshots()
        .map((event) => VenteACredits.FromFirestore(event));
  }

  Stream<List<VenteCredits>> vente_credits(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("vente_credits")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => VenteCredits.FromFirestore(e)).toList());
  }

  Stream<VenteCredits> vente_credit(String tranche_uid, String vente_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("vente_credits")
        .doc(vente_uid)
        .snapshots()
        .map((event) => VenteCredits.FromFirestore(event));
  }

  Stream<List<Clients>> clients(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("clients")
        .orderBy("dernier_achat", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Clients.FromFirestore(e)).toList());
  }

  Stream<Clients> client(String tranche_uid, String client_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("clients")
        .doc(client_uid)
        .snapshots()
        .map((event) => Clients.FromFirestore(event));
  }

  Stream<List<Depots>> depots(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depots")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map(
            (event) => event.docs.map((e) => Depots.FromFirestore(e)).toList());
  }

  Stream<Depots> depot(String tranche_uid, String depot_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("depots")
        .doc(depot_uid)
        .snapshots()
        .map((event) => Depots.FromFirestore(event));
  }

  Stream<List<Retraits>> retraits(String tranche_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("retraits")
        .orderBy("created_at", descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Retraits.FromFirestore(e)).toList());
  }

  Stream<Retraits> retrait(String tranche_uid, String retrait_uid) {
    return _ref
        .collection("tranches")
        .doc(tranche_uid)
        .collection("retraits")
        .doc(retrait_uid)
        .snapshots()
        .map((event) => Retraits.FromFirestore(event));
  }
}
