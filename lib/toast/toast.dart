import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Programado por HeroRickyGames

void toastShow(String texto, String Duracao){
  if(Duracao == "SHORT"){
    Fluttertoast.showToast(
        msg: texto,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  if(Duracao == "LONG"){
    Fluttertoast.showToast(
        msg: texto,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}