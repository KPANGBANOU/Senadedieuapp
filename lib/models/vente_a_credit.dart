// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VenteACredits {
  final String uid;
  final String created_at;
  final String updated_at;
  final bool paye;
  final String client_uid;
  final String client_nom;
  final String user_uid;
  final int montant;
  final double benefice;
  final String credit_uid;
  final String numero;
  final String achat;
  VenteACredits({
    required this.uid,
    required this.created_at,
    required this.updated_at,
    required this.paye,
    required this.client_uid,
    required this.client_nom,
    required this.user_uid,
    required this.montant,
    required this.benefice,
    required this.credit_uid,
    required this.numero,
    required this.achat,
  });

  factory VenteACredits.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    Timestamp updated = (document.data() as Map)['updated_at'];
    return VenteACredits(
        client_nom: (document.data() as Map)['client_nom'],
        achat: (document.data() as Map)['achat'],
        numero: (document.data() as Map)['numero'],
        uid: document.id,
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()) +
            " à " +
            DateFormat("HH:mm:ss").format(created.toDate()),
        updated_at: DateFormat("dd-MM-yyyy").format(updated.toDate()) +
            " à " +
            DateFormat("HH:mm:ss").format(updated.toDate()),
        paye: (document.data() as Map)['paye'],
        user_uid: (document.data() as Map)['user_uid'],
        client_uid: (document.data() as Map)['client_uid'],
        montant: (document.data() as Map)['montant'],
        benefice: (document.data() as Map)['benefice'],
        credit_uid: (document.data() as Map)['credit_uid']);
  }

  VenteACredits copyWith({
    String? uid,
    String? created_at,
    String? updated_at,
    bool? paye,
    String? client_uid,
    String? client_nom,
    String? user_uid,
    int? montant,
    double? benefice,
    String? credit_uid,
    String? numero,
    String? achat,
  }) {
    return VenteACredits(
      uid: uid ?? this.uid,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      paye: paye ?? this.paye,
      client_uid: client_uid ?? this.client_uid,
      client_nom: client_nom ?? this.client_nom,
      user_uid: user_uid ?? this.user_uid,
      montant: montant ?? this.montant,
      benefice: benefice ?? this.benefice,
      credit_uid: credit_uid ?? this.credit_uid,
      numero: numero ?? this.numero,
      achat: achat ?? this.achat,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});
    result.addAll({'paye': paye});
    result.addAll({'client_uid': client_uid});
    result.addAll({'client_nom': client_nom});
    result.addAll({'user_uid': user_uid});
    result.addAll({'montant': montant});
    result.addAll({'benefice': benefice});
    result.addAll({'credit_uid': credit_uid});
    result.addAll({'numero': numero});
    result.addAll({'achat': achat});

    return result;
  }

  factory VenteACredits.fromMap(Map<String, dynamic> map) {
    return VenteACredits(
      uid: map['uid'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
      paye: map['paye'] ?? false,
      client_uid: map['client_uid'] ?? '',
      client_nom: map['client_nom'] ?? '',
      user_uid: map['user_uid'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      benefice: map['benefice']?.toDouble() ?? 0.0,
      credit_uid: map['credit_uid'] ?? '',
      numero: map['numero'] ?? '',
      achat: map['achat'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VenteACredits.fromJson(String source) =>
      VenteACredits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VenteACredits(uid: $uid, created_at: $created_at, updated_at: $updated_at, paye: $paye, client_uid: $client_uid, client_nom: $client_nom, user_uid: $user_uid, montant: $montant, benefice: $benefice, credit_uid: $credit_uid, numero: $numero, achat: $achat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VenteACredits &&
        other.uid == uid &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.paye == paye &&
        other.client_uid == client_uid &&
        other.client_nom == client_nom &&
        other.user_uid == user_uid &&
        other.montant == montant &&
        other.benefice == benefice &&
        other.credit_uid == credit_uid &&
        other.numero == numero &&
        other.achat == achat;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        paye.hashCode ^
        client_uid.hashCode ^
        client_nom.hashCode ^
        user_uid.hashCode ^
        montant.hashCode ^
        benefice.hashCode ^
        credit_uid.hashCode ^
        numero.hashCode ^
        achat.hashCode;
  }
}
