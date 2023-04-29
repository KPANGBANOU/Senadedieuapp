// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/tranche_admin.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/tranches.dart';

class StreamTrancheAdmin extends StatelessWidget {
  const StreamTrancheAdmin({super.key, required this.tranche_uid});
  final String tranche_uid;
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
                updated_at: ""))
      ],
      child: TrancheAdmin(),
    );
  }
}
