// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/stream_vente_effectue.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/vente_credit.dart';
import 'package:senadedieu/provider/provider_paiement.dart';
import '../provider/provider_search.dart';
import 'drawer_admin.dart';

class ListVente extends StatelessWidget {
  const ListVente({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final ventes = Provider.of<List<VenteCredits>>(context);
    final budget_tranche = Provider.of<BudgetTranche>(context);
    final provider = Provider.of<Search>(context);
    String value = provider.value;
    bool affiche = provider.afficher;

    if (ventes.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.lightBlue.shade900,
        drawer: DrawerAdmin(tranche_uid: tranche_uid),
        appBar: AppBar(
          actions: [
            Image.asset(
              "images/logo.png",
              height: 60,
              width: 60,
              scale: 2.5,
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Ventes",
            style: GoogleFonts.alike(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                provider.afficher_void();
              },
              icon: Icon(Icons.search, color: Colors.black)),
        ],
        elevation: 0,
        centerTitle: false,
        title: affiche
            ? Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (value) {
                    provider.change_value(value);
                  },
                ),
              )
            : Text(
                "Ventes",
                style: GoogleFonts.alike(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: Colors.lightBlue.shade900,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 12, top: 25),
                  child: Text(
                    "ENTREPRISE sèna De Dieu".toUpperCase(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 20),
                  child: Container(
                    color: Colors.white,
                    width: 50,
                    height: 2,
                    alignment: Alignment.centerLeft,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  VenteCredits vente = ventes[index];

                  return !affiche
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StreamVenteEffectue(
                                      tranche_uid: tranche_uid,
                                      vente_uid: vente.uid,
                                      client_uid: vente.client_uid,
                                      credit_uid: vente.credit_uid,
                                      user_uid: vente.user_uid),
                                ));
                          },
                          title: Text(
                            vente.montant.toString() +
                                " XOF de " +
                                vente.credit_nom,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.sell,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                vente.created_at +
                                    " à " +
                                    vente.created_at_heure,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.lightBlue.shade900,
                            child: Text(
                              vente.credit_nom.substring(0, 2).toUpperCase(),
                              style: GoogleFonts.alike(color: Colors.white),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                DeleteVente(
                                    context,
                                    tranche_uid,
                                    budget_tranche.uid,
                                    budget_tranche.solde_total,
                                    budget_tranche.benefice,
                                    vente.uid,
                                    vente.credit_uid,
                                    vente.client_uid,
                                    vente.montant,
                                    vente.benefice,
                                    vente.credit_nom);
                              },
                              icon: Icon(Icons.delete)),
                        )
                      : vente.credit_nom
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              vente.client_nom
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              vente.numero.contains(value)
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StreamVenteEffectue(
                                          tranche_uid: tranche_uid,
                                          vente_uid: vente.uid,
                                          client_uid: vente.client_uid,
                                          credit_uid: vente.credit_uid,
                                          user_uid: vente.user_uid),
                                    ));
                              },
                              title: Text(
                                vente.montant.toString() +
                                    " XOF de " +
                                    vente.credit_nom,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.sell,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    vente.created_at +
                                        " à " +
                                        vente.created_at_heure,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alike(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade900,
                                child: Text(
                                  vente.credit_nom
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  style: GoogleFonts.alike(color: Colors.white),
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    DeleteVente(
                                        context,
                                        tranche_uid,
                                        budget_tranche.uid,
                                        budget_tranche.solde_total,
                                        budget_tranche.benefice,
                                        vente.uid,
                                        vente.credit_uid,
                                        vente.client_uid,
                                        vente.montant,
                                        vente.benefice,
                                        vente.credit_nom);
                                  },
                                  icon: Icon(Icons.delete)),
                            )
                          : Container();
                },
                itemCount: ventes.length,
              ))
        ],
      )),
    );
  }

  Future DeleteVente(
      BuildContext context,
      String tranche_uid,
      String budget_tranche_uid,
      int budget_tranche_solde_total,
      double budget_tranche_benefice,
      String vente_uid,
      String credit_uid,
      String client_uid,
      int vente_montant,
      double vente_benefice,
      String credit_nom) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogcontexte) {
        final provider = Provider.of<ProviderPaiement>(dialogcontexte);
        final function = Provider.of<Functions>(dialogcontexte);
        final budget = Provider.of<Budget>(dialogcontexte);
        bool affiche = provider.affiche;
        return AlertDialog(
          title: Text(
            "Suppression de vente".toUpperCase(),
            textAlign: TextAlign.justify,
            style: GoogleFonts.alike(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Voulez-vous supprimer la vente de " +
                vente_montant.toString() +
                " XOF du réseau GSM " +
                credit_nom +
                " ?",
            textAlign: TextAlign.justify,
            style: GoogleFonts.alike(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade900),
                      onPressed: () async {
                        provider.affiche_true();
                        final String statut_code =
                            await function.DeleteVenteCredit(
                                tranche_uid,
                                vente_uid,
                                credit_uid,
                                client_uid,
                                budget.uid,
                                budget_tranche_uid,
                                budget.solde_total,
                                budget_tranche_solde_total,
                                budget.benefice,
                                budget_tranche_benefice,
                                vente_montant,
                                vente_benefice);
                        if (statut_code == "202") {
                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Une erreur s'est produite",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.redAccent.withOpacity(.7),
                            elevation: 1,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(dialogcontexte)
                              .showSnackBar(snakbar);
                        } else if (statut_code == "100") {
                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Données invalides",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.redAccent.withOpacity(.7),
                            elevation: 1,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(dialogcontexte)
                              .showSnackBar(snakbar);
                        } else {
                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Effectué avec succès",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            backgroundColor: Colors.black87,
                            elevation: 1,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(dialogcontexte)
                              .showSnackBar(snakbar);
                          Navigator.of(dialogcontexte).pop();
                        }
                      },
                      child: affiche
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Confirmer".toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      onPressed: () {
                        Navigator.of(dialogcontexte).pop();
                      },
                      child: Text(
                        "Annuler".toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.alike(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
