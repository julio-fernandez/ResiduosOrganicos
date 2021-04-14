import 'package:flutter/material.dart';

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
                    onPressed: () {
                      Navigator.pushNamed(context, "listaRecoleciones");
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
                  onPressed: () {
                    Navigator.pushNamed(context, "listaRecolectores");
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
