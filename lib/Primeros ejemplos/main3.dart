import 'package:flutter/material.dart';
import 'package:pmsn20252/utils/colors_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp ({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Practica 1'),
            backgroundColor: Colors.deepPurple,
          ),
        body: Container(
           child: Center(
              child: Text('Contador $contador',style: TextStyle(fontSize: 25, fontFamily: 'Pricedown', color: ColorsApp.txtColor),)
            ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ads_click),
          onPressed: (){
            contador++;
            print(contador);
            setState(() {
              
            });
          } 
        ),
      ),
    );
  }

  miEvento(){

  }
}