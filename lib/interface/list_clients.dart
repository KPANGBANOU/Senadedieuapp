// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, must_be_immutable, prefer_final_fields, unused_field, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/drawer_admin.dart';
import 'package:senadedieu/interface/stream_client.dart';
import 'package:senadedieu/models/client.dart';
import '../provider/provider_search.dart';

class ListClients extends StatelessWidget {
  ListClients({
    key,
    required this.tranche_uid,
  });
  String _search_value = "";
  bool affiche = false;
  final String tranche_uid;
  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<List<Clients>>(context);
    final _sear_provider = Provider.of<Search>(context);
    affiche = _sear_provider.afficher;
    !affiche ? _search_value = "" : _search_value = _sear_provider.value;

    if (clients.isEmpty) {
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
            "Clients",
            style: GoogleFonts.alike(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(
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
                "Clients",
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
                      "Clients de Sèna De Dieu".toUpperCase(),
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
                    Clients _donnes = clients[index];
                    return !affiche
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => StreamClient(
                                          tranche_uid: tranche_uid,
                                          client_uid: _donnes.uid))));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightBlue.shade900,
                              child: Text(
                                _donnes.nom.substring(0, 2).toUpperCase(),
                                style: GoogleFonts.alike(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                  _donnes.dernier_achat,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.alike(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
                                    .contains(_search_value.toLowerCase()) ||
                                _donnes.numero.contains(_search_value)
                            ? ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => StreamClient(
                                              tranche_uid: tranche_uid,
                                              client_uid: _donnes.uid))));
                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.lightBlue.shade900,
                                  child: Text(
                                    _donnes.nom.substring(0, 2).toUpperCase(),
                                    style: GoogleFonts.alike(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                      _donnes.dernier_achat,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.alike(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
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
                  itemCount: clients.length),
            ),
          ],
        ),
      ),
    );
  }
}
