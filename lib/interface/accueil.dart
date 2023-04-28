// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senadedieu/interface/creat_account.dart';
import 'package:senadedieu/interface/login.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade900,
      appBar: AppBar(
        actions: [
          Image.asset(
            "images/logo.png",
            height: 100,
            width: 100,
            scale: 2.5,
          )
        ],
        leading: Container(),
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Sèna De Dieu",
          style: GoogleFonts.alike(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Text(
                              "Entreprise Sèna de Dieu".toUpperCase(),
                              style: GoogleFonts.alike(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              color: Colors.white,
                              height: 3,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/communication1.jpg"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Soyez les bienvenus",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 19),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Avez-vous déjà de compte actif ? ",
                textAlign: TextAlign.center,
                style: GoogleFonts.alike(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text(
                      "Créez votre compte".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      "Connectez-vous à votre compte".toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alike(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 50,
              )
            ],
          )),
    );
  }
}
