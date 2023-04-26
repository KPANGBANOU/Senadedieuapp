// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/tranches.dart';

class ServiceDB {
  final FirebaseFirestore _ref = FirebaseFirestore.instance;

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
}
