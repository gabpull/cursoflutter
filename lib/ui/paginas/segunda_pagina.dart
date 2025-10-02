import 'package:flutter/material.dart';
import 'package:myapp/core/models/persona.dart';

class SegundaPaginaArgumentos {
  final Persona? usuario;
  final bool esNuevo;

  const SegundaPaginaArgumentos({this.usuario, this.esNuevo = false});
}

class SegundaPagina extends StatefulWidget {
  final Persona? usuario;
  final bool esNuevo;

  const SegundaPagina({super.key, this.usuario, this.esNuevo = false});

  @override
  State<SegundaPagina> createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  @override
  Widget build(BuildContext context) {
    SegundaPaginaArgumentos argumentos;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      argumentos =
          ModalRoute.of(context)?.settings.arguments as SegundaPaginaArgumentos;
    } else {
      argumentos = SegundaPaginaArgumentos();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            //Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Segunda Pagina'),
      ), // AppBar
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/cachorros.jpg'),
                ),
              ),
            ), // Container
            Text(
              argumentos.usuario?.nombre ?? 'Sin datos',
              style: const TextStyle(fontSize: 20),
            ), // Text
            Text(
              argumentos.usuario?.edad.toString() ?? 'Sin datos',
              style: const TextStyle(fontSize: 20),
            ), // Text
            SizedBox(
              height: 200,
              width: 200,
              child: Image.network('https://www.dogalize.com/files/wp-content/uploads/2018/12/cat-329214_1280.jpg'
                ),
          ) // SizedBox
          ],
        ), // Column
      ), // SizedBox
    ); // Scaffold
  }
}
