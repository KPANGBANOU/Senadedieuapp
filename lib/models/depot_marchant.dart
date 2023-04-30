// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DepotMarchants {
  final String uid;
  final String created_at;
  final String credit_uid;
  final String user_uid;
  final String credit_nom;
  final int montant;
  DepotMarchants({
    required this.uid,
    required this.created_at,
    required this.credit_uid,
    required this.user_uid,
    required this.credit_nom,
    required this.montant,
  });

  factory DepotMarchants.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    return DepotMarchants(
        uid: document.id,
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()) +
            " à " +
            DateFormat("HH:mm:ss").format(created.toDate()),
        credit_uid: (document.data() as Map)['credit_uid'],
        user_uid: (document.data() as Map)['user_uid'],
        credit_nom: (document.data() as Map)['credit_nom'],
        montant: (document.data() as Map)['montant']);
  }

  DepotMarchants copyWith({
    String? uid,
    String? created_at,
    String? credit_uid,
    String? user_uid,
    String? credit_nom,
    int? montant,
  }) {
    return DepotMarchants(
      uid: uid ?? this.uid,
      created_at: created_at ?? this.created_at,
      credit_uid: credit_uid ?? this.credit_uid,
      user_uid: user_uid ?? this.user_uid,
      credit_nom: credit_nom ?? this.credit_nom,
      montant: montant ?? this.montant,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'created_at': created_at});
    result.addAll({'credit_uid': credit_uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'credit_nom': credit_nom});
    result.addAll({'montant': montant});

    return result;
  }

  factory DepotMarchants.fromMap(Map<String, dynamic> map) {
    return DepotMarchants(
      uid: map['uid'] ?? '',
      created_at: map['created_at'] ?? '',
      credit_uid: map['credit_uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      credit_nom: map['credit_nom'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepotMarchants.fromJson(String source) =>
      DepotMarchants.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DepotMarchants(uid: $uid, created_at: $created_at, credit_uid: $credit_uid, user_uid: $user_uid, credit_nom: $credit_nom, montant: $montant)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DepotMarchants &&
        other.uid == uid &&
        other.created_at == created_at &&
        other.credit_uid == credit_uid &&
        other.user_uid == user_uid &&
        other.credit_nom == credit_nom &&
        other.montant == montant;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        created_at.hashCode ^
        credit_uid.hashCode ^
        user_uid.hashCode ^
        credit_nom.hashCode ^
        montant.hashCode;
  }
}
