// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';
import 'package:senadedieu/provider/provider_paiement.dart';

class ClientEntreprise extends StatelessWidget {
  ClientEntreprise({
    Key? key,
    required this.tranche_uid,
  }) : super(key: key);
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Clients>(context);
    final budget_tranche = Provider.of<BudgetTranche>(context);
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.send)),
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
          "Client",
          style: GoogleFonts.alike(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
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
                      "Client de Sèna De Dieu".toUpperCase(),
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
                      image: AssetImage("images/article2.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Client de l'entreprise",
              textAlign: TextAlign.center,
              style: GoogleFonts.alike(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.94,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.89,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade900),
                          onPressed: () {},
                          child: Text(
                            "Informations sur le client".toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alike(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Client :",
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
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Numéro :",
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
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dernière transaction :",
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
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Montant total d'achat :",
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
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Montant total d'achat non payé :",
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
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total de retrait éffectué :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.total_retrait.toString() + " XOF",
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Totaux des dépots éffectués :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.total_depot.toString() + " XOF",
                              softWrap: true,
                              textAlign: TextAlign.justify,
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
                          left: 10, right: 10, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total de dépot non payé :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              client.total_depot_non_paye.toString() + " XOF",
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.alike(
                                  color: Colors.lightBlue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    client.total_depot_non_paye + client.total_non_paye > 0
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 49,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.lightBlue.shade900),
                                      onPressed: () {
                                        ConfirmPaiement(
                                            context,
                                            client.nom,
                                            client.total_depot_non_paye,
                                            client.total_non_paye,
                                            client.uid,
                                            budget_tranche.uid,
                                            budget_tranche.solde_total,
                                            budget_tranche.benefice);
                                      },
                                      child: Text(
                                        "Payer les crédits du client"
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.alike(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Future ConfirmPaiement(
      BuildContext context,
      String client_nom,
      int total_depot_non_paye,
      int total_non_paye,
      String client_uid,
      String budget_tranche_uid,
      int budget_tranche_solde_total,
      double budget_tranche_benefice) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProviderPaiement>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final budget = Provider.of<Budget>(dialogcontext);
        bool affiche = provider.affiche;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Paiement de crédit",
                style: GoogleFonts.alike(
                  fontWeight: FontWeight.bold,
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
              )
            ],
          ),
          content: Text(
            "Le client " +
                client_nom +
                " veut il payer la totalité de " +
                (total_depot_non_paye + total_non_paye).toString() +
                " XOF de son crédit ?",
            style: GoogleFonts.alike(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade900),
                  onPressed: () async {
                    provider.affiche_true();
                    final String statut_code = await function.PayerCreditClient(
                        tranche_uid,
                        client_uid,
                        total_non_paye,
                        total_depot_non_paye,
                        budget.uid,
                        budget.solde_total,
                        budget.benefice,
                        budget_tranche_uid,
                        budget_tranche_solde_total,
                        budget_tranche_benefice);

                    if (statut_code == "202") {
                      _speak(
                          "Une erreur est survenue. Vérifiez si les données mobiles sont activées");
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
                      ScaffoldMessenger.of(dialogcontext).showSnackBar(snakbar);
                    } else if (statut_code == "100") {
                      _speak("Données invalides");
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
                      ScaffoldMessenger.of(dialogcontext).showSnackBar(snakbar);
                    } else {
                      _speak("Paiement notifié avec succès");
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
                      ScaffoldMessenger.of(dialogcontext).showSnackBar(snakbar);
                      Navigator.of(dialogcontext).pop();
                    }
                  },
                  child: affiche
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Confirmez le paiement",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.alike(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
            )
          ],
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
