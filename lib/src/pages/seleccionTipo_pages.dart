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
                  color: Color.fromRGBO(117, 252, 20, 1),
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
                        Navigator.pushReplacementNamed(context, "login");
                      } else {
                        print("ERROR cambiarRol");
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/home.png",
                        ),
                        Text(
                          '\n\nDonar residuos',
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
                color: Color.fromRGBO(19, 242, 133, 1),
                child: TextButton(
                  onPressed: () async {
                    Usuario usr = Usuario.fromJson(
                        await SharedPreferencesClass.getPreferenceJsonOf(
                            "usuario"));
                    print("el usrname en selecintipo es " + usr.usrName);
                    usr.rol = 2;
                    var httpResponse = await FuturosUsr.updateUser(usr);
                    if (httpResponse.statusCode == 200) {
                      SharedPreferencesClass.setPreference("usuario", usr);
                      Navigator.pushReplacementNamed(context, "login");
                    } else {
                      print("ERROR cambiarRol");
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/recolecion-camion.png",
                        height: 200,
                      ),
                      Text(
                        'Recolectar Residuos Orgánicos',
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
