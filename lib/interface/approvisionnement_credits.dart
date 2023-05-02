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
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/models/user.dart';
import 'package:senadedieu/provider/provider_approvisionner_credit.dart';

class ApprovisionnerListCredits extends StatelessWidget {
  ApprovisionnerListCredits({key, required this.tranche_uid});

  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final credits = Provider.of<List<Credits>>(context);
    final user = Provider.of<donnesUtilisateur>(context);
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
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
                height: MediaQuery.of(context).size.height * 0.4,
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
                  "Approvisionnement de crédits",
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
                        fontSize: 18,
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
                    onChanged: (newValue) {
                      NumberCredit(context, newValue!, tranche_uid, user.uid);
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

  Future<void> NumberCredit(BuildContext context, String value,
      String tranche_uid, String user_uid) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogcontext) {
        final function = Provider.of<Functions>(dialogcontext);
        final provider =
            Provider.of<ProviderApprovisionnerCredit>(dialogcontext);
        bool affiche = provider.affiche;
        int montant = provider.montant;
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
                    "Veuillez chaisir le montant d'approvisionnement svp",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (value) {
                    provider.change_montant(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: montant <= 0 ? Colors.red : Colors.blue))),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown.shade900),
                        onPressed: () async {
                          provider.affiche_true();
                          final String statut_code =
                              await function.ApprovisionnementCredit(
                                  tranche_uid, value, montant, user_uid);

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
                            _speak("Montant invalide");
                            provider.affiche_false();
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Montant invalide",
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
                            _speak("Approvisionnement éffectué avec succès");
                            provider.affiche_false();
                            provider.change_montant("");
                            final snakbar = SnackBar(
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Approvisionnement éffectué avec succès",
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
                        child: Text(
                          "Réchargement".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alike(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
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
