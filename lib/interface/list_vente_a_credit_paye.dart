// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/stream_vente_a_credit_paye.dart';
import 'package:senadedieu/models/vente_a_credit.dart';
import '../provider/provider_search.dart';
import 'drawer_admin.dart';

class ListVenteACreditsPaye extends StatelessWidget {
  const ListVenteACreditsPaye({super.key, required this.tranche_uid});
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final ventes = Provider.of<List<VenteACredits>>(context);
    final provider = Provider.of<Search>(context);
    String value = provider.value;
    bool affiche = provider.afficher;
    int nombre = 0;

    ventes.forEach((element) {
      if (element.paye) {
        nombre++;
      }
    });
    if (nombre < 1) {
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
            "Ventes à crédits payées",
            style: GoogleFonts.alike(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      drawer: DrawerAdmin(tranche_uid: tranche_uid),
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
                "Ventes à crédits payées",
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
                  padding: const EdgeInsets.only(left: 20, bottom: 12, top: 25),
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
                  VenteACredits vente = ventes[index];

                  return !affiche
                      ? vente.paye
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StreamVenteACreditEffectuePaye(
                                              tranche_uid: tranche_uid,
                                              vente_uid: vente.uid,
                                              client_uid: vente.client_uid,
                                              credit_uid: vente.credit_uid,
                                              user_uid: vente.user_uid),
                                    ));
                              },
                              title: Text(
                                vente.achat,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.sell,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    vente.created_at,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alike(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade900,
                                child: Text(
                                  vente.client_nom
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  style: GoogleFonts.alike(color: Colors.white),
                                ),
                              ),
                            )
                          : Container()
                      : (vente.achat
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  vente.client_nom
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  vente.numero.contains(value)) &&
                              vente.paye
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StreamVenteACreditEffectuePaye(
                                              tranche_uid: tranche_uid,
                                              vente_uid: vente.uid,
                                              client_uid: vente.client_uid,
                                              credit_uid: vente.credit_uid,
                                              user_uid: vente.user_uid),
                                    ));
                              },
                              title: Text(
                                vente.achat,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.alike(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.sell,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    vente.created_at,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alike(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.lightBlue.shade900,
                                child: Text(
                                  vente.client_nom
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  style: GoogleFonts.alike(color: Colors.white),
                                ),
                              ),
                            )
                          : Container();
                },
                itemCount: ventes.length,
              ))
        ],
      )),
    );
  }
}
