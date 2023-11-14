import 'package:flutter/material.dart';
import 'package:s_cau/models/usuario.dart';
import 'package:s_cau/services/usuario_service.dart';
import 'package:s_cau/views/template/ResponsiveNavBarPage.dart';
import 'package:s_cau/views/usuario/usuarioCrearPage.dart';
import 'package:s_cau/views/usuario/usuarioEditarPage.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final UsuarioService usuarioService = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return ResponsiveNavBarPage(
      body: Center(
        // Centrar el contenido
        child: Container(
          width: MediaQuery.of(context).size.width.clamp(500, 850),
          child: FutureBuilder<List<Usuario>>(
            future: usuarioService.getUsuarios(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
              if (snapshot.hasData) {
                List<Usuario>? usuarios = snapshot.data;
                return Card(
                  // Agregar el Card aquí
                  child: Column(
                    children: [
                      Align(
                        // Alinear el botón a la derecha
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsuarioCrearPage(
                                    onUserUpdated: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text('Crear Usuario'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: usuarios!
                              .map(
                                (Usuario usuario) => ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('ID: ${usuario.id}'),
                                      Text('Username: ${usuario.username}'),
                                      Text('Password: ${usuario.password}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UsuarioEditarPage(
                                                onUserUpdated: () {
                                                  setState(() {});
                                                },
                                              ),
                                              settings: RouteSettings(
                                                arguments: usuario.id,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await usuarioService
                                              .deleteUsuario(usuario.id!);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
