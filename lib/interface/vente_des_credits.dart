// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_final_fields, unused_field, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/interface/list_credits.dart';
import 'package:senadedieu/models/budget.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_vente_credit.dart';

class VentesCredits extends StatelessWidget {
  VentesCredits({key, required this.tranche_uid});
  final String tranche_uid;

  @override
  Widget build(BuildContext context) {
    final credits = Provider.of<List<Credits>>(context);
    final user = Provider.of<donnesUtilisateur>(context);
    final budget = Provider.of<Budget>(context);
    final budget_tranche = Provider.of<BudgetTranche>(context);
    if (credits.isEmpty) {
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
            "Crédits",
            style: GoogleFonts.alike(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown.shade900,
          onPressed: () {
            AddCredit(context, tranche_uid, user.uid);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    }

    String grand_modele = "";
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Image.asset(
            "images/logo.png",
            height: 60,
            width: 60,
            scale: 2.5,
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Crédits",
          style: GoogleFonts.alike(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                        "Entreprise Sèna De Dieu".toUpperCase(),
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
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/communication2.jpg"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Vente de crédits",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, bottom: 15, right: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Veuillez sélectionner le crédit s'il vous plait",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: DropdownSearch<String>(
                    popupProps: PopupProps.dialog(
                      showSelectedItems: false,
                      showSearchBox: true,
                    ),
                    selectedItem: grand_modele,
                    items: credits.map((Credits value) => value.nom).toList(),
                    onChanged: (value) {
                      VenteCredit(
                          context,
                          value!,
                          tranche_uid,
                          budget_tranche.uid,
                          budget_tranche.perte,
                          budget_tranche.solde_total,
                          budget_tranche.benefice);
                    }),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade900,
        onPressed: () {
          AddCredit(context, tranche_uid, user.uid);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> VenteCredit(
    BuildContext context,
    String value,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_perte,
    int budget_tranche_solde_total,
    double budget_tranche_benefice,
  ) async {
    TextEditingController montantCredit = TextEditingController();
    TextEditingController descriptionPerte = TextEditingController();
    TextEditingController nomClient = TextEditingController();
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
                  value,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(fontWeight: FontWeight.bold),
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
                      final String statut_code = await function.VenteCredit(
                          dialogcontext,
                          tranche_uid,
                          value,
                          user.uid,
                          descriptionPerte.text,
                          payer,
                          perte,
                          montant,
                          nomClient.text,
                          numero_client,
                          numero,
                          budget.uid,
                          budget.solde_total,
                          budget.perte,
                          budget.benefice,
                          budget_tranche_uid,
                          budget_tranche_solde_total,
                          budget_tranche_benefice,
                          budget_tranche_perte);

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
