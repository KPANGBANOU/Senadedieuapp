// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Clients {
  final String uid;
  final String numero;
  final String nom;
  final int total_achat;
  final int total_non_paye;
  final String dernier_achat;
  final int total_depot;
  final int total_depot_non_paye;
  final int total_retrait;
  Clients({
    required this.uid,
    required this.numero,
    required this.nom,
    required this.total_achat,
    required this.total_non_paye,
    required this.dernier_achat,
    required this.total_depot,
    required this.total_depot_non_paye,
    required this.total_retrait,
  });

  factory Clients.FromFirestore(DocumentSnapshot document) {
    Timestamp dernier = (document.data() as Map)['dernier_achat'];
    return Clients(
        total_depot: (document.data() as Map)['total_depot'],
        total_depot_non_paye: (document.data() as Map)['total_depot_non_paye'],
        total_retrait: (document.data() as Map)['total_retrait'],
        uid: document.id,
        numero: (document.data() as Map)['numero'],
        nom: (document.data() as Map)['nom'],
        total_achat: (document.data() as Map)['total_achat'],
        total_non_paye: (document.data() as Map)['total_non_paye'],
        dernier_achat: DateFormat("dd-MM-yyyy").format(dernier.toDate()) +
            " à " +
            DateFormat("HH:mm:ss").format(dernier.toDate()));
  }

  Clients copyWith({
    String? uid,
    String? numero,
    String? nom,
    int? total_achat,
    int? total_non_paye,
    String? dernier_achat,
    int? total_depot,
    int? total_depot_non_paye,
    int? total_retrait,
  }) {
    return Clients(
      uid: uid ?? this.uid,
      numero: numero ?? this.numero,
      nom: nom ?? this.nom,
      total_achat: total_achat ?? this.total_achat,
      total_non_paye: total_non_paye ?? this.total_non_paye,
      dernier_achat: dernier_achat ?? this.dernier_achat,
      total_depot: total_depot ?? this.total_depot,
      total_depot_non_paye: total_depot_non_paye ?? this.total_depot_non_paye,
      total_retrait: total_retrait ?? this.total_retrait,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'numero': numero});
    result.addAll({'nom': nom});
    result.addAll({'total_achat': total_achat});
    result.addAll({'total_non_paye': total_non_paye});
    result.addAll({'dernier_achat': dernier_achat});
    result.addAll({'total_depot': total_depot});
    result.addAll({'total_depot_non_paye': total_depot_non_paye});
    result.addAll({'total_retrait': total_retrait});

    return result;
  }

  factory Clients.fromMap(Map<String, dynamic> map) {
    return Clients(
      uid: map['uid'] ?? '',
      numero: map['numero'] ?? '',
      nom: map['nom'] ?? '',
      total_achat: map['total_achat']?.toInt() ?? 0,
      total_non_paye: map['total_non_paye']?.toInt() ?? 0,
      dernier_achat: map['dernier_achat'] ?? '',
      total_depot: map['total_depot']?.toInt() ?? 0,
      total_depot_non_paye: map['total_depot_non_paye']?.toInt() ?? 0,
      total_retrait: map['total_retrait']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Clients.fromJson(String source) =>
      Clients.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Clients(uid: $uid, numero: $numero, nom: $nom, total_achat: $total_achat, total_non_paye: $total_non_paye, dernier_achat: $dernier_achat, total_depot: $total_depot, total_depot_non_paye: $total_depot_non_paye, total_retrait: $total_retrait)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Clients &&
        other.uid == uid &&
        other.numero == numero &&
        other.nom == nom &&
        other.total_achat == total_achat &&
        other.total_non_paye == total_non_paye &&
        other.dernier_achat == dernier_achat &&
        other.total_depot == total_depot &&
        other.total_depot_non_paye == total_depot_non_paye &&
        other.total_retrait == total_retrait;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        numero.hashCode ^
        nom.hashCode ^
        total_achat.hashCode ^
        total_non_paye.hashCode ^
        dernier_achat.hashCode ^
        total_depot.hashCode ^
        total_depot_non_paye.hashCode ^
        total_retrait.hashCode;
  }
}
