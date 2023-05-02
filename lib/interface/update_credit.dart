// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields, unused_field, unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, unred_type_equality_checks, prefer_const_declarations, prefer_is_empty, override_on_non_overriding_member, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/models/credits.dart';
import 'package:senadedieu/provider/provider_ajouter_credit.dart';

class UpdateCredit extends StatelessWidget {
  UpdateCredit({key, required this.tranche_uid}) : super(key: key);
  final String tranche_uid;
  @override
  TextEditingController nomCredit = TextEditingController();
  TextEditingController seuilAprovisionnement = TextEditingController();
  TextEditingController benefice = TextEditingController();
  TextEditingController montantDisponible = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final credit = Provider.of<Credits>(context);
    final provider = Provider.of<ProviderAjouterCredit>(context);
    final function = Provider.of<Functions>(context);
    bool affiche = provider.affiche;
    nomCredit.text = credit.nom.isNotEmpty ? credit.nom : "";
    seuilAprovisionnement.text = credit.seuil_approvisionnement > 0
        ? credit.seuil_approvisionnement.toString()
        : "0";
    benefice.text = credit.benefice_sur_5000 > 0
        ? credit.benefice_sur_5000.toString()
        : "0";
    montantDisponible.text = credit.montant_disponible > 0
        ? credit.montant_disponible.toString()
        : "0";
    String nom = provider.nom;
    int montant_initial = provider.montant_initial;
    int benefice_sur_5000 = provider.benefice;
    int seuil_approvisionnement = provider.seuil_approvisionnement;
    return Scaffold(
        backgroundColor: Colors.lightBlue.shade900,
        drawer: DrawerAdmin(tranche_uid: tranche_uid),
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
          title: Text(
            credit.nom,
            style: GoogleFonts.alike(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                "Reséau mobile " + credit.nom,
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nouveau nom du crédit",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: TextFormField(
                  onChanged: (value) {
                    provider.change_nom(value, nomCredit);
                  },
                  controller: nomCredit,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Colors.white.withOpacity(.7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: nom.isEmpty ? Colors.red : Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true),
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
                    "Quel est le montant disponible actuel du crédit ?",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  controller: montantDisponible,
                  onChanged: (value) {
                    provider.change_montant_initial(value);
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                montant_initial < 0 ? Colors.red : Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true),
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
                    "Nouvel seuil d'approvisionnement de " +
                        credit.nom.toLowerCase(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  onChanged: (value) {
                    provider.change_seuil_approvisionnement(value);
                  },
                  controller: seuilAprovisionnement,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: seuil_approvisionnement < 0
                                ? Colors.red
                                : Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true),
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
                    "Bénéfice sur 5000 F de vente de " + credit.nom,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15),
                child: TextFormField(
                  controller: benefice,
                  onChanged: (value) {
                    provider.change_benefice(value);
                  },
                  maxLength: 3,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: benefice_sur_5000 < 250 ||
                                    benefice_sur_5000 > 300
                                ? Colors.red
                                : Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                      hintStyle: GoogleFonts.lato(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, left: 15, bottom: 40),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        provider.affiche_true();

                        final String statut_code = await function.UpdateCredit(
                            tranche_uid,
                            credit.uid,
                            credit.nom,
                            nomCredit.text,
                            benefice_sur_5000,
                            credit.montant_initial,
                            credit.montant_initial_cumule,
                            seuil_approvisionnement,
                            credit.montant_disponible,
                            montant_initial);

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
                          _speak("Champs vides ou invalides");
                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tous les champs sont recquis",
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
                        } else if (statut_code == "201") {
                          _speak(
                              "Le nouveau nom  saisi correspond déjà à un crédit qui existe déjà");

                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Le nouveau nom saisi correspond à un crédit qui existe déjà",
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
                          _speak("Mise à jour éffectuée avec succès");
                          provider.affiche_false();
                          final snakbar = SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Mise è jour éffectuée avec succès",
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
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: affiche
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                              )
                            : Text(
                                "Mettre à jour".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.alike(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}

Future _speak(String text) async {
  final FlutterTts _flutter_tts = FlutterTts();
  _flutter_tts.setLanguage("Fr");
  _flutter_tts.setSpeechRate(0.5);
  _flutter_tts.setVolume(0.5);
  _flutter_tts.setPitch(1.0);
  _flutter_tts.speak(text);
}
