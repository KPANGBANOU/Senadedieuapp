// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:senadedieu/base_de_donnees/registration.dart';
import 'package:senadedieu/interface/facture_depot.dart';
import 'package:senadedieu/interface/facture_retrait.dart';
import 'package:senadedieu/interface/facture_vente_credit.dart';
import 'package:senadedieu/interface/stream_tranche_list_pertes.dart';
import 'package:senadedieu/interface/stream_tranche_ventes_a_credits_non_payes.dart';
import 'generate_code.dart';

class Functions {
  Future<String> login(
      String email, String password, firebaseAuth firebaseService) async {
    try {
      if (email.isEmpty || !email.contains("@") || password.length < 8) {
        return "100";
      } else {
        final request = await firebaseService.signInWithEmailAndPassword(
            email, password.trim());

        if (request != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            "login": true,
            "mdp": sha1.convert(utf8.encode(password.trim())).toString()
          });
          return "200";
        } else {
          return "202";
        }
      }
    } catch (e) {
      return "202";
    }
  }

  // credits

// ignore_for_file: non_constant_identifier_names

  Future<String> AjouterTranche(
      String user_uid, String nom, String description) async {
    try {
      if (nom.isEmpty || description.isEmpty || user_uid.isEmpty) {
        return "100"; // données invalides
      } else {
        final request = await FirebaseFirestore.instance
            .collection("tranches")
            .where("nom", isEqualTo: nom)
            .get();
        final bool is_empty = request.docs.isEmpty;

        if (!is_empty) {
          return "201"; // la tranche existe déjà
        } else {
          String tranche_uid = "";

          await FirebaseFirestore.instance.collection("tranches").add({
            "nom": nom,
            "description": description,
            "user_uid": user_uid,
            "created_at": DateTime.now(),
            "updated_at": DateTime.now(),
            "stop": false,
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .where("nom", isEqualTo: nom)
              .get()
              .then((value) {
            final tranche = value.docs.first;
            tranche_uid = tranche.id;
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("budget")
              .doc("budget_tranche")
              .set({
            "solde_total": 0,
            "depense": 0,
            "perte": 0,
            "benefice": 0.01
          });

          final String statut_code1 = await AjouterCredit(
              tranche_uid, "MTN Bénin".toUpperCase(), 250, 0, 3000, user_uid);

          final String statut_code2 = await AjouterCredit(
              tranche_uid, "Moov Bénin".toUpperCase(), 250, 0, 3000, user_uid);

          if (statut_code1 != "200" || statut_code2 != "200") {
            return "202";
          } else {
            return "200";
          }
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> DeleteTranche(String tranche_uid) async {
    try {
      if (tranche_uid.isEmpty) {
        return "100";
      } else {
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .delete();

        return "200";
      }
    } catch (e) {
      return "200";
    }
  }

  Future<String> UpdateTranche(String tranche_nom, String tranche_uid,
      String description, String nom) async {
    try {
      if (tranche_uid.isEmpty ||
          tranche_nom.isEmpty ||
          description.isEmpty ||
          nom.isEmpty) {
        return "100";
      } else {
        if (tranche_nom == nom) {
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .update(
                  {"description": description, "updated_at": DateTime.now()});
          return "200";
        } else {
          final request = await FirebaseFirestore.instance
              .collection("tranches")
              .where("nom", isEqualTo: nom)
              .get();
          final bool is_empty = request.docs.isEmpty;

          if (!is_empty) {
            return "201"; // Ce nom correspond déjà à une tranche
          } else {
            await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .update({
              "nom": nom,
              "description": description,
              "updated_at": DateTime.now()
            });

            return "200";
          }
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> AjouterCredit(String tranche_uid, String nom, int benefice,
      int montant_initial, int seuil_approvisionnement, String user_uid) async {
    try {
      if (nom.isEmpty ||
          tranche_uid.isEmpty ||
          benefice <= 0 ||
          benefice > 300 ||
          benefice < 250 ||
          seuil_approvisionnement <= 0) {
        return "100"; // données invalides
      } else {
        final request = await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .where("nom", isEqualTo: nom)
            .get();

        final bool is_empty = request.docs.isEmpty;

        if (!is_empty) {
          return "201"; // Ce credit existe déjà
        } else {
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .add({
            "nom": nom,
            "user_uid": user_uid,
            "created_at": DateTime.now(),
            "benefice_sur_5000": benefice,
            "benefice": 0.0,
            "benefice_cumule": 0.0,
            "montant_initial": montant_initial,
            "montant_initial_cumule": montant_initial,
            "seuil_approvisionnement": seuil_approvisionnement,
            "approvisionne": false,
            "montant_disponible": montant_initial
          });
          return "200";
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> DeleteCredit(
    String tranche_uid,
    String credit_uid,
  ) async {
    try {
      if (credit_uid.isEmpty || tranche_uid.isEmpty) {
        return "100"; // credit vide ou invalide
      } else {
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .doc(credit_uid)
            .delete();
        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateCredit(
      String tranche_uid,
      String credit_uid,
      String credit_nom,
      String nom,
      int benefice_sur_5000,
      int montant_initial,
      int montant_initial_cumule,
      int seuil_approvisionnement,
      int credit_montant_disponible,
      int montant_disponible) async {
    try {
      if (credit_uid.isEmpty ||
          tranche_uid.isEmpty ||
          credit_nom.isEmpty ||
          nom.isEmpty ||
          benefice_sur_5000 <= 0 ||
          benefice_sur_5000 > 300 ||
          benefice_sur_5000 < 250) {
        return "100";
      } else {
        if (credit_nom == nom) {
          // Si c'est le emem nom
          if (montant_disponible == credit_montant_disponible) {
            // s'il y a pas modification de stock
            await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .collection("credits")
                .doc(credit_uid)
                .update({
              "seuil_approvisionnement": seuil_approvisionnement,
              "benefice_sur_5000": benefice_sur_5000
            });
            return "200";
          } else {
            // Si on veut modifier le stock
            int difference = credit_montant_disponible - montant_disponible;

            if (difference >= 0) {
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "seuil_approvisionnement": seuil_approvisionnement,
                "benefice_sur_5000": benefice_sur_5000,
                "montant_initial": montant_initial - difference,
                "montant_initial_cumule": montant_initial_cumule - difference,
                "montant_disponible": credit_montant_disponible - difference
              });
              return "200";
            } else {
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "seuil_approvisionnement": seuil_approvisionnement,
                "benefice_sur_5000": benefice_sur_5000,
                "montant_initial": montant_initial - difference,
                "montant_initial_cumule": montant_initial_cumule - difference,
                "montant_disponible": credit_montant_disponible - difference
              });
              return "200";
            }
          }
        } else {
          final request = await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .where("nom", isEqualTo: nom)
              .get();
          final bool is_empty = request.docs.isEmpty;

          if (!is_empty) {
            return "201"; // Ce nom correspond déjà à un crédit
          } else {
            if (montant_disponible == credit_montant_disponible) {
              // s'il y a pas modification de stock
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "seuil_approvisionnement": seuil_approvisionnement,
                "benefice_sur_5000": benefice_sur_5000,
                "nom": nom,
              });
              return "200";
            } else {
              // Si on veut modifier le stock
              int difference = credit_montant_disponible - montant_disponible;

              if (difference >= 0) {
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("credits")
                    .doc(credit_uid)
                    .update({
                  "nom": nom,
                  "seuil_approvisionnement": seuil_approvisionnement,
                  "benefice_sur_5000": benefice_sur_5000,
                  "montant_initial": montant_initial - difference,
                  "montant_initial_cumule": montant_initial_cumule - difference,
                  "montant_disponible": credit_montant_disponible - difference
                });
                return "200";
              } else {
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("credits")
                    .doc(credit_uid)
                    .update({
                  "nom": nom,
                  "seuil_approvisionnement": seuil_approvisionnement,
                  "benefice_sur_5000": benefice_sur_5000,
                  "montant_initial": montant_initial - difference,
                  "montant_initial_cumule": montant_initial_cumule - difference,
                  "montant_disponible": credit_montant_disponible - difference
                });
                return "200";
              }
            }
          }
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> ApprovisionnementCredit(
      String tranche_uid, String nom, int montant, String user_uid) async {
    try {
      if (tranche_uid.isEmpty || nom.isEmpty || montant <= 0) {
        return "100";
      } else {
        String credit_uid = "";
        int montant_initial = 0;
        int montant_initial_cumule = 0;
        int montant_disponible = 0;
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .where("nom", isEqualTo: nom)
            .get()
            .then((value) {
          final credit = value.docs.first;
          credit_uid = credit.id;
          montant_disponible = credit.data()['montant_disponible'];
          montant_initial = credit.data()['montant_initial'];
          montant_initial_cumule = credit.data()['montant_initial_cumule'];
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .doc(credit_uid)
            .update({
          "montant_initial": montant_initial + montant,
          "montant_initial_cumule": montant_initial_cumule + montant,
          "montant_disponible": montant_disponible + montant
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("depot_marchants")
            .add({
          "created_at": DateTime.now(),
          "user_uid": user_uid,
          'credit_uid': credit_uid,
          "credit_nom": nom,
          "montant": montant
        });

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> VenteCredit(
      BuildContext dialodcontext,
      String tranche_uid,
      String nom_credit,
      String user_uid,
      String? description_perte,
      bool paye,
      bool perte,
      int montant,
      String nom_client,
      String numero_client,
      String numero,
      String budget_uid,
      int budget_solde_total,
      int budget_perte,
      double budget_benefice,
      String budget_tranche_uid,
      int budget_tranche_solde_total,
      double budget_tranche_benefice,
      int budget_tranche_perte) async {
    try {
      if ((tranche_uid.isEmpty ||
              nom_credit.isEmpty ||
              montant <= 0 ||
              numero.isEmpty ||
              numero_client.isEmpty ||
              nom_client.isEmpty) ||
          (perte && description_perte!.isEmpty)) {
        return "100"; // données vides ou invalides
      } else {
        String credit_uid = "";
        double benefice = 0;
        int benefice_sur_5000 = 0;
        double benefice_cumule = 0;
        int seuil_approvisionnement = 0;
        int montant_disponible = 0;
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .where("nom", isEqualTo: nom_credit)
            .get()
            .then((value) {
          final credit = value.docs.first;
          credit_uid = credit.id;
          benefice_sur_5000 = credit.data()['benefice_sur_5000'];
          montant_disponible = credit.data()['montant_disponible'];
          benefice = credit.data()['benefice'];
          benefice_cumule = credit.data()['benefice_cumule'];
          seuil_approvisionnement = credit.data()['seuil_approvisionnement'];
        });

        if (montant > montant_disponible) {
          return "101"; // stock insuffisant
        } else {
          if (perte) {
            // Si c'est une perte au cas ou il s'est trompé de numero

            final String statut_code = await AjouterPerte(
                credit_uid,
                tranche_uid,
                user_uid,
                description_perte!,
                montant,
                budget_uid,
                budget_perte,
                budget_tranche_uid,
                budget_tranche_perte);

            if (statut_code == "200") {
              await FirebaseFirestore.instance // mise à jour de stock
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({"montant_disponible": montant_disponible - montant});

              if (montant_disponible - montant <= seuil_approvisionnement) {
                // signaler l'approvsionnement
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("credits")
                    .doc(credit_uid)
                    .update({"approvisionne": true});
              }

              return "200";
            } else if (statut_code == "100") {
              return "100";
            } else {
              return "202";
            }
          } else {
            String client_uid = "";
            int total_achat = 0;
            int total_non_paye = 0;
            final client_request = await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .collection("clients")
                .where("numero", isEqualTo: numero_client)
                .get();
            final bool is_empty_client = client_request.docs.isEmpty;

            if (!paye) {
              // s'il s'agit de vente à crédit

              if (is_empty_client) {
                // si c'est le premier achat du client
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .add({
                  "total_depot": 0,
                  "total_depot_non_paye": 0,
                  "total_retrait": 0,
                  "nom": nom_client,
                  "numero": numero_client,
                  "dernier_achat": DateTime.now(),
                  "total_achat": montant,
                  "total_non_paye": montant
                });

                await FirebaseFirestore.instance // rechercher le client
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: numero_client)
                    .get()
                    .then((value) {
                  final mon_client = value.docs.first;
                  client_uid = mon_client.id;
                });
              } else {
                await FirebaseFirestore.instance // mise à jour du client
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: numero_client)
                    .get()
                    .then((value) {
                  final client = value.docs.first;
                  client_uid = client.id;
                  total_achat = client.data()['total_achat'];
                  total_non_paye = client.data()['total_non_paye'];
                });

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .doc(client_uid)
                    .update({
                  "derniere_achat": DateTime.now(),
                  "total_achat": total_achat + montant,
                  "total_non_paye": total_non_paye + montant
                });
              }

              await FirebaseFirestore.instance // save vente à crédits
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("vente_a_credits")
                  .add({
                "client_nom": nom_client,
                "created_at": DateTime.now(),
                "updated_at": DateTime.now(),
                "achat": "Ce client a achété " +
                    montant.toString() +
                    " XOF du crédit " +
                    nom_credit +
                    " à crédit",
                "numero": numero,
                "paye": false,
                "user_uid": user_uid,
                "client_uid": client_uid,
                "montant": montant,
                "credit_uid": credit_uid,
                "benefice": (montant * benefice_sur_5000) / 5000
              });

              await FirebaseFirestore.instance // mise à jour de stock
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({"montant_disponible": montant_disponible - montant});

              if (montant_disponible - montant <= seuil_approvisionnement) {
                await FirebaseFirestore.instance // signaler approvisionnement
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("credits")
                    .doc(credit_uid)
                    .update({"approvisionnen": true});
              }
              return "200";
            } else {
              // si la vente est payée

              if (is_empty_client) {
                // si c'est le premier achat du client
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .add({
                  "total_retrait": 0,
                  "total_depot": 0,
                  "total_depot_non_paye": 0,
                  "nom": nom_client,
                  "numero": numero_client,
                  "dernier_achat": DateTime.now(),
                  "total_achat": montant,
                  "total_non_paye": 0
                });

                await FirebaseFirestore.instance // rechercher le client
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: numero_client)
                    .get()
                    .then((value) {
                  final mon_client = value.docs.first;
                  client_uid = mon_client.id;
                });
              } else {
                await FirebaseFirestore.instance // mise à jour du client
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: numero_client)
                    .get()
                    .then((value) {
                  final client = value.docs.first;
                  client_uid = client.id;
                  total_achat = client.data()['total_achat'];
                  total_non_paye = client.data()['total_non_paye'];
                });

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .doc(client_uid)
                    .update({
                  "derniere_achat": DateTime.now(),
                  "total_achat": total_achat + montant,
                });
              }

              // enregistrer vente

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("vente_credits")
                  .add({
                "client_nom": nom_client,
                "created_at": DateTime.now(),
                "user_uid": user_uid,
                "numero": numero,
                "credit_uid": credit_uid,
                "client_uid": client_uid,
                "montant": montant,
                "benefice": (montant * benefice_sur_5000) / 5000,
                "credit_nom": nom_credit
              });

              // mise à jour de stock

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "montant_disponible": montant_disponible - montant,
                "benefice": benefice + (montant * benefice_sur_5000) / 5000,
                "benefice_cumule":
                    benefice_cumule + (montant * benefice_sur_5000) / 5000
              });

              if (montant_disponible - montant <= seuil_approvisionnement) {
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("credits")
                    .doc(credit_uid)
                    .update({"approvisionne": true});
              }
              // ajout au budget general
              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "solde_total": budget_solde_total + montant,
                "benefice":
                    budget_benefice + (montant * benefice_sur_5000) / 5000
              });
              // ajoutv au budget du tranche

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "solde_total": budget_tranche_solde_total + montant,
                "benefice": budget_tranche_benefice +
                    (montant * benefice_sur_5000) / 5000
              });

              await Navigator.push(
                  dialodcontext,
                  MaterialPageRoute(
                    builder: (context) => FactureVenteCredit(
                        nom_client: nom_client,
                        numero: numero,
                        numero_client: numero_client,
                        total_achat_client:
                            is_empty_client ? montant : total_achat + montant,
                        total_non_paye: is_empty_client ? 0 : total_non_paye,
                        credit_nom: nom_credit,
                        credit_montant_vendu: montant,
                        credit_montant_restant: montant_disponible - montant,
                        credit_uid: credit_uid,
                        tranche_uid: tranche_uid),
                  ));

              return "200";
            }
          }
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> DeleteVenteCredit(
    String tranche_uid,
    String vente_uid,
    String credit_uid,
    String client_uid,
    String budget_uid,
    String budget_tranche_uid,
    int budget_solde_total,
    int budget_tranche_solde_total,
    double budget_benefice,
    double budget_tranche_benefice,
    int vente_montant,
    double vente_benefice,
  ) async {
    try {
      if (tranche_uid.isEmpty ||
          vente_uid.isEmpty ||
          credit_uid.isEmpty ||
          client_uid.isEmpty ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty ||
          vente_montant <= 0 ||
          vente_benefice <= 0) {
        return "100";
      } else {
        int total_achat = 0;

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("clients")
            .doc(client_uid)
            .get()
            .then((value) {
          total_achat = (value.data() as Map)['total_achat'];
        });

        if (total_achat < vente_montant) {
          return "101";
        } else {
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .doc(client_uid)
              .update({"total_achat": total_achat - vente_montant});

          int montant_disponible = 0;
          double benefice = 0;
          double benefice_cumule = 0;

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .get()
              .then((value) {
            montant_disponible = (value.data() as Map)['montant_disponible'];
            benefice = (value.data() as Map)['benefice'];
            benefice_cumule = (value.data() as Map)['benefice_cumule'];
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .update({
            "montant_disponible": montant_disponible + vente_montant,
            "benefice": benefice - vente_benefice,
            "benefice_cumule": benefice_cumule - vente_benefice
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("budget")
              .doc(budget_tranche_uid)
              .update({
            "solde_total": budget_tranche_solde_total - vente_montant,
            "benefice": budget_tranche_benefice - vente_benefice
          });

          await FirebaseFirestore.instance
              .collection("budget")
              .doc(budget_uid)
              .update({
            "solde_total": budget_solde_total - vente_montant,
            "benefice": budget_benefice - vente_benefice
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("vente_credits")
              .doc(vente_uid)
              .delete();
          return "200";
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateVenteCredit(
      BuildContext context,
      String tranche_uid,
      String vente_uid,
      String client_numero,
      String numero,
      String nom_client_saisie,
      String client_numero_saisie,
      String numero_saisie,
      String user_uid,
      String credit_uid,
      String nom_credit,
      int credit_montant_disponible,
      double credit_benefice,
      double credit_benefice_cumule,
      String client_uid,
      int credit_benefice_sur_5000,
      String budget_uid,
      int budget_perte,
      String budget_tranche_uid,
      int budget_solde_total,
      int budget_tranche_solde_total,
      double budget_benefice,
      double budget_tranche_benefice,
      int budget_tranche_perte,
      double vente_benefice,
      int vente_montant,
      int client_total_paye,
      int client_total_non_paye,
      int montant,
      bool perte,
      bool payer,
      String? description) async {
    try {
      if ((tranche_uid.isEmpty ||
              nom_credit.isEmpty ||
              nom_client_saisie.isEmpty ||
              numero.isEmpty ||
              client_numero.isEmpty ||
              user_uid.isEmpty ||
              client_numero_saisie.isEmpty ||
              numero_saisie.isEmpty ||
              credit_uid.isEmpty ||
              client_uid.isEmpty ||
              vente_uid.isEmpty ||
              budget_uid.isEmpty ||
              budget_tranche_uid.isEmpty ||
              montant <= 0 ||
              vente_montant <= 0) ||
          (perte && description!.isEmpty)) {
        return "100"; // données vides ou invalides
      } else {
        int difference_montant = vente_montant - montant;
        double benefice = (montant * credit_benefice_sur_5000) / 5000;
        double differnce_benefice = vente_benefice - benefice;

        if (difference_montant < 0 &&
            credit_montant_disponible < -1 * difference_montant) {
          return "101";
        } else {
          if (perte) {
            // Si c'est une perte au cas ou il s'est trompé de numero

            final String statut_code = await AjouterPerte(
                credit_uid,
                tranche_uid,
                user_uid,
                description!,
                montant,
                budget_uid,
                budget_perte,
                budget_tranche_uid,
                budget_tranche_perte);

            if (statut_code == "200") {
              await FirebaseFirestore.instance // mise à jour de stock
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "montant_disponible":
                    credit_montant_disponible - difference_montant,
                "benefice": credit_benefice - differnce_benefice,
                "benefice_cumule": credit_benefice_cumule - differnce_benefice
              });

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("vente_credits")
                  .doc(vente_uid)
                  .delete();

              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "solde_total": budget_solde_total - vente_montant,
                "benefice": budget_benefice - vente_benefice,
              });

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "solde_total": budget_tranche_solde_total - vente_montant,
                "benefice": budget_tranche_benefice - vente_benefice
              });

              if (client_numero != client_numero_saisie) {
                String uid = "";
                int tot_paye = 0;
                int tota_non_paye = 0;
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: client_numero_saisie)
                    .get()
                    .then((value) {
                  final client = value.docs.first;
                  uid = client.id;
                  tot_paye = client.data()['total_achat'];
                });

                if (uid.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .doc(uid)
                      .update({
                    "total_achat": tot_paye - vente_montant,
                  });
                }
              } else {
                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .doc(client_uid)
                    .update({
                  "total_achat": client_total_paye - vente_montant,
                });
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StreamTrancheListPertes(tranche_uid: tranche_uid),
                  ));

              return "200";
            } else if (statut_code == "100") {
              return "100";
            } else {
              return "202";
            }
          } else {
            String nouveau_client_uid = "";

            if (!payer) {
              // s'il s'agit de vente à crédit

              if (client_numero != client_numero_saisie) {
                final client_request = await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: client_numero_saisie)
                    .get();
                final bool is_empty_client = client_request.docs.isEmpty;

                if (is_empty_client) {
                  // si c'est le premier achat du client
                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .add({
                    "total_depot": 0,
                    "total_depot_non_paye": 0,
                    "total_retrait": 0,
                    "nom": nom_client_saisie,
                    "numero": client_numero_saisie,
                    "dernier_achat": DateTime.now(),
                    "total_achat": montant,
                    "total_non_paye": montant
                  });

                  await FirebaseFirestore.instance // rechercher le client
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .where("numero", isEqualTo: client_numero_saisie)
                      .get()
                      .then((value) {
                    final mon_client = value.docs.first;
                    nouveau_client_uid = mon_client.id;
                  });
                } else {
                  int nouveau_total_achat = 0;
                  int nouveau_total_achat_non_paye = 0;

                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .where("numero", isEqualTo: client_numero_saisie)
                      .get()
                      .then((value) {
                    final client = value.docs.first;
                    nouveau_client_uid = client.id;
                    nouveau_total_achat = client.data()['total_achat'];
                    nouveau_total_achat_non_paye =
                        client.data()['total_non_paye'];
                  });

                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .doc(nouveau_client_uid)
                      .update({
                    "derniere_achat": DateTime.now(),
                    "total_achat": nouveau_total_achat + montant,
                    "total_non_paye": nouveau_total_achat_non_paye + montant
                  });
                }

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(client_uid)
                    .update({
                  "total_achat": client_total_paye - vente_montant,
                });

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("vente_credits")
                    .doc(vente_uid)
                    .delete();

                await FirebaseFirestore.instance // save vente à crédits
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("vente_a_credits")
                    .add({
                  "client_nom": nom_client_saisie,
                  "created_at": DateTime.now(),
                  "updated_at": DateTime.now(),
                  "achat": "Ce client a achété " +
                      montant.toString() +
                      " XOF du crédit " +
                      nom_credit +
                      " à crédit",
                  "numero": numero_saisie,
                  "paye": false,
                  "user_uid": user_uid,
                  "client_uid": nouveau_client_uid,
                  "montant": montant,
                  "credit_uid": credit_uid,
                  "benefice": benefice
                });
              } else {
                // le meme client

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("vente_credits")
                    .doc(vente_uid)
                    .delete();

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .doc(client_uid)
                    .update({
                  "total_achat": difference_montant > 0
                      ? client_total_paye - difference_montant
                      : client_total_paye + difference_montant,
                  "total_non_paye": client_total_non_paye + montant
                });

                await FirebaseFirestore.instance // save vente à crédits
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("vente_a_credits")
                    .add({
                  "client_nom": nom_client_saisie,
                  "created_at": DateTime.now(),
                  "updated_at": DateTime.now(),
                  "achat": "Ce client a achété " +
                      montant.toString() +
                      " XOF du crédit " +
                      nom_credit +
                      " à crédit",
                  "numero": numero_saisie,
                  "paye": false,
                  "user_uid": user_uid,
                  "client_uid": client_uid,
                  "montant": montant,
                  "credit_uid": credit_uid,
                  "benefice": benefice
                });
              }

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "solde_total": budget_tranche_solde_total - vente_montant,
                "benefice": budget_tranche_benefice - vente_benefice
              });
              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "solde_total": budget_solde_total - vente_montant,
                "benefice": budget_benefice - vente_montant
              });

              await FirebaseFirestore.instance // mise à jour de stock
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "montant_disponible": difference_montant > 0
                    ? credit_montant_disponible - difference_montant
                    : credit_montant_disponible + difference_montant,
                "benefice": credit_benefice - vente_benefice,
                "benefice_cumule": credit_benefice_cumule - vente_benefice
              });

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamTrancheVenteACreditsNonPayes(
                        tranche_uid: tranche_uid),
                  ));

              return "200";
            } else {
              // si la vente est payée

              if (client_numero != client_numero_saisie) {
                final client_request = await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .where("numero", isEqualTo: client_numero_saisie)
                    .get();
                final bool is_empty_client = client_request.docs.isEmpty;

                if (is_empty_client) {
                  // si c'est le premier achat du client
                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .add({
                    "total_depot": 0,
                    "total_depot_non_paye": 0,
                    "total_retrait": 0,
                    "nom": nom_client_saisie,
                    "numero": client_numero_saisie,
                    "dernier_achat": DateTime.now(),
                    "total_achat": montant,
                    "total_non_paye": 0
                  });

                  await FirebaseFirestore.instance // rechercher le client
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .where("numero", isEqualTo: client_numero_saisie)
                      .get()
                      .then((value) {
                    final mon_client = value.docs.first;
                    nouveau_client_uid = mon_client.id;
                  });
                } else {
                  int nouveau_total_achat = 0;

                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .where("numero", isEqualTo: client_numero_saisie)
                      .get()
                      .then((value) {
                    final client = value.docs.first;
                    nouveau_client_uid = client.id;
                    nouveau_total_achat = client.data()['total_achat'];
                  });

                  await FirebaseFirestore.instance
                      .collection("tranches")
                      .doc(tranche_uid)
                      .collection("clients")
                      .doc(nouveau_client_uid)
                      .update({
                    "derniere_achat": DateTime.now(),
                    "total_achat": nouveau_total_achat - difference_montant,
                  });
                }

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(client_uid)
                    .update({
                  "total_achat": client_total_paye - vente_montant,
                });
              } else {
                // le meme client

                await FirebaseFirestore.instance
                    .collection("tranches")
                    .doc(tranche_uid)
                    .collection("clients")
                    .doc(client_uid)
                    .update({
                  "total_achat": client_total_paye - difference_montant,
                });
              }

              // enregistrer vente

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("vente_credits")
                  .doc(vente_uid)
                  .update({
                "client_nom": nom_client_saisie,
                "numero": numero_saisie,
                "client_uid": client_numero != client_numero_saisie
                    ? nouveau_client_uid
                    : client_uid,
                "montant": vente_montant - difference_montant,
                "benefice": vente_benefice - differnce_benefice,
              });

              // mise à jour de stock

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(credit_uid)
                  .update({
                "montant_disponible":
                    credit_montant_disponible - difference_montant,
                "benefice": credit_benefice - differnce_benefice,
                "benefice_cumule": credit_benefice_cumule - differnce_benefice
              });

              // ajout au budget general
              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "solde_total": budget_solde_total - difference_montant,
                "benefice": budget_benefice - differnce_benefice
              });
              // ajoutv au budget du tranche

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "solde_total": budget_tranche_solde_total - difference_montant,
                "benefice": budget_tranche_benefice - differnce_benefice
              });

              return "200";
            }
          }
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> AjouterPerte(
      String? credit_uid,
      String tranche_uid,
      String user_uid,
      String description,
      int montant,
      String budget_uid,
      int budget_perte,
      String budget_tranche_uid,
      int budget_tranche_perte) async {
    try {
      if (tranche_uid.isEmpty ||
          user_uid.isEmpty ||
          description.isEmpty ||
          montant <= 0 ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100"; // données vides ou invalides
      } else {
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("pertes")
            .add({
          "credit_uid": credit_uid,
          "user_uid": user_uid,
          "created_at": DateTime.now(),
          "montant": montant,
          "description": description
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({
          "perte": budget_tranche_perte + montant,
        });

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({'perte': budget_perte + montant});

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> AjouterDepense(
      String tranche_uid,
      String user_uid,
      String description,
      int montant,
      String budget_uid,
      int budget_depense,
      String budget_tranche_uid,
      int budget_tranche_depense) async {
    try {
      if (tranche_uid.isEmpty ||
          user_uid.isEmpty ||
          description.isEmpty ||
          montant <= 0 ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100"; // données vides ou invalides
      } else {
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("depenses")
            .add({
          "user_uid": user_uid,
          "created_at": DateTime.now(),
          "montant": montant,
          "description": description
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({
          "depense": budget_tranche_depense + montant,
        });

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({'depense': budget_depense + montant});

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdateDepense(
      String transe_uid,
      String depense_uid,
      int depense_montant,
      int montant,
      String description,
      String budget_uid,
      String budget_tranche_uid,
      int budget_depense,
      int budget_tranche_depense) async {
    try {
      if (transe_uid.isEmpty ||
          depense_uid.isEmpty ||
          depense_montant <= 0 ||
          montant <= 0 ||
          description.isEmpty ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        int differnce = depense_montant - montant;

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(transe_uid)
            .collection("depenses")
            .doc(depense_uid)
            .update({
          "description": description,
          "montant": depense_montant - differnce
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(transe_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({"depense": budget_tranche_depense - differnce});

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({"depense": budget_depense - differnce});

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> UpdatePerte(
      String transe_uid,
      String perte_uid,
      int perte_montant,
      int montant,
      String description,
      String budget_uid,
      String budget_tranche_uid,
      int budget_perte,
      int budget_tranche_perte) async {
    try {
      if (transe_uid.isEmpty ||
          perte_uid.isEmpty ||
          perte_montant <= 0 ||
          montant <= 0 ||
          description.isEmpty ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        int differnce = perte_montant - montant;

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(transe_uid)
            .collection("pertes")
            .doc(perte_uid)
            .update({
          "description": description,
          "montant": perte_montant - differnce
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(transe_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({"perte": budget_tranche_perte - differnce});

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({"perte": budget_perte - differnce});

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> DeletePerte(
      String tranche_uid,
      String perte_uid,
      String? credit_uid,
      int perte_montant,
      String budget_uid,
      String budget_tranche_uid,
      int budget_perte,
      int budget_tranche_perte) async {
    try {
      if (tranche_uid.isEmpty ||
          perte_uid.isEmpty | budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        if (credit_uid!.isNotEmpty) {
          int montant_disponible = 0;
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .get()
              .then((value) {
            montant_disponible = (value.data() as Map)['montant_disponible'];
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .update(
                  {"montant_disponible": montant_disponible + perte_montant});
        }

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({"perte": budget_perte - perte_montant});

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({"perte": budget_tranche_perte - perte_montant});

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("pertes")
            .doc(perte_uid)
            .delete();

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> DeleteDepense(
      String tranche_uid,
      String depense_uid,
      int depense_montant,
      String budget_uid,
      String budget_tranche_uid,
      int budget_depense,
      int budget_tranche_depense) async {
    try {
      if (tranche_uid.isEmpty ||
          depense_uid.isEmpty ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({"depense": budget_depense - depense_montant});

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({"depense": budget_tranche_depense - depense_montant});

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("depenses")
            .doc(depense_uid)
            .delete();

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> PayerVenteACredit(
      String tranche_uid,
      String credit_uid,
      double credit_benefice,
      double credit_benefice_cumule,
      String vente_uid,
      int montant,
      String budget_tranche_uid,
      String budget_uid,
      int budget_solde_total,
      int budget_tranche_solde_total,
      double budget_benefice,
      double budget_tranche_benefice,
      double benefice,
      String client_uid,
      int client_total_non_paye) async {
    try {
      if (tranche_uid.isEmpty ||
          credit_uid.isEmpty ||
          vente_uid.isEmpty ||
          montant <= 0 ||
          budget_tranche_uid.isEmpty ||
          budget_uid.isEmpty ||
          client_uid.isEmpty ||
          client_total_non_paye < montant) {
        // données invalides
        return "100";
      } else {
        await FirebaseFirestore.instance // mise  à jour du budget de tranche
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({
          "solde_total": budget_tranche_solde_total + montant,
          "benefice": budget_tranche_benefice + benefice
        });

        await FirebaseFirestore.instance // mise à jour du budget principal
            .collection("budget")
            .doc(budget_uid)
            .update({
          "solde_total": budget_solde_total + montant,
          "benefice": budget_benefice + benefice
        });

        await FirebaseFirestore.instance // mise à jour du crédit
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .doc(credit_uid)
            .update({
          "benefice": credit_benefice + benefice,
          "benefice_cumule": credit_benefice_cumule + benefice
        });

        await FirebaseFirestore.instance // modification du crdit du client
            .collection("tranches")
            .doc(tranche_uid)
            .collection("clients")
            .doc(client_uid)
            .update({"total_non_paye": client_total_non_paye - montant});

        await FirebaseFirestore.instance // modification du statut
            .collection("tranches")
            .doc(tranche_uid)
            .collection("vente_a_credits")
            .doc(vente_uid)
            .update({"paye": true, "updated_at": DateTime.now()});

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> VerificationUtilisateur(
      String email,
      String nom,
      String prenom,
      String telephone,
      String sexe,
      String date_naissance,
      String password,
      String confirm_password) async {
    try {
      if (email.isEmpty || !email.contains("@")) {
        // email invalide
        return "100";
      } else if (nom.isEmpty ||
          prenom.isEmpty ||
          sexe.isEmpty ||
          telephone.length != 8 ||
          date_naissance.isEmpty) {
        // données invalides
        return "101";
      } else if (password.length < 8 || confirm_password.length < 8) {
        // mot de passe incorrect
        return "102";
      } else if (confirm_password != password) {
        // mot de passe mal confirmé
        return "103";
      } else {
        final request = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

        final bool is_empty = request.docs.isEmpty;

        if (!is_empty) {
          // cette adresse e-mail est utilisé
          return "104";
        } else {
          int code = RandomDigits.getInteger(5);

          String username = 'senadedieu2@gmail.com';
          String password = "cnufxxugouasgdnt";

          final smtpServer = gmail(username, password);
          final message = Message()
            ..from = Address(username, 'SENA DE DIEU')
            ..recipients.add(email.trim())
            ..ccRecipients
            ..subject = "Validation de l'adresse e-mail"
            ..text = " " +
                code.toString().toUpperCase() +
                " \n Voici le code de validation de votre adresse E-Mail pour la création de compte sur Agri Pilalo. Veuillez saisir ce code dans un bref dèlai";

          final sendReport = await send(message, smtpServer);

          return code.toString();
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> CreateAccount(
      String email,
      String nom,
      String prenom,
      String telephone,
      String sexe,
      String date_naissance,
      String password,
      int code_envoye,
      String code_saiie,
      firebaseAuth firebaseService) async {
    try {
      if (code_envoye.toString() != code_saiie) {
        return "100";
      } else {
        final result = await firebaseService.createUserWithEmailAndPassword(
            email, password);

        if (result != null) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            "login": true,
            "tranche_uid": "",
            "deleted": false,
            "nom": nom,
            "prenom": prenom,
            "sexe": sexe,
            "date_naissance": date_naissance,
            "telephone": telephone,
            "email": email,
            "timestamp": DateTime.now(),
            "admin": false,
            "is_active": false,
            "photo_url": "",
            "mdp": sha1.convert(utf8.encode(password.trim())).toString(),
          });
          return "200";
        } else {
          return "202";
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> FaireDepot(
    BuildContext context,
    String tranche_uid,
    String user_uid,
    String credit_nom,
    int montant,
    bool payer,
    String client_nom,
    String numero,
    String numero_client,
    String budget_uid,
    int budget_solde_total,
    double budget_benefice,
    String budget_tranche_uid,
    int budget_tranche_solde_total,
    double budget_tranche_benefice,
  ) async {
    try {
      if (tranche_uid.isEmpty ||
          credit_nom.isEmpty ||
          montant <= 0 ||
          client_nom.isEmpty ||
          numero.isEmpty ||
          numero_client.isEmpty ||
          numero.length != 8 ||
          numero_client.length != 8) {
        // validation de données
        return "100";
      } else {
        String credit_uid = "";
        String client_uid = "";
        int montant_disponible = 0;
        int total_depot = 0;
        int total_depot_non_paye = 0;
        double benefice = 0;
        double benefice_cumule = 0;
        int seuil_approvisionnement = 0;
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .where("nom", isEqualTo: credit_nom)
            .get()
            .then((value) {
          final credit = value.docs.first;
          seuil_approvisionnement = credit.data()['seuil_approvisionnement'];
          benefice = credit.data()['benefice'];
          benefice_cumule = credit.data()['benefice_cumule'];
          credit_uid = credit.id;
          montant_disponible = credit.data()['montant_disponible'];
        });

        if (montant > montant_disponible) {
          //stock insuffisant
          return "201";
        } else {
          // si le depot n'est pas payé
          final request = await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .where("numero", isEqualTo: numero_client)
              .get();

          final bool is_empty = request.docs.isEmpty;

          if (is_empty) {
            // si c'est le premier achat du client
            await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .collection("clients")
                .add({
              "total_depot": montant,
              "total_depot_non_paye": payer ? 0 : montant,
              "total_retrait": 0,
              "nom": client_nom,
              "numero": numero_client,
              "dernier_achat": DateTime.now(),
              "total_achat": 0,
              "total_non_paye": 0
            });

            await FirebaseFirestore.instance // rechercher le client
                .collection("tranches")
                .doc(tranche_uid)
                .collection("clients")
                .where("numero", isEqualTo: numero_client)
                .get()
                .then((value) {
              final mon_client = value.docs.first;
              client_uid = mon_client.id;
            });
          } else {
            await FirebaseFirestore.instance // mise à jour du client
                .collection("tranches")
                .doc(tranche_uid)
                .collection("clients")
                .where("numero", isEqualTo: numero_client)
                .get()
                .then((value) {
              final client = value.docs.first;
              client_uid = client.id;
              total_depot = client.data()['total_depot'];
              total_depot_non_paye = client.data()['total_depot_non_paye'];
            });

            await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .collection("clients")
                .doc(client_uid)
                .update({
              "derniere_achat": DateTime.now(),
              "total_depot": total_depot + montant,
              "total_non_paye":
                  payer ? total_depot_non_paye : total_depot_non_paye + montant
            });
          }

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .update({
            "montant_disponible": montant_disponible - montant,
            "benefice": payer ? benefice + (montant * 50) / 15500 : benefice,
            "benefice_cumule": payer
                ? benefice_cumule + (montant * 50) / 15500
                : benefice_cumule
          });

          if (montant_disponible - montant <= seuil_approvisionnement) {
            await FirebaseFirestore.instance
                .collection("tranches")
                .doc(tranche_uid)
                .collection("credits")
                .doc(credit_uid)
                .update({"approvisionne": true});
          }

          await FirebaseFirestore.instance
              .collection("budget")
              .doc(budget_uid)
              .update({
            "solde_total":
                !payer ? budget_solde_total : budget_solde_total + montant,
            "benefice": payer ? benefice + (montant * 50) / 15500 : benefice
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("budget")
              .doc(budget_tranche_uid)
              .update({
            "solde_total": !payer
                ? budget_tranche_solde_total
                : budget_tranche_solde_total + montant,
            "benefice": payer
                ? budget_tranche_benefice + (montant * 50) / 15500
                : budget_tranche_benefice
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("depots")
              .add({
            "user_uid": user_uid,
            "client_uid": client_uid,
            "credit_uid": credit_uid,
            "client_nom": client_nom,
            "credit_nom": credit_nom,
            "montant": montant,
            "benefice": (montant * 50) / 15500,
            "paye": payer,
            "numero_depot": numero,
            "created_at": DateTime.now(),
            "updated_at": DateTime.now()
          });

          Navigator.of(context).pop();

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FactureDepot(
                    credit_nom: credit_nom,
                    credit_montant_vendu: montant,
                    credit_montant_restant: montant_disponible - montant,
                    credit_uid: credit_uid,
                    tranche_uid: tranche_uid,
                    numero_client: numero_client,
                    nom_client: client_nom,
                    numero: numero,
                    total_depot_client:
                        is_empty ? montant : total_depot + montant,
                    total_non_paye: is_empty
                        ? payer
                            ? 0
                            : montant
                        : payer
                            ? total_depot_non_paye
                            : total_depot_non_paye + montant),
              ));

          return "200";
        }
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> PayerDepot(
      String tranche_uid,
      String credit_uid,
      String depot_uid,
      String client_uid,
      double depot_benefice,
      int depot_montant,
      int client_total_depot_non_paye,
      String budget_uid,
      int budget_solde_total,
      String budget_tranche_uid,
      int budget_tranche_solde_total,
      double budget_benefice,
      double budget_tranche_benefice) async {
    try {
      if (tranche_uid.isEmpty ||
          credit_uid.isEmpty ||
          depot_uid.isEmpty ||
          client_uid.isEmpty ||
          depot_montant > client_total_depot_non_paye ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty ||
          depot_benefice <= 0) {
        return "100";
      } else {
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({
          "benefice": budget_tranche_benefice + depot_benefice,
          "solde_total": budget_tranche_solde_total + depot_montant
        });

        await FirebaseFirestore.instance
            .collection("budgetb")
            .doc(budget_uid)
            .update({
          "benefice": budget_benefice + depot_benefice,
          "solde_total": budget_solde_total + depot_montant
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("depots")
            .doc(depot_uid)
            .update({"paye": true});
        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("clients")
            .doc(client_uid)
            .update({
          "total_depot_non_paye": client_total_depot_non_paye - depot_montant
        });
        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> PayerCreditClient(
      String tranche_uid,
      String client_uid,
      int client_total_non_paye,
      int client_depot_total_non_paye,
      String budget_uid,
      int budget_solde_total,
      double budget_benefice,
      String budget_tranche_uid,
      int budget_tranche_solde_total,
      double budget_tranche_benefice) async {
    try {
      if (tranche_uid.isEmpty ||
          client_uid.isEmpty ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        double credit_benefice = 0;
        double credit_benefice_cumule = 0;

        if (client_depot_total_non_paye > 0) {
          final depot_request = await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("depots")
              .where("client_uid", isEqualTo: client_uid)
              .get();

          final depots = depot_request.docs;

          depots.forEach((element) async {
            if (!(element.data()["paye"])) {
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(element.data()['credit_uid'])
                  .get()
                  .then((value) {
                credit_benefice = (value.data() as Map)['benefice'];
                credit_benefice_cumule =
                    (value.data() as Map)['benefice_cumule'];
              });

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(element.data()['credit_uid'])
                  .update({
                "benefice_cumule":
                    credit_benefice_cumule + element.data()['benefice'],
                "benefice": credit_benefice + element.data()['benefice']
              });
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("depots")
                  .doc(element.id)
                  .update({"paye": true});
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "benefice":
                    budget_tranche_benefice + (element.data())['benefice']
              });
              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "benefice": budget_benefice + element.data()['benefice']
              });
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("depots")
                  .doc(element.id)
                  .update({"paye": true});
            }
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .doc(client_uid)
              .update({"total_depot_non_paye": 0});
        }

        if (client_total_non_paye > 0) {
          final vente_request = await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("vente_a_credits")
              .where("client_uid", isEqualTo: client_uid)
              .get();

          final ventes = vente_request.docs;

          ventes.forEach((element) async {
            if (!(element.data()["paye"])) {
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(element.data()['credit_uid'])
                  .get()
                  .then((value) {
                credit_benefice = (value.data() as Map)['benefice'];
                credit_benefice_cumule =
                    (value.data() as Map)['benefice_cumule'];
              });

              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("credits")
                  .doc(element.data()['credit_uid'])
                  .update({
                "benefice_cumule":
                    credit_benefice_cumule + element.data()['benefice'],
                "benefice": credit_benefice + element.data()['benefice']
              });
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("vente_a_credits")
                  .doc(element.id)
                  .update({"paye": true});
              await FirebaseFirestore.instance
                  .collection("tranches")
                  .doc(tranche_uid)
                  .collection("budget")
                  .doc(budget_tranche_uid)
                  .update({
                "solde_total":
                    budget_tranche_solde_total + element.data()['montant'],
                "benefice":
                    budget_tranche_benefice + (element.data())['benefice']
              });
              await FirebaseFirestore.instance
                  .collection("budget")
                  .doc(budget_uid)
                  .update({
                "solde_total": budget_solde_total + element.data()['montant'],
                "benefice": budget_benefice + element.data()['benefice']
              });
            }
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .doc(client_uid)
              .update({"total_non_paye": 0});
        }

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> FaireRetrait(
      BuildContext context,
      String tranche_uid,
      String user_uid,
      String budget_uid,
      double budget_benefice,
      String budget_tranche_uid,
      double budget_tranche_benefice,
      int montant,
      String Credit_nom,
      String client_nom,
      String numero_client,
      String numero,
      int benefice) async {
    try {
      if (tranche_uid.isEmpty ||
          Credit_nom.isEmpty ||
          montant <= 0 ||
          client_nom.isEmpty ||
          numero.isEmpty ||
          numero_client.isEmpty ||
          benefice <= 0 ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        // données invalides
        return "100";
      } else {
        int total_retrait = 0;
        String client_uid = "";
        final request = await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("clients")
            .where("numero", isEqualTo: numero_client)
            .get();

        final bool is_empty = request.docs.isEmpty;

        if (is_empty) {
          // si c'est le premier achat du client
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .add({
            "total_depot": 0,
            "total_depot_non_paye": 0,
            "total_retrait": montant,
            "nom": client_nom,
            "numero": numero_client,
            "dernier_achat": DateTime.now(),
            "total_achat": 0,
            "total_non_paye": 0
          });

          await FirebaseFirestore.instance // rechercher le client
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .where("numero", isEqualTo: numero_client)
              .get()
              .then((value) {
            final mon_client = value.docs.first;
            client_uid = mon_client.id;
          });
        } else {
          await FirebaseFirestore.instance // mise à jour du client
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .where("numero", isEqualTo: numero_client)
              .get()
              .then((value) {
            final client = value.docs.first;
            client_uid = client.id;
            total_retrait = client.data()['total_retrait'];
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .doc(client_uid)
              .update({
            "derniere_achat": DateTime.now(),
            "total_retrait": total_retrait + montant,
          });
        }

        await FirebaseFirestore.instance
            .collection("budget")
            .doc(budget_uid)
            .update({"benefice": budget_benefice + benefice});

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("budget")
            .doc(budget_tranche_uid)
            .update({"benefice": budget_tranche_benefice + benefice});

        String credit_uid = "";
        int montant_disponible = 0;
        int montant_initial = 0;
        int montant_initial_cumule = 0;

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .where("nom", isEqualTo: Credit_nom)
            .get()
            .then((value) {
          final credit = value.docs.first;
          credit_uid = credit.id;
          montant_disponible = credit.data()['montant_disponible'];
          montant_initial = credit.data()['montant_initial'];
          montant_initial_cumule = credit.data()['montant_initial_cumule'];
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("credits")
            .doc(credit_uid)
            .update({
          "montant_disponible": montant_disponible + montant,
          "montant_initial": montant_initial + montant,
          "montant_initial_cumule": montant_initial_cumule + montant
        });

        await FirebaseFirestore.instance
            .collection("tranches")
            .doc(tranche_uid)
            .collection("retraits")
            .add({
          "user_uid": user_uid,
          "credit_uid": credit_uid,
          "client_uid": client_uid,
          "montant": montant,
          "benefice": benefice,
          "created_at": DateTime.now(),
          "client_nom": client_nom,
          "credit_nom": Credit_nom,
          "numero_retrait": numero
        });

        Navigator.of(context).pop();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FactureRetrait(
                  credit_nom: Credit_nom,
                  credit_montant_retire: montant,
                  credit_montant_restant: montant_disponible + montant,
                  credit_uid: credit_uid,
                  tranche_uid: tranche_uid,
                  numero_client: numero_client,
                  nom_client: client_nom,
                  numero_retrait: numero,
                  total_retrait: is_empty ? montant : total_retrait + montant,
                  benefice: benefice),
            ));

        return "200";
      }
    } catch (e) {
      return "202";
    }
  }

  Future<String> updateRetrait(
      String retrait_uid,
      String tranche_uid,
      String client_uid,
      int client_total_retrait,
      String credit_uid,
      int credit_montant_disponible,
      int credit_montant_initial,
      int credit_montant_initial_cumule,
      double credit_benefice,
      double credit_benefice_cumule,
      int retrait_montant,
      int retrait_benefice,
      int montant,
      int benefice,
      String budget_uid,
      String budget_tranche_uid,
      double budget_benefice,
      double budget_tranche_benefice) async {
    try {
      if (tranche_uid.isEmpty ||
          client_uid.isEmpty ||
          credit_uid.isEmpty ||
          retrait_montant <= 0 ||
          retrait_benefice <= 0 ||
          montant <= 0 ||
          benefice <= 0 ||
          budget_uid.isEmpty ||
          budget_tranche_uid.isEmpty) {
        return "100";
      } else {
        int difference_montant = retrait_montant - montant;
        int difference_benefice = retrait_benefice - benefice;

        if (difference_montant < 0 && montant < (-1 * difference_montant)) {
          return "201";
        } else {
          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("credits")
              .doc(credit_uid)
              .update({
            "montant_disponible":
                credit_montant_disponible - difference_montant,
            "montant_initial": credit_montant_initial - difference_montant,
            "montant_initial_cumule":
                credit_montant_initial_cumule - difference_montant,
            "benefice": credit_benefice - difference_benefice,
            "benefice_cumule": credit_benefice - difference_benefice
          });

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("clients")
              .doc(client_uid)
              .update(
                  {"total_retrait": client_total_retrait - difference_montant});

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("budget")
              .doc(budget_tranche_uid)
              .update(
                  {"benefice": budget_tranche_benefice - difference_benefice});

          await FirebaseFirestore.instance
              .collection("budget")
              .doc(budget_uid)
              .update({"benefice": budget_benefice - difference_benefice});

          await FirebaseFirestore.instance
              .collection("tranches")
              .doc(tranche_uid)
              .collection("retraits")
              .doc(retrait_uid)
              .update({"montant": montant, "benefice": benefice});

          return "200";
        }
      }
    } catch (e) {
      return "202";
    }
  }
}
