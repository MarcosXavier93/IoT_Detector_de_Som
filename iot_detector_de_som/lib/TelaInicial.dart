import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_detector_de_som/Decibeis.dart';
import 'package:iot_detector_de_som/OnLineView.dart';
import 'package:iot_detector_de_som/UserList.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


bool inicio=true;
class TelaInicialApp extends StatefulWidget {
  @override
  _TelaInicialAppState createState() => _TelaInicialAppState();
}
class _TelaInicialAppState extends State<TelaInicialApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool _isDark = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDark ? Colors.green : Colors.green.shade800,
        title: const Text('Medidor de Decibeis'),
      ),
      body:
      Center(
        child:
      Row(
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            color: Colors.white,
            textColor: Colors.red,
            padding: EdgeInsets.all(5.0),
            onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoiseApp()),
            );
              },
            child: Text(
              "Realizar Medicao em Tempo Real".toUpperCase(),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(width: 10),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)
            ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Tela3lApp()),
                  );
                },
            color: Colors.white,
            textColor: Colors.red,
            child: Text("Visualizar Medicoes Online".toUpperCase(),
                style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
      ),
    );
  }
}

