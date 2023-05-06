// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, must_be_immutable, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/base_de_donnees/registration.dart';
import 'package:senadedieu/functions/functions.dart';
import 'package:senadedieu/interface/reset_password.dart';
import 'package:senadedieu/interface/wrapper.dart';
import '../provider/provider_connnexion.dart';
import 'creat_account.dart';

class Login extends StatelessWidget {
  Login({super.key});

  bool connexion = false;
  bool obscure = false;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProviderConnexion>(context);
    final function = Provider.of<Functions>(context);
    connexion = _provider.connexion;
    obscure = _provider.is_obscure;
    password = _provider.password;
    email = _provider.email;
    final firebaseService = Provider.of<firebaseAuth>(context);
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Login",
          style: GoogleFonts.alike(
              color: Colors.black, fontWeight: FontWeight.bold),
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
          // ignore: prefer_const_literals_to_create_immutables
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
                      "Entreprise sèna De Dieu".toUpperCase(),
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
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/img.jpg",
                      ),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Login in your account",
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
              height: 80,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Adresse électronique",
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: TextFormField(
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) {
                    _provider.change_email(value);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: email.isEmpty ||
                                  email.length < 7 ||
                                  !email.contains("@")
                              ? BorderSide(color: Colors.redAccent)
                              : BorderSide(color: Colors.blue)),
                      fillColor: Colors.white,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 5),
                child: Text(
                  "Mot de passe de connexion",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.alike(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 20, right: 20),
              child: TextFormField(
                autocorrect: true,
                enableSuggestions: true,
                obscuringCharacter: "*",
                onChanged: (value) {
                  _provider.change_password(value);
                },
                obscureText: !obscure,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: password.isEmpty || password.length < 8
                          ? BorderSide(color: Colors.redAccent)
                          : BorderSide(color: Colors.blue)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _provider.obscure_true();
                    },
                    child: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 52,
              width: MediaQuery.of(context).size.width * 0.88,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade800),
                  onPressed: () async {
                    _provider.connexion_true();
                    final statut_code =
                        await function.login(email, password, firebaseService);

                    if (statut_code == "200") {
                      _provider.connexion_false();
                      _speak("Patientez pour la rédirection");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Wrapper(),
                          ));
                    } else if (statut_code == "100") {
                      _speak("Saisissez bien les champs");
                      _provider.connexion_false();

                      final snakbar = SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Adrssse électronique ou mot de passe incorrect",
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
                      _speak(
                          "Cette adresse n'existe pas ou les données mobiles sont désactivé");
                      _provider.connexion_false();

                      final snakbar = SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Tous les champs sont obligatoires. Veuillez vérifier si vous avez bien renseigné tous ces champs svp !",
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
                    }
                  },
                  child: connexion
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Connexion".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.alike(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.86,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, style: BorderStyle.solid, width: 5)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                  },
                  child: Text(
                    "Mot de passe oublié ?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alike(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 38,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "N'avez-vous pas encore de compte actif ? ".toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.88,
                height: 47,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Créez votre compte".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          color: Colors.brown.shade800,
                          fontWeight: FontWeight.bold),
                    ))),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
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
