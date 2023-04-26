// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Tranches {
  final String uid;
  final String nom;
  final String description;
  final bool stop;
  final String user_uid;
  final String created_at;
  final String updated_at;
  Tranches({
    required this.uid,
    required this.nom,
    required this.description,
    required this.stop,
    required this.user_uid,
    required this.created_at,
    required this.updated_at,
  });

  factory Tranches.FromFirestore(DocumentSnapshot document) {
    Timestamp created = (document.data() as Map)['created_at'];
    Timestamp updated = (document.data() as Map)['updated_at'];

    return Tranches(
      uid: document.id,
      nom: (document.data() as Map)['nom'],
      description: (document.data() as Map)['description'],
      stop: (document.data() as Map)['stop'],
      user_uid: (document.data() as Map)['user_uid'],
      created_at: DateFormat("dd-MM-yyyy").format(created.toDate()) +
          " à " +
          DateFormat("HH:mm:ss").format(created.toDate()),
      updated_at: DateFormat("dd-MM-yyyy").format(updated.toDate()) +
          " à " +
          DateFormat("HH:mm:ss").format(updated.toDate()),
    );
  }

  Tranches copyWith({
    String? uid,
    String? nom,
    String? description,
    bool? stop,
    String? user_uid,
    String? created_at,
    String? updated_at,
  }) {
    return Tranches(
      uid: uid ?? this.uid,
      nom: nom ?? this.nom,
      description: description ?? this.description,
      stop: stop ?? this.stop,
      user_uid: user_uid ?? this.user_uid,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'nom': nom});
    result.addAll({'description': description});
    result.addAll({'stop': stop});
    result.addAll({'user_uid': user_uid});
    result.addAll({'created_at': created_at});
    result.addAll({'updated_at': updated_at});

    return result;
  }

  factory Tranches.fromMap(Map<String, dynamic> map) {
    return Tranches(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      description: map['description'] ?? '',
      stop: map['stop'] ?? false,
      user_uid: map['user_uid'] ?? '',
      created_at: map['created_at'] ?? '',
      updated_at: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tranches.fromJson(String source) =>
      Tranches.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tranches(uid: $uid, nom: $nom, description: $description, stop: $stop, user_uid: $user_uid, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tranches &&
        other.uid == uid &&
        other.nom == nom &&
        other.description == description &&
        other.stop == stop &&
        other.user_uid == user_uid &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        nom.hashCode ^
        description.hashCode ^
        stop.hashCode ^
        user_uid.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
