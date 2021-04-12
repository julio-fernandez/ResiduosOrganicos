import 'package:flutter/material.dart';

class CardInicio extends StatelessWidget {
  const CardInicio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 25, bottom: 50),
              child: Text(
                "Desechos Organicos",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
          Container(
            child: Image.asset(
              "assets/img/planet-earth-green.png",
              height: 200,
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 60),
              child: Text("Ayuda al planeta a ser un lugar mejor",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          )
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
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 40, bottom: 25),
              child: Text(
                "!Como ayudar a tu ciudad a ser un lugar mejor¡",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/img/planet-earth-green.png",
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
                      "Solicita recoleccin",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Image.asset(
                  "assets/img/planet-earth-green.png",
                  width: 100,
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 40),
              child: Text("Ayuda al planeta a ser un lugar mejor",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
