// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/depot_marchant_effectue.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/depot_marchant.dart';
import 'package:senadedieu/models/user.dart';

class StreamDepotMarchant extends StatelessWidget {
  const StreamDepotMarchant(
      {super.key,
      required this.tranche_uid,
      required this.depot_uid,
      required this.credit_uid,
      required this.user_uid});
  final String tranche_uid;
  final String depot_uid;
  final String credit_uid;
  final String user_uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ServiceDB()),
        StreamProvider(
            create: (context) =>
                context.read<ServiceDB>().budget_tranche(tranche_uid),
            initialData: BudgetTranche(
                uid: "", solde_total: 0, depense: 0, perte: 0, benefice: 0)),
        StreamProvider(
            create: (context) => context
                .read<ServiceDB>()
                .depot_marchant(tranche_uid, depot_uid),
            initialData: DepotMarchants(
                uid: "",
                created_at: "",
                credit_uid: credit_uid,
                user_uid: user_uid,
                credit_nom: "",
                montant: 0)),
        StreamProvider(
            create: (context) =>
                context.read<ServiceDB>().credit(tranche_uid, credit_uid),
            initialData: Credits(
                uid: "",
                user_uid: user_uid,
                nom: "",
                created_at: "",
                created_at_heure: "",
                montant_initial: 0,
                montant_initial_cumule: 0,
                montant_disponible: 0,
                seuil_approvisionnement: 0,
                benefice: 0,
                benefice_sur_5000: 0,
                benefice_cumule: 0,
                approvisionne: false)),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().user_data(user_uid),
            initialData: donnesUtilisateur(
                login: false,
                nom: "",
                prenom: "",
                email: "",
                telephone: "",
                sexe: "",
                date_naissance: "",
                uid: "",
                photo_url: "",
                admin: false,
                is_active: false,
                mdp: "",
                tranche_uid: tranche_uid,
                date_inscription: "",
                deleted: false))
      ],
      child: DepotMarchantEffectue(tranche_uid: tranche_uid),
    );
  }
}
