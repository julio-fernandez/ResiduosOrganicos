import 'package:flutter/material.dart';

class RecolecionesLista extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desechos organicos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
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
            source: _DataSource(context),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "agendarRecoleccionPage");
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
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1', '1', '5', '6'),
      _Row('Cell A2', 'CellB2', 'CellC2', '2', '5', '6'),
      _Row('Cell A3', 'CellB3', 'CellC3', '3', '5', '6'),
      _Row('Cell A4', 'CellB4', 'CellC4', '4', '5', '6'),
      _Row('Cell B1', 'CellBB1', 'CellC1', '1', '5', '6'),
      _Row('Cell B2', 'CellBB2', 'CellC2', '2', '5', '6'),
      _Row('Cell B3', 'CellBB3', 'CellC3', '3', '5', '6'),
      _Row('Cell B4', 'CellBB4', 'CellC4', '4', '5', '6'),
      _Row('Cell C1', 'CellCC1', 'CellC1', '1', '5', '6'),
      _Row('Cell C2', 'CellCC2', 'CellC2', '2', '5', '6'),
      _Row('Cell C3', 'CellCC3', 'CellC3', '3', '5', '6'),
      _Row('Cell C4', 'CellCC4', 'CellC4', '4', '5', '6'),
    ];
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
