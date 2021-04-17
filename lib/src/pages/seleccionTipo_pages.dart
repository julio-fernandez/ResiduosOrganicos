import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/shared_preferences.dart';
import 'package:residuos/src/models/usuarios.dart';

class SelectorTipoPage extends StatefulWidget {
  @override
  _SelectorTipoPageState createState() => _SelectorTipoPageState();
}

class _SelectorTipoPageState extends State<SelectorTipoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seleccion"),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {
                      Usuario usr = Usuario.fromJson(
                          await SharedPreferencesClass.getPreferenceJsonOf(
                              "usuario"));
                      usr.rol = 1;
                      print("Usr nombre a actualizar : " + usr.usrName);
                      var httpResponse = await FuturosUsr.updateUser(usr);
                      if (httpResponse.statusCode == 200) {
                        SharedPreferencesClass.setPreference("usuario", usr);
                        Navigator.pushNamed(context, "listaRecoleciones");
                      } else {
                        print("ERROR cambiarRol");
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 120.0,
                        ),
                        Text(
                          'Recolecion de  desechos organicos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.yellow,
                child: TextButton(
                  onPressed: () async {
                    Usuario usr = Usuario.fromJson(
                        await SharedPreferencesClass.getPreferenceJsonOf(
                            "usuario"));
                    print(usr.usrName);
                    usr.rol = 2;
                    var httpResponse = await FuturosUsr.updateUser(usr);
                    if (httpResponse.statusCode == 200) {
                      SharedPreferencesClass.setPreference("usuario", usr);
                      Navigator.pushNamed(context, "listaRecolectores");
                    } else {
                      print("ERROR cambiarRol");
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 120.0,
                      ),
                      Text(
                        'Recolector de  desechos organicos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
