import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Decibeis.dart';

ThemeMode appTheme = ThemeMode.system; //dark / light

void main() => runApp(DecibelApp());

class DecibelApp extends StatefulWidget {
  @override
  _DecibelAppState createState() => _DecibelAppState();
}

class _DecibelAppState extends State<DecibelApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Medidor de Decibeis',
      home: NoiseApp(),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: GoogleFonts.comfortaa().fontFamily,
        ),
        primaryTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: GoogleFonts.comfortaa().fontFamily,
        ),
        accentTextTheme: ThemeData.dark().textTheme.apply(
          fontFamily: GoogleFonts.comfortaa().fontFamily,
        ),
      ),
      theme: ThemeData(
        fontFamily: GoogleFonts.comfortaa().fontFamily,
      ),
      themeMode: appTheme, //Atribuindo ao Tema do Aplictivo como sendo o tema do sistema operacional do dispositivo
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
   _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

    );
  }
}
