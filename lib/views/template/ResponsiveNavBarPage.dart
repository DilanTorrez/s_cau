import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_cau/models/AuthModel.dart';
import 'package:s_cau/views/login/LoginPage.dart';

class ResponsiveNavBarPage extends StatelessWidget {
  final Widget body;
  ResponsiveNavBarPage({Key? key, required this.body}) : super(key: key);

  // Creación de una clave global para el Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Obteniendo el ancho de la pantalla
    final width = MediaQuery.of(context).size.width;
    // Verificando si la pantalla es grande
    final bool isLargeScreen = width > 800;

    final AuthModel authModel = Provider.of<AuthModel>(context);

    return Theme(
      // Definiendo el tema claro
      data: ThemeData.light(),
      child: Scaffold(
        // Asignando la clave al Scaffold
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Logo",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems(context))
              ],
            ),
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                if (authModel.isAuthenticated) {
                  authModel.logout();
                  Navigator.pushNamed(context, '/');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
              },
              icon: authModel.isAuthenticated
                  ? const Icon(Icons.logout)
                  : const Icon(Icons.login),
              label: Text(
                authModel.isAuthenticated ? 'Logout' : 'Login',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),

        drawer: isLargeScreen ? null : _drawer(context),
        body: body, // Aquí usamos el widget de mis vistas como argumento
      ),
    );
  }

  // Método para crear el Drawer
  Widget _drawer(BuildContext context) => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      switch (item) {
                        case 'Inicio':
                          Navigator.pushNamed(context, '/');
                          break;
                        case 'Usuarios':
                          Navigator.pushNamed(context, '/usuarios');
                          break;
                        case 'Settings':
                          Navigator.pushNamed(context, '/settings');
                          break;
                      }
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );

  // Método para crear los elementos de la barra de navegación
  Widget _navBarItems(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {
                  // Navegar a la ruta correspondiente
                  switch (item) {
                    case 'Inicio':
                      Navigator.pushNamed(context, '/');
                      break;
                    case 'Usuarios':
                      Navigator.pushNamed(context, '/usuarios');
                      break;
                    case 'Settings':
                      Navigator.pushNamed(context, '/settings');
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );
}

// Lista de elementos del menú
final List<String> _menuItems = <String>[
  'Inicio',
  'Usuarios',
  'Settings',
];
