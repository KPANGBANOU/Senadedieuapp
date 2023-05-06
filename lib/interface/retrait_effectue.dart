// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/client.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/retrait.dart';
import 'package:senadedieu/models/user.dart';
import '../models/budget.dart';
import '../provider/provider_gestion_retrait.dart';

class RetraitEffectue extends StatelessWidget {
  const RetraitEffectue({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final retrait = Provider.of<Retraits>(context);
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
          IconButton(
              onPressed: () {
                MofiezRetrait(
                    context,
                    credit.nom,
                    retrait.uid,
                    retrait.montant,
                    retrait.benefice,
                    retrait.numero_retrait,
                    client.numero,
                    client.uid,
                    client.total_retrait,
                    client.nom,
                    credit.uid,
                    credit.montant_disponible,
                    credit.montant_initial,
                    credit.montant_initial_cumule,
                    credit.benefice,
                    credit.benefice_cumule,
                    tranche_uid,
                    budget_tranche.uid,
                    budget_tranche.perte,
                    budget_tranche.solde_total,
                    budget_tranche.benefice);
              },
              icon: Icon(Icons.edit)),
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
          "Rétrait éffectué",
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
                          "images/article2.jpg",
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Rétrait éffectué",
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
                            "Informations sur le retrait".toUpperCase(),
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
                            "Montant du retrait :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              retrait.montant.toString() + " XOF",
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
                            "Bénéfice réalisé sur le retrait :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              retrait.benefice.toString() + " XOF",
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
                            "Numéro de retrait :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              retrait.numero_retrait,
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
                            "Total de retrait de ce client :",
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
                            "Date de retrait :",
                            style: GoogleFonts.alike(
                                color: Colors.lightBlue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Text(
                              retrait.created_at +
                                  " à " +
                                  retrait.created_at_heure,
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
                            "Retrait enregistré par :",
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

  Future<void> MofiezRetrait(
    BuildContext context,
    String credit_nom,
    String retrait_uid,
    int retrait_montant,
    int retrait_benefice,
    String retrait_numero,
    String client_numero,
    String client_uid,
    int client_total_retrait,
    String client_nom,
    String credit_uid,
    int credit_montant_disponible,
    int credit_montant_initial,
    int credit_montant_initial_cumule,
    double credit_benefice,
    double credit_benefice_cumule,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_perte,
    int budget_tranche_solde_total,
    double budget_tranche_benefice,
  ) async {
    TextEditingController montantCredit = TextEditingController();
    TextEditingController nomClient = TextEditingController();
    TextEditingController beneficeRetrait = TextEditingController();
    TextEditingController numeroClient = TextEditingController();
    TextEditingController numeroRetrait = TextEditingController();
    montantCredit.text = retrait_montant.toString();
    nomClient.text = client_nom;
    beneficeRetrait.text = retrait_benefice.toString();
    numeroClient.text = client_numero;
    numeroRetrait.text = retrait_numero;
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProviderGestionRetrait>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final user = Provider.of<donnesUtilisateur>(dialogcontext);
        final budget = Provider.of<Budget>(dialogcontext);
        String nom_client = provider.nom_client;
        String numero_client = provider.numero_client;
        String numero = provider.numero_retrait;
        int montant = provider.montant;
        int _montant = 0;
        int _benefice = 0;
        bool affiche = provider.affiche;
        int benefice = provider.benefice;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Mise à jour de retrait éffectué",
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
                    "Veuillez chaisir le montant de retrait",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    provider.change_mntant(value);
                  },
                  controller: montantCredit,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: montant <= 0 ? Colors.red : Colors.blue))),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Quelle bénéfice réalisez-vous sur ce montant de retrait ?",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: beneficeRetrait,
                  onChanged: (value) {
                    provider.change_benefice(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  benefice <= 0 ? Colors.red : Colors.blue))),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Nom du client",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    provider.change_nom_client(value, nomClient);
                  },
                  controller: nomClient,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: nom_client.isEmpty
                                  ? Colors.red
                                  : Colors.blue))),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Numéro du client",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: numeroClient,
                  onChanged: (value) {
                    provider.change_numero_client(value);
                  },
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: numero_client.length != 8
                                  ? Colors.red
                                  : Colors.blue))),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Veuillez saisir le numéro de retrait. Répétez le numéro saisi ci haut s'il s'agit du numéro sur lequel le crédit serait envoyé",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: numeroRetrait,
                  onChanged: (value) {
                    provider.change_numero_retrait(value);
                  },
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: numero.length != 8
                                  ? Colors.red
                                  : Colors.blue))),
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
                      _montant = montantCredit.text.isEmpty
                          ? 0
                          : int.parse(montantCredit.text);
                      _benefice = beneficeRetrait.text.isEmpty
                          ? 0
                          : int.parse(beneficeRetrait.text);
                      final String statut_code = await function.updateRetrait(
                          retrait_uid,
                          tranche_uid,
                          client_uid,
                          client_total_retrait,
                          credit_uid,
                          credit_montant_disponible,
                          credit_montant_initial,
                          credit_montant_initial_cumule,
                          credit_benefice,
                          credit_benefice_cumule,
                          retrait_montant,
                          retrait_benefice,
                          _montant,
                          _benefice,
                          budget.uid,
                          budget_tranche_uid,
                          budget.benefice,
                          budget_tranche_benefice);

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
                        provider.change_mntant("");
                        provider.change_benefice("");
                        provider.change_numero_retrait("");
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
                            "modifiez le retrait".toUpperCase(),
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
