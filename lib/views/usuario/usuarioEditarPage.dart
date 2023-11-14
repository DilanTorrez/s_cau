import 'package:flutter/material.dart';
import 'package:s_cau/models/usuario.dart';
import 'package:s_cau/services/usuario_service.dart';
import 'package:s_cau/views/template/ResponsiveNavBarPage.dart';

class UsuarioEditarPage extends StatefulWidget {
  final VoidCallback onUserUpdated;
  UsuarioEditarPage({required this.onUserUpdated});

  @override
  _UsuarioEditarPageState createState() => _UsuarioEditarPageState();
}

class _UsuarioEditarPageState extends State<UsuarioEditarPage> {
  final UsuarioService usuarioService = UsuarioService();
  final _formKey = GlobalKey<FormState>();
  late Future<Usuario> _usuarioFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _usuarioFuture = _loadUsuario();
  }

  Future<Usuario> _loadUsuario() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return usuarioService.getUsuario(id);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      body: FutureBuilder<Usuario>(
        future: _usuarioFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final _usuario = snapshot.data!;
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _usuario.username,
                      decoration:
                          InputDecoration(labelText: 'Nombre de usuario'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre de usuario';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _usuario.username = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _usuario.password,
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una contraseña';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _usuario.password = value!;
                      },
                    ),
                    SizedBox(
                        height:
                            16), // Mantener la altura del SizedBox para separar
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await usuarioService.updateUsuario(
                              _usuario.id!, _usuario);
                          widget
                              .onUserUpdated(); // Notifica a la primera pantalla que el usuario ha sido actualizado
                          Navigator.pop(
                              context); // Regresa a la vista anterior después de actualizar un usuario
                        }
                      },
                      child: Text('Actualizar Usuario'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
