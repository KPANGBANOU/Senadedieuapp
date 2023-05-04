// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/vente_effecue.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/models/vente_credit.dart';

class StreamVenteEffectue extends StatelessWidget {
  const StreamVenteEffectue(
      {super.key,
      required this.tranche_uid,
      required this.vente_uid,
      required this.client_uid,
      required this.credit_uid,
      required this.user_uid});
  final String tranche_uid;
  final String vente_uid;
  final String client_uid;
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
            create: (context) =>
                context.read<ServiceDB>().vente_credit(tranche_uid, vente_uid),
            initialData: VenteCredits(
                uid: "",
                user_uid: user_uid,
                credit_uid: credit_uid,
                credit_nom: "",
                client_uid: client_uid,
                montant: 0,
                benefice: 0,
                created_at: "",
                created_at_heure: "",
                created_at_mois: "",
                created_at_annee: "",
                during: 0,
                numero: "",
                client_nom: "")),
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
            create: (context) =>
                context.read<ServiceDB>().client(tranche_uid, client_uid),
            initialData: Clients(
                uid: "",
                numero: "",
                nom: "",
                total_achat: 0,
                total_non_paye: 0,
                dernier_achat: "",
                total_depot: 0,
                total_depot_non_paye: 0,
                total_retrait: 0)),
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
      child: VenteEffectue(tranche_uid: tranche_uid),
    );
  }
}
