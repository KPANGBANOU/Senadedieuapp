// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/interface/stream_depense.dart';
import 'package:senadedieu/models/budget_tranches.dart';
import 'package:senadedieu/models/depense.dart';
import 'package:senadedieu/provider/provider_ajouter_depense.dart';
import '../functions/functions.dart';
import '../models/budget.dart';
import '../models/user.dart';
import '../provider/provider_ajouter_perte.dart';
import '../provider/provider_search.dart';

class ListeDepenses extends StatefulWidget {
  ListeDepenses({
    Key? key,
    required this.tranche_uid,
  }) : super(key: key);
  final String tranche_uid;

  @override
  State<ListeDepenses> createState() => _ListeDepensesState();
}

class _ListeDepensesState extends State<ListeDepenses> {
  String value = "";

  bool affiche = false;

  @override
  Widget build(BuildContext context) {
    final depenses = Provider.of<List<Depenses>>(context);
    final provider = Provider.of<Search>(context);
    value = provider.value;
    affiche = provider.afficher;
    final budget_tranche = Provider.of<BudgetTranche>(context);

    if (depenses.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.lightBlue.shade900,
        drawer: DrawerAdmin(tranche_uid: widget.tranche_uid),
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
            "Depenses",
            style: GoogleFonts.alike(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown.shade900,
          onPressed: () {
            AddDepense(context, widget.tranche_uid, budget_tranche.uid,
                budget_tranche.depense);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerAdmin(tranche_uid: widget.tranche_uid),
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
                "Depenses",
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
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 12, top: 25),
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
                  Depenses perte = depenses[index];
                  return !affiche
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StreamDepense(
                                      tranche_uid: widget.tranche_uid,
                                      depense_uid: perte.uid,
                                      user_uid: perte.user_uid),
                                ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.lightBlue.shade900,
                            child: Text(
                              "SD".toUpperCase(),
                              style: GoogleFonts.alike(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _Delete(
                                    context,
                                    perte.uid,
                                    perte.montant,
                                    widget.tranche_uid,
                                    budget_tranche.uid,
                                    budget_tranche.depense);
                              },
                              icon: Icon(Icons.delete)),
                          subtitle: Row(children: [
                            Icon(
                              Icons.sell,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              perte.created_at + " à " + perte.created_at_heure,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                          title: Text(
                            perte.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.alike(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : perte.description
                              .toLowerCase()
                              .contains(value.toLowerCase())
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StreamDepense(
                                          tranche_uid: widget.tranche_uid,
                                          depense_uid: perte.uid,
                                          user_uid: perte.user_uid),
                                    ));
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade900,
                                child: Text(
                                  "SD".toUpperCase(),
                                  style: GoogleFonts.alike(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _Delete(
                                        context,
                                        perte.uid,
                                        perte.montant,
                                        widget.tranche_uid,
                                        budget_tranche.uid,
                                        budget_tranche.depense);
                                  },
                                  icon: Icon(Icons.delete)),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.sell,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    perte.created_at +
                                        " à " +
                                        perte.created_at_heure,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alike(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              title: Text(
                                perte.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container();
                },
                itemCount: depenses.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade900,
        onPressed: () {
          AddDepense(context, widget.tranche_uid, budget_tranche.uid,
              budget_tranche.depense);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> AddDepense(
    BuildContext context,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_depense,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        final user = Provider.of<donnesUtilisateur>(dialogContext);
        final provider = Provider.of<ProviderAjouterDepense>(dialogContext);
        final function = Provider.of<Functions>(dialogContext);
        final budget = Provider.of<Budget>(dialogContext);
        int montant = provider.montant;
        String description = provider.description;
        bool affiche = provider.affiche;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  "Dépense de l'entreprise",
                  style: GoogleFonts.alike(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlue.shade900),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Description de la dépense",
                  style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: description.isEmpty
                                    ? Colors.red
                                    : Colors.blue))),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "Estimation du montant de la dépense",
                  style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    montant <= 0 ? Colors.red : Colors.blue))),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade900,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: affiche
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Ajouter la dépense'.toUpperCase(),
                            style: GoogleFonts.alike(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                  onPressed: () async {
                    provider.affiche_true();
                    final String statut_code = await function.AjouterDepense(
                        tranche_uid,
                        user.uid,
                        description,
                        montant,
                        budget.uid,
                        budget.depense,
                        budget_tranche_uid,
                        budget_tranche_depense);

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
                      ScaffoldMessenger.of(dialogContext).showSnackBar(snakbar);
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
                      ScaffoldMessenger.of(dialogContext).showSnackBar(snakbar);
                    } else {
                      _speak("Ajouté avec succès");
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
                      ScaffoldMessenger.of(dialogContext).showSnackBar(snakbar);
                      provider.change_description("");
                      provider.change_montant("");
                      Navigator.of(dialogContext).pop();
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }

  Future<void> _Delete(
    BuildContext context,
    String depense_uid,
    int depense_montant,
    String tranche_uid,
    String budget_tranche_uid,
    int budget_tranche_depense,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        final provider = Provider.of<ProviderAjouterPerte>(dialogContext);
        final budget = Provider.of<Budget>(dialogContext);
        final function = Provider.of<Functions>(dialogContext);
        bool affiche = provider.affiche;
        return AlertDialog(
          title: Text(
            "Suppression de dépense",
            style: GoogleFonts.alike(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  "Vous etes sur le point de supprimer  cette dépense de la base de données de cette entreprise",
                  style: GoogleFonts.alike(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade900,
                          textStyle: TextStyle()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: affiche
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Confirmer'.toUpperCase(),
                                style: GoogleFonts.alike(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                      onPressed: () async {
                        provider.affiche_true();
                        final String statut_code = await function.DeleteDepense(
                            tranche_uid,
                            depense_uid,
                            depense_montant,
                            budget.uid,
                            budget_tranche_uid,
                            budget.depense,
                            budget_tranche_depense);

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
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(snakbar);
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
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(snakbar);
                        } else {
                          _speak("Supprimé avec succès");
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
                          ScaffoldMessenger.of(dialogContext)
                              .showSnackBar(snakbar);
                          Navigator.of(dialogContext).pop();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(.7),
                          textStyle: TextStyle()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Annuler'.toUpperCase(),
                          style: GoogleFonts.alike(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        _speak("Suppression du dépense annulée");
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
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
