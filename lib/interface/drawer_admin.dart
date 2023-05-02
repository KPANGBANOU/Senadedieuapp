// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/accueil_admin.dart';
import 'package:senadedieu/interface/login.dart';
import 'package:senadedieu/interface/stream_tranche_approvisionner_credit.dart';
import 'package:senadedieu/interface/stream_tranche_faire_depot.dart';
import 'package:senadedieu/interface/stream_tranche_faire_retrait.dart';
import 'package:senadedieu/interface/stream_tranche_liquidite_credits.dart';
import 'package:senadedieu/interface/stream_tranche_list_client.dart';
import 'package:senadedieu/interface/stream_tranche_list_credit.dart';
import 'package:senadedieu/interface/stream_tranche_vente_credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_drawer_admin.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderDrawerAdmin>(context);
    final user = Provider.of<donnesUtilisateur>(context);
    if (!user.admin || !user.login) {
      return Login();
    }
    bool home = provider.home;
    bool vente_credits = provider.vente_credits;
    bool depot = provider.depot;
    bool recharger_stock = provider.recharger_stock;
    bool list_clients = provider.list_clients;
    bool liquidite = provider.liquidite_credit;
    bool list_credits = provider.list_credits;
    bool list_depenses = provider.list_depenses;
    bool list_pertes = provider.list_pertes;
    bool retrait = provider.retrait;
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(
                  child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  user.photo_url.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.asset(
                              'images/logo.png',
                              width: 120,
                              height: 120,
                              scale: 2.5,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(user.photo_url),
                                  fit: BoxFit.cover,
                                  scale: 2.5)),
                        ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        user.prenom + " " + user.nom,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alike(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              )),
            ),
            ListTile(
              textColor: home ? Colors.white : Colors.black,
              tileColor: home ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Home",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_home();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccueilAdmin(),
                    ));
              },
            ),
            ListTile(
              textColor: liquidite ? Colors.white : Colors.black,
              tileColor: liquidite ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Liquidité de crédits",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_liquidite_credit();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StreamTrancheLiquiditeCredits(
                          tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: vente_credits ? Colors.white : Colors.black,
              tileColor: vente_credits ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Vente de crédits",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_vente_credits();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheVentesCredits(tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: depot ? Colors.white : Colors.black,
              tileColor: depot ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Faire de dépot",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_depot();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheFaireDepot(tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: recharger_stock ? Colors.white : Colors.black,
              tileColor: recharger_stock ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Faire de dépot marchants",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_recharger_stock();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheApprovisionnementCredits(
                              tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: retrait ? Colors.white : Colors.black,
              tileColor: retrait ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Faire de retrait",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_retrait();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheFaireRetrait(tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: list_credits ? Colors.white : Colors.black,
              tileColor: list_credits ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Liste des crédits",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_list_credits();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheListCredits(tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: list_clients ? Colors.white : Colors.black,
              tileColor: list_clients ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Clients de l'entreprise",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_list_clients();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StreamTrancheListClient(tranche_uid: tranche_uid),
                    ));
              },
            ),
            ListTile(
              textColor: list_depenses ? Colors.white : Colors.black,
              tileColor: list_depenses ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Dépenses éffectuées",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_list_depense();
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccueilAdmin(),
                    ));*/
              },
            ),
            ListTile(
              textColor: list_pertes ? Colors.white : Colors.black,
              tileColor: list_pertes ? Colors.lightBlue.shade800 : null,
              title: Text(
                "Pertes réalisées",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                provider.put_list_perte();
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccueilAdmin(),
                    ));*/
              },
            ),
            ListTile(
              title: Text("Déconnexion",
                  style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  )),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
