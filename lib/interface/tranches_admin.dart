// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/stream_tranche_admin.dart';
import 'package:senadedieu/models/tranches.dart';

class TranchesAdmin extends StatelessWidget {
  const TranchesAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final tranches = Provider.of<List<Tranches>>(context);
    int nombre = 0;
    tranches.forEach((element) {
      if (!element.stop) {
        nombre++;
      }
    });
    if (nombre <= 0) {
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
              return !tranche.stop
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StreamTrancheAdmin(
                                    tranche_uid: tranche.uid)));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue.shade900,
                        child: Text(
                          tranche.nom.substring(0, 2).toUpperCase(),
                          style: GoogleFonts.alike(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                            style:
                                GoogleFonts.alike(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
            itemCount: tranches.length,
          ),
        ),
      ),
    );
  }
}
