import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_cau/models/AuthModel.dart';
import 'package:s_cau/views/login/HomePage.dart';
import 'package:s_cau/views/login/LoginPage.dart';
import 'package:s_cau/views/usuario/usuarioCrearPage.dart';
import 'package:s_cau/views/usuario/usuarioEditarPage.dart';
import 'package:s_cau/views/usuario/usuarioPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sistema de la Cooperativa de Agua Unificada',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            return Consumer<AuthModel>(
              builder: (_, authModel, __) {
                return authModel.isAuthenticated ? HomePage() : LoginPage();
              },
            );
          },
          '/usuarios': (context) => UsuarioPage(),
          '/usuarios/crear': (context) => UsuarioCrearPage(
                onUserUpdated: () {},
              ),
          '/usuarios/editar': (context) => UsuarioEditarPage(
                onUserUpdated: () {},
              ),
        },
      ),
    );
  }
}
