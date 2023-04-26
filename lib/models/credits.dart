// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Credits {
  final String uid;
  final String user_uid;
  final String nom;
  final String created_at;
  final String created_at_heure;
  final int montant_initial;
  final int montant_initial_cumule;
  final int montant_disponible;
  final int seuil_approvisionnement;
  final double benefice;
  final int benefice_sur_5000;
  final double benefice_cumule;
  Credits({
    required this.uid,
    required this.user_uid,
    required this.nom,
    required this.created_at,
    required this.created_at_heure,
    required this.montant_initial,
    required this.montant_initial_cumule,
    required this.montant_disponible,
    required this.seuil_approvisionnement,
    required this.benefice,
    required this.benefice_sur_5000,
    required this.benefice_cumule,
  });

  factory Credits.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    return Credits(
        uid: document.id,
        user_uid: (document.data() as Map<String, dynamic>)['user_uid'],
        nom: (document.data() as Map)['nom'],
        created_at: DateFormat("dd-MM-yyyy").format(created.toDate()),
        created_at_heure: DateFormat("HH:mm:ss").format(created.toDate()),
        montant_initial: (document.data() as Map)['montant_initial'],
        montant_initial_cumule:
            (document.data() as Map)['montant_initial_cumule'],
        montant_disponible: (document.data() as Map)['montant_disponible'],
        seuil_approvisionnement:
            (document.data() as Map)['seuil_approvisionnement'],
        benefice: (document.data() as Map)['benefice'],
        benefice_sur_5000: (document.data() as Map)['benefice_sur_5000'],
        benefice_cumule: (document.data() as Map)['benefice_cumule']);
  }

  Credits copyWith({
    String? uid,
    String? user_uid,
    String? nom,
    String? created_at,
    String? created_at_heure,
    int? montant_initial,
    int? montant_initial_cumule,
    int? montant_disponible,
    int? seuil_approvisionnement,
    double? benefice,
    int? benefice_sur_5000,
    double? benefice_cumule,
  }) {
    return Credits(
      uid: uid ?? this.uid,
      user_uid: user_uid ?? this.user_uid,
      nom: nom ?? this.nom,
      created_at: created_at ?? this.created_at,
      created_at_heure: created_at_heure ?? this.created_at_heure,
      montant_initial: montant_initial ?? this.montant_initial,
      montant_initial_cumule:
          montant_initial_cumule ?? this.montant_initial_cumule,
      montant_disponible: montant_disponible ?? this.montant_disponible,
      seuil_approvisionnement:
          seuil_approvisionnement ?? this.seuil_approvisionnement,
      benefice: benefice ?? this.benefice,
      benefice_sur_5000: benefice_sur_5000 ?? this.benefice_sur_5000,
      benefice_cumule: benefice_cumule ?? this.benefice_cumule,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'user_uid': user_uid});
    result.addAll({'nom': nom});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_heure': created_at_heure});
    result.addAll({'montant_initial': montant_initial});
    result.addAll({'montant_initial_cumule': montant_initial_cumule});
    result.addAll({'montant_disponible': montant_disponible});
    result.addAll({'seuil_approvisionnement': seuil_approvisionnement});
    result.addAll({'benefice': benefice});
    result.addAll({'benefice_sur_5000': benefice_sur_5000});
    result.addAll({'benefice_cumule': benefice_cumule});

    return result;
  }

  factory Credits.fromMap(Map<String, dynamic> map) {
    return Credits(
      uid: map['uid'] ?? '',
      user_uid: map['user_uid'] ?? '',
      nom: map['nom'] ?? '',
      created_at: map['created_at'] ?? '',
      created_at_heure: map['created_at_heure'] ?? '',
      montant_initial: map['montant_initial']?.toInt() ?? 0,
      montant_initial_cumule: map['montant_initial_cumule']?.toInt() ?? 0,
      montant_disponible: map['montant_disponible']?.toInt() ?? 0,
      seuil_approvisionnement: map['seuil_approvisionnement']?.toInt() ?? 0,
      benefice: map['benefice']?.toDouble() ?? 0.0,
      benefice_sur_5000: map['benefice_sur_5000']?.toInt() ?? 0,
      benefice_cumule: map['benefice_cumule']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credits.fromJson(String source) =>
      Credits.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Credits(uid: $uid, user_uid: $user_uid, nom: $nom, created_at: $created_at, created_at_heure: $created_at_heure, montant_initial: $montant_initial, montant_initial_cumule: $montant_initial_cumule, montant_disponible: $montant_disponible, seuil_approvisionnement: $seuil_approvisionnement, benefice: $benefice, benefice_sur_5000: $benefice_sur_5000, benefice_cumule: $benefice_cumule)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Credits &&
        other.uid == uid &&
        other.user_uid == user_uid &&
        other.nom == nom &&
        other.created_at == created_at &&
        other.created_at_heure == created_at_heure &&
        other.montant_initial == montant_initial &&
        other.montant_initial_cumule == montant_initial_cumule &&
        other.montant_disponible == montant_disponible &&
        other.seuil_approvisionnement == seuil_approvisionnement &&
        other.benefice == benefice &&
        other.benefice_sur_5000 == benefice_sur_5000 &&
        other.benefice_cumule == benefice_cumule;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user_uid.hashCode ^
        nom.hashCode ^
        created_at.hashCode ^
        created_at_heure.hashCode ^
        montant_initial.hashCode ^
        montant_initial_cumule.hashCode ^
        montant_disponible.hashCode ^
        seuil_approvisionnement.hashCode ^
        benefice.hashCode ^
        benefice_sur_5000.hashCode ^
        benefice_cumule.hashCode;
  }
}
