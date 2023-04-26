// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Depots {
  final String uid;
  final String user_uid;
  final String client_uid;
  final String credit_uid;
  final int montant;
  final double benefice;
  final String created_at;
  final String created_at_heure;
  final String updated_at;
  final String updated_at_heure;
  final bool paye;
  final String credit_nom;
  Depots({
    required this.uid,
    required this.user_uid,
    required this.client_uid,
    required this.credit_uid,
    required this.montant,
    required this.benefice,
    required this.created_at,
    required this.created_at_heure,
    required this.updated_at,
    required this.updated_at_heure,
    required this.paye,
    required this.credit_nom,
  });

  factory Depots.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    Timestamp updated = (document.data() as Map)['updated_at'];
    return Depots(
        credit_nom: (document.data() as Map)['credit_non'],
        uid: document.id,
        user_uid: (document.data() as Map)['user_uid'],
        client_uid: (document.data() as Map)['client_uid'],
        credit_uid: (document.data() as Map)['credit_uid'],
        montant: (document.data() as Map)['montant'],
        benefice: (document.data() as Map)['benefice'],
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
        created_at_heure: DateFormat("HH:mm:ss").format(created.toDate()),
        updated_at: DateFormat("dd-MM-yyyy").format(updated.toDate()),
        updated_at_heure: DateFormat("HH:mm:ss").format(updated.toDate()),
        paye: (document.data() as Map)['paye']);
  }

  Depots copyWith({
    String? uid,
    String? user_uid,
    String? client_uid,
    String? credit_uid,
    int? montant,
    double? benefice,
    String? created_at,
    String? created_at_heure,
    String? updated_at,
    String? updated_at_heure,
    bool? paye,
    String? credit_nom,
  }) {
    return Depots(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      client_uid: client_uid ?? this.client_uid,
      credit_uid: credit_uid ?? this.credit_uid,
      montant: montant ?? this.montant,
      benefice: benefice ?? this.benefice,
      created_at: created_at ?? this.created_at,
      created_at_heure: created_at_heure ?? this.created_at_heure,
      updated_at: updated_at ?? this.updated_at,
      updated_at_heure: updated_at_heure ?? this.updated_at_heure,
      paye: paye ?? this.paye,
      credit_nom: credit_nom ?? this.credit_nom,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'client_uid': client_uid});
    result.addAll({'credit_uid': credit_uid});
    result.addAll({'montant': montant});
    result.addAll({'benefice': benefice});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_heure': created_at_heure});
    result.addAll({'updated_at': updated_at});
    result.addAll({'updated_at_heure': updated_at_heure});
    result.addAll({'paye': paye});
    result.addAll({'credit_nom': credit_nom});

    return result;
  }

  factory Depots.fromMap(Map<String, dynamic> map) {
    return Depots(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      client_uid: map['client_uid'] ?? '',
      credit_uid: map['credit_uid'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      benefice: map['benefice']?.toDouble() ?? 0.0,
      created_at: map['created_at'] ?? '',
      created_at_heure: map['created_at_heure'] ?? '',
      updated_at: map['updated_at'] ?? '',
      updated_at_heure: map['updated_at_heure'] ?? '',
      paye: map['paye'] ?? false,
      credit_nom: map['credit_nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Depots.fromJson(String source) => Depots.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Depots(uid: $uid, user_uid: $user_uid, client_uid: $client_uid, credit_uid: $credit_uid, montant: $montant, benefice: $benefice, created_at: $created_at, created_at_heure: $created_at_heure, updated_at: $updated_at, updated_at_heure: $updated_at_heure, paye: $paye, credit_nom: $credit_nom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Depots &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.client_uid == client_uid &&
        other.credit_uid == credit_uid &&
        other.montant == montant &&
        other.benefice == benefice &&
        other.created_at == created_at &&
        other.created_at_heure == created_at_heure &&
        other.updated_at == updated_at &&
        other.updated_at_heure == updated_at_heure &&
        other.paye == paye &&
        other.credit_nom == credit_nom;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user_uid.hashCode ^
        client_uid.hashCode ^
        credit_uid.hashCode ^
        montant.hashCode ^
        benefice.hashCode ^
        created_at.hashCode ^
        created_at_heure.hashCode ^
        updated_at.hashCode ^
        updated_at_heure.hashCode ^
        paye.hashCode ^
        credit_nom.hashCode;
  }
}
