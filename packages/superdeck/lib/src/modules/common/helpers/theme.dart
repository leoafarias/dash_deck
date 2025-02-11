import 'package:flutter/material.dart';

ThemeData get theme => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
      dialogBackgroundColor: Colors.black,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );


// dark cupertino theme