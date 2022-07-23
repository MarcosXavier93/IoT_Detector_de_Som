import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart' as http;
class Tela3lApp extends StatefulWidget {
  @override
  _Tela3AppState createState() => _Tela3AppState();
}

class _Tela3AppState extends State<Tela3lApp> {
  // The list that contains information about photos
  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const apiUrl = 'https://api.thingspeak.com/channels/1717516/feeds.json';

    final response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    data =  data['feeds'];
    var data2 = data.reversed.toList();
    print("Valor de data");
    print(data2);
    setState(() {
      _loadedPhotos = data2;
    });
  @override
  void initState() {
    super.initState();
  }
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Theme
        .of(context)
        .brightness == Brightness.light;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _isDark ? Colors.green : Colors.green.shade800,
          title: const Text('Visualizacao de Dados Online - ThingSpeak'),
        ),
        body: SafeArea(
            child: _loadedPhotos.isEmpty
                ? Center(
              child: ElevatedButton(
                onPressed: _fetchData,
                child: const Text('Carregar Dados'),
              ),
            )
            // The ListView that displays photos
                : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext ctx, index) {
                return ListTile(
                  title: Text('Sensor 1'),
                  subtitle:
                  Text('Ultimo valor lido pelo sensor: ${_loadedPhotos[index]["field1"]}'),
                );
              },
            )));
  }
}


