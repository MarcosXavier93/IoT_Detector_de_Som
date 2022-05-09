import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';



class NoiseApp extends StatefulWidget {
  @override
  _NoiseAppState createState() => _NoiseAppState();
}

class _NoiseAppState extends State<NoiseApp> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  double? maxDB;
  double? meanDB;
  List<_ChartData> chartData = <_ChartData>[];
  late int previousMillis;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter(onError);
  }

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) this._isRecording = true;
    });
    maxDB = noiseReading.maxDecibel;
    meanDB = noiseReading.meanDecibel;

    chartData.add(
      _ChartData(
        maxDB,
        meanDB,
        ((DateTime.now().millisecondsSinceEpoch - previousMillis) / 1000)
            .toDouble(),
      ),
    );
  }

  void onError(Object e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    previousMillis = DateTime.now().millisecondsSinceEpoch;
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    try {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;

      this.setState(() => this._isRecording = false);
    } catch (e) {
      print('Erro ao parar a Leitura: $e');
    }
    previousMillis = 0;
    chartData.clear();
  }

  void copyValue(
      bool theme,
      ) {
    Clipboard.setData(
      ClipboardData(
          text: 'Valor copiado foi de ${maxDB!.toStringAsFixed(1)}decibeis'),
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2500),
          content: Row(
            children: [
              Icon(
                Icons.check,
                size: 14,
                color: theme ? Colors.white70 : Colors.black,
              ),
              SizedBox(width: 10),
              Text('Valores Copiados')
            ],
          ),
        ),
      );
    });
  }

  openGithub() async {
    const url = 'https://github.com/MarcosXavier93/IoT_Detector_de_Som/tree/main/iot_detector_de_som';
    try {
      await launch(url);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao abrir a Url $url'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Theme.of(context).brightness == Brightness.light;
    if (chartData.length >= 25) {
      chartData.removeAt(0);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDark ? Colors.green : Colors.green.shade800,
        title: Text('Medidor de Decibeis'),
        actions: [
          IconButton(
              tooltip: 'Codigo Fonte no Github',
              icon: Icon(Icons.code_outlined),
              onPressed: openGithub),
          IconButton(
            tooltip: 'Copiar os valores',
            icon: Icon(Icons.copy),
            onPressed: maxDB != null ? () => copyValue(_isDark) : null,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_isRecording ? 'Parar ' : 'Iniciar'),
        onPressed: _isRecording ? stop : start,
        icon: !_isRecording ? Icon(Icons.circle) : null,
        backgroundColor: _isRecording ? Colors.red : Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  maxDB != null ? maxDB!.toStringAsFixed(2) : 'Pressione Iniciar',
                  style: GoogleFonts.exo2(fontSize: 76),
                ),
              ),
            ),
            Text(
              meanDB != null
                  ? 'Mean: ${meanDB!.toStringAsFixed(2)}'
                  : 'Aguardando leitura',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
            ),
            Expanded(
              child: SfCartesianChart(
                series: <LineSeries<_ChartData, double>>[
                  LineSeries<_ChartData, double>(
                      dataSource: chartData,
                      color: Color(0xFFFFFD),
                      xAxisName: 'Tempo',
                      yAxisName: 'dB',
                      name: 'Linha do Tempo',
                      xValueMapper: (_ChartData value, _) => value.frames,
                      yValueMapper: (_ChartData value, _) => value.maxDB,
                      animationDuration: 0),

          ],
              ),
            ),
            SizedBox(
              height: 68,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  final double? maxDB;
  final double? meanDB;
  final double frames;

  _ChartData(this.maxDB, this.meanDB, this.frames);
}