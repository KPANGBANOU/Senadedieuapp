// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore_for_file: camel_case_types

class donnesUtilisateur {
  final bool login;
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String sexe;
  final String date_naissance;
  final String uid;
  final String photo_url;
  final bool admin;
  final bool is_active;
  final String mdp;
  final String tranche_uid;
  final String date_inscription;
  final bool deleted;
  donnesUtilisateur({
    required this.login,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.sexe,
    required this.date_naissance,
    required this.uid,
    required this.photo_url,
    required this.admin,
    required this.is_active,
    required this.mdp,
    required this.tranche_uid,
    required this.date_inscription,
    required this.deleted,
  });

  factory donnesUtilisateur.fromFiresotre(DocumentSnapshot snap) {
    final Timestamp dt = (snap.data() as Map)['timestamp'];
    return donnesUtilisateur(
        login: (snap.data() as Map)['login'],
        deleted: (snap.data() as Map)['deleted'],
        date_inscription: DateFormat('dd-MM-yyyy').format(dt.toDate()),
        mdp: (snap.data() as Map<String, dynamic>)['mdp'],
        nom: (snap.data() as Map<String, dynamic>)["nom"],
        prenom: (snap.data() as Map<String, dynamic>)["prenom"],
        email: (snap.data() as Map<String, dynamic>)["email"],
        telephone: (snap.data() as Map<String, dynamic>)["telephone"],
        sexe: (snap.data() as Map<String, dynamic>)["sexe"],
        date_naissance: (snap.data() as Map<String, dynamic>)["date_naissance"],
        uid: snap.id,
        tranche_uid: (snap.data() as Map)['tranche_uid'],
        photo_url: (snap.data() as Map<String, dynamic>)["photo_url"],
        admin: (snap.data() as Map)["admin"],
        is_active: (snap.data() as Map)["is_active"]);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'login': login});
    result.addAll({'nom': nom});
    result.addAll({'prenom': prenom});
    result.addAll({'email': email});
    result.addAll({'telephone': telephone});
    result.addAll({'sexe': sexe});
    result.addAll({'date_naissance': date_naissance});
    result.addAll({'uid': uid});
    result.addAll({'photo_url': photo_url});
    result.addAll({'admin': admin});
    result.addAll({'is_active': is_active});
    result.addAll({'mdp': mdp});
    result.addAll({'tranche_uid': tranche_uid});
    result.addAll({'date_inscription': date_inscription});
    result.addAll({'deleted': deleted});

    return result;
  }

  factory donnesUtilisateur.fromMap(Map<String, dynamic> map) {
    return donnesUtilisateur(
      login: map['login'] ?? false,
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      sexe: map['sexe'] ?? '',
      date_naissance: map['date_naissance'] ?? '',
      uid: map['uid'] ?? '',
      photo_url: map['photo_url'] ?? '',
      admin: map['admin'] ?? false,
      is_active: map['is_active'] ?? false,
      mdp: map['mdp'] ?? '',
      tranche_uid: map['tranche_uid'] ?? '',
      date_inscription: map['date_inscription'] ?? '',
      deleted: map['deleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory donnesUtilisateur.fromJson(String source) =>
      donnesUtilisateur.fromMap(json.decode(source));

  @override
  String toString() {
    return 'donnesUtilisateur(login: $login, nom: $nom, prenom: $prenom, email: $email, telephone: $telephone, sexe: $sexe, date_naissance: $date_naissance, uid: $uid, photo_url: $photo_url, admin: $admin, is_active: $is_active, mdp: $mdp, tranche_uid: $tranche_uid, date_inscription: $date_inscription, deleted: $deleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is donnesUtilisateur &&
        other.login == login &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.telephone == telephone &&
        other.sexe == sexe &&
        other.date_naissance == date_naissance &&
        other.uid == uid &&
        other.photo_url == photo_url &&
        other.admin == admin &&
        other.is_active == is_active &&
        other.mdp == mdp &&
        other.tranche_uid == tranche_uid &&
        other.date_inscription == date_inscription &&
        other.deleted == deleted;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        email.hashCode ^
        telephone.hashCode ^
        sexe.hashCode ^
        date_naissance.hashCode ^
        uid.hashCode ^
        photo_url.hashCode ^
        admin.hashCode ^
        is_active.hashCode ^
        mdp.hashCode ^
        tranche_uid.hashCode ^
        date_inscription.hashCode ^
        deleted.hashCode;
  }

  donnesUtilisateur copyWith({
    bool? login,
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
    String? sexe,
    String? date_naissance,
    String? uid,
    String? photo_url,
    bool? admin,
    bool? is_active,
    String? mdp,
    String? tranche_uid,
    String? date_inscription,
    bool? deleted,
  }) {
    return donnesUtilisateur(
      login: login ?? this.login,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      sexe: sexe ?? this.sexe,
      date_naissance: date_naissance ?? this.date_naissance,
      uid: uid ?? this.uid,
      photo_url: photo_url ?? this.photo_url,
      admin: admin ?? this.admin,
      is_active: is_active ?? this.is_active,
      mdp: mdp ?? this.mdp,
      tranche_uid: tranche_uid ?? this.tranche_uid,
      date_inscription: date_inscription ?? this.date_inscription,
      deleted: deleted ?? this.deleted,
    );
  }
}

class Utilisateur {
  final String uid;
  Utilisateur(
    this.uid,
  );
}
