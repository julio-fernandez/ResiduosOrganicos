import 'package:flutter/material.dart';
import 'package:residuos/src/widgets/presentacion_cards.dart';
import 'package:residuos/src/models/shared_preferences.dart';

class PresentacionPage extends StatefulWidget {
  const PresentacionPage({Key key}) : super(key: key);

  static const kIcons = <Widget>[
    CardInicio(),
    CardGuiaUno(),
    CardGuiaUno(),
    CardGuiaUno(),
    CardGuiaUno(),
    Center(
        child: Text(
      "Continuar",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 50),
    ))
  ];

  @override
  _PresentacionPageState createState() => _PresentacionPageState();
}

class _PresentacionPageState extends State<PresentacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desechos organicos"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green[200], Colors.green])),
        child: DefaultTabController(
          length: PresentacionPage.kIcons.length,
          child: Builder(
            builder: (BuildContext context) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: PresentacionPage.kIcons),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: TabPageSelector(
                      color: Colors.lightGreen[300],
                      selectedColor: Colors.green[400],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final TabController controller =
                          DefaultTabController.of(context);
                      if (!controller.indexIsChanging) {
                        if (controller.index != (controller.length - 1)) {
                          controller
                              .animateTo(PresentacionPage.kIcons.length - 1);
                        } else {
                          Navigator.pushReplacementNamed(context, "login");
                          SharedPreferencesClass.setPreference(
                              "initScreen", 2); //Fija pantalla inicial a login

                        }
                      }
                    },
                    child: Text('Omitir'),
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
