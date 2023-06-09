// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/models/vente_a_credit.dart';
import '../models/budget.dart';
import '../provider/provider_vente_credit.dart';

class VenteACreditEffectuePaye extends StatelessWidget {
  const VenteACreditEffectuePaye({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final vente = Provider.of<VenteACredits>(context);
    final budget_tranche = Provider.of<BudgetTranche>(context);
    final user = Provider.of<donnesUtilisateur>(context);
    final client = Provider.of<Clients>(context);
    final credit = Provider.of<Credits>(context);
    return Scaffold(
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          Image.asset(
            "images/logo.png",
            scale: 4.5,
            height: 100,
            width: 100,
          ),
        ],
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Vente à crédit payé",
          style: GoogleFonts.alike(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                color: Colors.lightBlue.shade900,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 12, top: 25),
                      child: Text(
                        "ENTREPRISE Sèna De Dieu".toUpperCase(),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/img.jpg",
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Vente à crédit éffectuée",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade900),
                          onPressed: () {},
                          child: Expanded(
                              child: Text(
                            "Informations sur la vente".toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alike(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Réseau GSM :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              credit.nom,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Montant vendu :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              vente.montant.toString() + " XOF",
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bénéfice à réaliser sur la vente :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              vente.benefice.toString() + " XOF",
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Montant disponible du réseau :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              credit.montant_disponible.toString() + " XOF",
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Achété par :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.nom,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Numéro ayant réçu le crédit :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              vente.numero,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Numéro du client :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.numero,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dernière transaction du client :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.dernier_achat,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total d'achat de ce client :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.total_achat.toString() + " XOF",
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Achat non payé :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.total_non_paye.toString() + " XOF",
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date de vente :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              vente.created_at,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    vente.paye
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date de paiement :",
                                  style: GoogleFonts.alike(
                                      color: Colors.lightBlue.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Expanded(
                                  child: Text(
                                    vente.updated_at,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: GoogleFonts.alike(
                                        color: Colors.lightBlue.shade800,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Vente enregistrée par :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              user.prenom + " " + user.nom,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Son E-Mail :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              user.email,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Son contact",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              user.telephone,
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    vente.paye
                        ? Container()
                        : SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.82,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade900),
                                onPressed: () {
                                  PayerCredit(
                                      context,
                                      vente.achat,
                                      credit.uid,
                                      credit.nom,
                                      credit.benefice,
                                      credit.benefice_cumule,
                                      vente.uid,
                                      vente.montant,
                                      vente.benefice,
                                      client.uid,
                                      client.nom,
                                      client.total_non_paye,
                                      tranche_uid,
                                      budget_tranche.uid,
                                      budget_tranche.solde_total,
                                      budget_tranche.benefice);
                                },
                                child: Text(
                                  "Paiement de crédit".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.alike(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          )),
    );
  }

  Future<void> PayerCredit(
    BuildContext context,
    String achat,
    String credit_uid,
    String credit_nom,
    double credit_benefice,
    double credit_benefice_cumule,
    String vente_uid,
    int montant,
    double benefice,
    String client_uid,
    String client_nom,
    int client_total_non_paye,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_solde_total,
    double budget_tranche_benefice,
  ) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProviderVenteCredit>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final user = Provider.of<donnesUtilisateur>(dialogcontext);
        final budget = Provider.of<Budget>(dialogcontext);
        bool affiche = provider.affiche;

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Paiement du vente à crédit",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.lightBlue.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(dialogcontext).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Voulez-vous confirmer que le client " +
                        client_nom +
                        " veut il payer son crédit de " +
                        achat +
                        " ?",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade900),
                    onPressed: () async {
                      provider.affiche_true();

                      final String statut_code =
                          await function.PayerVenteACredit(
                              tranche_uid,
                              credit_uid,
                              credit_benefice,
                              credit_benefice_cumule,
                              vente_uid,
                              montant,
                              budget_tranche_uid,
                              budget.uid,
                              budget.solde_total,
                              budget_tranche_solde_total,
                              budget.benefice,
                              budget_tranche_benefice,
                              benefice,
                              client_uid,
                              client_total_non_paye);

                      if (statut_code == "202") {
                        _speak(
                            "Vérifiez si vous avez activé les données mobiles");
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
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      } else if (statut_code == "100") {
                        _speak("Champs invalides");
                        provider.affiche_false();
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Champs invalides",
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
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      } else {
                        _speak("Effectué avec succès");
                        provider.affiche_false();
                        provider.change_montant("");
                        provider.change_numero("");
                        provider.change_numero_client("");
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
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        Navigator.of(dialogcontext).pop();
                      }
                    },
                    child: affiche
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Paiement du crédit".toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
              ),
            )
          ],
          // ignore: prefer_const_literals_to_create_immutables
        );
      },
    );
  }

  Future _speak(String text) async {
    final FlutterTts _flutter_tts = FlutterTts();
    _flutter_tts.setLanguage("Fr");
    _flutter_tts.setSpeechRate(0.5);
    _flutter_tts.setVolume(0.5);
    _flutter_tts.setPitch(1.0);
    _flutter_tts.speak(text);
  }
}
