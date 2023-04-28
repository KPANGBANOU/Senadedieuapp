// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senadedieu/interface/accueil.dart';
import 'package:senadedieu/interface/accueil_admin.dart';
import 'package:senadedieu/interface/loader.dart';
import 'package:senadedieu/interface/login.dart';
import 'package:senadedieu/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utilisateur>(context);
    final user_data = Provider.of<donnesUtilisateur>(context);

    if (user == null) {
      return Accueil();
    } else {
      if (!user_data.login) return Login();
      if (user_data.admin) return AccueilAdmin();
      return Loader();
    }
  }
}
