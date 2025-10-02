import 'package:myapp/core/models/persona.dart';

class PersonaControler {
  final Persona persona;

  PersonaControler(this.persona);

  void cambiarNombre(String nombre) {
    persona.nombre = nombre;
  }

  void cambiarEdad(int edad) {
    persona.edad = edad;
  }



}
