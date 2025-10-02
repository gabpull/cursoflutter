import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/core/controlers/persona_controler.dart';
import 'package:myapp/core/models/persona.dart';
import 'package:myapp/ui/paginas/segunda_pagina.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class FormularioPagina extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioPaginaState();
  }
}

class FormularioPaginaState extends State<FormularioPagina> {
  final _formKey = GlobalKey<FormState>();

  List<String> paises = ['Bolivia', 'Peru', 'Chile', 'Argentina'];

  //textField
  late TextEditingController _controller;
  late TextEditingController _controller2;

  late bool seleccionado;
  late String carrera;
  late String? pais;
  late String respuesta = '';

  final Persona persona = Persona(nombre: 'Gabriel Alvarado', edad: 42);

  final hiveStore = Hive.box('hiveBox');
  late final SharedPreferences preferencesStore;

  void initSharedPreferences() async {
    preferencesStore = await SharedPreferences.getInstance();
    var carreraPrefs = preferencesStore.getString('carrera') ?? '';
    setState(() {
      carrera = carreraPrefs;
    });
  }

  @override
  initState() {
    initSharedPreferences();
    _controller = TextEditingController(text: hiveStore.get('nombre') ?? '');
    _controller2 = TextEditingController(
      text: hiveStore.get('edad')?.toString() ?? '',
    );
    seleccionado = false;
    carrera = "";
    pais = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej. Gabriel Alvarado',
                label: Text('Nombre Completo'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return "Este campo nombre es requerido";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej10',
                label: Text('Edad'),
              ),
              onChanged: (valor) {
                // ignore: avoid_print
                print("Esta es mi edad $valor");
              },
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return "Este campo Edad es requerido";
                }
                return null;
              },
            ),
            ListTile(
              title: const Text("Eres nuevo Programador"),
              subtitle: const Text("Seleccion si eres nuevo programador"),
              leading: Checkbox(
                value: seleccionado,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      seleccionado = value;
                    }
                  });
                },
              ),
            ),
            Text("Selecciona tu carrera"),
            ListTile(
              title: const Text("Informatica"),
              trailing: Radio(
                // ignore: deprecated_member_use
                groupValue: carrera,
                value: "Informatica",
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      carrera = value;
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Electronica"),
              trailing: Radio(
                // ignore: deprecated_member_use
                groupValue: carrera,
                value: "Electronica",
                // ignore: deprecated_member_use
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      carrera = value;
                    }
                  });
                },
              ),
            ),
            Text("Selecciona tu carrera"),
            DropdownButton<String>(
              value: pais,
              items: paises.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  if (value != null) {
                    pais = value;
                  }
                });
              },
            ),
            Row(
              children: [
                TextButton(
                  child: Text("Validar"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (carrera == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Debes seleccionar una carrera"),
                          ),
                        );
                      }
                      hiveStore.put('nombre', _controller.value.text);
                      hiveStore.put('edad', int.parse(_controller2.value.text));
                      preferencesStore.setString('carrera', carrera);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Datos Almacenados correctamente1"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Datos Almacenados correctamente2"),
                        ),
                      );
                    }
                  },
                ),
                OutlinedButton(child: Text("Segundo"), onPressed: () {}),
                ElevatedButton(
                  child: Text("Tercero"),
                  onPressed: () {
                    final controlador = PersonaControler(persona);
                    controlador.cambiarNombre('Rodrigo Martinez');

                    //Navigator.push(context,
                    //  MaterialPageRoute(
                    //    builder: (context) => SegundaPagina(
                    //      usuario: Persona(nombre: 'Gabriel Alvarado', edad: 42),
                    //      esNuevo: seleccionado,
                    //     )
                    //
                    //  ),
                    // );

                    Navigator.pushNamed(
                      context,
                      'segunda_pagina',
                      arguments: SegundaPaginaArgumentos(
                        usuario: persona,
                        esNuevo: seleccionado,
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),

                    child: const Text("Cuartoss"),
                  ),
                  onTap: () async {
                    // ignore: avoid_print
                    var url = Uri.parse(
                      'https://jsonplaceholder.typicode.com/todos/1',
                    );
                    var respuestaPeticion = await http.get(url);
                    var json = jsonDecode(respuestaPeticion.body);
                    setState(() {
                      respuesta = json['title'];
                    });
                  },
                  onLongPress: () {
                    // ignore: avoid_print
                    print("Click largo en Cuarto");
                  },
                  onDoubleTap: () {
                    // ignore: avoid_print
                    print("Click doble en Cuarto");
                  },
                ),
              ],
            ),
            Text(respuesta),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    hiveStore.close();
    super.dispose();
  }
}
