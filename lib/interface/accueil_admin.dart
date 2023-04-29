// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_name, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/list_tranches.dart';
import 'package:senadedieu/interface/tranches_admin.dart';
import 'package:senadedieu/interface/tranches_clotures.dart';
import 'package:senadedieu/provider/provider_ajouter_tranche.dart';

import '../models/user.dart';
import '../provider/provider_change_index.dart';
import 'home.dart';
import 'login.dart';

class AccueilAdmin extends StatelessWidget {
  AccueilAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<donnesUtilisateur>(context);
    if (!user.admin) {
      return Login();
    }
    final provider = Provider.of<ProviderChangeIndex>(context);
    int current_index = provider.current_index;
    PageController pagecontroller = provider.page;
    final pages = [
      Home(),
      TranchesAdmin(),
      TranchesCloturees(),
      ListTranches()
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightBlue.shade900,
        elevation: 0,
        title: Text(
          "Sèna De Dieu",
          style: GoogleFonts.alike(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
            child: Container(
              color: Colors.lightBlue.shade900,
              height: 51,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          provider.change_current_index(0);
                        },
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      current_index == 0
                          ? Container(
                              color: Colors.white,
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                          : Container(
                              color: Colors.transparent,
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                    ],
                  ),
                  Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            provider.change_current_index(1);
                          },
                          child: Text(
                            "Slices",
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      current_index == 1
                          ? Container(
                              color: Colors.white,
                              height: 3,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                          : Container(
                              color: Colors.transparent,
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            provider.change_current_index(2);
                          },
                          child: Text(
                            "Slices closed",
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      current_index == 2
                          ? Container(
                              color: Colors.white,
                              height: 3,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                          : Container(
                              color: Colors.transparent,
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            provider.change_current_index(3);
                          },
                          child: Text(
                            "All sklices ",
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                      current_index == 3
                          ? Container(
                              color: Colors.white,
                              height: 3,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                          : Container(
                              color: Colors.transparent,
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.22,
                            )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: PageView.builder(
            itemCount: pages.length,
            controller: PageController(initialPage: current_index),
            onPageChanged: (value) {
              provider.change_current_index(value);
            },
            itemBuilder: (BuildContext context, int index) {
              return pages[current_index];
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade900,
        onPressed: () {
          AddNewSlice(context, user.uid, user.admin);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> AddNewSlice(
      BuildContext context, String user_uid, bool user_admin) {
    TextEditingController nomFerme = TextEditingController();
    TextEditingController descriptionFerme = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogcontext) {
        String ferme_uid = "";
        final provider = Provider.of<ProviderAjouterTranche>(dialogcontext);
        final function = Provider.of<Functions>(dialogcontext);
        String nom = provider.nom;
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
                "Nouvelle tranche".toUpperCase(),
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              )),
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
              child: ListBody(
            children: [
              Text(
                "Nom de la tranche",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: nomFerme,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: nom.isEmpty ? Colors.red : Colors.blue))),
                onChanged: (value) {
                  provider.change_nom(value, nomFerme);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description de la tranche",
                style: GoogleFonts.alike(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionFerme,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: description.isEmpty
                                ? Colors.red
                                : Colors.blue))),
                onChanged: (value) {
                  provider.change_description(value);
                },
              )
            ],
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, bottom: 15),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade900),
                    onPressed: () async {
                      provider.affiche_true();
                      final String statut_code = await function.AjouterTranche(
                          user_uid, nomFerme.text, description);
                      if (!user_admin) {
                        provider.affiche_false();
                        _speak(
                            "Vous n'avez pas les droits récquis pour éffectuer cette opération");
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Vous n'avez pas le droit d'effectuer cette opération",
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
                        ScaffoldMessenger.of(dialogcontext)
                            .showSnackBar(snakbar);
                      } else if (statut_code == "100") {
                        provider.affiche_false();
                        _speak("Vous devez saisir tous les champs");
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Champs vides ou invalides",
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
                        ScaffoldMessenger.of(dialogcontext)
                            .showSnackBar(snakbar);
                      } else if (statut_code == "201") {
                        provider.affiche_false();
                        _speak("cette tranche existe déjà");
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Cette tranche existe déjà",
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
                        ScaffoldMessenger.of(dialogcontext)
                            .showSnackBar(snakbar);
                      } else if (statut_code == "202") {
                        provider.affiche_false();
                        _speak("Vérifiez si les données mobiles sont activées");
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
                        ScaffoldMessenger.of(dialogcontext)
                            .showSnackBar(snakbar);
                      } else {
                        provider.affiche_false();
                        _speak("La tranche a été créée avec succès");
                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Tranche créée avec succès",
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
                        ScaffoldMessenger.of(dialogcontext)
                            .showSnackBar(snakbar);
                        Navigator.of(dialogcontext).pop();
                      }
                    },
                    child: affiche
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Add the new slice".toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alike(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
              ),
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
