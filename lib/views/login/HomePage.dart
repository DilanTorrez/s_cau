import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_cau/views/login/LoginPage.dart';
import 'package:s_cau/models/AuthModel.dart';
import 'package:s_cau/views/template/ResponsiveNavBarPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);

    if (!authModel.isAuthenticated) {
      return LoginPage();
    }

    return ResponsiveNavBarPage(
      body: Center(
        child: !authModel.isAuthenticated
            ? const Text(
                'NO has iniciado sesión',
                style: TextStyle(fontSize: 20),
              )
            : const Text('Has iniciado sesión correctamente',
                style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
