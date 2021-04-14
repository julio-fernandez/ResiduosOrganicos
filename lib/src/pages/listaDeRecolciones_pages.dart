import 'package:flutter/material.dart';
import 'package:residuos/src/models/futurosUsuarios.dart';
import 'package:residuos/src/models/recolecciones.dart';

class RecolecionesLista extends StatefulWidget {
  @override
  _RecolecionesListaState createState() => _RecolecionesListaState();
}

class _RecolecionesListaState extends State<RecolecionesLista> {
  Future<List<Recolecciones>> _listaRecol;

  @override
  void initState() {
    super.initState();
    _listaRecol = FuturosRecolec.getRecolecciones();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desechos organicos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder(
              future: _listaRecol,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  List<_Row> rows = [];
                  for (var item in snapshot.data) {
                    rows.add(_Row(item.direccion, item.fecha, item.fecha,
                        item.repetir, 'btn mod', 'btn eliminar'));
                  }
                  return PaginatedDataTable(
                    header: Text('Recoleciones programadas'),
                    rowsPerPage: 7,
                    columnSpacing: 40,
                    columns: [
                      DataColumn(label: Text('Dirección')),
                      DataColumn(label: Text('Fecha')),
                      DataColumn(label: Text('Hora')),
                      DataColumn(label: Text('Repetición')),
                      DataColumn(label: Text('Modificar')),
                      DataColumn(label: Text('Eliminar')),
                    ],
                    // source: _DataSource(context),
                    source: _DataSource(context, rows),
                  );
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
              onPressed: () {
                Navigator.pushNamed(context, "agendarRecolectoresPage");
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
  );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;

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
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     notifyListeners();
      //   }
      // },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD)),
        DataCell(Text(row.valueE)),
        DataCell(Text(row.valueF)),
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
