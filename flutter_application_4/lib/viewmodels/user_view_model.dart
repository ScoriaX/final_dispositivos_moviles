// Descripción: Estructura de 'UserViewModel'
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 19/11/2025

import 'package:flutter/material.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  final List<User> _usuarios = [];

  List<User> get usuarios => _usuarios;

  // Funcion para agregar usuario
  void agregarUsuario(User usuario) {
    _usuarios.add(usuario);
    notifyListeners();
  }

  // Funcion para editar usuario
  void editarUsuario(int index, User usuario) {
    _usuarios[index] = usuario;
    notifyListeners();
  }

  // Funcion para eliminar usuario
  void eliminarUsuario(int index) {
    _usuarios.removeAt(index);
    notifyListeners();
  }
}
