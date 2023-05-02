// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/client_entreprise.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';

class StreamClient extends StatelessWidget {
  const StreamClient(
      {super.key, required this.tranche_uid, required this.client_uid});
  final String tranche_uid;
  final String client_uid;
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
                total_retrait: 0))
      ],
      child: ClientEntreprise(tranche_uid: tranche_uid),
    );
  }
}
