import 'package:flutter/material.dart';
import 'package:myapp/ui/paginas/primera_pagina.dart';
import 'package:myapp/ui/paginas/segunda_pagina.dart';
import 'package:hive_flutter/adapters.dart';

void main()async {
  await Hive.initFlutter();
  await Hive.openBox('hiveBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removed const here because Scaffold and AppBar are not const constructors.
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routes: {
        'primera_pagina': (context) => FormularioPagina(),
        'segunda_pagina': (context) => SegundaPagina()
        },
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario"), // Added const for Text widget
        ),
        body: Center(child: FormularioPagina()),
      ), // Added const for Center and Text widgets
    );
  }
}

// ignore: use_key_in_widget_constructors
class TercerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
