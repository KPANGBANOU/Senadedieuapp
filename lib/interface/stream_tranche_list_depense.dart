// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/list_depense.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/depense.dart';

class StreamTrancheListDepense extends StatelessWidget {
  const StreamTrancheListDepense({super.key, required this.tranche_uid});
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
            create: (context) =>
                context.read<ServiceDB>().depenses(tranche_uid),
            initialData: <Depenses>[])
      ],
      child: ListeDepenses(tranche_uid: tranche_uid),
    );
  }
}
