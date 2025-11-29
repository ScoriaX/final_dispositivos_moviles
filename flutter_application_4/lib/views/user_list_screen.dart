// Descripción: Muestra la lista
// Autor: Piero Poblete
// Fecha creación: 19/11/2025
// Última modificación: 19/11/2025

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_view_model.dart';
import '../models/user.dart';
import 'user_form_screen.dart';

class UserListScreen extends StatefulWidget {
  final String email; 

  const UserListScreen({super.key, required this.email});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool _mostrarSoloActivos = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserViewModel>();
    final usuariosFiltrados = _mostrarSoloActivos
        ? viewModel.usuarios.where((u) => u.activo).toList()
        : viewModel.usuarios;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido: ${widget.email}'), // <-- corregido
        actions: [
          Row(
            children: [
              const Text('Solo activos'),
              Switch(
                value: _mostrarSoloActivos,
                onChanged: (value) {
                  setState(() => _mostrarSoloActivos = value);
                },
              ),
            ],
          ),
        ],
      ),
      body: usuariosFiltrados.isEmpty
          ? const Center(child: Text('No hay usuarios registrados'))
          : ListView.builder(
              itemCount: usuariosFiltrados.length,
              itemBuilder: (context, index) {
                final user = usuariosFiltrados[index];
                return Card(
                  child: ListTile(
                    title: Text(user.nombre),
                    subtitle: Text(
                        '${user.genero} - ${user.activo ? 'Activo' : 'Inactivo'} - ${user.edad} años\n${user.correo}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final actualizado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserFormScreen(
                                  usuario: user,
                                  indice: index,
                                ),
                              ),
                            );
                            if (actualizado != null && actualizado is User) {
                              final originalIndex =
                                  viewModel.usuarios.indexOf(user);
                              viewModel.editarUsuario(originalIndex, actualizado);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final originalIndex =
                                viewModel.usuarios.indexOf(user);
                            viewModel.eliminarUsuario(originalIndex);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoUsuario = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserFormScreen()),
          );
          if (nuevoUsuario != null && nuevoUsuario is User) {
            viewModel.agregarUsuario(nuevoUsuario);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
