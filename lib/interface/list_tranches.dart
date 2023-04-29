// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/stream_tranche_information.dart';
import 'package:senadedieu/models/tranches.dart';
import 'package:senadedieu/models/user.dart';
import '../models/budget.dart';

class ListTranches extends StatelessWidget {
  const ListTranches({super.key});

  @override
  Widget build(BuildContext context) {
    final tranches = Provider.of<List<Tranches>>(context);
    final budget = Provider.of<Budget>(context);
    final user = Provider.of<donnesUtilisateur>(context);
    if (tranches.isEmpty) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.lightBlue.shade900,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Tranches tranche = tranches[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StreamTrancheInformation(
                              tranche_uid: tranche.uid,
                              user_uid: tranche.user_uid)));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade900,
                  child: Text(
                    tranche.nom.substring(0, 2).toUpperCase(),
                    style: GoogleFonts.alike(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {
                      _Delete(
                          context,
                          tranche.nom,
                          tranche.uid,
                          budget.uid,
                          budget.solde_total,
                          budget.depense,
                          budget.perte,
                          user.admin,
                          user.mdp,
                          budget.benefice);
                    },
                    icon: Icon(Icons.delete)),
                title: Text(
                  tranche.nom,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.alike(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
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
                      tranche.created_at,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
            itemCount: tranches.length,
          ),
        ),
      ),
    );
  }

  Future<void> _Delete(
      BuildContext context,
      String ferme_nom,
      String ferme_uid,
      String budget_uid,
      int budget_solde_total,
      int budget_depense,
      int budget_perte,
      bool is_admin,
      String user_password,
      double budget_benefice) async {
    TextEditingController password = TextEditingController();
    int budget_ferme_solde_total = 0;
    int budget_ferme_perte = 0;
    int budget_ferme_depense = 0;
    String budget_ferme_uid = "budget_tranche";
    double tranche_benefice = 0;
    String _password = "";
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Avertissement".toUpperCase(),
            style: GoogleFonts.alike(
                fontWeight: FontWeight.bold, color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Vous etes sur le point de supprimer la tranche  " +
                      ferme_nom +
                      " de la base de données de cette entreprise. Cette action est irréversible",
                  style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Votre mot de passe",
                  style: GoogleFonts.alike(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    obscuringCharacter: "-",
                    enableSuggestions: true,
                    autocorrect: true,
                  ),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          _password = password.text.isNotEmpty
                              ? sha1
                                  .convert(utf8.encode(password.text.trim()))
                                  .toString()
                              : "";
                          if (!is_admin) {
                            _speak(
                                "Cher utilisateur, vous n'avez pas les droits récquis pour pouvoir éffectuer cette action sur la base de données. Désolé");
                          } else if (password.text.isEmpty) {
                            _speak(
                                "Nous dévrions avant tout valider votre identité. Pour cela, vous devrez saisir votre mot de passe");
                          } else if (_password != user_password) {
                            _speak(
                                "Le mot de passe saisi ne correspond pas au votre. Réessayez s'il vous plait");
                          } else {
                            _speak("suppression en cours");

                            await FirebaseFirestore.instance
                                .collection("tranches")
                                .doc(ferme_uid)
                                .collection("budget")
                                .doc(budget_ferme_uid)
                                .get()
                                .then((DocumentSnapshot document) {
                              budget_ferme_depense =
                                  (document.data() as Map)['depense'];
                              budget_ferme_perte =
                                  (document.data() as Map)['perte'];
                              budget_ferme_solde_total =
                                  (document.data() as Map)['solde_total'];
                              tranche_benefice =
                                  (document.data() as Map)['benefice'];
                            });

                            await FirebaseFirestore.instance
                                .collection("budget")
                                .doc(budget_uid)
                                .update({
                              "benefice": budget_benefice - tranche_benefice,
                              "solde_total":
                                  budget_solde_total - budget_ferme_solde_total,
                              "depense": budget_depense - budget_ferme_depense,
                              "perte": budget_perte - budget_ferme_perte
                            });

                            await FirebaseFirestore.instance
                                .collection("tranches")
                                .doc(ferme_uid)
                                .delete();

                            _speak("Suppression effectué avec succès");
                            Navigator.of(dialogContext).pop();
                          }
                          // ignore: empty_catches
                        } catch (e) {
                          _speak("une erreur s'est produite");
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
                        _speak("Suppression du tranche annulée");
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
}

Future _speak(String text) async {
  final FlutterTts _flutter_tts = FlutterTts();
  _flutter_tts.setLanguage("Fr");
  _flutter_tts.setSpeechRate(0.5);
  _flutter_tts.setVolume(0.5);
  _flutter_tts.setPitch(1.0);
  _flutter_tts.speak(text);
}
