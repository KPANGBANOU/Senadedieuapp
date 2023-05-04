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
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/models/vente_credit.dart';
import '../models/budget.dart';
import '../provider/provider_vente_credit.dart';

class VenteEffectue extends StatelessWidget {
  const VenteEffectue({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final vente = Provider.of<VenteCredits>(context);
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
                UpdateVenteCredit(
                    context,
                    credit.uid,
                    credit.nom,
                    credit.montant_disponible,
                    credit.benefice,
                    credit.benefice_cumule,
                    credit.benefice_sur_5000,
                    vente.uid,
                    vente.montant,
                    vente.benefice,
                    client.uid,
                    client.nom,
                    client.numero,
                    client.total_achat,
                    client.total_non_paye,
                    vente.numero,
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
          "Vente éffectuée",
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
                "Vente éffectuée",
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
                            "Bénéfice réalisé sur la vente :",
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
                            "Dernier transaction du client :",
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
                              vente.created_at + " à " + vente.created_at_heure,
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

  Future<void> UpdateVenteCredit(
    BuildContext context,
    String credit_uid,
    String credit_nom,
    int credit_montant_disponible,
    double credit_benefice,
    double credit_benefice_cumule,
    int credit_benefice_sur_5000,
    String vente_uid,
    int vente_montant,
    double vente_benefice,
    String client_uid,
    String client_nom,
    String client_numero,
    int client_total_paye,
    int client_total_non_paye,
    String vente_numero,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_perte,
    int budget_tranche_solde_total,
    double budget_tranche_benefice,
  ) async {
    TextEditingController montantCredit = TextEditingController();
    TextEditingController descriptionPerte = TextEditingController();
    TextEditingController nomClient = TextEditingController();
    montantCredit.text = vente_montant.toString();
    nomClient.text = client_nom;
    TextEditingController numeroClient = TextEditingController();
    TextEditingController numeroVente = TextEditingController();
    numeroClient.text = client_numero;
    numeroVente.text = vente_numero;
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final provider = Provider.of<ProviderVenteCredit>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        final user = Provider.of<donnesUtilisateur>(dialogcontext);
        final budget = Provider.of<Budget>(dialogcontext);
        String nom_client = provider.nom_client;
        String numero_client = provider.numero_client;
        String numero = provider.numero;
        int montant = provider.montant;
        int _montant = 0;
        bool affiche = provider.affiche;
        bool perte = provider.perte;
        bool payer = provider.payer;
        String description = provider.description;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Mise à jour de la vente",
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
                    "Veuillez chaisir le montant de vente",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    provider.change_montant(value);
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
                    "Veuillez saisir le numéro sur lequel le crédit serait envoyé. Répétez le numéro saisi ci haut s'il s'agit du numéro sur lequel le crédit serait envoyé",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: numeroVente,
                  onChanged: (value) {
                    provider.change_numero(value);
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
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Etes-vous trompé de numéro pendant la vente ? Dans ce cas, cette vente serait évidemment considérée comme une perte",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile(
                  value: true,
                  groupValue: perte,
                  onChanged: (value) {
                    provider.change_perte(value);
                  },
                  title: Text(
                    "oui".toUpperCase(),
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile(
                  value: false,
                  groupValue: perte,
                  onChanged: (value) {
                    provider.change_perte(value);
                  },
                  title: Text(
                    "nom".toUpperCase(),
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                perte
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Décrivez la perte réalisé",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              provider.change_description(value);
                            },
                            controller: descriptionPerte,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: description.isEmpty
                                            ? Colors.red
                                            : Colors.blue))),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            "S'agit il d'une vente à crédit ?",
                            style:
                                GoogleFonts.alike(fontWeight: FontWeight.bold),
                          ),
                          RadioListTile(
                            title: Text(
                              "oui".toUpperCase(),
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold),
                            ),
                            value: true,
                            groupValue: payer,
                            onChanged: (value) {
                              provider.change_payer(value);
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              "Non".toUpperCase(),
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold),
                            ),
                            value: false,
                            groupValue: payer,
                            onChanged: (value) {
                              provider.change_payer(value);
                            },
                          )
                        ],
                      )
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
                      final String statut_code =
                          await function.UpdateVenteCredit(
                              context,
                              tranche_uid,
                              vente_uid,
                              client_numero,
                              numero,
                              nomClient.text,
                              numeroClient.text,
                              numeroVente.text,
                              user.uid,
                              credit_uid,
                              credit_nom,
                              credit_montant_disponible,
                              credit_benefice,
                              credit_benefice_cumule,
                              client_uid,
                              credit_benefice_sur_5000,
                              budget.uid,
                              budget.perte,
                              budget_tranche_uid,
                              budget.solde_total,
                              budget_tranche_solde_total,
                              budget.benefice,
                              budget_tranche_benefice,
                              budget_tranche_perte,
                              vente_benefice,
                              vente_montant,
                              client_total_paye,
                              client_total_non_paye,
                              montant,
                              perte,
                              payer,
                              description);

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
                      } else if (statut_code == "101") {
                        _speak("Stock insuffisant");
                        provider.affiche_false();
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Stock insuffisant",
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
                        : perte
                            ? Text(
                                "Enregistrez la perte".toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : !payer
                                ? Text(
                                    "Enregistrez le crédit".toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alike(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                : Text(
                                    "Enregistrez la vente".toUpperCase(),
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
