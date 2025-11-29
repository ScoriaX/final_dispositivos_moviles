// Descripción: Estructura de 'User'
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 19/11/2025

class User {
  String nombre;
  String genero;
  bool activo;
  int edad;
  String correo;

  User({
    required this.nombre,
    required this.genero,
    required this.activo,
    required this.edad,
    required this.correo,
  });
}
