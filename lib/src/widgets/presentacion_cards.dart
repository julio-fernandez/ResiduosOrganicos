import 'package:flutter/material.dart';

class CardInicio extends StatelessWidget {
  const CardInicio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 50),
            child: Text(
              "Residuos Orgánicos",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ),
          Container(
            child: Image.asset(
              "assets/img/planet-earth-green.png",
              height: 200,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 60),
            child: Text("Ayuda al planeta a ser un lugar mejor",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

class CardGuiaUno extends StatelessWidget {
  const CardGuiaUno({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 25),
            child: Text(
              "¿ Como ayudar a tu ciudad a ser un lugar mejor ?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/img/botedeResiduos.png",
                  width: 100,
                ),
                Row(
                  children: [
                    Text(
                      "Separa residuos organicos",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      "Solicita recolección",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Image.asset(
                    "assets/img/recolecion-camion.png",
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 50),
            child: Text("Espera a que le sea asignado un recolector",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
