import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/recolecciones.dart';
import 'package:residuos/src/models/shared_preferences.dart';
import 'package:residuos/src/models/usuarios.dart';

// import 'package:login/home_page.dart';
String grupo = "tiempo";
_DataSource dataSource;

class AgendarRecolectoresPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _AgendarRecolectoresPageState createState() =>
      new _AgendarRecolectoresPageState();
}

class _AgendarRecolectoresPageState extends State<AgendarRecolectoresPage> {
  Future<List<Recolecciones>> _futuroListaRecol;
  List<Recolecciones> _listaRecol = [];
  @override
  void initState() {
    super.initState();
    _futuroListaRecol = FuturosRecolec.getRecoleccionesByrecolectornulo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Residuos Orgánicos'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "listaRecolectores");
            }),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder(
              future: _futuroListaRecol,
              builder: (context, snapshot) {
                print("Valor del future builder");
                print(snapshot.data);
                List<Recolecciones> reco = (snapshot.data);
                print("¿Es nulo?");
                bool isnullRec = reco == null ? true : false;
                print(isnullRec);
                var fechahoy = DateTime.now();

                if (!isnullRec) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<_Row> rows = [];

                    for (var item in snapshot.data) {
                      int anio = int.parse(item.fechahasta.substring(0, 4));
                      int mes = int.parse(item.fechahasta.substring(5, 7));
                      int dia = int.parse(item.fechahasta.substring(8, 10));
                      var fechaRecoleccion = DateTime(anio, mes, dia);

                      if (item.fechahasta != "2000-00-00 00:00:00" &&
                          fechahoy.isBefore(fechaRecoleccion)) {
                        _listaRecol.add(item);

                        rows.add(_Row(
                          item.direccion,
                          Recolecciones.fechaFormatoCorrector(item.fechade),
                          (Recolecciones.fechaFormatoCorrector(item.fechahasta)
                                  .substring(10) +
                              " hrs"),
                          item.cantidad,
                          item.descripcion,
                          item.repetir,
                          // 'Nombre usuario',
                          // 'Puntuacion usuario',
                          item.recoleccionid,
                          item.usuarioid,
                          item.recolectorid,
                        ));
                      }
                    }

                    return PaginatedDataTable(
                      header:
                          Text('Seleccione los recolecciones para recolectar'),
                      rowsPerPage: 7,
                      columnSpacing: 40,
                      columns: [
                        DataColumn(label: Text('Dirección')),
                        DataColumn(label: Text('Fecha de')),
                        DataColumn(label: Text('limite')),
                        DataColumn(label: Text('cantidad')),
                        DataColumn(label: Text('descripción')),
                        DataColumn(label: Text('Repetición')),
                        // DataColumn(label: Text('Nombre usuario')),
                        // DataColumn(label: Text('Puntuacion usuario')),
                      ],
                      source: dataSource = _DataSource(context, rows),
                    );
                  } else {
                    return Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 100, bottom: 200),
                            height: 200.0,
                            width: 200.0,
                            child: CircularProgressIndicator()));
                  }
                } else {
                  return Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 100),
                          height: 200.0,
                          width: 200.0,
                          child: CircularProgressIndicator()));
                }
              }),
          ElevatedButton(
              onPressed: () async {
                Usuario usr = Usuario.fromJson(
                    await SharedPreferencesClass.getPreferenceJsonOf(
                        "usuario"));
                List<int> recid = [];
                print("Id de rows guardados");
                for (_Row item in dataSource._rows) {
                  if (item.selected) {
                    recid.add(item.recoleccionid);
                    print(item.recoleccionid);
                  }
                }
                print("ids de elementos a actualizar");

                for (Recolecciones item in _listaRecol) {
                  if (recid.contains((item.recoleccionid))) {
                    item.recolectorid = usr.usuarioId;
                    print("recoleccionid a actualizar=");
                    print(item.recoleccionid);
                    item.fechade =
                        Recolecciones.fechaFormatoCorrector(item.fechade);
                    item.fechahasta =
                        Recolecciones.fechaFormatoCorrector(item.fechahasta);
                    var httpResponse = await FuturosRecolec.updateRecol(item);
                    if (httpResponse.statusCode == 200) {
                      print("Recolecion ${item.recoleccionid} actualizada");
                      Navigator.pushReplacementNamed(
                          context, "listaRecolectores");
                    } else {
                      print(
                          "Recolecion ${item.recoleccionid} fallida actualizacion");
                    }
                  }
                }
                print("Usr name=${usr.usrName}");
                setState(() {});
              },
              child: Text("Agendar Recolección")),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
    this.valueF,
    // this.valueG,
    // this.valueH,
    this.recoleccionid,
    this.usuarioid,
    this.recolectorid,
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;
  // final String valueG;
  // final String valueH;
  final int recoleccionid;
  final int usuarioid;
  final int recolectorid;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, List<_Row> datos) {
    _rows = datos;
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
        // DataCell(Text(row.valueG)),
        // DataCell(Text(row.valueH)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
