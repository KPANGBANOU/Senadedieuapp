// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/registration.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/tranches.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_ajouter_credit.dart';
import 'package:senadedieu/provider/provider_ajouter_depense.dart';
import 'package:senadedieu/provider/provider_ajouter_perte.dart';
import 'package:senadedieu/provider/provider_ajouter_tranche.dart';
import 'package:senadedieu/provider/provider_recharger_credit.dart';
import 'package:senadedieu/provider/provider_vente_credit.dart';

import 'interface/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ServiceDB>(create: (_) => ServiceDB()),
        Provider<firebaseAuth>(create: (_) => firebaseAuth()),
        StreamProvider(
            create: (context) => context.read<firebaseAuth>().utilisateur,
            initialData: null),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().currentuserdata,
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
                tranche_uid: "",
                date_inscription: "",
                deleted: false)),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().budget,
            initialData: Budget(
                uid: "", solde_total: 0, depense: 0, perte: 0, benefice: 0)),
        StreamProvider(
            create: (context) => context.read<ServiceDB>().list_tranches,
            initialData: <Tranches>[]),
        ChangeNotifierProvider(
          create: (context) => ProviderAjouterTranche(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAjouterCredit(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderRechargerCredit(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAjouterDepense(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderAjouterPerte(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderVenteCredit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
