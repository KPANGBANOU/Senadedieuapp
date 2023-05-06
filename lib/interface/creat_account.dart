// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, unused_local_variable, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/validate_account_creating.dart';

import '../provider/provider_created_account.dart';
import 'login.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController nom_utilisateur = TextEditingController();
  TextEditingController date_naissance = TextEditingController();
  TextEditingController prenom_utilisateur = TextEditingController();
  TextEditingController email_user = TextEditingController();
  TextEditingController numero_user = TextEditingController();
  TextEditingController password_user = TextEditingController();
  TextEditingController confirm_password_user = TextEditingController();
  String nom = "";
  String prenom = "";
  String sexe = "Masculin";
  String email = "";
  String numero = "";
  String password = "";
  String confirm_password = "";
  bool affiche = false;
  bool password_obscure = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<providerCreateAccount>(context);
    final function = Provider.of<Functions>(context);
    nom = provider.nom;
    prenom = provider.prenom;
    sexe = provider.sexe;
    email = provider.email;
    numero = provider.numero;
    password = provider.password;
    confirm_password = provider.confirm_password;
    affiche = provider.affiche;
    password_obscure = provider.password_obscure;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        leading: Container(),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Creat account",
          style: GoogleFonts.alike(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          Image.asset(
            "images/logo.png",
            scale: 4.5,
            height: 100,
            width: 100,
          ),
        ],
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
                      "Sèna De Dieu".toUpperCase(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 20),
                    child: Container(
                      color: Colors.white,
                      width: 40,
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
              height: MediaQuery.of(context).size.height * 0.5,
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
              "Création de compte",
              textAlign: TextAlign.center,
              style: GoogleFonts.alike(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: 2,
              width: 80,
              color: Colors.white,
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.92,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      width: 3,
                      color: Colors.redAccent)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 15, top: 15),
                child: Text(
                  "Renseignez bien les informations".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alike(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nom de l'utilisateur",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                controller: nom_utilisateur,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: nom.isEmpty || nom.length < 3
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_nom(value, nom_utilisateur);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Prénom de l'utilisateur",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                autocorrect: true,
                controller: prenom_utilisateur,
                enableSuggestions: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: prenom.isEmpty || prenom.length < 3
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_prenom(value, prenom_utilisateur);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Adresse électronique",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                controller: email_user,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: email.isEmpty ||
                                email.length < 7 ||
                                !email.contains("@")
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_email(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12, right: 5),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Numéro téléphonique ( Numéro watsapp )",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                controller: numero_user,
                maxLength: 8,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    counterText: "",
                    focusedBorder: OutlineInputBorder(
                        borderSide: numero.isEmpty || numero.length < 8
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_numero(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date de naissance",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                onTap: () async {
                  DateTime? dateSelectionned = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  String format = dateSelectionned != null
                      ? DateFormat('dd-MM-yyyy').format(dateSelectionned)
                      : "";
                  if (format.isNotEmpty) {
                    date_naissance.text = format;
                  }
                },
                controller: date_naissance,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sexe de l'utilisateur",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Column(
              children: [
                RadioListTile(
                  title: Text(
                    "Masculin".toUpperCase(),
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  value: "Masculin",
                  groupValue: sexe,
                  onChanged: (value) {
                    provider.change_sexe(value);
                  },
                ),
                RadioListTile(
                  title: Text(
                    "Féminin".toUpperCase(),
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  value: "Féminin",
                  groupValue: sexe,
                  onChanged: (value) {
                    provider.change_sexe(value);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12, right: 5),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mot de passe de connexion",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                controller: password_user,
                obscureText: password_obscure,
                obscuringCharacter: "*",
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        provider.change_password_obscure();
                      },
                      child: Icon(
                        password_obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: password.isEmpty || password.length < 8
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_password(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 12, right: 5),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirmation du mot de passe de connexion",
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
              child: TextField(
                controller: confirm_password_user,
                obscureText: password_obscure,
                obscuringCharacter: "*",
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: confirm_password.isEmpty ||
                                confirm_password.length < 8 ||
                                confirm_password != password
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.blue)),
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true),
                onChanged: (value) {
                  provider.change_confirm_password(value);
                },
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.91,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900),
                    onPressed: () async {
                      provider.affiche_true();
                      final statut_code =
                          await function.VerificationUtilisateur(
                              email,
                              nom,
                              prenom,
                              numero_user.text,
                              sexe,
                              date_naissance.text,
                              password,
                              confirm_password);

                      if (statut_code == "100") {
                        _speak("Adresse électronique invalide");
                        provider.affiche_false();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Adresse e-mail vide ou invalide",
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
                      } else if (statut_code == "101") {
                        _speak("Champs vide ou mal renseignés");
                        provider.affiche_false();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Champs vides ou invalids",
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
                      } else if (statut_code == "102") {
                        _speak("Mot de passe moins sécurisé");
                        provider.affiche_false();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Mot de passe moins sécurisé",
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
                      } else if (statut_code == "103") {
                        _speak("Mot de passe mal confirmé");
                        provider.affiche_false();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Mot de passe mal confirmé",
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
                      } else if (statut_code == "104") {
                        _speak(
                            "Cette adresse est utilisé déjà pour créer un compte sur l'application");
                        provider.affiche_false();

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Adresse électronique déjà utilisée",
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
                      } else if (statut_code == "202") {
                        _speak(
                            "Vérifiez si les données mobiles sont activées. Une erreur est survenue");
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
                          backgroundColor: Colors.redAccent.withOpacity(.8),
                          elevation: 1,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      } else {
                        provider.affiche_false();
                        _speak(
                            "un code à cinq chiffres vous a été envoyé via cette adresse électronique. Vérifiez votre boite mail et saisissez le");

                        final snakbar = SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Un code vous a été envoyé ",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ValidateUserEmail(
                                  email: email,
                                  nom: nom_utilisateur.text,
                                  prenom: prenom_utilisateur.text,
                                  telephone: numero_user.text,
                                  date_naissance: date_naissance.text,
                                  sexe: sexe,
                                  password: password,
                                  code: int.parse(statut_code)),
                            ));
                      }
                    },
                    child: affiche
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Créez votre compte".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alike(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "J'ai déjà un compte ",
                  style: GoogleFonts.alike(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "images/sticker.png",
                  scale: 2.5,
                  fit: BoxFit.cover,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.91,
                height: 47,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Connectez-vous alors".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

Future _speak(String text) async {
  final FlutterTts flutter_tts = FlutterTts();
  flutter_tts.setLanguage("Fr");
  flutter_tts.setSpeechRate(0.5);
  flutter_tts.setVolume(0.5);
  flutter_tts.setPitch(1.0);
  flutter_tts.speak(text);
}
