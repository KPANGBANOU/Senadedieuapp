// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/tranche_information.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/tranches.dart';

import '../models/user.dart';

class StreamTrancheInformation extends StatelessWidget {
  const StreamTrancheInformation(
      {super.key, required this.tranche_uid, required this.user_uid});
  final String tranche_uid;
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
            create: (context) => context.read<ServiceDB>().tranche(tranche_uid),
            initialData: Tranches(
                uid: "",
                nom: "",
                description: "",
                stop: false,
                user_uid: "",
                created_at: "",
                updated_at: "")),
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
                is_active: true,
                mdp: "",
                tranche_uid: tranche_uid,
                date_inscription: "",
                deleted: false))
      ],
      child: TrancheInformation(),
    );
  }
}
