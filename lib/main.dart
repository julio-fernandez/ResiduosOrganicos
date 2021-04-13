import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:residuos/src/pages/login_pages.dart';
import 'package:residuos/src/pages/presentacion_pages.dart';
import 'package:residuos/src/pages/registro_pages.dart';
import 'package:residuos/src/pages/seleccionTipo_pages.dart';
import 'package:residuos/src/pages/listaDeRecolciones_pages.dart';
import 'package:residuos/src/pages/listaDeRecolectores_pages.dart';
import 'package:residuos/src/pages/agendarRecoleccion_page.dart';
import 'package:residuos/src/pages/agendarRecolectores_page.dart';

import 'package:residuos/src/pages/pruebas/tableExample_pages.dart';

// import 'package:residuos/src/pages/pruebas/sh_preferencies_pages.dart';
int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setInt("initScreen", 12);
  initScreen = await prefs.getInt("initScreen");
  print('initScreen $initScreen');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desechos organicos',
      theme:
          //  _buildShrineTheme(),
          ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Nunito',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: (() {
        print(initScreen);
        if (initScreen == null || initScreen == 1) return "/";
        if (initScreen == 2) return "login";
        if (initScreen == 3) return "listaRecoleciones";
        if (initScreen == 3) return "listaRecolectores";
      }()),
      routes: {
        '/': (BuildContext context) => PresentacionPage(),
        // '/': (BuildContext context) => RecolecionesLista(),
        'presentacion': (BuildContext context) => PresentacionPage(),
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'selectorTipo': (BuildContext context) => SelectorTipoPage(),
        'tablaDemo': (BuildContext context) => DataTableDemo(),
        'listaRecoleciones': (BuildContext context) => RecolecionesLista(),
        'listaRecolectores': (BuildContext context) => RecolectoresLista(),
        'agendarRecoleccionPage': (BuildContext context) =>
            AgendarRecoleccionPage(),
        'agendarRecolectoresPage': (BuildContext context) =>
            AgendarRecolectoresPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        );
      },
    );
  }
}
