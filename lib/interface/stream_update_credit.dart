// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/interface/update_credit.dart';
import 'package:senadedieu/models/credits.dart';

class StreamUpdateCredit extends StatelessWidget {
  const StreamUpdateCredit(
      {super.key, required this.credit_uid, required this.tranche_uid});
  final String credit_uid;
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ServiceDB()),
        StreamProvider(
            create: (context) =>
                context.read<ServiceDB>().credit(tranche_uid, credit_uid),
            initialData: Credits(
                uid: "",
                user_uid: "",
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
                approvisionne: true))
      ],
      child: UpdateCredit(tranche_uid: tranche_uid),
    );
  }
}
