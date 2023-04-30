// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/registration.dart';
import 'package:senadedieu/base_de_donnees/service_base_de_donnees.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/tranches.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_ajouter_credit.dart';
import 'package:senadedieu/provider/provider_ajouter_depense.dart';
import 'package:senadedieu/provider/provider_ajouter_perte.dart';
import 'package:senadedieu/provider/provider_ajouter_tranche.dart';
import 'package:senadedieu/provider/provider_approvisionner_credit.dart';
import 'package:senadedieu/provider/provider_change_index.dart';
import 'package:senadedieu/provider/provider_connnexion.dart';
import 'package:senadedieu/provider/provider_created_account.dart';
import 'package:senadedieu/provider/provider_drawer_admin.dart';
import 'package:senadedieu/provider/provider_gestion_depot.dart';
import 'package:senadedieu/provider/provider_gestion_retrait.dart';
import 'package:senadedieu/provider/provider_new_password.dart';
import 'package:senadedieu/provider/provider_profil.dart';
import 'package:senadedieu/provider/provider_recharger_credit.dart';
import 'package:senadedieu/provider/provider_reset_password.dart';
import 'package:senadedieu/provider/provider_search.dart';
import 'package:senadedieu/provider/provider_vente_credit.dart';

import 'interface/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        Provider<Functions>(create: (_) => Functions()),
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
        ChangeNotifierProvider(
          create: (context) => ProviderGestionDepot(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderGestionRetrait(),
        ),
        ChangeNotifierProvider(
          create: (context) => providerCreateAccount(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderConnexion(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderResetPassword(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderChangeIndex(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderProfil(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderNewPassword(),
        ),
        ChangeNotifierProvider(
          create: (context) => Search(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderDrawerAdmin(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderApprovisionnerCredit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
