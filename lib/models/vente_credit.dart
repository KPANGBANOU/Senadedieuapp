// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VenteCredits {
  final String uid;
  final String user_uid;
  final String credit_uid;
  final String credit_nom;
  final String client_uid;
  final int montant;
  final double benefice;
  final String created_at;
  final String created_at_heure;
  final String created_at_mois;
  final String created_at_annee;
  final int during;
  final String numero;
  final String client_nom;
  VenteCredits({
    required this.uid,
    required this.user_uid,
    required this.credit_uid,
    required this.credit_nom,
    required this.client_uid,
    required this.montant,
    required this.benefice,
    required this.created_at,
    required this.created_at_heure,
    required this.created_at_mois,
    required this.created_at_annee,
    required this.during,
    required this.numero,
    required this.client_nom,
  });

  factory VenteCredits.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];

    return VenteCredits(
        client_nom: (document.data() as Map)['client_nom'],
        credit_nom: (document.data() as Map)['credit_nom'],
        numero: (document.data() as Map)['numero'],
        uid: document.id,
        user_uid: (document.data() as Map)['user_uid'],
        credit_uid: (document.data() as Map)['credit_uid'],
        client_uid: (document.data() as Map)['client_uid'],
        montant: (document.data() as Map)['montant'],
        benefice: (document.data() as Map)['benefice'],
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
        created_at_heure: DateFormat("HH:mm:ss").format(created.toDate()),
        created_at_mois: DateFormat("MM-yyyy").format(created.toDate()),
        created_at_annee: DateFormat("yyyy").format(created.toDate()),
        during: created.millisecondsSinceEpoch);
  }

  VenteCredits copyWith({
    String? uid,
    String? user_uid,
    String? credit_uid,
    String? credit_nom,
    String? client_uid,
    int? montant,
    double? benefice,
    String? created_at,
    String? created_at_heure,
    String? created_at_mois,
    String? created_at_annee,
    int? during,
    String? numero,
    String? client_nom,
  }) {
    return VenteCredits(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      credit_uid: credit_uid ?? this.credit_uid,
      credit_nom: credit_nom ?? this.credit_nom,
      client_uid: client_uid ?? this.client_uid,
      montant: montant ?? this.montant,
      benefice: benefice ?? this.benefice,
      created_at: created_at ?? this.created_at,
      created_at_heure: created_at_heure ?? this.created_at_heure,
      created_at_mois: created_at_mois ?? this.created_at_mois,
      created_at_annee: created_at_annee ?? this.created_at_annee,
      during: during ?? this.during,
      numero: numero ?? this.numero,
      client_nom: client_nom ?? this.client_nom,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'credit_uid': credit_uid});
    result.addAll({'credit_nom': credit_nom});
    result.addAll({'client_uid': client_uid});
    result.addAll({'montant': montant});
    result.addAll({'benefice': benefice});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_heure': created_at_heure});
    result.addAll({'created_at_mois': created_at_mois});
    result.addAll({'created_at_annee': created_at_annee});
    result.addAll({'during': during});
    result.addAll({'numero': numero});
    result.addAll({'client_nom': client_nom});

    return result;
  }

  factory VenteCredits.fromMap(Map<String, dynamic> map) {
    return VenteCredits(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      credit_uid: map['credit_uid'] ?? '',
      credit_nom: map['credit_nom'] ?? '',
      client_uid: map['client_uid'] ?? '',
      montant: map['montant']?.toInt() ?? 0,
      benefice: map['benefice']?.toDouble() ?? 0.0,
      created_at: map['created_at'] ?? '',
      created_at_heure: map['created_at_heure'] ?? '',
      created_at_mois: map['created_at_mois'] ?? '',
      created_at_annee: map['created_at_annee'] ?? '',
      during: map['during']?.toInt() ?? 0,
      numero: map['numero'] ?? '',
      client_nom: map['client_nom'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VenteCredits.fromJson(String source) =>
      VenteCredits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VenteCredits(uid: $uid, user_uid: $user_uid, credit_uid: $credit_uid, credit_nom: $credit_nom, client_uid: $client_uid, montant: $montant, benefice: $benefice, created_at: $created_at, created_at_heure: $created_at_heure, created_at_mois: $created_at_mois, created_at_annee: $created_at_annee, during: $during, numero: $numero, client_nom: $client_nom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VenteCredits &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.credit_uid == credit_uid &&
        other.credit_nom == credit_nom &&
        other.client_uid == client_uid &&
        other.montant == montant &&
        other.benefice == benefice &&
        other.created_at == created_at &&
        other.created_at_heure == created_at_heure &&
        other.created_at_mois == created_at_mois &&
        other.created_at_annee == created_at_annee &&
        other.during == during &&
        other.numero == numero &&
        other.client_nom == client_nom;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user_uid.hashCode ^
        credit_uid.hashCode ^
        credit_nom.hashCode ^
        client_uid.hashCode ^
        montant.hashCode ^
        benefice.hashCode ^
        created_at.hashCode ^
        created_at_heure.hashCode ^
        created_at_mois.hashCode ^
        created_at_annee.hashCode ^
        during.hashCode ^
        numero.hashCode ^
        client_nom.hashCode;
  }
}
