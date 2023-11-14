import 'package:flutter/material.dart';
import 'package:s_cau/models/usuario.dart';
import 'package:s_cau/services/usuario_service.dart';
import 'package:s_cau/views/template/ResponsiveNavBarPage.dart';

class UsuarioCrearPage extends StatefulWidget {
  final VoidCallback onUserUpdated;
  UsuarioCrearPage({required this.onUserUpdated});

  @override
  _UsuarioCrearPageState createState() => _UsuarioCrearPageState();
}

class _UsuarioCrearPageState extends State<UsuarioCrearPage> {
  final UsuarioService usuarioService = UsuarioService();
  final _formKey = GlobalKey<FormState>();
  final _usuario = Usuario(username: '', password: '');

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      body: Center(
        child: Card(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nombre de usuario'),
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
                  Padding(
                    padding: EdgeInsets.only(
                        top:
                            16.0), // Ajusta el valor de top según tus necesidades
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await usuarioService.createUsuario(_usuario);
                          widget.onUserUpdated();
                          Navigator.pop(
                              context); // Regresa a la vista anterior después de crear un usuario
                        }
                      },
                      child: Text('Crear Usuario'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
