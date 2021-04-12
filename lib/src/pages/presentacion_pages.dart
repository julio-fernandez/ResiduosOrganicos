import 'package:flutter/material.dart';
import 'package:residuos/src/widgets/presentacion_cards.dart';

class PresentacionPage extends StatelessWidget {
  const PresentacionPage({Key key}) : super(key: key);

  static const kIcons = <Widget>[
    CardInicio(),
    CardGuiaUno(),
    Center(
        child: Text(
      "Fin",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 125),
    ))
  ];

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
          length: kIcons.length,
          child: Builder(
            builder: (BuildContext context) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: kIcons),
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
                          controller.animateTo(kIcons.length - 1);
                        } else {
                          Navigator.pushReplacementNamed(context, "login");
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
