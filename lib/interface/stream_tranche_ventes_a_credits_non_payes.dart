// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/list_vente_a_credits_non_paye.dart';
import 'package:senadedieu/models/vente_a_credit.dart';

class StreamTrancheVenteACreditsNonPayes extends StatelessWidget {
  const StreamTrancheVenteACreditsNonPayes(
      {super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ServiceDB()),
        StreamProvider(
            create: (context) =>
                context.read<ServiceDB>().ventes_a_credits(tranche_uid),
            initialData: <VenteACredits>[])
      ],
      child: ListVenteACreditsNonPaye(tranche_uid: tranche_uid),
    );
  }
}
