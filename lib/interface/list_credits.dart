// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, must_be_immutable, prefer_final_fields, unused_field, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/interface/stram_liquidite_credit.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_ajouter_credit.dart';
import '../provider/provider_search.dart';

class ListCredits extends StatelessWidget {
  ListCredits({
    key,
    required this.tranche_uid,
  });
  String _search_value = "";
  bool affiche = false;
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final _list_credits = Provider.of<List<Credits>>(context);
    final user = Provider.of<donnesUtilisateur>(context);
    final _sear_provider = Provider.of<Search>(context);
    affiche = _sear_provider.afficher;
    !affiche ? _search_value = "" : _search_value = _sear_provider.value;

    if (_list_credits.isEmpty) {
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
          backgroundColor: Colors.white,
          title: Text(
            "Crédits",
            style: GoogleFonts.alike(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue.shade900,
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

    return Scaffold(
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: (() {
                _sear_provider.afficher_void();
              }),
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 20,
              ))
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: affiche
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15,
                ),
                child: TextField(
                  onChanged: (value) {
                    _sear_provider.change_value(value);
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Recherchez ...",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              )
            : Text(
                "Crédits",
                style: GoogleFonts.alike(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: ((context, index) {
                    Credits _donnes = _list_credits[index];
                    return !affiche
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          StreamLiquiditeCredit(
                                              credit_uid: _donnes.uid,
                                              tranche_uid: tranche_uid,
                                              user_uid: _donnes.user_uid))));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue.shade900,
                              child: Text(
                                _donnes.nom.substring(0, 1).toUpperCase(),
                                style: GoogleFonts.alike(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: (() {
                                  _showMyDialog(context, _donnes.nom,
                                      _donnes.uid, tranche_uid);
                                }),
                                icon: Icon(
                                  Icons.delete,
                                )),
                            title: Text(
                              _donnes.nom,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.alike(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : _donnes.nom
                                .toLowerCase()
                                .contains(_search_value.toLowerCase())
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              StreamLiquiditeCredit(
                                                  credit_uid: _donnes.uid,
                                                  tranche_uid: tranche_uid,
                                                  user_uid:
                                                      _donnes.user_uid))));
                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.lightBlue.shade900,
                                  child: Text(
                                    _donnes.nom.substring(0, 1).toUpperCase(),
                                    style: GoogleFonts.alike(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                    onPressed: (() {
                                      _showMyDialog(context, _donnes.nom,
                                          _donnes.uid, tranche_uid);
                                    }),
                                    icon: Icon(
                                      Icons.delete,
                                    )),
                                title: Text(
                                  _donnes.nom,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.alike(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Container();
                  }),
                  itemCount: _list_credits.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade900,
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
}

Future<void> AddCredit(
    BuildContext context, String tranche_uid, String user_uid) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogcontext) {
      final provider = Provider.of<ProviderAjouterCredit>(dialogcontext);
      final function = Provider.of<Functions>(dialogcontext);
      String nom = provider.nom;
      int benefice_sur_5000 = provider.benefice;
      int montant_initial = provider.montant_initial;
      int seuil_approvisionnement = provider.seuil_approvisionnement;
      TextEditingController nomCredit = TextEditingController();
      bool affiche = provider.affiche;
      return AlertDialog(
        title: Row(
          children: [
            Expanded(
                child: Text(
              "Nouveau crédit".toUpperCase(),
              style: GoogleFonts.alike(fontWeight: FontWeight.bold),
            )),
            SizedBox(
              width: 4,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue.shade900),
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
        content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Nom du crédit",
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      provider.change_nom(value, nomCredit);
                    },
                    controller: nomCredit,
                    enableSuggestions: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    nom.isEmpty ? Colors.red : Colors.blue))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Bénéfice sur 5000 F de vente de ce crédit",
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      provider.change_benefice(value);
                    },
                    maxLength: 3,
                    decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: benefice_sur_5000 > 300 ||
                                        benefice_sur_5000 < 250
                                    ? Colors.red
                                    : Colors.blue))),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Stock initial du crédit",
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      provider.change_montant_initial(value);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: montant_initial < 0
                                    ? Colors.red
                                    : Colors.blue))),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Seuil d'approvisionnement",
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: TextField(
                    onChanged: (value) {
                      provider.change_seuil_approvisionnement(value);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: seuil_approvisionnement < 0
                                    ? Colors.red
                                    : Colors.blue))),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 14),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade900),
                onPressed: () async {
                  provider.affiche_true();
                  final String statut_code = await function.AjouterCredit(
                      tranche_uid,
                      nomCredit.text,
                      benefice_sur_5000,
                      montant_initial,
                      seuil_approvisionnement,
                      user_uid);

                  if (statut_code == "100") {
                    _speak("champs vides ou invalides");
                    provider.affiche_false();

                    final snakbar = SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "champs vides ou invalides",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      backgroundColor: Colors.redAccent.withOpacity(.8),
                      elevation: 1,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snakbar);
                  } else if (statut_code == "202") {
                    _speak("vérifiez si vous avez activé les données mobiles");
                    provider.affiche_false();

                    final snakbar = SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Une erreur est survenue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      backgroundColor: Colors.redAccent.withOpacity(.8),
                      elevation: 1,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snakbar);
                  } else if (statut_code == "201") {
                    _speak("Ce crédit existe déjà");
                    provider.affiche_false();

                    final snakbar = SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ce crédit existe déjà",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      backgroundColor: Colors.redAccent.withOpacity(.8),
                      elevation: 1,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snakbar);
                  } else {
                    _speak("le credit a été ajouter avec succès");
                    provider.affiche_false();
                    provider.change_benefice("");
                    provider.change_seuil_approvisionnement("");
                    provider.change_montant_initial("");
                    final snakbar = SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ce crédit a été ajouté avec succès",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                        "Ajouter crédit".toUpperCase(),
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

Future<void> _showMyDialog(BuildContext context, String credit_nom,
    String credit_uid, String tranche_uid) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext dialogContext) {
      final function = Provider.of<Functions>(dialogContext);
      return AlertDialog(
        title: Text(
          "Etes vous sur ?".toUpperCase(),
          style: GoogleFonts.alike(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                "Vous etes sur le point de supprimer le produit  " +
                    credit_nom.toLowerCase() +
                    " de la base de données de cette entreprise",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
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
                        child: Text(
                          'Confirmer'.toUpperCase(),
                          style: GoogleFonts.alike(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        final String statutcode = await function.DeleteCredit(
                            tranche_uid, credit_uid);

                        if (statutcode == "100") {
                          _speak("données invalides");

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
                            backgroundColor: Colors.redAccent.withOpacity(.8),
                            elevation: 1,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        } else if (statutcode == "202") {
                          _speak("Une erreur s'est produite");

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
                            backgroundColor: Colors.redAccent.withOpacity(.8),
                            elevation: 1,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakbar);
                        } else {
                          _speak("Ce crédit a été supprimé");

                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Ce crédit a été supprimé",
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
                          Navigator.of(dialogContext).pop();
                        }
                      }),
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
                      _speak("suppression du crédit annulée");
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
