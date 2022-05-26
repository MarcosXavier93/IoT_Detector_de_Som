//
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';
// class OnLineView extends  StatefulWidget{
//   OnLineView({Key? key, required this.title}) : super(key: key);
//   @override
//   void initState() {
//     super.initState();
//     futureTour = fetchTour();
//   }
//
//   final String title;
//   @override
//   _OnLineViewState createState() => _OnLineViewState();
// }
// class _OnLineViewState extends State<OnLineView> {
//   Future <List> getSensorData() async {
//     var url = Uri.parse(
//         'https://api.thingspeak.com/channels/1717516/fields/1.json?api_key=00ZZ5BC2GHCLQIOX&results=1');
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       return json;
//     }
//     else {
//       throw Exception('Erro ao carregar dados do Servidor');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           body: FutureBuilder(
//             future: getSensorData(),
//             builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//               return snapshot.hasData
//                   ? SfDataGrid(source: snapshot.data, columns: getColumns())
//                   : Center(
//                 child: CircularProgressIndicator(
//                   strokeWidth: 3,
//                 ),
//               );
//             },
//           ),
//         ));
//
//   }
//
//   Future<ProductDataGridSource> getProductDataSource() async {
//     var dadosList = await generateDadosList();
//     return ProductDataGridSource(dadosList);
//   }
//
//   List<GridColumn> getColumns() {
//     return <GridColumn>[
//       GridTextColumn(
//           columnName: 'orderID',
//           width: 70,
//           label: Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.centerLeft,
//               child: Text('Order ID',
//                   overflow: TextOverflow.clip, softWrap: true))),
//       GridTextColumn(
//           columnName: 'customerID',
//           width: 100,
//           label: Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.centerRight,
//               child: Text('Customer ID',
//                   overflow: TextOverflow.clip, softWrap: true))),
//       GridTextColumn(
//           columnName: 'employeeID',
//           width: 100,
//           label: Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.centerLeft,
//               child: Text('Employee ID',
//                   overflow: TextOverflow.clip, softWrap: true))),
//       GridTextColumn(
//           columnName: 'orderDate',
//           width: 95,
//           label: Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.centerRight,
//               child: Text('Order Date',
//                   overflow: TextOverflow.clip, softWrap: true))),
//       GridTextColumn(
//           columnName: 'freight',
//           width: 65,
//           label: Container(
//               padding: EdgeInsets.all(8),
//               alignment: Alignment.centerLeft,
//               child: Text('Freight')))
//     ];
//   }
//
//   Future<List<Dados>> generateDadosList() async {
//     var response = await http.get(Uri.parse(
//         'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
//     var decodedProducts =
//     json.decode(response.body).cast<Map<String, dynamic>>();
//     List<Dados> dadosList = await decodedProducts
//         .map<Dados>((json) => Dados.fromJson(json))
//         .toList();
//     return dadosList;
//   }
// }
//
// class ProductDataGridSource extends DataGridSource {
//   ProductDataGridSource(this.dadosList) {
//     buildDataGridRow();
//   }
//   late List<DataGridRow> dataGridRows;
//   late List<Dados> Dadoslist;
//
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: [
//       Container(
//         child: Text(
//           row.getCells()[0].value.toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           row.getCells()[1].value,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           row.getCells()[2].value.toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//           alignment: Alignment.centerRight,
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             row.getCells()[4].value.toStringAsFixed(1),
//             overflow: TextOverflow.ellipsis,
//           ))
//     ]);
//   }
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   void buildDataGridRow() {
//     dataGridRows = productList.map<DataGridRow>((dataGridRow) {
//       return DataGridRow(cells: [
//         DataGridCell(columnName: 'orderID', value: dataGridRow.orderID),
//         DataGridCell<String>(
//             columnName: 'customerID', value: dataGridRow.customerID),
//         DataGridCell<int>(
//             columnName: 'employeeID', value: dataGridRow.employeeID),
//         DataGridCell<DateTime>(
//             columnName: 'orderDate', value: dataGridRow.orderDate),
//         DataGridCell<double>(columnName: 'freight', value: dataGridRow.freight)
//       ]);
//     }).toList(growable: false);
//   }
// }
//
// class Dados {
//   factory Dados.fromJson(Map<String, dynamic> json) {
//     return Dados(
//         entry_id: json['entry_id'],
//         field1: json['field1'],
//         created_at: json['created_at']);
//   }
//   Dados(
//       {required this.entry_id,
//         required this.field1,
//         required this.created_at});
//   final int? entry_id;
//   final String? field1;
//   final String? created_at;
//
// }
