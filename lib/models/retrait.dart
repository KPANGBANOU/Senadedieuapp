// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Retraits {
  final String uid;
  final String user_uid;
  final String client_uid;
  final String credit_uid;
  final int montant;
  final double benefice;
  final String created_at;
  final String created_at_heure;
  final String credit_nom;
  final String numero_retrait;
  final String client_nom;
  Retraits({
    required this.uid,
    required this.user_uid,
    required this.client_uid,
    required this.credit_uid,
    required this.montant,
    required this.benefice,
    required this.created_at,
    required this.created_at_heure,
    required this.credit_nom,
    required this.numero_retrait,
    required this.client_nom,
  });

  factory Retraits.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    return Retraits(
      client_nom: (document.data() as Map)['client_nom'],
      numero_retrait: (document.data() as Map)['numero_retrait'],
      credit_nom: (document.data() as Map)['credit_nom'],
      uid: document.id,
      user_uid: (document.data() as Map)['user_uid'],
      client_uid: (document.data() as Map)['client_uid'],
      credit_uid: (document.data() as Map)['credit_uid'],
      montant: (document.data() as Map)['montant'],
      benefice: (document.data() as Map)['benefice'],
      created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
      created_at_heure: DateFormat("HH:mm:ss").format(created.toDate()),
    );
  }

  Retraits copyWith({
    String? uid,
    String? user_uid,
    String? client_uid,
    String? credit_uid,
    int? montant,
    double? benefice,
    String? created_at,
    String? created_at_heure,
    String? credit_nom,
    String? numero_retrait,
    String? client_nom,
  }) {
    return Retraits(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      client_uid: client_uid ?? this.client_uid,
      credit_uid: credit_uid ?? this.credit_uid,
      montant: montant ?? this.montant,
      benefice: benefice ?? this.benefice,
      created_at: created_at ?? this.created_at,
      created_at_heure: created_at_heure ?? this.created_at_heure,
      credit_nom: credit_nom ?? this.credit_nom,
      numero_retrait: numero_retrait ?? this.numero_retrait,
      client_nom: client_nom ?? this.client_nom,
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
    result.addAll({'credit_nom': credit_nom});
    result.addAll({'numero_retrait': numero_retrait});
    result.addAll({'client_nom': client_nom});

    return result;
  }

  factory Retraits.fromMap(Map<String, dynamic> map) {
    return Retraits(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      client_uid: map['client_uid'] ?? '',
      credit_uid: map['credit_uid'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      benefice: map['benefice']?.toDouble() ?? 0.0,
      created_at: map['created_at'] ?? '',
      created_at_heure: map['created_at_heure'] ?? '',
      credit_nom: map['credit_nom'] ?? '',
      numero_retrait: map['numero_retrait'] ?? '',
      client_nom: map['client_nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Retraits.fromJson(String source) =>
      Retraits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Retraits(uid: $uid, user_uid: $user_uid, client_uid: $client_uid, credit_uid: $credit_uid, montant: $montant, benefice: $benefice, created_at: $created_at, created_at_heure: $created_at_heure, credit_nom: $credit_nom, numero_retrait: $numero_retrait, client_nom: $client_nom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Retraits &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.client_uid == client_uid &&
        other.credit_uid == credit_uid &&
        other.montant == montant &&
        other.benefice == benefice &&
        other.created_at == created_at &&
        other.created_at_heure == created_at_heure &&
        other.credit_nom == credit_nom &&
        other.numero_retrait == numero_retrait &&
        other.client_nom == client_nom;
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
        credit_nom.hashCode ^
        numero_retrait.hashCode ^
        client_nom.hashCode;
  }
}
